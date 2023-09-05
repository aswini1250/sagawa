
import '../config/app_config.dart';

class Api{
  static const updateLogin = AppConfig.baseUrl + "Login/index";
  static const fcmUpdate = AppConfig.baseUrl + "customer/fcm";
  static const getIncidentDashboard = AppConfig.baseUrl + "incident/Incident_list?";
  static const getNotification = AppConfig.baseUrl + "Login/notification";
  static const getIncidentSave = AppConfig.baseUrl + "incident/incident_save";
  static const getDivisionList = AppConfig.baseUrl + "incident/cost_centre";
  static const getEmployeeList = AppConfig.baseUrl + "incident/employee";
  static const getSGHVehicleList = AppConfig.baseUrl + "incident/vehicle_number";
  static const getCorrectiveActionList = AppConfig.baseUrl + "incident/corrective_action";
  static const getPreventiveActionList = AppConfig.baseUrl + "incident/preventive_action";
  static const getIncidentView = AppConfig.baseUrl + "incident/incident_view";
  static const getAccidentView = AppConfig.baseUrl + "accident/accident_view";
  static const getPropertyDamageView = AppConfig.baseUrl + "Property/property_save";
  static const getAccidentSave = AppConfig.baseUrl + "accident/accident_save";
  static const getAccidentDashboard = AppConfig.baseUrl + "Accident/accident_list?";
  static const getReportBy = AppConfig.baseUrl + "incident/report_no";
  static const getpreparedBy = AppConfig.baseUrl + "incident/prepared_by";
  static const getStatus = AppConfig.baseUrl + "incident/corrective_action";
  static const getPropertyDamageDashboard = AppConfig.baseUrl + "Property/property_list?";
  static const getReportByAcc = AppConfig.baseUrl + "incident/report_no";
  static const getpreparedByAcc = AppConfig.baseUrl + "incident/prepared_by";
  static const getStatusAcc = AppConfig.baseUrl + "incident/corrective_action";
  static const getReportByPro = AppConfig.baseUrl + "incident/report_no";
  static const getpreparedByPro = AppConfig.baseUrl + "incident/prepared_by";
  static const getStatusPro = AppConfig.baseUrl + "incident/corrective_action";
  static const getPropertyView = AppConfig.baseUrl + "Property/property_view";
  static const getPropertySave = AppConfig.baseUrl + "Property/property_save";
  static const incidentApproveSection = AppConfig.baseUrl + "incident/approve_section";
  static const accidentApproveSection = AppConfig.baseUrl + "accident/approve_section";
  static const propertyApproveSection = AppConfig.baseUrl + "property/approve_section";
  static const getDataForApprovalsInsident = AppConfig.baseUrl + "incident/approved_incident";
  static const getDataForApprovalsAccident = AppConfig.baseUrl + "accident/approved_accident";

  static const getDataForApprovalsProperty = AppConfig.baseUrl + "property/approved_property";

}
