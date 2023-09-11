import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/bag/bloc/cart_bloc.dart';
import '../../domain/bag/model/coupon.dart';
import '../../widgets/coupon_widget.dart';
import '../../widgets/coustome_popup_widget.dart';
import '../../widgets/doted_separator.dart';
import '../../widgets/product_bag_card.dart';
import '../../widgets/received_message_screen.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_input_field.dart';
import '../../widgets/row_content_widget.dart';
import '../../widgets/send_messsage_screen.dart';
import '../../widgets/text_field_container.dart';

class BagScreen extends StatefulWidget {
  const BagScreen({super.key});

  @override
  State<BagScreen> createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  late OverlayEntry overlayEntry;

  final TextEditingController _instructionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color myGreenColor = const Color(0xFF008754);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 235, 235),
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            return state.cart.groupBoolValue[0].addInstruction == false
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      RoundedInputField(
                        controller: _instructionController,
                        hintText: "Add Your instruction",
                      ),
                      InkWell(
                        onTap: () {
                          context.read<CartBloc>().add(AddInstruction(false));
                        },
                        child: CircleAvatar(
                          backgroundColor: myGreenColor,
                          radius: 20,
                          child: const Icon(
                            Icons.arrow_outward_outlined,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  );
          } else {
            return SizedBox();
          }
        },
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return switch (state) {
              CartLoading() => const CircularProgressIndicator(),
              CartError() => const Text('Something went wrong!'),
              CartLoaded() => Column(
                  children: [
                    SentMessageScreen(
                      children: [
                        RowContentWidget(
                          title: Text(
                            "Cart (${(state.cart.items.length)})",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          action: const Icon(Icons.expand_less),
                        ),
                        const DotedSeparator(),
                        RowContentWidget(
                          title: const Text(
                            "Grand Totel",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          action: Text(
                            '\u{20B9} ${state.cart.discount}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: myGreenColor),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "There might be a change in the final bill which will be generated from the shop",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 13),
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.cart.items.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final item = state.cart.items[index];
                            return ProductBagCard(
                              name: item.name,
                              image: item.image,
                              count: item.count,
                              price: item.price,
                              quantity: item.quantity,
                              unit: item.unit,
                              item: item,
                            );
                          },
                        ),
                        const DotedSeparator(),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add More Items",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.add,
                                size: 15,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    state.cart.couponAvilCheck
                        ? const SizedBox()
                        : Column(
                            children: [
                              ReceivedMessageScreen(
                                widget: RichText(
                                  text: TextSpan(
                                    text: 'Add Products Worth ',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            '\u{20B9} ${state.cart.couponAvilePrice}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: ' to avail coupon ',
                                        style: TextStyle(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              RoundedButton(
                                  text: "Proceed",
                                  color: myGreenColor,
                                  textColor: Colors.white,
                                  onPressed: () {}),
                            ],
                          ),
                    state.cart.couponAvilCheck
                        ? Column(
                            children: [
                              ReceivedMessageScreen(
                                widget: CouponWidget(
                                  firstText:
                                      "${state.cart.coupons.length} Unused Coupons",
                                  secondText: "Applay coupon and get discount",
                                ),
                              ),
                              state.cart.discounts.isNotEmpty ||
                                      state.cart.groupBoolValue[0].couponSkiped
                                  ? const SizedBox()
                                  : RoundedButton(
                                      text: "Continue without applying",
                                      textColor: myGreenColor,
                                      onPressed: () {
                                        context
                                            .read<CartBloc>()
                                            .add(const CoupenSkiped(true));
                                      },
                                    ),
                              state.cart.discounts.isNotEmpty ||
                                      state.cart.groupBoolValue[0].couponSkiped
                                  ? const SizedBox()
                                  : RoundedButton(
                                      text: "Applay coupon",
                                      color: myGreenColor,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        applayCoupenMethod(
                                            context, state, myGreenColor);
                                      },
                                    ),
                            ],
                          )
                        : const SizedBox(),
                    state.cart.discounts.isNotEmpty
                        ? SentMessageScreen(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Yahoo!!!\n ',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: 'i won',
                                        style: TextStyle(),
                                      ),
                                      TextSpan(
                                        text:
                                            ' \u{20B9} ${state.cart.discounts.first.disCountAdded}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: myGreenColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    state.cart.groupBoolValue[0].isTakeAwaySelected == true
                        ? const ReceivedMessageScreen(
                            widget: Text("Select delivery method"))
                        : const SizedBox(),
                    state.cart.discounts.isNotEmpty ||
                            state.cart.groupBoolValue[0].couponSkiped == true
                        ? state.cart.groupBoolValue[0].isTakeAwaySelected !=
                                false
                            ? const SizedBox()
                            : Column(
                                children: [
                                  const ReceivedMessageScreen(
                                      widget: Text("Select delivery method")),
                                  RoundedButton(
                                    needIcon: true,
                                    iconData: Icons.home_outlined,
                                    text: "Home delivery",
                                    textColor: myGreenColor,
                                    onPressed: () {},
                                  ),
                                  RoundedButton(
                                    needIcon: true,
                                    iconData: Icons.takeout_dining_outlined,
                                    text: "Take away",
                                    textColor: myGreenColor,
                                    onPressed: () {
                                      context
                                          .read<CartBloc>()
                                          .add(const TakeAwaySelected(true));
                                    },
                                  ),
                                ],
                              )
                        : const SizedBox(),
                    state.cart.groupBoolValue[0].isTakeAwaySelected
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SentMessageScreen(children: [
                                Text(" I prefer Take away    "),
                              ]),
                              const ReceivedMessageScreen(
                                widget: Text(
                                    "Please select a time slot to collect the products from our store"),
                              ),
                              state.cart.selectedTime.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Wrap(
                                        children: state.cart.timeSlots
                                            .map(
                                              (e) => InkWell(
                                                onTap: () {
                                                  context
                                                      .read<CartBloc>()
                                                      .add(TimeSloteAdded(e));
                                                },
                                                child: TextFieldContainer(
                                                  width: 150,
                                                  child: Text(
                                                    e.timeSlotes,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          )
                        : const SizedBox(),
                    state.cart.selectedTime.isEmpty
                        ? const SizedBox()
                        : Column(
                            children: [
                              SentMessageScreen(
                                children: [
                                  Text(state.cart.selectedTime),
                                ],
                              ),
                              ReceivedMessageScreen(
                                widget: Column(
                                  children: [
                                    const Text(
                                      "Bill Details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    RowContentWidget(
                                      title: const Text(
                                        "Item Total",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      action: Text(
                                        "\u{20B9} ${state.cart.totalPrice}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                    ),
                                    RowContentWidget(
                                      title: const Text(
                                        "Coupon discount",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13),
                                      ),
                                      action: Text(
                                        "\u{20B9} -${state.cart.gainedDiscount}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: myGreenColor),
                                      ),
                                    ),
                                    const DotedSeparator(),
                                    RowContentWidget(
                                      title: const Text(
                                        "Grand Totel",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      ),
                                      action: Text(
                                        '\u{20B9} ${state.cart.discount}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            color: myGreenColor),
                                      ),
                                    ),
                                    const DotedSeparator(),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "There might be a change in the final bill which will be generated from the shop",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13),
                                      ),
                                    ),
                                    const DotedSeparator(),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<CartBloc>()
                                            .add(AddInstruction(true));
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Add Instraction",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Icon(
                                              Icons.add,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              _instructionController.text.isNotEmpty
                                  ? Column(
                                      children: [
                                        SentMessageScreen(children: [
                                          Text(_instructionController.text)
                                        ]),
                                        const ReceivedMessageScreen(
                                            widget: Text(
                                                "Your Instraction has been shared to the shop owner"))
                                      ],
                                    )
                                  : const SizedBox(),
                              RoundedButton(
                                text: "Cancel",
                                textColor: Colors.black,
                                onPressed: () {},
                              ),
                              RoundedButton(
                                text: "Place Order",
                                textColor: Colors.white,
                                color: myGreenColor,
                                onPressed: () {},
                              ),
                            ],
                          )
                  ],
                )

              // ListView.separated(
              //     shrinkWrap: true,
              //     itemCount: state.cart.items.length,
              //     separatorBuilder: (_, __) => const SizedBox(height: 4),
              //     itemBuilder: (context, index) {
              //       final item = state.cart.items[index];
              //       return Material(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(16),
              //         ),
              //         clipBehavior: Clip.hardEdge,
              //         child: ListTile(
              //           leading: const Icon(Icons.done),
              //           title: Text(
              //             item.name,
              //           ),
              //           onLongPress: () {
              //             context
              //                 .read<CartBloc>()
              //                 .add(CartItemRemoved(item));
              //           },
              //         ),
              //       );
              //     },
              //   ),
            };
          },
        ),
      ),
    );
  }

  Future<dynamic> applayCoupenMethod(
      BuildContext context, CartLoaded state, Color myGreenColor) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        final double check = size.width / 8;
        return Stack(
          children: [
            Positioned(
              child: AlertDialog(
                backgroundColor: Colors.white,
                content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return SizedBox(
                      height: 450,
                      width: double.infinity,
                      // color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          CouponWidget(
                            firstTextSize: 14,
                            secondTextSize: 13,
                            firstText: "Applay Coupon and get discount",
                            secondText:
                                "${state.cart.coupons.length} Unused Coupons",
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 300,
                            width: 400,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              shrinkWrap: true,
                              itemCount: state.cart.coupons.length,
                              itemBuilder: (context, index) {
                                final coupon = state.cart.coupons[index];
                                return InkWell(
                                  onTap: () {
                                    showOverlay(coupon);
                                    context.read<CartBloc>().add(CouponAdded(
                                        coupon, coupon.discountAmount));
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFffffff),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(40, 158, 158, 158),
                                          blurRadius: 5,
                                          spreadRadius: 0.0,
                                          offset: Offset(
                                            5.0,
                                            5.0,
                                          ),
                                        )
                                      ],
                                    ),
                                    child: Image.asset(
                                        "assets/images/couponGift-removebg-preview.png"),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                            width: 300,
                            child: DotedSeparator(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Note : Applay Coupon and get discount enjoy $check ",
                            style: const TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 13),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: size.width / 0.6,
              left: size.width / 6,
              width: 300,
              child: RoundedButton(
                textColor: myGreenColor,
                text: "Continue Without applying",
                onPressed: () {},
              ),
            )
          ],
        );
      },
    );
  }

  void showOverlay(Coupon couponData) {
    overlayEntry = OverlayEntry(builder: (context) {
      return Stack(
        children: [
          // Dark background overlay
          Positioned.fill(
            child: GestureDetector(
              onTap: hideOverlay,
              child: Container(
                color:
                    Colors.black.withOpacity(0.5), // Adjust opacity as needed
              ),
            ),
          ),
          // Your custom popup
          Center(
            child: CustomPopupWidget(
              couponData: couponData,
            ),
          ),
        ],
      );
    });
    Overlay.of(context).insert(overlayEntry);
  }

  void hideOverlay() {
    Navigator.pop(context);
    overlayEntry.remove();
  }
}
