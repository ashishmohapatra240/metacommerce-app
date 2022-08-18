import 'package:metamall/common/widgets/custom_button.dart';
import 'package:metamall/features/account/services/account_services.dart';
import 'package:metamall/features/account/widgets/account_button.dart';
import 'package:metamall/features/account/widgets/below_app_bar.dart';
import 'package:metamall/features/account/widgets/orders.dart';
import 'package:metamall/constants/global_variables.dart';
import 'package:metamall/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountServices accountServices = AccountServices();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Orders(),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 64,
                decoration: BoxDecoration(
                    color: GlobalVariables.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Image.asset(
                              'assets/images/MetaCoins.png',
                              height: 48,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Metacoins',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        child: Center(
                          child: Text('4'),
                        ),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 236, 0, 140),
                              Color.fromARGB(255, 252, 103, 103),
                            ],
                            stops: [0.25, 0.75],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 324,
              ),
              CustomButton(
                  text: 'Log Out',
                  onTap: () {
                    accountServices.logOut(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
