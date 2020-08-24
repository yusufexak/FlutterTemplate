import 'package:denemehttp/Model/fakemodel.dart';
import 'package:denemehttp/Model/fakeuser.dart';
import 'package:denemehttp/Service/IResponseModel.dart';
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
    var a = await fetchAll();
    list = a.list;
    var t = await fetchUser();
    user = t.data;
    print(user.title);
    print(t.msg);
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
        url: "https://jsonplaceholder.cypress.io/todos/4", model: FakeUser());
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      color: Colors.cyan,
                      height: 120,
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("${user.id}"),
                          Text("${user.title}"),
                          Text("${user.userId}"),
                          Text("${user.completed}"),
                        ],
                      )),
                  buildListView(),
                ],
              ),
            ),
    );
  }

  Widget buildListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(list[index].title),
            leading: Text(list[index].id.toString()),
          );
        },
      ),
    );
  }
}
