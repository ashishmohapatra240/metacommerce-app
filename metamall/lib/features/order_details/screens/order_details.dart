import 'package:metamall/common/widgets/custom_button.dart';
import 'package:metamall/features/admin/services/admin_services.dart';
import 'package:metamall/features/search/screens/search_screen.dart';
import 'package:metamall/models/order.dart';
import 'package:metamall/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  static const routeName = '/order-details';
  final Order order;
  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentStep = widget.order.status;
  }

//!!!ONLY FOR ADMIN!!!!
  void changeOrderStatus(status) {
    adminServices.changeOrderStatus(
        context: context,
        status: status,
        order: widget.order,
        onSuccess: () {
          setState() {
            currentStep += 1;
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    void navigateToSearchScreen(String query) {
      Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    }

    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'View order details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Date:      ${DateFormat().format(
                      DateTime.fromMillisecondsSinceEpoch(
                          widget.order.orderedAt),
                    )}'),
                    Text('Order ID:          ${widget.order.id}'),
                    Text('Order Total:       ₹${widget.order.totalPrice}'),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Purchase Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Qty: ${widget.order.quantity[i]}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Tracking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    if (user.type == 'admin') {
                      return CustomButton(
                          text: 'Done',
                          onTap: () {
                            changeOrderStatus(details.currentStep);
                          });
                    } else {
                      return const SizedBox();
                    }
                  },
                  steps: [
                    Step(
                      title: const Text('Pending'),
                      content: const Text('Your order is Pending'),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Completed'),
                      content: const Text(
                          'Your order has dispatched'),
                      isActive: currentStep > 1,
                    ),
                    Step(
                      title: const Text('Recieved'),
                      content: const Text(
                          'Your order is out for delivery'),
                      isActive: currentStep > 2,
                    ),
                    Step(
                      title: const Text('Delivered'),
                      content: const Text(
                          'Your order has been Recieved'),
                      isActive: currentStep >= 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
