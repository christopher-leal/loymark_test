const SequelizeAuto = require('sequelize-auto')
require('dotenv').config();
console.log('entro')
const tables = [
    // tables
    'users',
    'activities',
]

const auto_models = new SequelizeAuto(process.env.DATABASE, process.env.DB_USERNAME, process.env.DB_PASSWORD, {
    host: process.env.DB_HOST,
    dialect: 'mysql',
    port: '3306',
    directory: './src/models',
    additional: {
        timestamps: false,
    },
    caseModel: 'p',
    caseFile: 'c',
    caseProp: 'c',
    singularize: true,

    tables,

})

auto_models.run(err => {
    if (err) throw err;
    console.log(auto_models.tables)
    console.log(auto_models.foreignKeys)
})
