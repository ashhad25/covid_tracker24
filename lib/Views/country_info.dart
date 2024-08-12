import 'package:covid_tracker/Services/states_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';

class CountryData extends StatefulWidget {
  String name, image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  CountryData({
    super.key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<CountryData> createState() => _CountryDataState();
}

class _CountryDataState extends State<CountryData> {
  final colorList = <Color>[
    const Color(0xFF4285F4),
    const Color(0xFF1aa260),
    const Color(0xFFde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
          elevation: 2,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .06,
                ),
                PieChart(
                  dataMap: {
                    "Total": double.parse(widget.totalCases.toString()),
                    "Recovered": double.parse(widget.totalRecovered.toString()),
                    "Deaths": double.parse(widget.totalDeaths.toString()),
                  },
                  chartValuesOptions: const ChartValuesOptions(
                      showChartValuesInPercentage: true),
                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                  legendOptions:
                      const LegendOptions(legendPosition: LegendPosition.left),
                  animationDuration: const Duration(milliseconds: 1200),
                  chartType: ChartType.ring,
                  colorList: colorList,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .067),
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .09),
                            ReusableRow(
                                title: 'Cases',
                                value: widget.totalCases.toString()),
                            ReusableRow(
                                title: 'Deaths',
                                value: widget.totalDeaths.toString()),
                            ReusableRow(
                                title: 'Recovered',
                                value: widget.totalRecovered.toString()),
                            ReusableRow(
                                title: 'Active',
                                value: widget.active.toString()),
                            ReusableRow(
                                title: 'Critical',
                                value: widget.critical.toString()),
                            ReusableRow(
                                title: 'Today Deaths',
                                value: widget.totalDeaths.toString()),
                            ReusableRow(
                                title: 'Today Recovered',
                                value: widget.todayRecovered.toString()),
                          ],
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(widget.image),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
