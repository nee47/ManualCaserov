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
        res = self.executeQuery(q)
        return (res.fetchall(), res.lastrowid)
    
    def getContentQuery(self, id):
        q = f"""
            SELECT content.description
            FROM sections INNER JOIN content
            ON sections.id_sections = content.section_cod
            WHERE sections.id_sections = {id}            
        """
        return self.executeQuery(q).fetchall()
    
    def _insertArticle(self, name):
        q = f"""
            INSERT INTO articles (name)
            VALUES (?);            
        """
        return self.executeQuery(q,(str.lower(name),))

    def _insertArticle(self, name):
        q = f"""
            INSERT INTO articles (name)
            VALUES (?);            
        """
        return self.executeQuery(q,(name,))

    def insertItemsQuery(self, items):
        
        if(items[0] == "" or items[1] == "" ):
            return

        q = f"""
            INSERT INTO articles (name)
            VALUES (?);            
        """
        article_id = self._insertArticle(items[0]).lastrowid
    
        q = f"""
            INSERT INTO sections (title, article_cod)
            VALUES (?, ?);
        """
        section_id = self.executeQuery(q, (items[1], article_id)).lastrowid

        if(items[2] == "" ):
            return

        q = f"""
            INSERT INTO content (description, section_cod)
            VALUES (?, ?);            
        """
        self.executeQuery(q, (items[2], section_id))
        return 

    def insertNewSectionQuery(self, articleName, sectionName):

        print(f"lo que entra articlename: {articleName}, section name : {sectionName}")

        q = f"""
            SELECT  id_article  
            FROM articles
            WHERE articles.name = ?
            ;            
        """
        article_id = self.executeQuery(q, (articleName,)).fetchone()
        
        q = f"""
            INSERT INTO sections (title, article_cod)
            VALUES (?, ?);            
        """
        self.executeQuery(q, (sectionName, article_id[0]))

        return 

    def insertNewContentQuery(self, contentDescription, sec_cod):

        q = f"""
            INSERT INTO content (description, section_cod)
            VALUES (?,?);            
        """

        self.executeQuery(q, (contentDescription, sec_cod))

    def updateContentQuery(self, newDescription, id):

        q = f"""
            UPDATE content
              SET description = ? 
              WHERE content.id_content = ?           
        """

        self.executeQuery(q, (newDescription, id))



