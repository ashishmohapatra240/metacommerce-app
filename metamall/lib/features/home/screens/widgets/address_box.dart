import 'package:metamall/constants/global_variables.dart';
import 'package:metamall/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Image.asset(
            'assets/images/appliances.png',
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                '| Delivery to ${user.name} - ${user.address}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(151, 151, 151, 1),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5, top: 2),
            child: Icon(
              Icons.arrow_drop_down_outlined,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
