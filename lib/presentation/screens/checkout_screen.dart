import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:test_2go_bank/presentation/viewmodel/checkout_viewmodel.dart';

import 'components/add_product_bottomsheet.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CheckoutViewModel _viewModel = GetIt.I<CheckoutViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _addProductButton(),
                  _titlePage(),
                  _productList(),
                ],
              ),
            ),
          ),
          _totalValue(context),
        ],
      ),
    );
  }

  Widget _totalValue(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: -4,
      child: Card(
        elevation: 24,
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: [
              Observer(builder: (_) {
                return Text(
                  NumberFormat.simpleCurrency(locale: "pt_br")
                      .format(_viewModel.purchase.total),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              const SizedBox(width: 32),
              const Expanded(
                child: Text(
                  'Valor atualizado com as promoções',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productList() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Observer(builder: (_) {
          if (_viewModel.purchase.items.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum produto\nadicionado',
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            itemCount: _viewModel.purchase.items.length,
            itemBuilder: (context, index) {
              return _productItem(
                isFirst: index == 0,
                isLast: index == _viewModel.purchase.items.length - 1,
                index: index,
              );
            },
          );
        }),
      ),
    );
  }

  Widget _productItem(
      {required bool isFirst, required bool isLast, required int index}) {
    return Container(
      margin:
          EdgeInsets.fromLTRB(8, index == 0 ? 12 : 8, 8, index == 4 ? 100 : 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Observer(builder: (_) {
        return ListTile(
          title: Text(
            _viewModel.purchase.items[index].name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  NumberFormat.simpleCurrency(locale: "pt_br")
                      .format(_viewModel.purchase.items[index].price),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _viewModel.purchase.items[index].amount > 1
                          ? _viewModel.updateProductAmount(
                              _viewModel.purchase.items[index].id,
                              -1,
                            )
                          : null,
                      child: CircleAvatar(
                        backgroundColor:
                            _viewModel.purchase.items[index].amount == 1
                                ? Colors.grey[50]
                                : Colors.grey[100],
                        child: Icon(
                          Icons.remove_rounded,
                          color: _viewModel.purchase.items[index].amount == 1
                              ? Colors.grey[300]
                              : Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      width: 60,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[200]!,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child:
                            Text('${_viewModel.purchase.items[index].amount}'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _viewModel.updateProductAmount(
                        _viewModel.purchase.items[index].id,
                        1,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child: const Icon(
                          Icons.add_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => _viewModel
                          .removeProduct(_viewModel.purchase.items[index].id),
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[200]!),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          size: 20,
                          color: Colors.red[800]!,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Padding _titlePage() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Nova compra',
            style: TextStyle(fontSize: 26),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green[800],
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            child: Observer(builder: (_) {
              return Text(
                '${_viewModel.purchase.items.length} items',
                style: const TextStyle(fontSize: 12, color: Colors.white),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _addProductButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () => addProductBottomSheet(),
          child: const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.black,
            child: Icon(
              Icons.add_rounded,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
