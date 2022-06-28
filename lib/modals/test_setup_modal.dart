class TestSetupModal{

  String sampleProfile;
  String lotNumber;
  String industryType;
  String materialApplication;
  String materialTypeCard;
  String shapeType;
  int  materialType;
  String turtosity;
  String sizeType;
  String thickness;
  String wettingFluid;
  String bubblePointType;
  double bubblePoint;
  double testPressureone;
  double  testPressuretwo;

  TestSetupModal({
    this.sampleProfile='',this.lotNumber='',this.industryType='',this.materialApplication='',this.materialTypeCard='',this.shapeType='',
    this.materialType=0,this.turtosity='',this.sizeType='',this.thickness='',this.wettingFluid='',this.bubblePointType='',this.bubblePoint=0.0,
    this.testPressureone=0.0,this.testPressuretwo=0.0
  });

  /*TestSetupModal.fromMap(Map<Stirng, dynamic> map) {
    sampleProfile = map['sampleProfile']?.toString() ?? "";
    materialType = map['materialType'] is int ? map["materialType"] : 0;
  }*/

  static TestSetupModal fromMap(Map<String,dynamic> map) {
    String sampleProfile;
    String lotNumber;
    String industryType;
    String materialApplication;
    String materialTypeCard;
    String shapeType;
    int  materialType;
    String turtosity;
    String sizeType;
    String thickness;
    String wettingFluid;
    String bubblePointType;
    double bubblePoint;
    double testPressureone;
    double  testPressuretwo;
    sampleProfile=map['sampleProfile']??"";
    lotNumber=map['lotNumber']??"";
    industryType=map['industryType']??"";
    materialApplication=map['materialApplication']??"";
    materialTypeCard=map['materialTypeCard']??"";
    shapeType=map['shapeType']??"";
    materialType=map['materialType']??0;
    turtosity=map['turtosity']??"";
    sizeType=map['sizeType']??"";
    thickness=map['thickness']??"";
    wettingFluid=map['wettingFluid']??"";
    bubblePointType=map['bubblePointType']??"";
    bubblePoint=map['bubblePoint']??0.0;
    testPressureone = double.tryParse(map['testPressureone'].toString()) ?? 0.0;
    testPressuretwo=double.tryParse(map['testPressuretwo'].toString()) ?? 0.0;
    return TestSetupModal(sampleProfile: sampleProfile,lotNumber: lotNumber,industryType: industryType,materialApplication: materialApplication,
        materialTypeCard:materialTypeCard,shapeType:shapeType,materialType:materialType,turtosity:turtosity,sizeType:sizeType,
        thickness:thickness,wettingFluid:wettingFluid,bubblePointType:bubblePointType,bubblePoint:bubblePoint,testPressureone:testPressureone,
        testPressuretwo:testPressuretwo
    );
  }

  Map<String,dynamic> toMap(){
  return {
    "sampleProfile":sampleProfile,
    "lotNumber":lotNumber,
    "industryType":industryType,
    "materialApplication":materialApplication,
    "materialTypeCard":materialTypeCard,
    "shapeType":shapeType,
    "materialType":materialType,
    "turtosity":turtosity,
    "sizeType":sizeType,
    "thickness":thickness,
    "wettingFluid":wettingFluid,
    "bubblePointType":bubblePointType,
    "bubblePoint":bubblePoint,
    "testPressureone":testPressureone,
    "testPressuretwo":testPressuretwo,
  };
  }
}