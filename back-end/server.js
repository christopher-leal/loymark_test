const express = require('express');
const app = express();
const port = process.env.PORT || port;
app.get('/', (req, res) => {
    res.status(200).json({ success: true, status: 200 })
});
app.listen(port, () => console.log(`listening on http://localhost:${port}`));
