// ignore_for_file: library_private_types_in_public_api

import 'package:live_activities/models/live_activity_state.dart';

abstract class ActivityUpdate {
  ActivityUpdate({required this.activityId});

  final String activityId;

  factory ActivityUpdate.fromMap(Map<String, dynamic> map) {
    final status = LiveActivityState.values.byName(map['status']);
    final activityId = map['activityId'] as String;
    switch (status) {
      case LiveActivityState.active:
        return ActiveActivityUpdate._(activityId: activityId, activityToken: map['token'] as String);
      case LiveActivityState.ended:
      case LiveActivityState.dismissed:
        return EndedActivityUpdate._(activityId: activityId);
      case LiveActivityState.stale:
        return StaleActivityUpdate._(activityId: activityId);
      case LiveActivityState.unknown:
        return UnknownActivityUpdate._(activityId: activityId);
    }
  }

  TResult map<TResult extends Object?>({
    required TResult Function(ActiveActivityUpdate value) active,
    required TResult Function(EndedActivityUpdate value) ended,
    required TResult Function(StaleActivityUpdate value) stale,
    required TResult Function(UnknownActivityUpdate value) unknown,
  });

  @override
  String toString() {
    return '$runtimeType(activityId: $activityId)';
  }
}

class ActiveActivityUpdate extends ActivityUpdate {
  ActiveActivityUpdate._({required super.activityId, required this.activityToken});

  final String activityToken;

  @override
  map<TResult extends Object?>({
    required TResult Function(ActiveActivityUpdate value) active,
    required TResult Function(EndedActivityUpdate value) ended,
    required TResult Function(StaleActivityUpdate value) stale,
    required TResult Function(UnknownActivityUpdate value) unknown,
  }) {
    return active(this);
  }

  @override
  String toString() {
    return '$runtimeType(activityId: $activityId, activityToken: $activityToken)';
  }
}

class EndedActivityUpdate extends ActivityUpdate {
  EndedActivityUpdate._({required super.activityId});

  @override
  map<TResult extends Object?>({
    required TResult Function(ActiveActivityUpdate value) active,
    required TResult Function(EndedActivityUpdate value) ended,
    required TResult Function(StaleActivityUpdate value) stale,
    required TResult Function(UnknownActivityUpdate value) unknown,
  }) {
    return ended(this);
  }
}

class StaleActivityUpdate extends ActivityUpdate {
  StaleActivityUpdate._({required super.activityId});

  @override
  map<TResult extends Object?>({
    required TResult Function(ActiveActivityUpdate value) active,
    required TResult Function(EndedActivityUpdate value) ended,
    required TResult Function(StaleActivityUpdate value) stale,
    required TResult Function(UnknownActivityUpdate value) unknown,
  }) {
    return stale(this);
  }
}

class UnknownActivityUpdate extends ActivityUpdate {
  UnknownActivityUpdate._({required super.activityId});

  @override
  map<TResult extends Object?>({
    required TResult Function(ActiveActivityUpdate value) active,
    required TResult Function(EndedActivityUpdate value) ended,
    required TResult Function(StaleActivityUpdate value) stale,
    required TResult Function(UnknownActivityUpdate value) unknown,
  }) {
    return unknown(this);
  }
}
