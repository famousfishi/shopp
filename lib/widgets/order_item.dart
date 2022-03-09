import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopp/models/order_item.dart';
import 'package:intl/intl.dart';

class OrderItemm extends StatefulWidget {
  final OrderItem orderItem;

  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  OrderItemm({required this.orderItem});

  @override
  State<OrderItemm> createState() => _OrderItemmState();
}

class _OrderItemmState extends State<OrderItemm> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderItem.amount}'),
            subtitle: Text(
                DateFormat('dd-MM-yyyy').format(widget.orderItem.dateTime)),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    expanded = !expanded;
                  });
                },
                icon: Icon(expanded ? Icons.expand_less : Icons.expand_more)),
          ),
          if (expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              height: min(widget.orderItem.products.length * 20.0 + 10, 180),
              child: ListView.builder(
                  itemCount: widget.orderItem.products.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.orderItem.products[index].title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            '${widget.orderItem.products[index].quantity} X  \$${widget.orderItem.products[index].price}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey))
                      ],
                    );
                  }),
            )
        ],
      ),
    );
  }
}
