import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rozklad_knu_fit/domain/entities/calendar_entity.dart';
import 'package:rozklad_knu_fit/domain/repositories/repository.dart';

import '../../internal/error/failure.dart';
import '../../internal/use_cases.dart';

class GetCalendarUseCase extends UseCase<CalendarEntity, Params> {
  final Repository repository;

  GetCalendarUseCase(this.repository);

  @override
  Future<Either<Failure, CalendarEntity>> call(Params params) async {
    return repository.getCalendar(params.map);
  }
}

class Params extends Equatable {
  final Map<String, String> map;

  const Params({required this.map});

  @override
  List<Object?> get props => [map];
}
