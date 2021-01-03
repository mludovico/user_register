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
    zip: json['cep'] == null ? '' : json['cep'],
    address: json['logradouro'] == null ? '' : json['logradouro'],
    // number: json['number'] == null ? 0 : json['number'],
    complement: json['complemento'] == null ? '' : json['complemento'],
    district: json['bairro'] == null ? '' : json['bairro'],
    city: json['localidade'] == null ? '' : json['localidade'],
    state: json['uf'] == null ? '' : json['uf'],
  );

  Map<String, dynamic> toMap() => {
    'zip': zip == null ? '' : zip,
    'address': address == null ? '' : address,
    'number': number == null ? '' : number,
    'complement': complement == null ? '' : complement,
    'district': district == null ? '' : district,
    'city': city == null ? '' : city,
    'state': state == null ? '' : state,
  };

  Address updateFrom(Address address){
    if(address.zip != null)
      this.zip = address.zip;
    if(address.address != null)
      this.address = address.address;
    if(address.number != null)
      this.number = address.number;
    if(address.complement != null)
      this.complement = address.complement;
    if(address.district != null)
      this.district = address.district;
    if(address.city != null)
      this.city = address.city;
    if(address.state != null)
      this.state = address.state;
    return this;
  }
}