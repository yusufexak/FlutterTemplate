import 'package:denemehttp/Model/fakemodel.dart';
import 'package:denemehttp/Model/fakeuser.dart';
import 'package:denemehttp/Service/responseModel.dart';
import 'package:denemehttp/Service/web_service.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Fake> list;
  bool loading = true;
  FakeUser user;
  @override
  void initState() {
    super.initState();
    httpInit();
  }

  void httpInit() async {
    loadingStatus(true);

    //WeatherModel model = await fetchWeather();
    var responseAll = await fetchAll();
    list = responseAll.list;
    var responseUser = await fetchUser();
    user = responseUser.data;
    loadingStatus(false);
  }

  loadingStatus(bool status) {
    setState(() {
      loading = status;
    });
  }

  Future<ResponseModel<Fake>> fetchAll() async {
    ResponseModel<Fake> serviceResponse = await WebService().getData<Fake>(
        url: "https://jsonplaceholder.typicode.com/posts", model: Fake());

    return serviceResponse;
  }

  Future<ResponseModel<FakeUser>> fetchUser() async {
    ResponseModel<FakeUser> user = await WebService().getData<FakeUser>(
        url: "https://jsonplaceholder.cypress.io/todos/5", model: FakeUser());
    return user;
  }
/*
  Future<WeatherModel> fetchWeather() async {
    WeatherModel weatherResponse = await WebService().getData<WeatherModel>(
        url:
            "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=439d4b804bc8187953eb36d2a8c26a02",
        model: WeatherModel());
    return weatherResponse;
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildRow,
                    buildListView,
                  ],
                ),
              ),
      ),
    );
  }

  Widget get buildRow => Container(
        padding: EdgeInsets.all(24),
        color: Colors.cyan,
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            Chip(label: Text("${user.title}")),
            Chip(label: Text("${user.id}")),
            Chip(label: Text("${user.userId}")),
            Chip(label: Text("${user.completed}")),
          ],
        ),
      );

  Widget get buildListView => Expanded(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(list[index].title),
              leading: Text(
                list[index].id.toString(),
              ),
            );
          },
        ),
      );
}
