import sqlite3

class PlantsEntity:
    conn = sqlite3.connect('orders.db')
    cur = conn.cursor()


    # place - местность, в которой обитает. Пример: пустыня, саванна
    def createTable(self):
        self.cur.execute("""CREATE TABLE IF NOT EXISTS plant(
           plant_id INT PRIMARY KEY,
           place TEXT);
        """)
        self.conn.commit()
