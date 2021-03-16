class News {
  final String newsID;
  final String categoryID;
  final String categoryName;
  final String title;
  final String publishedDate;
  final String expiryDate;

  News(
      {this.newsID,
      this.categoryID,
      this.categoryName,
      this.title,
      this.publishedDate,
      this.expiryDate});

  factory News.fromJson(Map<String, dynamic> json) {
    return new News(
      newsID: json['NewsID'],
      categoryID: json['CategoryID'],
      categoryName: json['CategoryName'],
      title: json['Title'],
      publishedDate: json['PublishedDate'],
      expiryDate: json['ExpiryDate'],
    );
  }
}

class NewsDesc {
  final String newsID;
  final String categoryID;
  final String categoryName;
  final String title;
  final String fullContent;
  final String publishedDate;
  final String expiryDate;

  NewsDesc(
      {this.newsID,
      this.categoryID,
      this.categoryName,
      this.title,
      this.fullContent,
      this.publishedDate,
      this.expiryDate});

  factory NewsDesc.fromJson(Map<String, dynamic> json) {
    return new NewsDesc(
      newsID: json['NewsID'],
      categoryID: json['CategoryID'],
      categoryName: json['CategoryName'],
      title: json['Title'],
      fullContent: json['FullContent'],
      publishedDate: json['PublishedDate'],
      expiryDate: json['ExpiryDate'],
    );
  }
}
