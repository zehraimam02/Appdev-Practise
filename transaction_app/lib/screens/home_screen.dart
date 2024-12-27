import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/transaction_bloc.dart';
import '../models/transaction_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionInitial) {
              context.read<TransactionBloc>().add(LoadTransactions());
              return Center(child: CircularProgressIndicator());
            }

            if (state is TransactionLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is TransactionLoaded) {
              return Column(
                children: [
                  _buildHeader(state.totalBalance),
                  _buildTransactionsList(state.transactions),
                ],
              );
            }

            if (state is TransactionError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildHeader(double balance) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  // Handle back button logic
                },
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MONDAY',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '17 Nov',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                '\$${balance.toStringAsFixed(0)}',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Transactions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(List<TransactionModel> transactions) {
    return Expanded(
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return ListTile(
            leading: _buildIcon(transaction.category),
            title: Text(
              transaction.title,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              transaction.category,
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Text(
              '${transaction.amount > 0 ? '+' : ''}\$${transaction.amount.abs()}',
              style: TextStyle(
                color: transaction.amount > 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIcon(String category) {
    IconData iconData;
    Color backgroundColor;

    switch (category.toLowerCase()) {
      case 'shopping':
        iconData = Icons.shopping_bag;
        backgroundColor = Colors.blue.shade100;
        break;
      case 'grocery':
        iconData = Icons.local_grocery_store;
        backgroundColor = Colors.green.shade100;
        break;
      case 'transport':
        iconData = Icons.directions_car;
        backgroundColor = Colors.orange.shade100;
        break;
      case 'payment':
        iconData = Icons.payment;
        backgroundColor = Colors.purple.shade100;
        break;
      default:
        iconData = Icons.person;
        backgroundColor = Colors.grey.shade100;
    }

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, color: Colors.black54),
    );
  }
}