class newsModel {
  late String? title;
  late String? description;
  late String? url;
  late String? urlToImage;
  late String? publishedAt;
  late String? content;
  late String? category;

  newsModel(
      {this.title = "title",
      this.description = "decp",
      this.url = "url",
      this.urlToImage = "image",
      this.publishedAt = "date and time",
      this.content = "content",
      this.category = "category"});

  factory newsModel.fromMap(Map news) {
    return newsModel(
      title: news["title"],
      description: news["description"],
      url: news["url"],
      urlToImage: news["urlToImage"],
      publishedAt: news["publishedAt"],
      content: news["content"],
      category: news["category"],
    );
  }
}
