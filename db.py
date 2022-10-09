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

    def executeQuery(self, query, values=None):
        try:
            c = self.connection.cursor()
            result = None
            if values:
                result = c.execute(query, values)
            else:
                result = c.execute(query)
            
            self.connection.commit()
            return result

        except Error as e:
            print(e)
            return None

    def create_table(self, create_table_sql):
        """ create a table from the create_table_sql statement
        :param conn: Connection object
        :param create_table_sql: a CREATE TABLE statement
        :return:"""
        self.executeQuery(create_table_sql)

    def getSectionsQuery(self, searchWord):    
        q = f"""
            SELECT sections.id_sections, sections.title 
            FROM articles INNER JOIN sections
            ON articles.id_article = sections.article_cod
            WHERE articles.name = "{searchWord}"            
        """
        return self.executeQuery(q).fetchall()
    
    def getContentQuery(self, id):
        q = f"""
            SELECT content.description
            FROM sections INNER JOIN content
            ON sections.id_sections = content.section_cod
            WHERE sections.id_sections = {id}            
        """
        return self.executeQuery(q).fetchall()
    
    def insertItemsQuery(self, items):

        q = f"""
            INSERT INTO articles (name)
            VALUES (?);            
        """
        article_id = self.executeQuery(q,(str.lower(items[0]),)).lastrowid
        
        q = f"""
            INSERT INTO sections (title, article_cod)
            VALUES (?, ?);
        """
        section_id = self.executeQuery(q, (items[1], article_id)).lastrowid
        q = f"""
            INSERT INTO content (description, section_cod)
            VALUES (?, ?);            
        """
        self.executeQuery(q, (items[2], section_id))
        return 