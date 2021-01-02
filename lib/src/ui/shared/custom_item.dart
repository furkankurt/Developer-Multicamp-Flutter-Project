import 'package:cached_network_image/cached_network_image.dart';
import 'package:fk_haber/src/config/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';

class CustomItem extends StatefulWidget {
  final RssItem item;

  const CustomItem({Key key, this.item}) : super(key: key);
  @override
  _CustomItemState createState() => _CustomItemState();
}

class _CustomItemState extends BaseState<CustomItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.all(12),
      height: isExpanded ? dynamicHeight(0.4) : dynamicHeight(0.25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(0, 3),
            blurRadius: 10,
            spreadRadius: 1,
          )
        ],
        image: DecorationImage(
          image: CachedNetworkImageProvider(widget.item.imageUrl),
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
          fit: BoxFit.cover,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Wrap(
                  children: [
                    Text(
                      DateFormat("dd MMMM yyyy | HH:mm", "tr")
                          .format(widget.item.pubDate),
                      style:
                          GoogleFonts.exo2(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Wrap(
                  children: [
                    Text(
                      widget.item.title,
                      maxLines: isExpanded ? 5 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.exo2(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    if (isExpanded) ...[
                      Divider(
                        color: Colors.white,
                      ),
                      Text(
                        widget.item.description,
                        style:
                            GoogleFonts.exo2(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(
                        height: 8,
                        width: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.share,
                                  color: Colors.white, size: 30),
                              onPressed: () => Share.share(widget.item.link,
                                  subject: widget.item.title)),
                          Container(
                            width: 2,
                            height: 40,
                            color: Colors.white,
                          ),
                          IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.open_in_browser,
                                  color: Colors.white, size: 30),
                              onPressed: () async =>
                                  await launch(widget.item.link))
                        ],
                      )
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
