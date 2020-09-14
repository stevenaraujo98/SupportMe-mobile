import 'package:flutter/material.dart';
import 'package:supportme/auth/session.dart';
import 'package:supportme/views/hueca.dart';
import 'package:supportme/views/map_view.dart';
import 'package:supportme/views/profile.dart';
import 'buscar.dart';
import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _bottomNavigationIndex = 0;
  Widget _widget;

  @override
  void initState() {
    _widget = MapView();
    super.initState();
  }

  _onItemTap(int index) async {
    setState(() {
      if (index == 0 || index == 2 || index == 3) _bottomNavigationIndex = index;
    });
    switch (index) {
      case 0:
        setState(() {
          _widget = MapView();
        });
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => BuscarView()));
        break;
      case 2:
        setState(() {
          _widget = HuecaView();
        });
        break;
      case 3:
        if (Session.instance.isAuthenticate) {
          setState(() {
            _widget = Container();
          });
        } else {
          bool login = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Login()));
          if(login ?? false){
            setState(() {
            _widget = Container();
            });
          }
        }
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widget,
      bottomNavigationBar: BottomMenu(
        bottomNavigationIndex: _bottomNavigationIndex,
        onItemTap: _onItemTap,
      ),
    );
  }
}

class BottomMenu extends StatelessWidget {
  final Function(int) onItemTap;
  final int bottomNavigationIndex;

  const BottomMenu(
      {Key key, @required this.bottomNavigationIndex, this.onItemTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: bottomNavigationIndex,
        onTap: onItemTap,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("Inicio")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text("Buscar")),
          BottomNavigationBarItem(
              icon: Icon(Icons.add), title: Text("Nuevo")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Perfil"))
        ]);
  }
}
