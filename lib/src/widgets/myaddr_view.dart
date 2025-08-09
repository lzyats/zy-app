import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';

class ChineseCityPickerPage extends StatefulWidget {
  @override
  ChineseCityPickerPageState createState() => new ChineseCityPickerPageState();
}

class ChineseCityPickerPageState extends State<ChineseCityPickerPage> {
  String area = '';
  String area1 = '';
  String area2 = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('城市三级联动选择器'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Container(
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_location),
                    this.area.length > 0
                        ? Text(
                            "$area",
                            style: TextStyle(color: Colors.black54),
                          )
                        : Text("省/市/区", style: TextStyle(color: Colors.black54))
                  ],
                ),
                onTap: () async {
                  Result? result = await CityPickers.showCityPicker(
                      context: context,
                      cancelWidget: Text(
                        "取消",
                        style: TextStyle(color: Colors.black),
                      ),
                      confirmWidget: Text(
                        "确定",
                        style: TextStyle(color: Colors.black),
                      ));
                  print(result);
                  setState(() {
                    this.area =
                        "${result!.provinceName}/${result.cityName}/${result.areaName}";
                  });
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_location),
                    this.area1.length > 0
                        ? Text(
                            "$area1",
                            style: TextStyle(color: Colors.black54),
                          )
                        : Text("省/市/区", style: TextStyle(color: Colors.black54))
                  ],
                ),
                onTap: () async {
                  Result? result1 = await CityPickers.showFullPageCityPicker(
                    context: context,
                  );
                  print(result1);
                  setState(() {
                    this.area1 =
                        "${result1!.provinceName}/${result1.cityName}/${result1.areaName}";
                  });
                },
              ),
            ),
            Container(
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_location),
                    this.area2.length > 0
                        ? Text(
                            "$area2",
                            style: TextStyle(color: Colors.black54),
                          )
                        : Text("省/市/区", style: TextStyle(color: Colors.black54))
                  ],
                ),
                onTap: () async {
                  Result? result2 = await CityPickers.showCitiesSelector(
                    context: context,
                  );
                  print(result2);
                  setState(() {
                    this.area2 =
                        "${result2!.provinceName}/${result2.cityName}/${result2.areaName}";
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(ChineseCityPickerPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
