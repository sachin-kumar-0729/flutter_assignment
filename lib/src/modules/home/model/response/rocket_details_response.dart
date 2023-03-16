class RocketDetailsResponse {
  Height? height;
  Diameter? diameter;
  List<String>? flickrImages;
  String? name;
  String? type;
  bool? active;
  var stages;
  var boosters;
  var costPerLaunch;
  var successRatePct;
  String? firstFlight;
  String? country;
  String? company;
  String? wikipedia;
  String? description;
  String? id;

  RocketDetailsResponse(
      {this.height,
      this.diameter,
      this.flickrImages,
      this.name,
      this.type,
      this.active,
      this.stages,
      this.boosters,
      this.costPerLaunch,
      this.successRatePct,
      this.firstFlight,
      this.country,
      this.company,
      this.wikipedia,
      this.description,
      this.id});

  RocketDetailsResponse.fromJson(Map<String, dynamic> json) {
    height =
        json['height'] != null ? new Height.fromJson(json['height']) : null;
    diameter = json['diameter'] != null
        ? new Diameter.fromJson(json['diameter'])
        : null;
    flickrImages = json['flickr_images'].cast<String>();
    name = json['name'];
    type = json['type'];
    active = json['active'];
    stages = json['stages'] ?? "";
    boosters = json['boosters'] ?? "";
    costPerLaunch = json['cost_per_launch'] ?? "";
    successRatePct = json['success_rate_pct'] ?? "";
    firstFlight = json['first_flight'];
    country = json['country'];
    company = json['company'];
    wikipedia = json['wikipedia'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.height != null) {
      data['height'] = this.height!.toJson();
    }
    if (this.diameter != null) {
      data['diameter'] = this.diameter!.toJson();
    }
    data['flickr_images'] = this.flickrImages;
    data['name'] = this.name;
    data['type'] = this.type;
    data['active'] = this.active;
    data['stages'] = this.stages;
    data['boosters'] = this.boosters;
    data['cost_per_launch'] = this.costPerLaunch;
    data['success_rate_pct'] = this.successRatePct;
    data['first_flight'] = this.firstFlight;
    data['country'] = this.country;
    data['company'] = this.company;
    data['wikipedia'] = this.wikipedia;
    data['description'] = this.description;
    data['id'] = this.id;
    return data;
  }
}

class Height {
  var meters;
  var feet;

  Height({this.meters, this.feet});

  Height.fromJson(Map<String, dynamic> json) {
    meters = json['meters'];
    feet = json['feet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meters'] = this.meters;
    data['feet'] = this.feet;
    return data;
  }
}

class Diameter {
  var meters;
  var feet;

  Diameter({this.meters, this.feet});

  Diameter.fromJson(Map<String, dynamic> json) {
    meters = json['meters'];
    feet = json['feet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meters'] = this.meters;
    data['feet'] = this.feet;
    return data;
  }
}
