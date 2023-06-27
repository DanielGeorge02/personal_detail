import 'package:flutter_application_1/db_helper/repository.dart';
import '../model/user.dart';

class UserService {
  late Repository _repository;
  UserService() {
    _repository = Repository();
  }
//Save User
  SaveUser(User user) async {
    return await _repository.insertData("users", user.userMap());
  }

//Read all User
  readAllUserS() async {
    return await _repository.readData("users");
  }

//Edit user
  UpdateUser(User user) async {
    return await _repository.updateData("users", user.userMap());
  }

//Delete user
  deleteUser(userId) async {
    return await _repository.deleteDataById('users', userId);
  }
}
