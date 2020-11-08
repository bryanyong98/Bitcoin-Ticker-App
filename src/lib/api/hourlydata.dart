
class HourlyData {
  String time;
  String high;
  String low;
  String open;
  String volumefrom;
  String volumeto;
  String close;
  String conversionType;
  String conversionSymbol;

  HourlyData(
      {this.time,
        this.high,
        this.low,
        this.open,
        this.volumefrom,
        this.volumeto,
        this.close,
        this.conversionType,
        this.conversionSymbol});

  HourlyData.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    high = json['high'];
    low = json['low'];
    open = json['open'];
    volumefrom = json['volumefrom'];
    volumeto = json['volumeto'];
    close = json['close'];
    conversionType = json['conversionType'];
    conversionSymbol = json['conversionSymbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['high'] = this.high;
    data['low'] = this.low;
    data['open'] = this.open;
    data['volumefrom'] = this.volumefrom;
    data['volumeto'] = this.volumeto;
    data['close'] = this.close;
    data['conversionType'] = this.conversionType;
    data['conversionSymbol'] = this.conversionSymbol;
    return data;
  }
}