class BubblePointModel {
  String testname = "",
      fluidname = "",
      duration = "",
      crosssection = "",
      materialtype = "",
      splate = "",
      durationsecond = "",
      testtime = "",
      testdate = "",
      application = "",
      indistry = "",
      materialclassification = "";
  int thikness = 0;
  double bpressure = 0.0,
      bdiameter = 0.0,
      thresold = 0.0,
      fluidvalue = 0.0,
      tfact = 0.0,
      samplediameter = 0.0;
  List<double> p1 = [], p2 = [], flow = [], ans = [], dp = [], dt = [], t = [];

  BubblePointModel({
    this.testname = "",
    this.p1 = const [],
    this.p2 = const [],
    this.bpressure = 0.0,
    this.fluidname = "",
    this.duration = "",
    this.crosssection = "",
    this.materialtype = "",
    this.splate = "",
    this.flow = const [],
    this.bdiameter = 0.0,
    this.durationsecond = "",
    this.thresold = 0.0,
    this.ans = const [],
    this.testtime = "",
    this.testdate = "",
    this.dp = const [],
    this.fluidvalue = 0.0,
    this.dt = const [],
    this.tfact = 0.0,
    this.t = const [],
    this.application = "",
    this.thikness = 0,
    this.indistry = "",
    this.samplediameter = 0.0,
    this.materialclassification = "",
  });

  BubblePointModel.fromJson(Map<String, dynamic> json) {
    testname = json['testname'];
    p2 = stringToListDouble(json['p2']??"");
    bpressure = double.tryParse(json['bpressure']) ?? 0.0;
    fluidname = json['fluidname'];
    duration = json['duration'];
    crosssection = json['crosssection'];
    materialtype = json['materialtype'];
    splate = json['splate'];
    bdiameter = double.tryParse(json['bdiameter']) ?? 0.0;
    durationsecond = json['durationsecond'];
    thresold = double.tryParse(json['thresold']) ?? 0.0;
    testtime = json['testtime'];
    testdate = json['testdate'];
    fluidvalue = double.tryParse(json['fluidvalue'])??0.0;
    tfact = double.tryParse(json['tfact'])??0.0;
    application = json['application'];
    thikness = int.tryParse(json['thikness'])??0;
    indistry = json['indistry'];
    samplediameter = double.tryParse(json['samplediameter'])??0.0;
    materialclassification = json['materialclassification'];

    String piValue = json['p1'] ?? "";
    if(piValue.isNotEmpty){
      p1.addAll(piValue.split(",").map((e) => double.tryParse(e) ?? 0.0).toList());
    }

    String p2Value = json['p2'] ?? "";
    if(p2Value.isNotEmpty){
      p2.addAll(piValue.split(",").map((e) => double.tryParse(e) ?? 0.0).toList());
    }
    String flowValue = json['flow'] ?? "";
    if(flowValue.isNotEmpty){
      flow.addAll(piValue.split(",").map((e) => double.tryParse(e) ?? 0.0).toList());
    }
    String ansValue = json['ans'] ?? "";
    if(ansValue.isNotEmpty){
      dp.addAll(piValue.split(",").map((e) => double.tryParse(e) ?? 0.0).toList());
    }

    String dpValue = json['Dp'] ?? "";
    if(dpValue.isNotEmpty){
      dp.addAll(piValue.split(",").map((e) => double.tryParse(e) ?? 0.0).toList());
    }
    String dtValue = json['Dt'] ?? "";
    if(dtValue.isNotEmpty){
      dt.addAll(piValue.split(",").map((e) => double.tryParse(e) ?? 0.0).toList());
    }
    String tValue = json['t'] ?? "";
    if(tValue.isNotEmpty){
      t.addAll(piValue.split(",").map((e) => double.tryParse(e) ?? 0.0).toList());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testname'] = this.testname;
    data['p1'] = this.p1;
    data['p2'] = this.p2;
    data['bpressure'] = this.bpressure;
    data['fluidname'] = this.fluidname;
    data['duration'] = this.duration;
    data['crosssection'] = this.crosssection;
    data['materialtype'] = this.materialtype;
    data['splate'] = this.splate;
    data['flow'] = this.flow;
    data['bdiameter'] = this.bdiameter;
    data['durationsecond'] = this.durationsecond;
    data['thresold'] = this.thresold;
    data['ans'] = this.ans;
    data['testtime'] = this.testtime;
    data['testdate'] = this.testdate;
    data['Dp'] = this.dp;
    data['fluidvalue'] = this.fluidvalue;
    data['Dt'] = this.dt;
    data['tfact'] = this.tfact;
    data['t'] = this.t;
    data['application'] = this.application;
    data['thikness'] = this.thikness;
    data['indistry'] = this.indistry;
    data['samplediameter'] = this.samplediameter;
    data['materialclassification'] = this.materialclassification;
    return data;
  }

  List<double> stringToListDouble(String val){
    List<double> convertedVal = [];
    if(val.isNotEmpty){
      val.split(",").forEach((element) {
        double p1Double = double.tryParse(element) ?? 0.0;
        convertedVal.add(p1Double);
      });
    }
    return convertedVal;
  }
}
