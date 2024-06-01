import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';

class Graph extends StatefulWidget {
  @override
  State<Graph> createState() => GraphPage();
}

class GraphPage extends State<Graph> {
  Widget chartToRun() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData = ChartData(dataRowsColors: [
      Colors.green,
      Colors.red
    ], dataRows: [
      [2, 20, 10, 50],
      [6, 30, 30, 20]
    ], xUserLabels: [
      "avril",
      "mai",
      "juin",
      "juillet"
    ], dataRowsLegends: [
      "Les Don reussie",
      "annonces non reussie",
    ], chartOptions: ChartOptions());
    // ChartOptions chartOptions = const ChartOptions();
    // print(chartOptions);
    // Example shows a demo-type data generated randomly in a range.
    // chartData = RandomChartData.generated(chartOptions: chartOptions);
    // print(chartData.);
    var lineChartContainer = LineChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var lineChart = LineChart(
      painter: LineChartPainter(
        lineChartContainer: lineChartContainer,
      ),
    );
    return lineChart;
  }

  Widget chartToRun2() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    // xContainerLabelLayoutStrategy?.isRotateLabelsReLayout = true;
    ChartOptions chartOptions = const ChartOptions();
    chartOptions = const ChartOptions(
      dataContainerOptions: DataContainerOptions(
        yTransform: log10,
        yInverseTransform: inverseLog10,
      ),
    );
    chartData = ChartData(
      dataRowsColors: [Colors.blue],
      dataRows: const [
        [30, 60, 10],
      ],
      xUserLabels: const ['Janvier', 'Fevrier', 'Mars'],
      dataRowsLegends: const [
        'nombre des announces',
      ],
      chartOptions: chartOptions,
    );
    var verticalBarChartContainer = VerticalBarChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var verticalBarChart = VerticalBarChart(
      painter: VerticalBarChartPainter(
        verticalBarChartContainer: verticalBarChartContainer,
      ),
    );
    return verticalBarChart;
  }

  Widget chartToRun3() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    chartOptions = const ChartOptions(
      dataContainerOptions: DataContainerOptions(
        yTransform: log10,
        yInverseTransform: inverseLog10,
      ),
    );
    chartData = ChartData(
      dataRowsColors: [Colors.red, Colors.blue],
      dataRows: const [
        [50, 10, 100],
        [10, 100, 9],
      ],
      xUserLabels: const ['janvier', 'fevrier', 'mars'],
      dataRowsLegends: const [
        'A+',
        'O+',
      ],
      chartOptions: chartOptions,
    );
    var verticalBarChartContainer = VerticalBarChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var verticalBarChart = VerticalBarChart(
      painter: VerticalBarChartPainter(
        verticalBarChartContainer: verticalBarChartContainer,
      ),
    );
    return verticalBarChart;
  }

  void _chartStateChanger() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "widget.title",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              height: 40,
            ),
            Container(
              height: 400,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: chartToRun()), // verticalBarChart, lineChart
                ],
              ),
            ),
            Container(
              height: 30,
            ),
            Container(
              height: 400,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: chartToRun2()), // verticalBarChart, lineChart
                ],
              ),
            ),
            Container(
              height: 40,
            ),
            Container(
              height: 400,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: chartToRun3()), // verticalBarChart, lineChart
                ],
              ),
            ),
            Container(
              height: 300,
            )
          ],
        ),
      ),
    );
  }
}
