import sys
import os
from pathlib import Path
from db import ManualDB

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import *

class ManualBackend(QObject):
   
    def __init__(self):
        QObject.__init__(self)
        self.manualdb = ManualDB()
        self.__setupDB()

    def __setupDB(self):
        dbPath = os.getcwd()+'\manual.db'
        self.manualdb.create_connection(dbPath)
        sql_create_articles_table = """
            CREATE TABLE "articles" (
            "id_article"	INTEGER,
            "name"	text NOT NULL,
            "begin_date"	text,
            "description"	TEXT,
            PRIMARY KEY("id_article" AUTOINCREMENT)
        );
         """

        sql_create_sections_table = """
            CREATE TABLE "sections" (
            "id_sections"	INTEGER,
            "title"	TEXT NOT NULL,
            "src"	TEXT,
            "article_cod"	INTEGER,
            FOREIGN KEY("article_cod") REFERENCES "articles"("id_article"),
            PRIMARY KEY("id_sections" AUTOINCREMENT)
        );
        """

        sql_create_content_table = """
            CREATE TABLE "content" (
            "id_content"	INTEGER NOT NULL,
            "description"	TEXT,
            "src"	TEXT,
            "section_cod"	INTEGER,
            FOREIGN KEY("section_cod") REFERENCES "sections"("id_sections"),
            PRIMARY KEY("id_content" AUTOINCREMENT)
        );
        """


        self.manualdb.create_table(sql_create_articles_table)
        

    signalGetData = Signal(type([]))

    @Slot(str)
    def searchHandler(self, searchTerm):
        self.signalGetData.emit(["hola", "mundo"])
        print(f"searchTerm es : {searchTerm}")

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    thebackend = ManualBackend()
    engine.rootContext().setContextProperty("backend", thebackend)
    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
