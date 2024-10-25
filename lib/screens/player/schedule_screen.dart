import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/constants/const_strings.dart';
import 'package:arcadia/models/models.dart';
import 'package:arcadia/provider/provider.dart';
import 'package:arcadia/screens/player/match_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/schedule-screen';
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<Match> upcomingmatches = [];
  List<Match> completedmatches = [];
  List<Team> teams = [];
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<Matches>(context, listen: false).fetchAndSetMatches().then(
        (value) {
          Provider.of<Teams>(context, listen: false).fetchAndSetTeams().then(
                (value) => setState(() {
                  _isLoading = false;
                }),
              );
        },
      );
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    upcomingmatches =
        Provider.of<Matches>(context, listen: false).upcomingMatches;
    completedmatches =
        Provider.of<Matches>(context, listen: false).completedMatches;
    teams = Provider.of<Teams>(context, listen: false).teams;
    //print("teams in schedscreenstate=" + teams.toString());
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : DefaultTabController(
            length: 2,
            child: Scaffold(
               backgroundColor: CustomColors.primaryColor,
              appBar: AppBar(
                backgroundColor: CustomColors.firebaseNavy,
                title: Text(
                  "Match Schedule",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                bottom: const TabBar(
                  indicatorColor: Colors.white70,
                  tabs: [
                    Tab(
                      child: Text("Upcoming Matches"),
                    ),
                    Tab(
                      child: Text("Matches History"),
                    )
                  ],
                ),
                // actions: [
                //   Icon(
                //     Icons.filter,
                //     color: Colors.white60,
                //   ),
                //   SizedBox(
                //     width: 20,
                //   ),
                // ],
                centerTitle: true,
              ),
              body: Material(
                color: CustomColors.firebaseNavy,
                child: Container(
                  child: TabBarView(
                    children: [
                      ListView.builder(
                        itemCount: upcomingmatches.length,
                        itemBuilder: (BuildContext context, int index) {
                          return UpcomingMatchCard(
                              upcomingmatches[index], teams);
                        },
                      ),
                      ListView.builder(
                        itemCount: completedmatches.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CompletedMatchCard(
                              completedmatches[index], teams);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class UpcomingMatchCard extends StatelessWidget {
  final Match match;
  final List<Team> teams;
  UpcomingMatchCard(this.match, this.teams);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MatchDetails(match.matchId.toString())),
        );
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width*0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.blueAccent,
            ),
            color: CustomColors.taskez1,
          ),
          margin: EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 10),
          child: ListTile(
            contentPadding:
                EdgeInsets.only(top: 25, bottom: 25, right: 15, left: 15),
            leading: Column(
              children: [
                CircleAvatar(
                  minRadius: 25,
                  maxRadius: 25,
                  child: FutureBuilder(
                    future: Provider.of<Teams>(context, listen: false)
                        .getImageUrl(teams
                            .firstWhere((e) => e.teamUid == match.teamId1)
                            .teamUid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CircleAvatar(
                          radius: 25,
                          backgroundColor: CustomColors.primaryColor,
                          foregroundColor: Colors.white54,
                          backgroundImage: CachedNetworkImageProvider(
                            snapshot.data.toString(),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Icon(Icons.image_not_supported_sharp);
                      } else {
                        return CircleAvatar(
                          radius: 25,
                          backgroundColor: CustomColors.primaryColor,
                          foregroundColor: Colors.white54,
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            trailing: Column(
              children: [
                CircleAvatar(
                  minRadius: 25,
                  maxRadius: 25,
                  child: FutureBuilder(
                    future: Provider.of<Teams>(context, listen: false)
                        .getImageUrl(teams
                            .firstWhere((e) => e.teamUid == match.teamId2)
                            .teamUid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CircleAvatar(
                          radius: 25,
                          backgroundColor: CustomColors.primaryColor,
                          foregroundColor: Colors.white54,
                          backgroundImage: CachedNetworkImageProvider(
                            snapshot.data.toString(),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Icon(Icons.image_not_supported_sharp);
                      } else {
                        return CircleAvatar(
                          radius: 25,
                          backgroundColor: CustomColors.primaryColor,
                          foregroundColor: Colors.white54,
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            title: Center(
              child: Column(children: [
                Container(
                  child: Text(
                    "Match " + match.matchId,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white60),
                    textScaler: TextScaler.linear(1.5),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width*0.175,
                      alignment: Alignment.center,
                      child: Text(
                        teams
                            .firstWhere((e) => e.teamUid == match.teamId1)
                            .teamAbbreviation,
                        // teams.firstWhere((e) => e.teamUid==match.teamId1).teamAbbreviation[1] +
                        // teams.firstWhere((e) => e.teamUid==match.teamId1).teamAbbreviation[2],

                        // overflow: TextOverflow.visible,
                        style: TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.bold,
                            ),
                        textScaler: TextScaler.linear(1),
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width*0.075,
                      alignment: Alignment.center,
                      child: Text(
                        "   Vs   ",
                        style: TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.bold,
                            ),
                        textScaler: TextScaler.linear(1),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.sizeOf(context).width*0.175,
                      child: Text(
                        teams
                            .firstWhere((e) => e.teamUid == match.teamId2)
                            .teamAbbreviation,
                        // teams.firstWhere((e) => e.teamUid==match.teamId2).teamAbbreviation[1] +
                        // teams.firstWhere((e) => e.teamUid==match.teamId2).teamAbbreviation[2],
                        // overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.bold,
                            ),textScaler: TextScaler.linear(1),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                  color: Colors.white,
                ),
                Text(
                  "Live at " + DateFormat(dateFormat).format(match.matchTime),
                  style: TextStyle(color: Colors.white60),
                ),
              ]),
            ),
          )),
    );
  }
}

class CompletedMatchCard extends StatelessWidget {
  final Match match;
  final List<Team> teams;
  CompletedMatchCard(this.match, this.teams);

  @override
  Widget build(BuildContext context) {
    // print("teams=" + teams.toString());
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MatchDetails(match.matchId.toString())),
        );
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.blueAccent,
            ),
            color: CustomColors.taskez1,
          ),
          margin: EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 0),
          child: ListTile(
            contentPadding:
                EdgeInsets.only(top: 25, bottom: 25, right: 15, left: 15),
            leading: Column(
              children: [
                FutureBuilder(
                  future: Provider.of<Teams>(context, listen: false)
                      .getImageUrl(teams
                          .firstWhere((e) => e.teamUid == match.teamId1)
                          .teamUid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CircleAvatar(
                        radius: 25,
                        backgroundColor: CustomColors.primaryColor,
                        foregroundColor: Colors.white54,
                        backgroundImage: CachedNetworkImageProvider(
                          snapshot.data.toString(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Icon(Icons.image_not_supported_sharp);
                    } else {
                      return CircleAvatar(
                        radius: 25,
                        backgroundColor: CustomColors.primaryColor,
                        foregroundColor: Colors.white54,
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
            trailing: Column(
              children: [
                FutureBuilder(
                  future: Provider.of<Teams>(context, listen: false)
                      .getImageUrl(teams
                          .firstWhere((e) => e.teamUid == match.teamId2)
                          .teamUid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CircleAvatar(
                        radius: 25,
                        backgroundColor: CustomColors.primaryColor,
                        foregroundColor: Colors.white54,
                        backgroundImage: CachedNetworkImageProvider(
                          snapshot.data.toString(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Icon(Icons.image_not_supported_sharp);
                    } else {
                      return CircleAvatar(
                        radius: 25,
                        backgroundColor: CustomColors.primaryColor,
                        foregroundColor: Colors.white54,
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
            title: Center(
              child: Column(children: [
                Text(
                  "Match " + match.matchId,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white60),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      teams
                          .firstWhere((e) => e.teamUid == match.teamId1)
                          .teamAbbreviation,
                      //
                      //     teams.firstWhere((e) => e.teamUid==match.teamId1).teamAbbreviation[1] +
                      //     teams.firstWhere((e) => e.teamUid==match.teamId1).teamAbbreviation[2],
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          color: Colors.white60,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      "   Vs   ",
                      style: TextStyle(
                          color: Colors.white60,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      teams
                          .firstWhere((e) => e.teamUid == match.teamId2)
                          .teamAbbreviation,
                      // teams.firstWhere((e) => e.teamUid==match.teamId2).teamAbbreviation[1] +
                      // teams.firstWhere((e) => e.teamUid==match.teamId2).teamAbbreviation[2],
                      // overflow: TextOverflow.visible,
                      style: TextStyle(
                          color: Colors.white60,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                  color: Colors.white,
                ),
                (match.points![match.teamId1] == match.points![match.teamId2])
                    ? Text(
                        "Match Draw",
                        style: TextStyle(color: Colors.white60),
                      )
                    : ((match.points![match.teamId1]!.toInt()) >
                            (match.points![match.teamId2]!.toInt()))
                        ? Text(
                            teams
                                    .firstWhere(
                                        (e) => e.teamUid == match.teamId1)
                                    .teamName +
                                " won the match",
                            style: TextStyle(color: Colors.white60),
                          )
                        : Text(
                            teams
                                    .firstWhere(
                                        (e) => e.teamUid == match.teamId2)
                                    .teamName +
                                " won the match",
                            style: TextStyle(color: Colors.white60),
                          )
              ]),
            ),
          )),
    );
  }
}
