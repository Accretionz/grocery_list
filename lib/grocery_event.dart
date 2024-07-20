part of 'grocery_bloc.dart';

abstract class GroceryEvent extends Equatable {
  const GroceryEvent();

  @override
  List<Object> get props => [];
}

class LoadGroceries extends GroceryEvent {}

class AddGrocery extends GroceryEvent {
  final String grocery;

  const AddGrocery(this.grocery);

  @override
  List<Object> get props => [grocery];
}

class RemoveGrocery extends GroceryEvent {
  final String grocery;

  const RemoveGrocery(this.grocery);

  @override
  List<Object> get props => [grocery];
}

class EditGrocery extends GroceryEvent {
  final int index;
  final String newGrocery;

  const EditGrocery(this.index, this.newGrocery);

  @override
  List<Object> get props => [index, newGrocery];
}
