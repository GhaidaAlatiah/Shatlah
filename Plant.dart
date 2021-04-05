


class Plant {
  String  ArName,EnName,Irrigation,Sunlight,Temp;
  String serial, image;
  String addedDate;

  Plant(this.ArName,this.EnName,this.Irrigation,this.Sunlight,this.Temp);



  String getArname (){
    return ArName;
  }

  String getEnname (){
    return EnName;
  }

  String getIrrigation (){
    return Irrigation;
  }

  String getSunlight (){
    return Sunlight;
  }
  String getTemp (){
    return Temp;
  }

}