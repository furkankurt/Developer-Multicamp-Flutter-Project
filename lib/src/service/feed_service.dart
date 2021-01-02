import 'package:fk_haber/src/config/constants/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/domain/rss_feed.dart';

class FeedService {
  Future<RssFeed> getFeed() async {
    http.Response response = await http.get(k_SERVICE_URL);
    return RssFeed.parse(response.body);
  }
}
