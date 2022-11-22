import 'package:dog_did/global_widgets/color_scheme.dart';
import 'package:dog_did/global_widgets/dog_did_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return DogDidScaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SfCalendar(
        allowedViews: const [CalendarView.day, CalendarView.week, CalendarView.month, CalendarView.schedule],
        firstDayOfWeek: 1,
        // todayTextStyle: TextStyle(color: Colors.white),
        // scheduleViewSettings: const ScheduleViewSettings(
        //   appointmentTextStyle: TextStyle(color: Colors.white),
        //   dayHeaderSettings: DayHeaderSettings(dateTextStyle: TextStyle(color: Colors.white), dayTextStyle: TextStyle(color: Colors.white)),
        //   monthHeaderSettings: MonthHeaderSettings(monthTextStyle: TextStyle(color: Colors.white)),
        //   weekHeaderSettings: WeekHeaderSettings(weekTextStyle: TextStyle(color: Colors.white)),
        // ),
        monthViewSettings: const MonthViewSettings(
          showAgenda: true,
          monthCellStyle: MonthCellStyle(
            textStyle: TextStyle(color: Colors.white),
            leadingDatesTextStyle: TextStyle(color: Colors.grey),
            trailingDatesTextStyle: TextStyle(color: Colors.grey),
          ),
          agendaStyle: AgendaStyle(
            dayTextStyle: TextStyle(color: Colors.white),
            dateTextStyle: TextStyle(color: Colors.white),
            appointmentTextStyle: TextStyle(color: Colors.white),
          ),
        ),

        headerStyle: CalendarHeaderStyle(
          textAlign: TextAlign.center,
          textStyle: TextStyle(color: colorScheme().primary),
        ),
        viewHeaderStyle: ViewHeaderStyle(
          dayTextStyle: TextStyle(color: colorScheme().primary),
          dateTextStyle: TextStyle(color: colorScheme().primary),
        ),

        timeSlotViewSettings: const TimeSlotViewSettings(
          timelineAppointmentHeight: 40,
          timeTextStyle: TextStyle(color: Colors.white),
          timeInterval: Duration(minutes: 60),
          timeFormat: 'h:mm',
        ),
        scheduleViewSettings: const ScheduleViewSettings(
          appointmentTextStyle: TextStyle(fontFamily: 'SyneTactile', color: Colors.black),
          dayHeaderSettings: DayHeaderSettings(
            dateTextStyle: TextStyle(fontFamily: 'SyneTactile', color: Colors.black),
            dayTextStyle: TextStyle(fontFamily: 'SyneTactile', color: Colors.black),
          ),
          monthHeaderSettings: MonthHeaderSettings(
            monthTextStyle: TextStyle(fontFamily: 'SyneTactile', color: Colors.black),
          ),
          weekHeaderSettings: WeekHeaderSettings(
            weekTextStyle: TextStyle(fontFamily: 'SyneTactile', color: Colors.black),
          ),
        ),
        appointmentTextStyle: const TextStyle(fontFamily: 'SyneTactile', color: Colors.black),
      ),
    ));
  }
}
