import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transaction_model.dart';

// Events
abstract class TransactionEvent {}

class LoadTransactions extends TransactionEvent {}

// States
abstract class TransactionState {}

class TransactionInitial extends TransactionState {}
class TransactionLoading extends TransactionState {}
class TransactionLoaded extends TransactionState {
  final List<TransactionModel> transactions;
  final double totalBalance;

  TransactionLoaded(this.transactions, this.totalBalance);
}
class TransactionError extends TransactionState {
  final String message;
  TransactionError(this.message);
}

// Bloc class
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TransactionBloc() : super(TransactionInitial()) {
    on<LoadTransactions>((event, emit) async {  // Handler for the LoadTransactions event
      emit(TransactionLoading());
      try {
        final QuerySnapshot snapshot = await _firestore
            .collection('transactions')
            .orderBy('date', descending: true)
            .get();

        final transactions = snapshot.docs
            .map((doc) => TransactionModel.fromFirestore(doc))
            .toList();

        final totalBalance = transactions.fold<double>(
          0,
          (sum, transaction) => sum + transaction.amount,
        );

        emit(TransactionLoaded(transactions, totalBalance));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });
  }
}