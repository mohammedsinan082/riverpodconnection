// class addressModel{
//   String fullname;
//   String phonenumber;
//   String pincode;
//   String state;
//   String city;
//   String housenumber;
//   String area;
//
//   addressModel({
//     required this.fullname,
//     required this.phonenumber,
//     required this.pincode,
//     required this.state,
//     required this.city,
//     required this.housenumber,
//     required this.area
// });
//
//   addressModel copywith({
//     String? fullname,
//     String? phonenumber,
//     String? pincode,
//     String? state,
//     String? city,
//     String? housenumber,
//     String? area,
//
// }) => addressModel(
//       fullname: fullname ?? this.fullname,
//       phonenumber: phonenumber ?? this.phonenumber,
//       pincode: pincode ?? this.pincode,
//       state: state ?? this.state,
//       city: city ?? this.city,
//       housenumber: housenumber ?? this.housenumber,
//       area: area ?? this.area
//   );
//
//   factory addressModel.fromJson(dynamic json) => addressModel(
//       fullname: json['fullname']??'',
//       phonenumber: json['phonenumber']??'',
//       pincode: json['pincode']??'',
//       state: json['state']??'',
//       city: json['city']??'',
//       housenumber: json['housenumber']??'',
//       area: json['area']??''
//   );
//
//   Map<String,dynamic> toJson() =>{
//     "fullname":fullname,
//     "phonenumber":phonenumber,
//     "pincode":pincode,
//     "state":state,
//     "city":city,
//     "housenumber":housenumber,
//     "area":area
//   };
//
//
// }

import 'dart:convert';

class AddressModel {
  String name;
  String address;

  AddressModel({
    required this.name,
    required this.address,
  });

  AddressModel copywith({
    String? name,
    String? address,
  }) =>
      AddressModel(
          name: name ?? this.name,
          address: address ?? this.address
      );

  factory AddressModel.fromJson(dynamic json) =>AddressModel(
      name: json['name'] ?? '',
      address: json['address'] ?? ''
  );

  Map<String,dynamic> toJson() =>{
    "name":name,
    "address":address,
  };


}