import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../../../utils/my_colors.dart';
import 'delivery_orders_list_controller.dart';

class DeliveryOrdersListPage extends StatefulWidget {
  const DeliveryOrdersListPage({Key key}) : super(key: key);

  @override
  State<DeliveryOrdersListPage> createState() => _DeliveryOrdersListPageState();
}

class _DeliveryOrdersListPageState extends State<DeliveryOrdersListPage> {

  final DeliveryOrdersListController _con = DeliveryOrdersListController();

  @override
  void initState(){
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar: AppBar(
          leading: _menuDrawer()
      ),
      drawer: _drawer(),
      body: Center(
          child: ElevatedButton(
              onPressed: _con.logout,
              child: const Text("Cerrar Sesion")
          )
      ),
    );
  }

  Widget _menuDrawer(){
    return GestureDetector(
        onTap: _con.openDrawer,
        child: Container(
            margin: const EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/img/menu.png',
              width: 20,
              height: 20,
            )
        )
    );
  }

  Widget _drawer(){
    return Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                    color: MyColors.primaryColor
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      _con.user?.email ?? '',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[200],
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      _con.user?.phone ?? '',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[200],
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic
                      ),
                      maxLines: 1,
                    ),
                    Container(
                      height: 60,
                      margin: const EdgeInsets.only(top: 10),
                      child: FadeInImage(
                        image: _con.user?.image != null
                            ? NetworkImage(_con.user?.image)
                            : const AssetImage('assets/img/no-image.png'),
                        fit: BoxFit.contain,
                        fadeInDuration: const Duration(milliseconds: 50),
                        placeholder: const AssetImage('assets/img/no-image.png'),
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                title: const Text('Seleccionar Rol'),
                trailing: const Icon(Icons.person_outlined),
                onTap: _con.goToRoles,
              ),
              ListTile(
                title: const Text('Cerrar Sesion'),
                trailing: const Icon(Icons.power_settings_new_outlined),
                onTap: _con.logout,
              )
            ]
        )
    );
  }

  void refresh(){
    setState(() {});
  }
}
