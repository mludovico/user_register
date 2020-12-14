class Address {
  String zip;
  String address;
  int number;
  String complement;

  Address({this.zip, this.address, this.number, this.complement});

  factory Address.fromMap(Map json) => Address(
    zip: json['zip'] == null ? '' : json['zip'],
    address: json['address'] == null ? '' : json['address'],
    number: json['number'] == null ? 0 : json['number'],
    complement: json['complement'] == null ? '' : json['complement'],
  );

  Map toMap() => {
    'zip': zip == null ? '' : zip,
    'address': address == null ? '' : address,
    'number': number == null ? '' : number,
    'complement': complement == null ? '' : complement,
  };
}