import 'package:equatable/equatable.dart';

class Discount extends Equatable {
  Discount(this.disCountAdded);
  int disCountAdded;

  @override
  List<Object> get props => [disCountAdded];
}
