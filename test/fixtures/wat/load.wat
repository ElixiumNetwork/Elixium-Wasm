(module
  (memory 1)
  (data (i32.const 0) "\ff\ff\ff\ff")
  (data (i32.const 4) "\00\00\ce\41")
  (data (i32.const 8) "\00\00\00\00\00\ff\8f\40")
  (data (i32.const 16) "\ff\ff\ff\ff\ff\ff\ff\ff")

  (func (export "i32_load8_s") (result i32)
    i32.const 0
    i32.load8_s)
  (func (export "i32_load16_s") (result i32)
    i32.const 0
    i32.load16_s)
  (func (export "i32_load") (result i32)
    i32.const 0
    i32.load)

  (func (export "i32_load8_u") (result i32)
    i32.const 0
    i32.load8_u)
  (func (export "i32_load16_u") (result i32)
    i32.const 0
    i32.load16_u)

  (func (export "i64_load8_s") (result i64)
    i32.const 0
    i64.load8_s)
  (func (export "i64_load16_s") (result i64)
    i32.const 0
    i64.load16_s)
  (func (export "i64_load32_s") (result i64)
    i32.const 0
    i64.load32_s)

  (func (export "i64_load") (result i64)
    i32.const 16
    i64.load)

  (func (export "i64_load8_u") (result i64)
    i32.const 0
    i64.load8_u)
  (func (export "i64_load16_u") (result i64)
    i32.const 0
    i64.load16_u)
  (func (export "i64_load32_u") (result i64)
    i32.const 0
    i64.load32_u)

  (func (export "f32_load") (result f32)
    i32.const 4
    f32.load)

  (func (export "f64_load") (result f64)
    i32.const 8
    f64.load)
)
(;; STDOUT ;;;
i32_load8_s() => i32:4294967295
i32_load16_s() => i32:4294967295
i32_load() => i32:4294967295
i32_load8_u() => i32:255
i32_load16_u() => i32:65535
i64_load8_s() => i64:18446744073709551615
i64_load16_s() => i64:18446744073709551615
i64_load32_s() => i64:18446744073709551615
i64_load() => i64:18446744073709551615
i64_load8_u() => i64:255
i64_load16_u() => i64:65535
i64_load32_u() => i64:4294967295
f32_load() => f32:25.750000
f64_load() => f64:1023.875000
;;; STDOUT ;;)
