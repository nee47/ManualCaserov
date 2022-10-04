import imp
from msilib.schema import Class


import sqlite3
from sqlite3 import Error

class ManualDB():
    def __init__(self):
        self.connection = None

        self.searchQuery = """ 
            SELECT a.description as "title_app", s.title as "section", c.description
            FROM articles a INNER JOIN sections s
            on a.id_article = s.article_cod
            INNER JOIN content c
            on s.id_sections = c.section_cod
            WHERE a.name = "react"
        """

    def create_connection(self, db_file):
        """ create a database connection to a SQLite database """
        try:
            self.connection = sqlite3.connect(db_file)
            print(sqlite3.version)
        except Error as e:
            print(e)

    def create_table(self, create_table_sql):
        """ create a table from the create_table_sql statement
        :param conn: Connection object
        :param create_table_sql: a CREATE TABLE statement
        :return:"""
        try:
            c = self.connection.cursor()
            c.execute(create_table_sql)
            self.connection.commit()

        except Error as e:
            print("aca en create teblor")
            print(e)