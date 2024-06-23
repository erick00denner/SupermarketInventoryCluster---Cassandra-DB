from cassandra.cluster import Cluster
import uuid
import random

cluster = Cluster(['127.0.0.1'])
session = cluster.connect('filial_nyc')

categories = ['Bebidas', 'Laticínios', 'Frutas', 'Carnes']
for _ in range(1000000):
    session.execute("""
        INSERT INTO produtos (product_id, nome, categoria, preco, estoque)
        VALUES (%s, %s, %s, %s, %s)
    """, (uuid.uuid4(), 'Produto ' + str(uuid.uuid4()), random.choice(categories), random.uniform(1.0, 100.0), random.randint(1, 1000)))

session.shutdown()
cluster.shutdown()
