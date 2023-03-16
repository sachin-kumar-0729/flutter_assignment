class RocketResponse {
  List<String>? flickrImages;
  String? name;
  String? type;
  bool? active;
  int? stages;
  int? boosters;
  int? costPerLaunch;
  int? successRatePct;
  String? firstFlight;
  String? country;
  String? company;
  String? wikipedia;
  String? description;
  String? id;

  RocketResponse(
      {this.flickrImages,
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

  RocketResponse.fromJson(Map<String, dynamic> json) {
    flickrImages = json['flickr_images'].cast<String>();
    name = json['name'];
    type = json['type'];
    active = json['active'];
    stages = json['stages'];
    boosters = json['boosters'];
    costPerLaunch = json['cost_per_launch'];
    successRatePct = json['success_rate_pct'];
    firstFlight = json['first_flight'];
    country = json['country'];
    company = json['company'];
    wikipedia = json['wikipedia'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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