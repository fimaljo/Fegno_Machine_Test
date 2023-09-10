import 'package:equatable/equatable.dart';

class GroupValue extends Equatable {
  GroupValue(this.couponSkiped,this.isTakeAwaySelected);
  bool couponSkiped;
  bool isTakeAwaySelected;

  @override
  List<Object> get props => [couponSkiped,isTakeAwaySelected];
}
