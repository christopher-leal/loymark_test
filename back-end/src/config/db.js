const { Sequelize } = require('sequelize');
const { initModels } = require('../models/init-models');

const sequelize = new Sequelize(process.env.DATABASE, process.env.DB_USERNAME, process.env.DB_PASSWORD, {
    host: process.env.DB_HOST,
    dialect: 'mysql',
    port: 3306,
    pool: {
        max: 5,
        min: 0,
        acquire: 10000,
        idle: 10000
    },

    dialectOptions: {
        timezone: '-05:00',
    },
    timezone: '-05:00',
})

module.exports = {
    models: () => initModels(sequelize)
}
