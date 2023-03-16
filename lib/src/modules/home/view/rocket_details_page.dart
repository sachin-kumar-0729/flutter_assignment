import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/src/common_widget/custom_shimmer_widget.dart';
import 'package:flutter_application/src/common_widget/next_page_route.dart';
import 'package:flutter_application/src/common_widget/progress_hud.dart';
import 'package:flutter_application/src/common_widget/tap_widget.dart';
import 'package:flutter_application/src/modules/home/model/response/rocket_details_response.dart';
import 'package:flutter_application/src/modules/home/model/response/rockets_response.dart';
import 'package:flutter_application/src/modules/home/provider/home_provider.dart';
import 'package:flutter_application/src/modules/home/state/home_state.dart';
import 'package:flutter_application/src/utils/log.dart';
import 'package:flutter_application/src/utils/size_helper.dart';
import 'package:flutter_application/src/utils/utility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RocketDetailPage extends ConsumerStatefulWidget {
  String id;

  RocketDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  ConsumerState createState() => _RocketDetailPageState();
}

class _RocketDetailPageState extends ConsumerState<RocketDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late double _height;
  late double _width;
  bool _isLoading = false;
  RocketDetailsResponse? getRocketsDetails;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(homeStateProvider.notifier)
          .rocketsDetailsCall(id: widget.id.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    ref.listen<HomeState>(
        homeStateProvider.select<HomeState>((state) => state as HomeState),
        (_, state) {
      Log.v("listening..............");
      _handleLoginResponse(state, context);
    });
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final state = ref.watch(homeStateProvider);
      if (state is GetRocketsDetailsLoading) {
        Log.v("Get Rockets Details Loading");
        _isLoading = true;
      }
      if (state is GetRocketsDetailsSuccess) {
        Log.v("Get Rockets Details Success");
        _isLoading = false;
      }
      if (state is GetRocketsDetailsError) {
        Log.v("Get Rockets Details Error  ");
        _isLoading = false;
      }

      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Rockets Details",
            ),
            centerTitle: true,
          ),
          key: _scaffoldKey,
          body: ProgressHud(
            isLoading: _isLoading,
            child: Container(
              height: _height,
              width: _width,
              child: ScrollConfiguration(
                behavior: const ScrollBehavior(),
                child: SingleChildScrollView(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getRocketsDetails?.id != null
                            ? _rocketsDetailsBuilder(context)
                            : SizedBox(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child:
                                    const Center(child: Text("No Data found"))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void _handleLoginResponse(HomeState state, BuildContext context) {
    if (state is GetRocketsDetailsSuccess) {
      getRocketsDetails = state.response;
      showSnackBar(
          message: "Rockets Details Get Successfully", context: context);
      Log.v("Get Rockets Details Success");
    }
    if (state is GetRocketsDetailsError) {
      Utility.showSnackBar(message: state.error, context: context);
      Log.v("Get Rockets Details Error");
    }
  }

  _rocketsDetailsBuilder(BuildContext context) {
    return Card(
      child: Container(
          width: _width,
          color: Colors.white12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Name:- ${getRocketsDetails?.name ?? "Not found"}"),
              )),
              sizedHeight(),
              _flickrImagesListBuilder(context),
              sizedHeight(),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Active Status:- ${getRocketsDetails?.active ?? "Not found"}"),
              )),
              sizedHeight(),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "CostPerLaunch:- ${getRocketsDetails?.costPerLaunch ?? "Not found"}"),
              )),
              sizedHeight(),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "successRatePct:- ${getRocketsDetails?.successRatePct.toString() ?? "Not found"}"),
              )),
              sizedHeight(),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Description:- ${getRocketsDetails?.description ?? "Not found"}"),
              )),
              sizedHeight(),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Wikipedia link:- ${getRocketsDetails?.wikipedia ?? "Not found"}"),
              )),
              sizedHeight(),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Height & Diameter in Feet:- ${getRocketsDetails?.height?.feet ?? "Not found"} "),
              )),
              sizedHeight(),
            ],
          )),
    );
  }

  _flickrImagesListBuilder(
    BuildContext context,
  ) {
    return SizedBox(
      height: 300,
      width: screenWidth(context),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        shrinkWrap: true,
        itemCount: getRocketsDetails?.flickrImages?.length,
        itemBuilder: (context, index) {
          return _flickrImagesListItem(context, index);
        },
      ),
    );
  }

  _flickrImagesListItem(BuildContext context, int index) {
    return SizedBox(
      height: screenWidth(context) - 60,
      width: _width,
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: getRocketsDetails?.flickrImages?[index] ??
            "http://via.placeholder.com/350x150",
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CustomShimmerWidget.rectangular(
          height: screenWidth(context) - 60,
          width: screenWidth(context),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
