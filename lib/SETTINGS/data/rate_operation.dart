import 'package:personal/SETTINGS/data/DataBaseRepo.dart';
import 'package:personal/SETTINGS/models/RateModel.dart';
class RateOperations {

  DatabaseRepository dbRepository = DatabaseRepository.instance;

  addrate(RateModel ratemodel) async {
    final db = await dbRepository.database;
    print(ratemodel.rate);
    db.insert('rate', ratemodel.toMap());
    print("Rate Added Successfully");

  }

/* updateUser(UserRegistration userreg) async {
    final db = await dbRepository.database;
    db.update('user', userreg.toMap(),
        where: 'userId=?', whereArgs: [userreg.id]);
  }

  deleteUser(UserRegistration userreg) async {
    final db = await dbRepository.database;
    db.delete('user', where: 'userId=?', whereArgs: [userreg.id]);
  }

  Future<List<UserRegistration>> getAllUsers() async {
    final db = await dbRepository.database;
    var allRows = await db.query('user');
    List<UserRegistration> users =
    allRows.map((userreg) => UserRegistration.fromMap(userreg)).toList();
    return users;
  }

 */
}