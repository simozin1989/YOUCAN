class ArticleModel {
  String url = "http://soltana.ma/wp-json/wp/v2/posts";
  int id;
  String title;
  String description;
  String published;
  String image;

  ArticleModel(
      this.id, this.title, this.description, this.image, this.published);
  ArticleModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title']['rendered'];
    this.description = json['content']['rendered'];
    this.published = json['date'];
    this.image = '${url + json["_links"]["wp:featuredmedia"]["source_url"]}';
  }
}
