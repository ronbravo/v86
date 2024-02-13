import commonjs from '@rollup/plugin-commonjs';
import { nodeResolve } from '@rollup/plugin-node-resolve';

export default {
  input: './src/js/server/build/@defasm/core/index.js',
  output: {
    file: './build/defasm.js',
    format: 'umd',
    name: 'defasm',
    globals: {
      defasm: 'defasm',
    },
  },
  plugins: [nodeResolve (), commonjs ()],
};
