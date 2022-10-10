import 'package:nuri/domain_layer/bp_module_login/data/register_response_entity.dart';

registerResponseEntityFromJson(RegisterResponseEntity data, Map<String, dynamic> json) {
	if (json['iStatus'] != null) {
		data.iStatus = json['iStatus'] is String
				? int.tryParse(json['iStatus'])
				: json['iStatus'].toInt();
	}
	if (json['mPrimary'] != null) {
		data.mPrimary = json['mPrimary'] is String
				? int.tryParse(json['mPrimary'])
				: json['mPrimary'].toInt();
	}
	return data;
}

Map<String, dynamic> registerResponseEntityToJson(RegisterResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['iStatus'] = entity.iStatus;
	data['mPrimary'] = entity.mPrimary;
	return data;
}