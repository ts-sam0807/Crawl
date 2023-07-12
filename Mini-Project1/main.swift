//
//  main.swift
//  Mini-Project1
//
//  Created by Derrick Park on 2023-07-10.
//

import Foundation

// around 50 lines
//
//let fileManager: FileManager = FileManager.default
//let currentPath: String = fileManager.currentDirectoryPath
//
//func isDirectory(path: String) -> Bool {
//  var isDirectory: ObjCBool = false
//  if fileManager.fileExists(atPath: path, isDirectory: &isDirectory) {
//    if isDirectory.boolValue {
//      return true
//    }
//  }
//  return false
//}
//
//
//if let contents: [String] = try? fileManager.contentsOfDirectory(atPath: currentPath) {
//  print(contents)
//  let filepath = currentPath + "/\(contents[0])"
//  let dirPath = currentPath
//  print(isDirectory(path: filepath))
//  print(isDirectory(path: dirPath))
//  print("└─")
//}
//

let fileManager = FileManager.default
var isDirectory: ObjCBool = false
var directoriesCount = 0
var filesCount = 0
//let path = "/Users/tssam/Desktop/Chess2"
let path = fileManager.currentDirectoryPath

func crawl(path: String, indent: String = "", isLast: Bool = true) {
    
    guard fileManager.fileExists(atPath: path, isDirectory: &isDirectory) else {
        return
    }
    
    let symbol = isLast ? "└─ " : "├─ "
    print("\(indent)\(symbol)\(URL(fileURLWithPath: path).lastPathComponent)")
    
    if isDirectory.boolValue {
        directoriesCount += 1
        do {
            let contents = try fileManager.contentsOfDirectory(atPath: path)
            for (index, content) in contents.enumerated() {
                let isLastItem = index == contents.count - 1
                let newPath = (path as NSString).appendingPathComponent(content)
                
                let levelIndent = isLast ? " " : "│"
                let newIndent = "\(indent)\(levelIndent)    "
                crawl(path: newPath, indent: newIndent, isLast: isLastItem)
            }
        } catch {
            print("Cannot access the directory : \(error)")
        }
    } else {
        filesCount += 1
    }
}

crawl(path: path)
print("\(directoriesCount) directories, \(filesCount) files")

