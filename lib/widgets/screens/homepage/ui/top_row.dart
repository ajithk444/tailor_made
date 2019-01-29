import 'package:flutter/material.dart';
import 'package:tailor_made/constants/mk_style.dart';
import 'package:tailor_made/models/stats.dart';
import 'package:tailor_made/utils/mk_navigate.dart';
import 'package:tailor_made/widgets/screens/contacts/contacts.dart';
import 'package:tailor_made/widgets/screens/homepage/ui/helpers.dart';
import 'package:tailor_made/widgets/screens/jobs/jobs.dart';

class TopRowWidget extends StatelessWidget {
  const TopRowWidget({
    Key key,
    @required this.height,
    @required this.stats,
  }) : super(key: key);

  final StatsModel stats;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border(bottom: MkBorderSide()),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(right: MkBorderSide()),
              ),
              child: TMGridTile(
                icon: Icons.supervisor_account,
                color: Colors.orangeAccent,
                title: "Contacts",
                subTitle: "${stats.contacts.total} Contacts",
                onPressed: () => MkNavigate(context, ContactsPage()),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: TMGridTile(
                icon: Icons.work,
                color: Colors.greenAccent.shade400,
                title: "Jobs",
                subTitle: "${stats.jobs.total} Total",
                onPressed: () => MkNavigate(context, JobsPage()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
