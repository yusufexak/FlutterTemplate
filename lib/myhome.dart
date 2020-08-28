import 'package:denemehttp/Core/Service/Localization/language_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'Core/Service/Network/Response/responseModel.dart';
import 'Core/Service/Network/network_service.dart';
import 'Model/fakemodel.dart';
import 'Model/fakeuser.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  Future<ResponseModel<Fake>> fake;
  ResponseModel<FakeUser> user;

  bool loading = true;
  @override
  void initState() {
    super.initState();
    fake = fetchAll();
    httpInit();
  }

  void httpInit() async {
    loadingStatus(true);

    //WeatherModel model = await fetchWeather();

    user = await fetchUser();
    print(user.map.title);
    loadingStatus(false);
  }

  loadingStatus(bool status) {
    setState(() {
      loading = status;
    });
  }

  Future<ResponseModel<Fake>> fetchAll() async {
    ResponseModel<Fake> serviceResponse = await NetworkService.instance
        .getData<Fake>(
            url: "https://jsonplaceholder.typicode.com/posts", model: Fake());

    return serviceResponse;
  }

  Future<ResponseModel<FakeUser>> fetchUser() async {
    ResponseModel<FakeUser> user = await NetworkService.instance
        .getData<FakeUser>(
            url: "https://jsonplaceholder.cypress.io/todos/5",
            model: FakeUser());
    return user;
  }

  /*
  Future<WeatherModel> fetchWeather() async {
    WeatherModel weatherResponse = await NetworkService().getData<WeatherModel>(
        url:
            "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=439d4b804bc8187953eb36d2a8c26a02",
        model: WeatherModel());
    return weatherResponse;
  }*/
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        appBar: buildAppBar(),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //buildRow,
              FutureBuilder<ResponseModel<Fake>>(
                future: fake,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (!snapshot.data.isSucces) {
                      return Expanded(
                        child: Center(
                          child: Text("${snapshot.data.error.errorMessage}"),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.list.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data.list[index].title),
                            leading: Text(
                              snapshot.data.list[index].id.toString(),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Expanded(
                      child: Center(
                        child: Text("${snapshot.hasError}"),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          _globalKey.currentState.showBottomSheet(
            (context) => Container(
              color: Colors.amber,
              height: 100,
              child: Center(
                child: buildRowLang(context),
              ),
            ),
          );
        },
      ),
      title: Text("hello".tr().toString()),
    );
  }

  Row buildRowLang(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: LanguageService.instance.locales
          .map(
            (e) => FlatButton(
              onPressed: () {
                EasyLocalization.of(context).locale = e;
              },
              color: EasyLocalization.of(context).locale == e
                  ? Colors.red
                  : Colors.redAccent[100],
              child: Text(e.toLanguageTag()),
            ),
          )
          .toList(),
    );
  }

  Widget get buildRow => Container(
        padding: EdgeInsets.all(24),
        color: Colors.cyan,
        width: double.infinity,
        child: user.isSucces
            ? Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Chip(label: Text("${user.map.title}")),
                  Chip(label: Text("${user.map.id}")),
                  Chip(label: Text("${user.map.userId}")),
                  Chip(label: Text("${user.map.completed}")),
                ],
              )
            : Center(
                child: Text("${user.error.errorMessage}"),
              ),
      );
}
