import 'package:metamall/constants/global_variables.dart';
import 'package:metamall/constants/utils.dart';
import 'package:metamall/features/address/services/address_services.dart';
import 'package:metamall/features/search/screens/search_screen.dart';
import 'package:metamall/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_textfield.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController flatBuildingController =
        TextEditingController();
    final TextEditingController areaController = TextEditingController();
    final TextEditingController pincodeController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final _addressFormKey = GlobalKey<FormState>();
    String addressToBeUsed = "";
    List<PaymentItem> paymentItems = [];
    final AddressServices addressServices = AddressServices();

    void onGooglePayResult(res) {
      if (Provider.of<UserProvider>(context).user.address.isEmpty) {
        addressServices.saveUserAddress(
            context: context, address: addressToBeUsed);
      }
    }

    @override
    void initState() {
      super.initState();
      paymentItems.add(
        PaymentItem(
            amount: widget.totalAmount,
            label: 'Total Amount',
            status: PaymentItemStatus.final_price),
      );
    }

    void payPressed(String addressFromProvider) {
      addressToBeUsed = "";
      bool isForm = flatBuildingController.text.isNotEmpty ||
          areaController.text.isNotEmpty ||
          pincodeController.text.isNotEmpty ||
          cityController.text.isNotEmpty;

      if (isForm) {
        if (_addressFormKey.currentState!.validate()) {
          addressToBeUsed =
              '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
        } else {
          throw Exception('Please enter all the values!');
        }
      } else if (addressFromProvider.isNotEmpty) {
        addressToBeUsed = addressFromProvider;
      } else {
        showSnackbar(context, 'ERROR');
      }
    }

    void navigateToSearchScreen(String query) {
      Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    }

    @override
    void dispose() {
      super.dispose();
      flatBuildingController.dispose();
      areaController.dispose();
      pincodeController.dispose();
      cityController.dispose();
    }

    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Text('Address'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter your',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) =>
                          GlobalVariables.primaryGradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Address',
                            style: TextStyle(
                                fontSize: 34, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: 'Flat, House No., Building',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: areaController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: cityController,
                      hintText: 'City',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GooglePayButton(
                onPressed: () => (address),
                paymentConfigurationAsset: 'gpay.json',
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                height: 52,
                width: double.infinity,
                style: GooglePayButtonStyle.white,
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 16),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
