import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/enums/category.dart';
import 'package:arcadia/provider/player.dart';
import 'package:arcadia/provider/players.dart';
import 'package:arcadia/provider/team.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuctionDetails extends StatefulWidget {
  static const routeName = '/auction-details';
  @override
  _AuctionDetailsState createState() => _AuctionDetailsState();
}

class _AuctionDetailsState extends State<AuctionDetails> {
  List<Team> teams = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<Teams>(context).fetchAndSetTeams();
  }

  @override
  Widget build(BuildContext context) {
    teams = Provider.of<Teams>(context, listen: false).teams;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.firebaseNavy,
        title: Text(
          "Auction Status",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Material(
        color: CustomColors.firebaseNavy, //Colors.deepPurpleAccent,
        child: ListView.builder(
          itemCount: teams.length,
          itemBuilder: (BuildContext context, int index) {
            return TeamCard(teams[index]);
          },
        ),
      ),
    );
  }
}

class TeamCard extends StatelessWidget {
  final Team team;
  TeamCard(this.team);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      color: CustomColors.taskez1,
      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: ExpansionTile(
        title: Text(
          team.teamName,
          style: TextStyle(
              color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        subtitle: Text(
          "Owner: " + team.ownerName,
          style: TextStyle(
              color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: CustomColors.firebaseNavy,
                  border: Border.all(
                    color: Colors.blueAccent,
                  ),
                ),
                margin:
                    EdgeInsets.only(left: 20, right: 4, top: 20, bottom: 20),
                child: Text(
                  "Players: " + team.playerUid.length.toString(),
                  style: TextStyle(fontSize: 22, color: Colors.white54),
                ),
              ),
              Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: CustomColors.firebaseNavy,
                  border: Border.all(
                    color: Colors.blueAccent,
                  ),
                ),
                margin:
                    EdgeInsets.only(left: 4, right: 20, top: 20, bottom: 20),
                child: Text(
                  "Credits: " + team.credits.toString(),
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white54,
                  ),
                ),
              )
            ],
          ),
          ...team.playerUid.map((e) {
            return PlayerTile(
                player: Provider.of<Players>(context).getPlayer(e));
          }).toList(),
        ],
      ),
    );
  }
}

class PlayerTile extends StatelessWidget {
  final Player player;

  const PlayerTile({required this.player});

  Color getCategoryColor(PlayerCategory cat) {
    switch (cat) {
      case PlayerCategory.gold:
        return Color(0xffd4af37);
      case PlayerCategory.silver:
        return Color(0xffc0c0c0);
      case PlayerCategory.bronze:
        return Color(0xffcd7f32);
      default:
        return Colors.white24;
    }
  }

  // Future<String> getImageUrl(String uid) async {
  //   final ref =
  //       FirebaseStorage.instance.ref().child('PlayerProfileImages/$uid/image');

  //   var url = await ref.getDownloadURL();
  //   print(url);

  //   return url;
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide:
              BorderSide(color: getCategoryColor(player.playerCategory))),
      color: CustomColors.firebaseNavy,
      borderOnForeground: true,
      margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
      child: ListTile(
        leading: new CircleAvatar(
          backgroundColor: getCategoryColor(player.playerCategory),
          child: new Text(
            player.name[0].toUpperCase(),
          ),
        ),
        // leading: Ink.image(
        //   image: FirebaseImage(
        //       'gs://arcadia-auction-app.appspot.com/PlayerProfileImages/${player.uid}/image',
        //       shouldCache: true,
        //       maxSizeBytes: 3000 * 1000,
        //       cacheRefreshStrategy: CacheRefreshStrategy.NEVER),
        //   fit: BoxFit.cover,
        //   width: 20,
        //   height: 20,
        //   //child: InkWell(onTap: onClicked),
        // ),
        // leading: new CircleAvatar(
        //   foregroundColor: Theme.of(context).primaryColor,
        //   backgroundColor: Colors.grey,
        //   backgroundImage: new NetworkImage(getImageUrl(player.uid).toString()),
        // ),
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Text(
              player.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getCategoryColor(player.playerCategory),
                  fontSize: 18),
            ),
          ],
        ),
        subtitle: new Container(
          padding: const EdgeInsets.only(top: 5.0),
          child: new Text(
            player.inGameName,
            style: new TextStyle(
                color: getCategoryColor(player.playerCategory), fontSize: 15.0),
          ),
        ),
        trailing: new Text(
          player.soldIn.toString(),
          style: TextStyle(
              fontSize: 18.0, color: getCategoryColor(player.playerCategory)),
        ),
      ),
    );
  }
}