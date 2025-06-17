const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.send('物語ステーション サーバーが起動しています');
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
}); 