import 'package:mockito/annotations.dart';
import 'package:test_2go_bank/data/data_sources/remote_data_source.dart';
import 'package:test_2go_bank/domain/repositories/product_repository.dart';

@GenerateMocks([
  ProductRepository,
  ProductRemoteDataSource,
])
void main() {}
