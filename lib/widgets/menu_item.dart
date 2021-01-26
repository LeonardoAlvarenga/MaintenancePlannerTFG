import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String optionTitle;
  final Icon optionIcon;
  final String routeName;

  const MenuItem({
    @required this.optionTitle,
    @required this.optionIcon,
    @required this.routeName,
  });

  void choosenRoute(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        choosenRoute(context);
      },
      child: Container(
        margin: EdgeInsets.all(15),
        child: GridTile(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).accentColor,
                ),
              ),
              Positioned(
                child: optionIcon,
                right: 50,
                left: 50,
                top: 40,
              ),
            ],
          ),
          footer: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Theme.of(context).primaryColorDark,
            ),
            child: Center(
              child: Text(
                optionTitle,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
