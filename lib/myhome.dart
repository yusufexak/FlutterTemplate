import 'package:denemehttp/Model/fakemodel.dart';
import 'package:denemehttp/Model/weathermodel.dart';
import 'package:denemehttp/Service/web_service.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Fake> list;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    listd();
  }

  void listd() async {
    loadingStatus(true);

    //WeatherModel model = await fetchWeather();
    //print(model.sys.message);
    list = await fetchAll();
    loadingStatus(false);
  }

  loadingStatus(bool status) {
    setState(() {
      loading = status;
    });
  }

  Future<List<Fake>> fetchAll() async {
    List<Fake> serviceResponse = await WebService().getData<List<Fake>, Fake>(
        url: "https://jsonplaceholder.typicode.com/posts", model: Fake());

    return serviceResponse;
  }

  Future<WeatherModel> fetchWeather() async {
    WeatherModel weatherResponse = await WebService().getData<WeatherModel,
            String>(
        url:
            "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=439d4b804bc8187953eb36d2a8c26a02",
        model: WeatherModel());
    return weatherResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(list[index].title),
                    leading: Text(list[index].id.toString()),
                  );
                },
              ),
      ),
    );
  }
}
