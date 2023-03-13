import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:tod/model/erro.dart';

class PieChart extends StatelessWidget {
  final List<Erro> seriesList;
  final bool animate;

  PieChart(this.seriesList, {this.animate = true});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF464646),
      body: body(context),
    );
  }

  Widget body(BuildContext context){
    List<charts.Series<Erro, String>> series = [
      charts.Series(
          id: "errors",
          data: seriesList,
          domainFn: (Erro series, _) => series.title,
          measureFn: (Erro series, _) => series.many,
          colorFn: (Erro series, _) => series.barColor
      )
    ];
    return Stack(
      children: [

        charts.PieChart(
          series,
          animate: animate,
          defaultRenderer: charts.ArcRendererConfig(
            arcRendererDecorators: [
              charts.ArcLabelDecorator(
                labelPosition: charts.ArcLabelPosition.inside,
              ),
            ],
          ),
        ),
        Positioned(top: 40,left: 30,right: 30,child: Row(
          children: [
            IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new,size: 35,color: Colors.white,)),
            Text("Statistics",style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),)
          ],
        ),),
      ],
    );
  }


}
