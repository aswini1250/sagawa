
import '../config/app_config.dart';

class Api{
  static const updateLogin = AppConfig.baseUrl + "Login/index";
  static const fcmUpdate = AppConfig.baseUrl + "customer/fcm";
  static const getIncidentDashboard = AppConfig.baseUrl + "incident/Incident_list";
  static const getIncidentSave = AppConfig.baseUrl + "incident/incident_save";
  static const getDivisionList = AppConfig.baseUrl + "incident/cost_centre";
  static const getEmployeeList = AppConfig.baseUrl + "incident/employee";
  static const getSGHVehicleList = AppConfig.baseUrl + "incident/vehicle_number";
  static const getCorrectiveActionList = AppConfig.baseUrl + "incident/corrective_action";
  static const getPreventiveActionList = AppConfig.baseUrl + "incident/preventive_action";

}
