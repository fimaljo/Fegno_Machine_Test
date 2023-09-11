import 'package:equatable/equatable.dart';

class GroupValue extends Equatable {
  GroupValue(this.couponSkiped, this.isTakeAwaySelected, this.addInstruction);
  bool couponSkiped;
  bool isTakeAwaySelected;
  bool addInstruction = false;
  @override
  List<Object> get props => [couponSkiped, isTakeAwaySelected, addInstruction];
}
