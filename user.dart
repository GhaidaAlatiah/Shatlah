import 'package:shatlah2/Plant.dart';
import 'package:shatlah2/plantImage.dart';


class user {

  String _name;
  String _email;
  List<String> userPlants = [];
  List <String> userImage = [];
  List<plantImage> userCollection = [];
  List<plantImage> sortedColl = [];

  user(name, email){
    this._name = name;
    this._email= email;
    this.userPlants= new List<String>();
    this.userImage = new List<String>();
    this.userCollection = new List<plantImage>();
    this.sortedColl = new List<plantImage>();
  }

  void setName(String name){
    this._name= name;
  }

  String getName(){
    return this._name;
  }

  void setEmail(String email){
    this._email= email;
  }

  String getEmail(){
    return this._email;
  }

void setUserPlants( List<String> plants){
    this.userPlants= plants;
}

  List<String> getUserPlants(){
    return this.userPlants;
  }

  List<plantImage> getUserCollection(){
    return this.userCollection;
  }



} // end class