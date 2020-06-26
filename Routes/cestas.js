// IMPORTS
    // Express
    const express = require('express');
    const router = express.Router() ;
    // SQL
    const Sql = require('../infra/sql');




// ROTAS
    // / --> Todas cestas do Db
    router.get('/', async (req, res) => {

        let cestas = null;

        await Sql.conectar(async (sql) =>  {
            
            cestas = await sql.query('SELECT * FROM cesta');
            
        });

        res.send(cestas || []);

    });


    // /pedido --> Cadastra Pedido 
    router.post('/pedido', async (req, res) => {

        let data = req.body;
        let resp = null;
        await Sql.conectar(async (sql) => {
            try {
                await sql.beginTransaction();

                await sql.query('INSERT INTO pedido (ped_detalhes, ped_cliente) VALUES (?, ?)', [data.cliente.observacao, data.cliente.nome_cliente])

                let ped_id = await sql.scalar('SELECT LAST_INSERT_ID()');

                data.cestas.forEach(async (obj) => {

                    await sql.query('INSERT INTO pedido_item (ped_item_qtd, cesta_id, ped_id) VALUES (?, ?, ?)', [obj.qtd, obj.id, ped_id])
                
                });

                await sql.commit();

            }
            catch (e) {
                resp = e;
            }
        })
        
        res.send(resp);
        
    })

    // /pedidos --> Mostra pedidos
    router.get('/pedidos', async (req, res) => {
        let pedidos = null;

        await Sql.conectar(async (sql) =>  {
            
            pedidos = await sql.query('SELECT ped.ped_cliente, ped.ped_detalhes, it.ped_item_qtd, c.cesta_nome, c.cesta_id, cat.cat_nome FROM pedido ped INNER JOIN pedido_item it ON ped.ped_id = it.ped_id INNER JOIN cesta c ON c.cesta_id = it.cesta_id INNER JOIN categoria cat ON cat.cat_id = c.cat_id');
            
        });

        res.send(pedidos || []);
    })


module.exports = router;