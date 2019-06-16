import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latter/core/models/update_interval.dart';
import 'package:latter/core/services/shared_preferences_service.dart';
import 'dart:async';

class IntervalService {
  final SharedPreferencesService _sharedPreferencesService;
  IntervalService({ SharedPreferencesService sharedPreferencesService }) : _sharedPreferencesService = sharedPreferencesService;

  final Duration messageInterval = Duration(minutes: 1);
  final Duration updateInterval = Duration(seconds: 1);

  Stream<UpdateInterval> get interval => streamMessageUpdateInterval();

  Stream<UpdateInterval> streamMessageUpdateInterval ()  {
    int lastUpdate = -1;

    return Stream.periodic(updateInterval, (_) {
      DateTime now = DateTime.now();
      bool shouldUpdate = false;

      Duration timePassed = Duration(seconds: now.difference(DateTime(now.year, now.month, now.day)).inSeconds);
      Duration remaining = Duration(seconds: (timePassed.inSeconds / messageInterval.inSeconds).ceil() * messageInterval.inSeconds - timePassed.inSeconds);

      if(lastUpdate != timePassed.inMinutes && timePassed.inMinutes % messageInterval.inMinutes == 0) {
        shouldUpdate = true;
        lastUpdate = timePassed.inMinutes;
      }

      return UpdateInterval((b) => b
        ..remaining = remaining
        ..shouldUpdate = shouldUpdate
        ..lastUpdate = DateTime(now.year, now.month, now.day).add(Duration(minutes: lastUpdate))
      );
    });
  }

  Stream<UpdateInterval> _streamMessgeUpdate () {
    int computationCount = 0;
    // ignore: close_sinks
    StreamController controller;
    // ignore: close_sinks
    controller = new StreamController(
      sync: true,
      onListen: () {
      },
    );

  }

}
