defmodule AlchemyVM.ExecutorTest do
  use ExUnit.Case
  require Bitwise
  doctest AlchemyVM

  #### Basic Int Numeric Operations
  test "32 bit integers with add properly" do
    {:ok, pid} = AlchemyVM.start()
    AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
    assert AlchemyVM.execute(pid, "i32__add", [4, 2]) == {:ok, 9, 6}
  end

  test "64 bit integers with add properly" do
    {:ok, pid} = AlchemyVM.start()
    AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
    assert AlchemyVM.execute(pid, "i64__add", [4, 2]) == {:ok, 9, 6}
  end

  test "32 bit integers with mult properly" do
    {:ok, pid} = AlchemyVM.start()
    AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
    assert AlchemyVM.execute(pid, "i32__mul", [4, 2]) == {:ok, 11, 8}
  end

  test "64 bit integers with mult properly" do
    {:ok, pid} = AlchemyVM.start()
    AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
    assert AlchemyVM.execute(pid, "i64__mul", [4, 2]) == {:ok, 11, 8}
  end

  test "32 bit integers with sub properly" do
    {:ok, pid} = AlchemyVM.start()
    AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
    assert AlchemyVM.execute(pid, "i32__sub", [4, 2]) == {:ok, 9, -2}
  end

  test "64 bit integers with sub properly" do
    {:ok, pid} = AlchemyVM.start()
    AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
    assert AlchemyVM.execute(pid, "i64__sub", [4, 2]) == {:ok, 9, -2}
  end


    #### END OF Basic Numeric Operations

    #### Basic div Operations

    test "32 bit unsgined int can divide properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      result = AlchemyVM.execute(pid, "i32__div_u", [2, 4])
      assert result == {:ok, 11, 2}
    end

    test "32 bit signed int can divide properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      {:ok, 11, result} = AlchemyVM.execute(pid, "i32__div_s", [2, -4])
      answer = :math.pow(2, 32) + (result)
      assert answer == 4294967294
    end

    test "32 bit float can divide properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      result = AlchemyVM.execute(pid, "f32__div", [2.0, 4.0])
      assert result == {:ok, 11, AlchemyVM.Executor.float_point_op(2.0)}
    end
    #### End Basic Div Operations

    #### Basic REM Operations

    test "32 bit uint can rem properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "i32__rem_u", [2, 5]) == {:ok, 11, 1}
    end

    test "64 bit uint can rem properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "i64__rem_u", [2, 5]) == {:ok, 11, 1}
    end

    test "32 bit sint can rem properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      {:ok, _gas, res} = AlchemyVM.execute(pid, "i32__rem_s", [2, -5])
      answer = :math.pow(2, 32) + res
      assert Kernel.round(answer) == 4294967295
    end

    test "64 bit sint can rem properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "i64__rem_s", [2, -5]) == {:ok, 11, 1.8446744073709552e19}
    end

    #### End Basic Rem Operations

    #### Basic popcnt Operations

    test "32 bit int can popcnt properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "i32__popcnt", [128]) == {:ok, 8, 1}
    end

    test "64 bit int can popcnt properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "i64__popcnt", [128]) == {:ok, 8, 1}
    end

    #### End Basic PopCnt  Operations


    #### Basic Bitwise Operations

    test "32 bit int can Conjucture properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "i32__and", [11, 5]) == {:ok, 9, 1}
    end

    test "64 bit int can Conjucture properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "i64__and", [11, 5]) == {:ok, 9, 1}
    end

    test "32 bit int can or properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "i32__or", [11, 5]) == {:ok, 9, 15}
    end

    test "64 bit int can or properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "i64__or", [11, 5]) == {:ok, 9, 15}
    end

    test "32 bit int can xor properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "i32__xor", [11, 5]) == {:ok, 9, 14}
    end

    test "64 bit int can xor properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "i64__xor", [11, 5]) == {:ok, 9, 14}
    end

    test "32 bit int / ns can shl properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      {:ok, _gas, result} = AlchemyVM.execute(pid, "i32__shl", [3, -100])

      answer = :math.pow(2, 32) + result

      assert Kernel.round(answer) == 4294966496
    end

    test "64 bit int can shl properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      {:ok, _gas, result} = AlchemyVM.execute(pid, "i64__shl", [3, -100])

      answer = Bitwise.band(result, 0xFFFFFFFFFFFFFFFF)

      assert round(answer) == 18446744073709550816
    end

    test "32 bit sint can shr properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      {:ok, _gas, result} = AlchemyVM.execute(pid, "i32__shr_s", [3, -100])

      assert Bitwise.band(result, 0xFFFFFFFF) == 4294967283
    end

    test "64 bit sint can shr properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      {:ok, _gas, result} = AlchemyVM.execute(pid, "i64__shr_s", [3, -100])

      assert Bitwise.band(result, 0xFFFFFFFFFFFFFFFF) == 18446744073709551603
    end

    # NW
    test "32 bit uint can shr properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert {:ok, _gas, 536870899} = AlchemyVM.execute(pid, "i32__shr_u", [3, 100])
    end

    # NW
    test "64 bit uint can shr properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert {:ok, _gas, 0} = AlchemyVM.execute(pid, "i64__shr_u", [5, 6])
    end

    test "32 bit uint can rotl properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      {:ok, _gas, result} = AlchemyVM.execute(pid, "i32__rotl", [-100, 3])

      answer = :math.pow(2, 32) + result

      assert answer == 4294966503
    end

    test "32 bit uint can rotr properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert {:ok, _gas, 4} = AlchemyVM.execute(pid, "i32__rotr", [16, 2])
    end


    test "Call instruction works properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/nested_func_call.wasm")
      assert {:ok, _gas, -7367} =  AlchemyVM.execute(pid, "nested_func_call", [0, 32])
    end

    ### End simnple BitWise Ops

    ### Begin Float Operations

    test "32 bit float with add properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "f32__add", [4.0, 2.0]) == {:ok, 9, AlchemyVM.Executor.float_point_op(6.0)}
    end

    test "64 bit float with add properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "f64__add", [4.0, 2.0]) == {:ok, 9, AlchemyVM.Executor.float_point_op(6.0)}
    end

    test "32 bit float with sub properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "f32__sub", [4.0, 2.0]) == {:ok, 9, AlchemyVM.Executor.float_point_op(2.0)}
    end

    test "64 bit float with sub properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "f64__sub", [4.0, 2.0]) == {:ok, 9, AlchemyVM.Executor.float_point_op(2.0)}
    end

    test "32 bit float with mult properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "f32__mul", [4.0, 2.0]) == {:ok, 11, AlchemyVM.Executor.float_point_op(8.0)}
    end

    test "64 bit float with mult properly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "f64__mul", [4.0, 2.0]) == {:ok, 11, AlchemyVM.Executor.float_point_op(8.0)}
    end

    test "32 bit Floats Ceil Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "f32__ceil", [-1.75]) == {:ok, 8, AlchemyVM.Executor.float_point_op(-1.000000)}
    end

    test "32 bit Floats Min Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "f32__min", [0.00, 0.00]) == {:ok, 11, AlchemyVM.Executor.float_point_op(0.0)}
    end

    test "32 bit Floats Max Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "f32__max", [0.00, 0.00]) == {:ok,  11, AlchemyVM.Executor.float_point_op(0.0)}
    end

    test "64 bit Floats Min Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "f64__min", [0.00, 0.00]) == {:ok, 11, AlchemyVM.Executor.float_point_op(0.0)}
    end

    test "64 bit Floats Max Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "f64__max", [0.00, 0.00]) == {:ok,  11, AlchemyVM.Executor.float_point_op(0.0)}
    end

    test "32 bit Floats copysign Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "f32__copysign", [0.0, 0.0]) == {:ok, 11, AlchemyVM.Executor.float_point_op(0.0)}
      assert AlchemyVM.execute(pid, "f32__copysign", [-1.0, 0.0]) == {:ok, 11, AlchemyVM.Executor.float_point_op(0.0)}
      assert AlchemyVM.execute(pid, "f32__copysign", [-1.0, 1.0]) == {:ok, 11, AlchemyVM.Executor.float_point_op(-1.0)}
    end

    test "64 bit Floats copysign Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "f64__copysign", [0.0, 0.0]) == {:ok, 11, AlchemyVM.Executor.float_point_op(0.0)}
      assert AlchemyVM.execute(pid, "f64__copysign", [-1.0, 0.0]) == {:ok, 11, AlchemyVM.Executor.float_point_op(0.0)}
      assert AlchemyVM.execute(pid, "f64__copysign", [-1.0, 1.0]) == {:ok, 11, AlchemyVM.Executor.float_point_op(-1.0)}
    end

    test "32 bit Floats abs Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "f32__abs", [0.0]) == {:ok, 8, AlchemyVM.Executor.float_point_op(0.0)}
      assert AlchemyVM.execute(pid, "f32__abs", [-1.0]) == {:ok, 8, AlchemyVM.Executor.float_point_op(1.0)}
    end

    test "64 bit Floats abs Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "f64__abs", [-1.0]) == {:ok, 8, AlchemyVM.Executor.float_point_op(1.0)}
    end

    test "32 bit Floats neg Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "f32__neg", [0.0]) == {:ok, 8, AlchemyVM.Executor.float_point_op(0.0)}
      assert AlchemyVM.execute(pid, "f32__neg", [-1.0]) == {:ok, 8, AlchemyVM.Executor.float_point_op(1.0)}
    end

    test "64 bit Floats neg Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "f64__neg", [0.0]) == {:ok, 8, AlchemyVM.Executor.float_point_op(0.0)}
      assert AlchemyVM.execute(pid, "f64__neg", [-1.0]) == {:ok, 8, AlchemyVM.Executor.float_point_op(1.0)}
    end

    ### End of Basic Float Point Operations

    ### Begin Complex Integer Operations
    test "32 bit Integer lt_u Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "i32__lt_u", [1, 0]) == {:ok, 9, 1}
      assert AlchemyVM.execute(pid, "i32__lt_u", [0, 1]) == {:ok, 9, 0}
    end

    test "64 bit Integer lt_u Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "i64__lt_u", [1, 0]) == {:ok, 9, 1}
      assert AlchemyVM.execute(pid, "i64__lt_u", [0, 1]) == {:ok, 9, 0}
    end

    test "32 bit Integer lt_s Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "i32__lt_s", [2, 1]) == {:ok, 9, 1}
      assert AlchemyVM.execute(pid, "i32__lt_s", [1, 2]) == {:ok, 9, 0}
    end

    test "64 bit Integer lt_s Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "i64__lt_s", [2, 1]) == {:ok, 9, 1}
      assert AlchemyVM.execute(pid, "i64__lt_s", [1, 2]) == {:ok, 9, 0}
    end

    test "32 bit Integer gt_u Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "i32__gt_u", [2, 1]) == {:ok, 9, 0}
      assert AlchemyVM.execute(pid, "i32__gt_u", [1, 2]) == {:ok, 9, 1}
    end

    test "64 bit Integer gt_u Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "i64__gt_u", [2, 1]) == {:ok, 9, 0}
      assert AlchemyVM.execute(pid, "i64__gt_u", [1, 2]) == {:ok, 9, 1}
    end

    test "32 bit Integer gt_s Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "i32__gt_u", [2, 1]) == {:ok, 9, 0}
      assert AlchemyVM.execute(pid, "i32__gt_u", [1, 2]) == {:ok, 9, 1}
    end

    test "64 bit Integer gt_s Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "i64__gt_s", [2, 1]) == {:ok, 9, 0}
      assert AlchemyVM.execute(pid, "i64__gt_s", [1, 2]) == {:ok, 9, 1}
    end

    test "32 bit Integer le_u Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "i32__le_u", [2, 1]) == {:ok, 9, 1}
      assert AlchemyVM.execute(pid, "i32__le_u", [1, 2]) == {:ok, 9, 0}
    end

    test "64 bit Integer le_u Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "i64__le_u", [2, 1]) == {:ok, 9, 1}
      assert AlchemyVM.execute(pid, "i64__le_u", [1, 2]) == {:ok, 9, 0}
    end

    test "32 bit Integer ge_u Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "i32__ge_u", [2, 1]) == {:ok, 9, 0}
      assert AlchemyVM.execute(pid, "i32__ge_u", [1, 2]) == {:ok, 9, 1}
    end

    test "64 bit Integer ge_u Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "i64__ge_u", [2, 1]) == {:ok, 9, 0}
      assert AlchemyVM.execute(pid, "i64__ge_u", [1, 2]) == {:ok, 9, 1}
    end

    test "32 bit Integer clz Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "i32__clz", [2]) == {:ok, 8, 3}
    end

    test "64 bit Integer clz Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "i64__clz", [2]) == {:ok, 8, 3}
    end

    test "32 bit Integer ctz Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "i32__ctz", [2]) == {:ok, 8, 0}
    end

    test "64 bit Integer ctz Works Correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")

      assert AlchemyVM.execute(pid, "i64__ctz", [2]) == {:ok, 8, 0}
    end

    ### END COMPLEX INTEGER

    ### BEGIN PARAMETRIC TEST
    test "if statement works" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/if_2.wasm")
      assert {status, _gas, 1} = AlchemyVM.execute(pid, "ifOne", [0])
    end

    ### END PARAMTERIC TEST

    ### Begin Memory Tests
    test "32 Store 8 works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/memory.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "i32_store8", [])

      answer =
        answer
        |> :binary.encode_unsigned()
        |> :binary.bin_to_list()
        |> Enum.reverse
        |> :binary.list_to_bin
        |> :binary.decode_unsigned()

      assert answer == 4278058235
    end

    test "64 Store 8 works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/memory.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "i64_store8", [])

      answer =
        answer
        |> :binary.encode_unsigned()
        |> :binary.bin_to_list()
        |> Enum.reverse
        |> :binary.list_to_bin
        |> :binary.decode_unsigned()

      assert answer == 4278058235
    end

    test "32 Store 16 works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/memory.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "i32_store16", [])

      answer =
        answer
        |> :binary.encode_unsigned()
        |> :binary.bin_to_list()
        |> Enum.reverse
        |> :binary.list_to_bin
        |> :binary.decode_unsigned()

      assert answer == 3435907785
    end

    test "64 Store 16 works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/memory.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "i64_store16", [])

      answer =
        answer
        |> :binary.encode_unsigned()
        |> :binary.bin_to_list()
        |> Enum.reverse
        |> :binary.list_to_bin
        |> :binary.decode_unsigned()

      assert answer == 3435907785
    end

    test "64 Store 32 works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/memory.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "i64_store32", [])

      answer =
        answer
        |> :binary.encode_unsigned()
        |> :binary.bin_to_list()
        |> Enum.reverse
        |> :binary.list_to_bin
        |> :binary.decode_unsigned()

      assert answer == 4294843840
    end

    test "32 Store works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/memory.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "i32_store", [])
      assert answer == 4294843840
    end

    test "32 load8_s works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/load.wasm")
      assert {:ok, _gas, 255} = AlchemyVM.execute(pid, "i32_load8_s", [])
    end

    test "32 load8_u works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/load.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "i32_load8_u", [])
      assert answer == 255
    end

    test "32 load16_u works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/load.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "i32_load16_u", [])
      assert answer == 65535
    end

    test "64 load8_u works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/load.wasm")
      assert {:ok, _gas, 255} = AlchemyVM.execute(pid, "i64_load8_u", [])
    end

    test "64 load16_u works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/load.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "i64_load16_u", [])
      assert answer == 65535
    end

    test "64 load32_u works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/load.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "i64_load32_u", [])
      assert answer == 4294967295
    end


    test "32 load16_s works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/load.wasm")
      assert {:ok, _gas, 65535} = AlchemyVM.execute(pid, "i32_load16_s", [])
    end

    test "64 load8_s works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/load.wasm")
      assert {:ok, _gas, 255} = AlchemyVM.execute(pid, "i64_load8_s", [])
    end

    test "64 load16_s works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/load.wasm")
      assert {:ok, _gas, 65535} = AlchemyVM.execute(pid, "i64_load16_s", [])
    end

    test "64 load32_s works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/load.wasm")
      assert {:ok, _gas, 4294967295} = AlchemyVM.execute(pid, "i64_load32_s", [])
    end

    ### End Memory Tests

    ### Begin Wrapping & Trunc Tests
    test "32 wrap 64 works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap.wasm")
      assert {:ok, _gas, 4294967295} = AlchemyVM.execute(pid, "i32_wrap_i64", [])
    end

    test "f32 trunc i32 U works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap.wasm")
      assert {:ok, _gas, 3000000000} = AlchemyVM.execute(pid, "i32_trunc_u_f32", [])
    end

    test "f32 trunc i32 S works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "i32_trunc_s_f32", [])

      answer = Bitwise.band(answer, 0xFFFFFFFF)
      assert answer == 4294967196
    end

    test "f64 trunc i32 U works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "i32_trunc_u_f64", [])
      assert answer == 3000000000
    end

    test "f64 trunc i32 S works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "i32_trunc_s_f64", [])

      answer = Bitwise.band(answer, 0xFFFFFFFF)
      assert answer == 4294967196
    end

    test "f32 trunc i64 U works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap.wasm")
      assert {:ok, _gas, 1} = AlchemyVM.execute(pid, "i64_trunc_u_f32", [])
    end

    test "f32 trunc i64 S works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "i64_trunc_s_f32", [])

      answer = Bitwise.band(answer, 0xFFFFFFFF)
      assert answer == 1
    end

    test "f64 trunc i64 U works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap.wasm")
      assert {:ok, _gas, 1} = AlchemyVM.execute(pid, "i64_trunc_u_f64", [])
    end

    test "f64 trunc i64 S works correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "i64_trunc_s_f64", [])

      answer = Bitwise.band(answer, 0xFFFFFFFF)
      assert answer == 1
    end

    test "f32 i32 S Convert works" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap_fixed.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "f32_convert_s_i32", [])

      assert answer == AlchemyVM.Executor.float_point_op(-1 * 1.000000)
    end

    test "f32 i32 U Convert works" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap_fixed.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "f32_convert_u_i32", [])

      assert answer == AlchemyVM.Executor.float_point_op(4294967295 * 1.000000)
    end

    test "f32 i64 S Convert works" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap_fixed.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "f32_convert_s_i64", [])

      assert answer == AlchemyVM.Executor.float_point_op(0 * 1.000000)
    end

    test "f32 i64 U Convert works" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap_fixed.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "f32_convert_u_i64", [])

      assert answer == AlchemyVM.Executor.float_point_op(0 * 1.000000)
    end

    test "f64 i64 S Convert works" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap_fixed.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "f32_convert_s_i64", [])

      assert answer == AlchemyVM.Executor.float_point_op(0 * 1.000000)
    end

    test "f64 i64 U Convert works" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap_fixed.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "f32_convert_u_i64", [])

      assert answer == AlchemyVM.Executor.float_point_op(0 * 1.000000)
    end

    test "f64 i32 S Convert works" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap_fixed.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "f32_convert_s_i32", [])

      assert answer == AlchemyVM.Executor.float_point_op(-1 * 1.000000)
    end

    test "f64 i32 U Convert works" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap_fixed.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "f32_convert_u_i32", [])

      assert answer == AlchemyVM.Executor.float_point_op(4294967295 * 1.000000)
    end

    test "i64 extend i32 u works" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap_fixed.wasm")
      assert {:ok, _gas, 4294967295} = AlchemyVM.execute(pid, "i64_extend_u_i32", [])
    end

    test "i64 extend i32 s works" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap_fixed.wasm")
      assert {:ok, _gas, 18446744073709551615} = AlchemyVM.execute(pid, "i64_extend_s_i32", [])
    end

    test "f32 demote f64 works" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap_fixed.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "f32_demote_f64", [])

      assert answer == AlchemyVM.Executor.float_point_op(123456789 * 1.0)
    end

    test "f64 promote f32 works" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/wrap_fixed.wasm")
      {:ok, _gas, answer} = AlchemyVM.execute(pid, "f64_demote_f32", [])

      assert answer == AlchemyVM.Executor.float_point_op(12345679 * 1.0)
    end

    ### End Wrapping & Trunc Tests

    ### Begin Compare tests
    test "i64 eq true works" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/compare.wasm")
      assert {:ok, _gas, 1} = AlchemyVM.execute(pid, "i64_eq_true", [])
    end

    test "i64 eq false works" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/compare.wasm")
      assert {:ok, _gas, 0} = AlchemyVM.execute(pid, "i64_eq_false", [])
    end

    ### END COMPARE

    ### START GAS SYSTEM
    test "gas instantiates correctly" do
      {:ok, pid} = AlchemyVM.start()
      AlchemyVM.load_file(pid, "test/fixtures/wasm/types.wasm")
      assert AlchemyVM.execute(pid, "i32__add", [2, 4]) == {:ok, 9, 6}
    end

    test "gas instantiates with limit correctly" do
      # {:ok, pid} = AlchemyVM.start()
      #AlchemyVM.load_file(pid, "test/fixtures/wasm/add_2.wasm")
      #{status, gas_cost, stack_value} =  AlchemyVM.execute(pid, "_Z3addPi", [4], [gas_limit: 1])
      #{status, gas_cost2, stack_value2} =  AlchemyVM.execute(pid, "_Z3addPi", [4], [gas_limit: 10])
    #  assert gas_cost == 0
      #assert gas_cost2 == 3
      #assert stack_value == 4
      #assert stack_value2 == 4
    end
end
