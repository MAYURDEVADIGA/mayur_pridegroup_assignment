import 'dart:async';
import 'dart:isolate';
import 'dart:math';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mayur_pridegroup_assignment/bloc/currency_pair_bloc.dart';
import 'package:mayur_pridegroup_assignment/constants.dart';
import 'package:mayur_pridegroup_assignment/repositories/currency_pairs_repository.dart';
import 'candle_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

void computeHeavyTask(SendPort sendPort) {
  double bid1 = Random().nextDouble() * 100;
  double bid2 = Random().nextDouble() * 100;
  double bid3 = Random().nextDouble() * 100;
  double ask1 = Random().nextDouble() * 100;
  double ask2 = Random().nextDouble() * 100;
  double ask3 = Random().nextDouble() * 100;
  List res = [bid1, bid2, bid3, ask1, ask2, ask3];

  sendPort.send(res);
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> bidBgColor = [];
  List<Color> askBgColor = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < currencyPairs.length; i++) {
      bidBgColor.add(Colors.transparent);
      askBgColor.add(Colors.transparent);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      body: BlocBuilder<CurrencyPairBloc, CurrencyPairState>(
        builder: (context, state) {
          if (state is CurrencyPairInitial) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (state is CurrencyPairLoaded) {
            for (int i = 0; i < state.currencyPairs.length; i++) {
              Timer.periodic(const Duration(seconds: 1), (timer) async {
                //call the isolate function
                double previousBid = state.currencyPairs[i].bid2;
                double previousAsk = state.currencyPairs[i].ask2;
                final receivePort = ReceivePort();
                await Isolate.spawn(computeHeavyTask, receivePort.sendPort);
                receivePort.listen((res) {
                  context.read<CurrencyPairBloc>().add(ChangeBids(
                        i,
                        res[0],
                        res[1],
                        res[2],
                        Candle(
                          date: DateTime.now(),
                          open: res[0],
                          close: res[5],
                          high: res[1],
                          low: res[4],
                          volume: 50,
                        ),
                      ));
                  context.read<CurrencyPairBloc>().add(ChangeAsks(
                        i,
                        res[3],
                        res[4],
                        res[5],
                      ));

                  setState(() {
                    bidBgColor[i] =
                        previousBid < res[1] ? Colors.green : Colors.red;
                    askBgColor[i] =
                        previousAsk < res[4] ? Colors.green : Colors.red;
                  });
                });
              });
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < state.currencyPairs.length; i++)
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: width,
                      height: 70,
                      color: Colors.grey[900],
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                state.currencyPairs[i].icon,
                                WhiteText(
                                    title: state.currencyPairs[i].title,
                                    size: 20,
                                    fontWeight: FontWeight.bold),
                              ],
                            ),
                          ),
                          Flexible(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    color: bidBgColor[i],
                                    width: 135,
                                    height: 70,
                                    child: Center(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          WhiteText(
                                            title: state.currencyPairs[i].bid1
                                                .toStringAsFixed(2),
                                          ),
                                          WhiteText(
                                              title: state.currencyPairs[i].bid2
                                                  .toStringAsFixed(0),
                                              size: 30),
                                          WhiteText(
                                            title: state.currencyPairs[i].bid3
                                                .toStringAsFixed(0),
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    color: askBgColor[i],
                                    width: 135,
                                    height: 70,
                                    child: Center(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          WhiteText(
                                            title: state.currencyPairs[i].ask1
                                                .toStringAsFixed(2),
                                            //size: 18,
                                          ),
                                          WhiteText(
                                              title: state.currencyPairs[i].ask2
                                                  .toStringAsFixed(0),
                                              size: 30),
                                          WhiteText(
                                            title: state.currencyPairs[i].ask3
                                                .toStringAsFixed(0),
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                ],
              ),
            );
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.withOpacity(0.5),
        child: const Icon(Icons.bar_chart, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CandleScreen()),
          );
        },
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                WhiteText(
                  title: '!',
                  fontStyle: FontStyle.italic,
                ),
                WhiteText(title: 'Symbol'),
              ],
            ),
          ),
          Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  WhiteText(title: 'Bid'),
                  SizedBox(
                    width: 100,
                  ),
                  WhiteText(title: 'Ask'),
                ],
              )),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
