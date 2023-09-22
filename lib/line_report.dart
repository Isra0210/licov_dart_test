import 'package:equatable/equatable.dart';

class LineReport extends Equatable {
  final String sourceFile;
  final int lineFound;
  final int lineHit;

  LineReport({
    required this.sourceFile,
    required this.lineFound,
    required this.lineHit,
  });
  
  @override
  List<Object> get props => [sourceFile, lineFound, lineHit];
}
