import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/src/common_widget/custom_shimmer_widget.dart';
import 'package:flutter_application/src/common_widget/next_page_route.dart';
import 'package:flutter_application/src/common_widget/progress_hud.dart';
import 'package:flutter_application/src/common_widget/tap_widget.dart';
import 'package:flutter_application/src/modules/home/model/response/rockets_response.dart';
import 'package:flutter_application/src/modules/home/provider/home_provider.dart';
import 'package:flutter_application/src/modules/home/state/home_state.dart';
import 'package:flutter_application/src/modules/home/view/rocket_details_page.dart';
import 'package:flutter_application/src/utils/log.dart';
import 'package:flutter_application/src/utils/size_helper.dart';
import 'package:flutter_application/src/utils/utility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late double _height;
  late double _width;
  bool _isLoading = false;
  List<RocketResponse> getRocketsList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeStateProvider.notifier).rocketsListCall();
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
      if (state is GetRocketsListLoading) {
        Log.v("Get Rockets List Loading");
        _isLoading = true;
      }
      if (state is GetRocketsListSuccess) {
        Log.v("Get Rockets List Success");
        _isLoading = false;
      }
      if (state is GetRocketsListError) {
        Log.v("Get Rockets List Error  ");
        _isLoading = false;
      }

      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Home Page",
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
                        _rocketsDetailsBuilder(context),
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
    if (state is GetRocketsListSuccess) {
      getRocketsList = state.response!;
      showSnackBar(message: "Rockets List Get Successfully", context: context);
      Log.v("Get Rockets List Success");
    }
    if (state is GetRocketsListError) {
      Log.v("Get Rockets List Error");
      Utility.showSnackBar(message: state.error, context: context);
    }
  }

  _rocketsDetailsBuilder(BuildContext context) {
    return getRocketsList.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            primary: false,
            shrinkWrap: true,
            itemCount: getRocketsList.length,
            itemBuilder: (context, index) {
              return _rocketsListItem(context, index);
            },
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const Center(child: Text("No Data Found")));
    ;
  }

  _rocketsListItem(BuildContext context, int index) {
    return TapWidget(
      onTap: () {
        Navigator.push(
            context,
            NextPageRoute(RocketDetailPage(
              id: getRocketsList[index].id ?? "",
            )));
      },
      child: Column(
        children: [
          Card(
              //width: _width,
              color: Colors.white38,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _flickrImagesListBuilder(context, index),
                  Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Name:- ${getRocketsList[index].name ?? "Not found"}"),
                  )),
                  sizedHeight(),
                  Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Country:- ${getRocketsList[index].country ?? "Not found"}"),
                  )),
                  sizedHeight(),
                  Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Engines Count:- ${getRocketsList[index].name ?? "Not found"}"),
                  )),
                  sizedHeight(),
                  
                ],
              )),
              sizedHeight(),
        ],
      ),
    );
  }

  _flickrImagesListBuilder(BuildContext context, int index) {
    return SizedBox(
      //color: Colors.amber,
      height: 300,
      width: screenWidth(context),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        shrinkWrap: true,
        itemCount: getRocketsList[index].flickrImages?.length,
        itemBuilder: (context, imageIndex) {
          return _flickrImagesListItem(context, imageIndex, index);
        },
      ),
    );
  }

  _flickrImagesListItem(BuildContext context, int imageIndex, int index) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox(
        height: screenWidth(context) - 60,
        width: _width,
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: getRocketsList[index].flickrImages?[imageIndex] ??
              "http://via.placeholder.com/350x150",
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CustomShimmerWidget.rectangular(
            height: screenWidth(context) - 60,
            width: screenWidth(context),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
