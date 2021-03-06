local insert
do
  local _obj_0 = table
  insert = _obj_0.insert
end
local make_callback
make_callback = function(name)
  local add
  add = function(callback)
    local current = ngx.ctx[name]
    local t = type(current)
    local _exp_0 = t
    if "nil" == _exp_0 then
      ngx.ctx[name] = callback
    elseif "function" == _exp_0 then
      ngx.ctx[name] = {
        current,
        callback
      }
    elseif "table" == _exp_0 then
      return insert(current, callback)
    end
  end
  local run
  run = function(...)
    local callbacks = ngx.ctx[name]
    local _exp_0 = type(callbacks)
    if "table" == _exp_0 then
      for _index_0 = 1, #callbacks do
        local fn = callbacks[_index_0]
        fn(...)
      end
    elseif "function" == _exp_0 then
      return callbacks(...)
    end
  end
  return add, run
end
local after_dispatch, run_after_dispatch = make_callback("after_dispatch")
return {
  after_dispatch = after_dispatch,
  run_after_dispatch = run_after_dispatch
}
