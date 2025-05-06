class Appointment {
  final String id;
  final String doctorId;
  final String patientId;
  final DateTime appointmentDateTime;
  final String reason;
  final String status;
  final bool useInsurance;
  final String? insuranceNumber;
  final String? insuranceProvider;
  final String? notes;

  Appointment({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.appointmentDateTime,
    required this.reason,
    required this.status,
    required this.useInsurance,
    this.insuranceNumber,
    this.insuranceProvider,
    this.notes,
  });

  factory Appointment.fromMap(Map<String, dynamic> map, String id) {
    return Appointment(
      id: id,
      doctorId: map['doctorId'] ?? '',
      patientId: map['patientId'] ?? '',
      appointmentDateTime: map['appointmentDateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['appointmentDateTime'])
          : DateTime.now(),
      reason: map['reason'] ?? '',
      status: map['status'] ?? 'pending',
      useInsurance: map['useInsurance'] ?? false,
      insuranceNumber: map['insuranceNumber'],
      insuranceProvider: map['insuranceProvider'],
      notes: map['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'patientId': patientId,
      'appointmentDateTime': appointmentDateTime.millisecondsSinceEpoch,
      'reason': reason,
      'status': status,
      'useInsurance': useInsurance,
      'insuranceNumber': insuranceNumber,
      'insuranceProvider': insuranceProvider,
      'notes': notes,
    };
  }
}
