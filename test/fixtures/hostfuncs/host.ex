defmodule Host do
  use WaspVM.HostFunction

  defhost :function0, [_a, _b] do
    WaspVM.HostFunction.API.update_memory(ctx, "memory1", 0, <<0, 50, 130, 53>>) # 3310133
    WaspVM.HostFunction.API.update_memory(ctx, "memory1", 32, <<0, 102, 20, 75>>) # 6689867
  end

  defhost :function1 do
    IO.puts "HI"
  end

  defhost :fill_mem_at_locations, [addr1, addr2] do
    WaspVM.HostFunction.API.update_memory(ctx, "memory1", addr1, <<0, 50, 130, 53>>) # 3310133
    WaspVM.HostFunction.API.update_memory(ctx, "memory1", addr2, <<0, 102, 20, 75>>) # 6689867
  end
end