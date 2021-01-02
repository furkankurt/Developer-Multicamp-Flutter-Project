import 'package:fk_haber/src/config/base/base_state.dart';
import 'package:fk_haber/src/config/constants/route_constants.dart';
import 'package:fk_haber/src/config/navigation/navigation_service.dart';
import 'package:fk_haber/src/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends BaseState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar"),
      ),
      body: ListView(
        children: [
          myListItem(
              title: "Geliştirici",
              subtitle: "Furkan KURT",
              onPressed: () async => await launch("http://furkankurt.com.tr/")),
          myListItem(
            title: "Lisanslar",
            subtitle: "Açık Kaynak Lisanslar",
            onPressed: () => showLicensePage(context: context),
          ),
          FutureBuilder(
              future: PackageInfo.fromPlatform().then((value) => value.version),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return myListItem(
                    title: "Uygulama Versionu",
                    subtitle: snapshot.data,
                  );
                } else {
                  return Container();
                }
              }),
          myListItem(
            title: "Çıkış Yap",
            onPressed: () {
              getProvider<AuthProvider>().logOut();
              NavigationService.instance.navigateToReset(k_ROUTE_SPLASH);
            },
          ),
        ],
      ),
    );
  }

  Widget myListItem({String title, String subtitle, VoidCallback onPressed}) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.exo2(),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: GoogleFonts.exo2(),
            )
          : null,
      onTap: onPressed,
    );
  }
}
