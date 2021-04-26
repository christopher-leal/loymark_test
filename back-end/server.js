const express = require('express');
const app = express();
require('dotenv').config();


app.use(require('cors')())
app.use(express.json())

const port = process.env.PORT || 3000;

app.use('/user', require('./src/routes/users'));
app.use('/activity', require('./src/routes/activities'));

app.get('/', (req, res) => {
    res.status(200).json({ success: true, status: 200 })
});
app.listen(port, () => console.log(`listening on http://localhost:${port}`));
