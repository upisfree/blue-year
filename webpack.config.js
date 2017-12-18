const path = require('path');

module.exports = {
  entry: './src/index.coffee',
  output: {
    filename: 'blue-year.js',
    path: path.resolve(__dirname, 'bin')
  },
  watch: true,
  module: {
    rules: [
      {
        test: /\.coffee$/,
        use: [
          {
            loader: 'coffee-loader',
            options: { 
              transpile: {
                presets: ['env']
              },
              options: { sourceMap: true }
            }
          }
        ]
      }
    ]
  }
}