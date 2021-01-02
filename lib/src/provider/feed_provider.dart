import 'package:fk_haber/src/service/feed_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:webfeed/webfeed.dart';

class FeedProvider extends ChangeNotifier {
  FeedProvider() {
    getRssFeed(false);
  }
  RssFeed feed;
  List<RssItem> filteredItems = List();
  List<RssItem> items = List();
  bool isLoading = false;

  getRssFeed(bool isNotify) async {
    isLoading = true;
    if (isNotify ?? false) {
      notifyListeners();
    }
    try {
      FeedService().getFeed().then((value) {
        if (value != null) {
          feed = value;
          items = value.items;
          filteredItems = value.items;
          isLoading = false;
          notifyListeners();
        }
      });
    } catch (e) {
      print("Rss parse error: $e");
      isLoading = false;
      notifyListeners();
    }
  }

  void onQueryChanged(String query) async {
    if (query.isEmpty) {
      filteredItems = feed.items;
    } else {
      // items.forEach((element) {
      //   if (element.title.toLowerCase().contains(query.toLowerCase())) {
      //     filteredItems.add(element);
      //   }
      // });
      filteredItems = items
          .where((string) =>
              string.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void clear() {
    filteredItems = feed.items;
    notifyListeners();
  }
}
