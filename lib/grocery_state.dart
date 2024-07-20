part of 'grocery_bloc.dart';

abstract class GroceryState extends Equatable {
  const GroceryState();

  @override
  List<Object> get props => [];
}

class GroceryInitial extends GroceryState {}

class GroceryLoaded extends GroceryState {
  final List<String> groceries;

  const GroceryLoaded(this.groceries);

  @override
  List<Object> get props => [groceries];
}
