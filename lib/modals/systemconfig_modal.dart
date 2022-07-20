class SystemConfigModal{

double pressureGuage1 = 0.0;
double pressureGuage2 = 0.0;
double pressureRegulator = 0.0;
double flowController = 0.0;
String setUnitOne = "";
String setUnitTwo = "";
bool scaleTypeOne =  false;
bool scaleTypeTwo =  false;
String selectChamber = "";
double firstBubble = 0.0;
double moderate = 0.0;
double continous = 0.0;
String calibration='';
String pressure = "";
String flow = "";
String diameter = "";
String precision = "";
bool curveFit =  false;
bool lowPressureGuage =  false;
bool valveA =  false;
bool valveB =  false;
bool valveC =  false;
bool valveD =  false;
bool valveE =  false;
bool valveF =  false;
bool valveG =  false;
bool valveH =  false;

SystemConfigModal({
  this.pressureGuage1=0.0,this.pressureGuage2=0.0,this.pressureRegulator=0.0,this.flowController=0.0,
  this.setUnitOne='psi',this.setUnitTwo='psi', this.firstBubble=0.0,this.continous=0.0,this.moderate=0.0,
  this.selectChamber='Manual',this.scaleTypeOne=false,this.scaleTypeTwo=false,this.flow='sccm',this.pressure='torr',this.diameter='nm',
  this.precision='1',this.curveFit=false,this.lowPressureGuage=false,this.valveA=false,this.valveB=false,this.valveC=false,
  this.valveE=false,this.valveD=false,this.valveF=false,this.valveG=false,this.valveH=false,this.calibration=''

});

SystemConfigModal.fromMap(Map<String,dynamic> map){
  pressureGuage1=map['pressureGuage1'] ?? 0.0;
  pressureGuage2=map['pressureGuage2'] ?? 0.0;
  pressureRegulator=map['pressureRegulator'] ?? 0.0;
  flowController=map['flowController'] ?? 0.0;
  setUnitOne=map['setUnitOne'] ?? '';
  setUnitTwo=map['setUnitTwo'] ?? '';
  firstBubble=map['firstBubble'] ?? 0.0;
  continous=map['continous'] ?? 0.0;
  moderate=map['moderate'] ?? 0.0;
  selectChamber=map['selectChamber'] ?? 'Manual';
  scaleTypeOne=map['scaleTypeOne'] ?? false;
  scaleTypeTwo=map['scaleTypeTwo'] ?? false;
  flow=map['flow'] ?? '';
  pressure=map['pressure'] ?? '';
  diameter=map['diameter'] ?? '';
  precision=map['precision'] ?? '';
  curveFit=map['curveFit'] ?? false;
  lowPressureGuage=map['lowPressureGuage'] ?? false;
  valveA=map['valveA'] ?? false;
  valveB=map['valveB'] ?? false;
  valveC=map['valveC'] ?? false;
  valveD=map['valveD'] ?? false;
  valveE=map['valveE'] ?? false;
  valveF=map['valveF'] ?? false;
  valveG=map['valveG'] ?? false;
  valveH=map['valveH'] ?? false;
  calibration=map['calibration'] ?? '';
}

Map<String,dynamic> toMap(){
  Map<String,dynamic> map={
    "pressureGuage1" : pressureGuage1,
        "pressureGuage2" : pressureGuage2,
        "pressureRegulator" : pressureRegulator,
        "flowController" : flowController,
        "setUnitOne" : setUnitOne,
        "setUnitTwo" : setUnitTwo,
        "selectChamber" : selectChamber,
        "firstBubble" : firstBubble,
        "moderate" : moderate,
        "continous" : continous,
        "scaleTypeOne" : scaleTypeOne,
        "scaleTypeTwo" : scaleTypeTwo,
        "pressure" : pressure,
        "flow" : flow,
        "diameter" : diameter,
        "precision" : precision,
        "curveFit" : curveFit,
        "lowPressureGuage" : lowPressureGuage,
        "valveA" : valveA,
        "valveB" : valveB,
        "valveC" : valveC,
        "valveD" : valveD,
        "valveE" : valveE,
        "valveF" : valveF,
        "valveG" : valveG,
        "valveH" : valveH,
    "calibration":calibration
  };
  return map;
}


}