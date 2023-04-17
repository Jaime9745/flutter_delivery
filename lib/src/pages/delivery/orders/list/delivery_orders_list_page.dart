import 'package:flutter/material.dart';

class DeliveryOrdersListPage extends StatefulWidget {
  const DeliveryOrdersListPage({Key key}) : super(key: key);

  @override
  State<DeliveryOrdersListPage> createState() => _DeliveryOrdersListPageState();
}

class _DeliveryOrdersListPageState extends State<DeliveryOrdersListPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Delivery Orders List'),
      ),
    );
  }
}
