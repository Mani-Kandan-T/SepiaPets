//
//  Date+String.swift
//  Sepia Pets
//
//  Created by Manikandan on 10/01/23.
//

import Foundation

class DateHelper {
  private init() {}
  static let shared = DateHelper()
  
  func lastModifiedDateWithTime(dateStr: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.ssZ"
    
    guard let addedDate = dateFormatter.date(from: dateStr) else {
      return ""
    }
    
    dateFormatter.dateFormat = "d MMM y, HH:mm E"
    return dateFormatter.string(from: addedDate)
  }
  
  func isWorkingHours() -> Bool {
    guard let workingHoursArray = workingHoursFromCongig(from: "config")?.components(separatedBy: " "),
          workingHoursArray.count > 3 else {
      return false
    }
    let startTime: String = workingHoursArray[1]
    let endTime: String = workingHoursArray[3]
    return isBetweenWorkingDay() && isBetweenWorkingTime(startTime: startTime, endTime: endTime)
  }
  
  private func isBetweenWorkingDay() -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "E"
    let dateStr = dateFormatter.string(from: Date())
    return dateStr.first != "S"
  }
  
  private func isBetweenWorkingTime(startTime: String, endTime: String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    let startDateWithTime = dateFormatter.date(from: startTime)
    let endDateWithTime = dateFormatter.date(from: endTime)

    guard let startDate = startDateWithTime, let endDate = endDateWithTime else {
      return false
    }
    
    dateFormatter.dateFormat = "HH"
    let startHour = Int(dateFormatter.string(from: startDate)) ?? -1
    let endHour = Int(dateFormatter.string(from: endDate)) ?? -1
    let currentHour = currentHourAsInt()
    
    return (currentHour >= startHour && currentHour < endHour)
  }
  
  private func currentHourAsInt() -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH"
    let dateStr = dateFormatter.string(from: Date())
    return Int(dateStr) ?? -2
  }
  
  private func workingHoursFromCongig(from appConfig: String) -> String? {
    if let url = Bundle.main.url(forResource: Constants.configFileName,
                                 withExtension: Constants.fileType) {
      do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let configuration = try decoder.decode(AppSettings.self, from: data)
        return configuration.settings.workHours
      } catch {
        print("error:\(error.localizedDescription)")
      }
    }
    return nil
  }
}

