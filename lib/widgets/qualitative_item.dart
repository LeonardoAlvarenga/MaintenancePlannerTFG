import 'package:flutter/material.dart';

import '../models/qualitative.dart';

class QualitativeItem extends StatelessWidget {
  final Qualitative itemData;

  QualitativeItem(this.itemData);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.amberAccent[700],
                    Colors.amberAccent[400],
                    Colors.amberAccent[700],
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.015,
              left: MediaQuery.of(context).size.width * 0.05,
              child: Text(
                itemData.parameterName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.08,
              right: 0,
              child: EditButton(),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.14 + 5,
              right: 0,
              child: DeleteButton(),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.08,
              left: MediaQuery.of(context).size.width * 0.03,
              height: MediaQuery.of(context).size.height * 0.25,
              child: DescriptionContainer(itemData: itemData),
            )
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
      ],
    );
  }
}

class DescriptionContainer extends StatelessWidget {
  const DescriptionContainer({
    Key key,
    @required this.itemData,
  }) : super(key: key);

  final Qualitative itemData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white54,
          border: Border.all(
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10)),
      width: MediaQuery.of(context).size.width * 0.7,
      child: SingleChildScrollView(
        child: Text(
          itemData.parameterDescription,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
          ),
          color: Colors.blueGrey[900].withOpacity(.9),
        ),
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.25,
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.delete,
                size: 20,
                color: Colors.amber,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Text(
                'Excluir',
                style: TextStyle(
                    color: Colors.grey[50],
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
          ),
          color: Colors.blueGrey[900].withOpacity(.9),
        ),
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.25,
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.settings,
                size: 20,
                color: Colors.amber,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Text(
                'Editar',
                style: TextStyle(
                    color: Colors.grey[50],
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
