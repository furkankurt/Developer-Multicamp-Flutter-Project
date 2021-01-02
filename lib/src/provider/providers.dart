import 'package:fk_haber/src/provider/auth_provider.dart';
import 'package:fk_haber/src/provider/feed_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentService,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentService = [
  ChangeNotifierProvider<AuthProvider>.value(value: AuthProvider()),
  ChangeNotifierProvider<FeedProvider>.value(value: FeedProvider()),
];

List<SingleChildWidget> uiConsumableProviders = [];
