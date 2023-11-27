abstract class IUserRepository {
  Future<bool> get doesUserExist;
  Future<void> createUser();
}
