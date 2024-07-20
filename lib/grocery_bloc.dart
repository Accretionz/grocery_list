import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

part 'grocery_event.dart';
part 'grocery_state.dart';

class GroceryBloc extends Bloc<GroceryEvent, GroceryState> {
  GroceryBloc() : super(GroceryInitial()) {
    on<LoadGroceries>(_onLoadGroceries);
    on<AddGrocery>(_onAddGrocery);
    on<RemoveGrocery>(_onRemoveGrocery);
    on<EditGrocery>(_onEditGrocery);
  }

  Future<void> _onLoadGroceries(
      LoadGroceries event, Emitter<GroceryState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final groceryList = prefs.getStringList('groceries') ?? [];
    emit(GroceryLoaded(List<String>.from(groceryList)));
  }

  Future<void> _onAddGrocery(
      AddGrocery event, Emitter<GroceryState> emit) async {
    if (state is GroceryLoaded) {
      final List<String> updatedList =
          List.from((state as GroceryLoaded).groceries)..add(event.grocery);
      await _saveGroceryList(updatedList);
      emit(GroceryLoaded(updatedList));
    }
  }

  Future<void> _onRemoveGrocery(
      RemoveGrocery event, Emitter<GroceryState> emit) async {
    if (state is GroceryLoaded) {
      final List<String> updatedList =
          List.from((state as GroceryLoaded).groceries)..remove(event.grocery);
      await _saveGroceryList(updatedList);
      emit(GroceryLoaded(updatedList));
    }
  }

  Future<void> _onEditGrocery(
      EditGrocery event, Emitter<GroceryState> emit) async {
    if (state is GroceryLoaded) {
      final List<String> updatedList =
          List.from((state as GroceryLoaded).groceries)
            ..[event.index] = event.newGrocery;
      await _saveGroceryList(updatedList);
      emit(GroceryLoaded(updatedList));
    }
  }

  Future<void> _saveGroceryList(List<String> groceryList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('groceries', groceryList);
  }
}
