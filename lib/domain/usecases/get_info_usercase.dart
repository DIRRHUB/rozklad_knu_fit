import 'package:dartz/dartz.dart';
import 'package:rozklad_knu_fit/domain/entities/info_entity.dart';
import 'package:rozklad_knu_fit/domain/repositories/repository.dart';
import 'package:rozklad_knu_fit/internal/use_cases.dart';
import '../../internal/error/failure.dart';

class GetInfoUseCase extends UseCase<InfoEntity, NoParams> {
  final Repository repository;

  GetInfoUseCase(this.repository);

  @override
  Future<Either<Failure, InfoEntity>> call(NoParams params) async {
    return await repository.getInfo();
  }
}