import 'package:fk_haber/src/config/base/base_state.dart';
import 'package:fk_haber/src/config/constants/route_constants.dart';
import 'package:fk_haber/src/config/navigation/navigation_service.dart';
import 'package:fk_haber/src/config/theme/app_colors.dart';
import 'package:fk_haber/src/provider/feed_provider.dart';
import 'package:fk_haber/src/ui/shared/custom_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/webfeed.dart';

class HomePage extends StatefulWidget {
  final BuildContext context;

  const HomePage({Key key, this.context}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  FeedProvider _feedProvider;
  GlobalKey<AnimatedWidgetBaseState> _key = GlobalKey();
  bool isSearching = false;

  @override
  void initState() {
    _feedProvider = getProvider<FeedProvider>();
    _feedProvider.getRssFeed(false);
    super.initState();
  }

  InputDecoration myDecoration({String label, bool isError = false}) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1.2)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red, width: 1.2)),
      labelText: label,
      labelStyle: GoogleFonts.exo2(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedProvider>(builder: (_, provider, child) {
      if (provider.isLoading) {
        return Scaffold(
          backgroundColor: AppColors.mainColor,
          body: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        );
      } else {
        if (provider.feed != null) {
          return Scaffold(
            appBar: AppBar(
              title: isSearching
                  ? TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Ara...",
                        hintStyle: GoogleFonts.exo2(color: Colors.white),
                      ),
                      onChanged: provider.onQueryChanged,
                      cursorColor: Colors.yellow,
                      style: GoogleFonts.exo2(color: Colors.white),
                    )
                  : Text(
                      provider.feed.title,
                      style: GoogleFonts.exo2(fontSize: 16),
                    ),
              leading: IconButton(
                icon: isSearching ? Icon(Icons.close) : Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                  if (!isSearching) {
                    provider.clear();
                  }
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () =>
                      NavigationService.instance.navigate(k_ROUTE_SETTINGS),
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () => _feedProvider.getRssFeed(true),
              child: Center(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    RssItem item = provider.filteredItems[index];
                    return CustomItem(
                      item: item,
                    );
                  },
                  itemCount: provider.filteredItems.length,
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: AppColors.mainColor,
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          );
        }
      }
    });
  }
}
