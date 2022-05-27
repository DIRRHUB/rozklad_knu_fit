import 'package:dartz/dartz.dart';
import 'package:rozklad_knu_fit/domain/entities/specs_entity.dart';
import 'package:rozklad_knu_fit/domain/repositories/repository.dart';
import 'package:rozklad_knu_fit/internal/error/failure.dart';
import 'package:rozklad_knu_fit/internal/use_cases.dart';

class GetSpecsUseCase extends UseCase<SpecsEntity, NoParams> {
  final Repository repository;

  GetSpecsUseCase(this.repository);

  @override
  Future<Either<Failure, SpecsEntity>> call(NoParams params) async {
    return await repository.getSpecs();
  }
}
