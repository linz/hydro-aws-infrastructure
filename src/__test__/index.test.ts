import assert from 'node:assert';
import { describe, it } from 'node:test';
import { helloWorld } from '../index.js';

describe('helloWorld', () => {
  it('should respond with hello world', () => {
    assert.equal(helloWorld('test'), 'hello world! test');
  });
});
