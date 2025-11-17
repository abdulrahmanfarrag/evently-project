
class Event {
  String? id;
  String? title;
  String? description;
  int? date;
  int? time;
  double? latitude;
  double? longitude;

  int? categoryId;

   List<String> favoriteList ;

  Event({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
    this.categoryId,
    this.latitude,
    this.longitude,
     List<String>? favoriteList,
  }) : favoriteList = favoriteList ?? [];


  Map<String, dynamic> toFirebase() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "time": time,
      "categoryId": categoryId,
      'favoriteList': favoriteList??[],
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  Event.fromFirebase(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        description = data['description'],
        date = data['date'],
        time = data['time'],
        categoryId = data['categoryId'],
        latitude = (data['latitude'] != null)
            ? (data['latitude'] as num).toDouble()
            : null,
        longitude = (data['longitude'] != null)
            ? (data['longitude'] as num).toDouble()
            : null,
        favoriteList = List<String>.from(data['favoriteList'] ?? []);
  }

