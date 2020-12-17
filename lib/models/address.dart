class Address {
  String zip;
  String address;
  int number;
  String complement;
  String district;
  String city;
  String state;

  Address({this.zip, this.address, this.number, this.complement, this.district,
    this.city, this.state});

  factory Address.fromMap(Map json) => Address(
    zip: json['zip'] == null ? '' : json['zip'],
    address: json['address'] == null ? '' : json['address'],
    number: json['number'] == null ? 0 : json['number'],
    complement: json['complement'] == null ? '' : json['complement'],
    district: json['district'] == null ? '' : json['district'],
    city: json['city'] == null ? '' : json['city'],
    state: json['state'] == null ? '' : json['state'],
  );

  Map toMap() => {
    'zip': zip == null ? '' : zip,
    'address': address == null ? '' : address,
    'number': number == null ? '' : number,
    'complement': complement == null ? '' : complement,
    'district': district == null ? '' : district,
    'city': city = null ? '' : city,
    'state': state == null ? '' : state,
  };
}