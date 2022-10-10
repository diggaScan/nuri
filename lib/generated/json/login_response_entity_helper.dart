import 'package:nuri/domain_layer/bp_module_login/data/login_response_entity.dart';

loginResponseEntityFromJson(LoginResponseEntity data, Map<String, dynamic> json) {
	if (json['iStatus'] != null) {
		data.iStatus = json['iStatus'] is String
				? int.tryParse(json['iStatus'])
				: json['iStatus'].toInt();
	}
	if (json['sInfo'] != null) {
		data.sInfo = json['sInfo'].toString();
	}
	return data;
}

Map<String, dynamic> loginResponseEntityToJson(LoginResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['iStatus'] = entity.iStatus;
	data['sInfo'] = entity.sInfo;
	return data;
}