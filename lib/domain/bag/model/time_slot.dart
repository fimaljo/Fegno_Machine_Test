import 'package:equatable/equatable.dart';

class TimeSlot extends Equatable {
  TimeSlot(this.timeSlotes, this.selectedTimeZone );

  String timeSlotes;
 bool selectedTimeZone;

  @override
  List<Object> get props => [timeSlotes, selectedTimeZone];
}
