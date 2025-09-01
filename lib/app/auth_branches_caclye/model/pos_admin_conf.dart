// To parse this JSON data, do
//
//     final posAdminConf = posAdminConfFromJson(jsonString);

import 'dart:convert';

PosAdminConf posAdminConfFromJson(String str) => PosAdminConf.fromJson(json.decode(str));

String posAdminConfToJson(PosAdminConf data) => json.encode(data.toJson());

class PosAdminConf {
    int? status;
    List<Datum>? data;

    PosAdminConf({
        this.status,
        this.data,
    });

    factory PosAdminConf.fromJson(Map<String, dynamic> json) => PosAdminConf(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    bool? bypassAccess;
    bool? update;
    bool? singleMaintenance;
    bool? allMaintenance;
    dynamic iosVersion;
    dynamic androidVersion;
    bool? mobappForceUpdate;
    dynamic mobappForceUpdateText;
    bool? mobappMaintenance;
    dynamic mobappMaintenanceText;

    Datum({
        this.id,
        this.bypassAccess,
        this.update,
        this.singleMaintenance,
        this.allMaintenance,
        this.iosVersion,
        this.androidVersion,
        this.mobappForceUpdate,
        this.mobappForceUpdateText,
        this.mobappMaintenance,
        this.mobappMaintenanceText,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        bypassAccess: json["bypass_access"],
        update: json["update"],
        singleMaintenance: json["single_maintenance"],
        allMaintenance: json["all_maintenance"],
        iosVersion: json["ios_version"],
        androidVersion: json["android_version"],
        mobappForceUpdate: json["mobapp_force_update"],
        mobappForceUpdateText: json["mobapp_force_update_text"],
        mobappMaintenance: json["mobapp_maintenance"],
        mobappMaintenanceText: json["mobapp_maintenance_text"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "bypass_access": bypassAccess,
        "update": update,
        "single_maintenance": singleMaintenance,
        "all_maintenance": allMaintenance,
        "ios_version": iosVersion,
        "android_version": androidVersion,
        "mobapp_force_update": mobappForceUpdate,
        "mobapp_force_update_text": mobappForceUpdateText,
        "mobapp_maintenance": mobappMaintenance,
        "mobapp_maintenance_text": mobappMaintenanceText,
    };
}
