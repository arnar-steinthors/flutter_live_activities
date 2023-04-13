class ActivityContent {
  ActivityContent._({required this.activityId, required this.contentState});

  factory ActivityContent.fromMap(Map<String, dynamic> map) {
    return ActivityContent._(
      activityId: map['id'],
      contentState: map..remove(map['id']),
    );
  }

  final String activityId;
  final Map<String, dynamic> contentState;
}
