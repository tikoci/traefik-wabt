(module $wat_amm0_log

  ;; logs a message to the host's logs at the given $level.
  (import "http_handler" "log" (func $log
    (param $level i32)
    (param $buf i32) (param $buf_limit i32)))

  (memory (export "memory") 1 1 (; 1 page==64KB ;))
  (global $message i32 (i32.const 0))
  (data (i32.const 0) "hello world")
  (global $message_len i32 (i32.const 11))

  (func (export "handle_request") (result (; ctx_next ;) i64)
    (call $log
      (i32.const 0) ;; log_level_info
      (global.get $message)
      (global.get $message_len))

    ;; uint32(ctx_next) == 1 means proceed to the next handler on the host.
    (return (i64.const 1)))

  ;; handle_response is no-op as this is a request-only handler.
  (func (export "handle_response") (param $reqCtx i32) (param $is_error i32))
  
)
