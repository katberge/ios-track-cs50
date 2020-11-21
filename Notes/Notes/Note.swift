//
//  Note.swift
//  Notes
//
//  Created by Kat Berge on 11/21/20.
//  Copyright © 2020 Kat Berge. All rights reserved.
//

import Foundation
import SQLite3

struct Note {
    let id: Int
    var contents: String
}

struct NoteManager {
    var database: OpaquePointer!
    
    static let main = NoteManager()
    
    private init() {
    }
    
    func connect() {
        // don't do this twice
        if database != nil {
            return
        }
        
        do {
            let databaseURL = try FileManager.default.url(for: .userDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("notes.sqlite3")
            
            // open and make sure it was successful
            if sqlite3_open(databaseURL.path, UnsafeMutablePointer(database)) == SQLITE_OK {
                // sqlite3 will automatically create rowid column
                if sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS notes (contents TEXT)", nil, nil, nil) != SQLITE_OK {
                    print("Could not create table.")
                }
            }
            else {
                print("Could not connect.")
            }
        }
        catch let error {
            print("\(error): Could not create database.")
        }
    }
    
    func create() -> Int {
        connect()
        
        var statement: OpaquePointer!
        
        // give new notes default text of "New note"
        if sqlite3_prepare_v2(database, "INSERT INTO notes (contents) VALUES ('New note')", -1, &statement, nil) != SQLITE_OK {
            print("Could not create query.")
            return -1
        }
        if sqlite3_step(statement) != SQLITE_DONE {
            print("Could not insert note.")
            return -1
        }
        
        sqlite3_finalize(statement)
        return Int(sqlite3_last_insert_rowid(database))
    }
    
    func getAllNotes() -> [Note] {
        connect()
        var result: [Note] = []
        
        var statement: OpaquePointer!
        
        if sqlite3_prepare_v2(database, "SELECT rowid, contents FROM notes", -1, &statement, nil) != SQLITE_OK {
            print("Error creating select.")
            return []
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            result.append(Note(id: Int(sqlite3_column_int(statement, 0)), contents: String(cString: sqlite3_column_text(statement, 1))))
        }
        
        sqlite3_finalize(statement)
        return result
    }
}
