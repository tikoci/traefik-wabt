
;;; *** NOTE ***
;;; Just for quick reference - not for compiling!
;;; Based on cut-and-paste from https://http-wasm.io/http-handler-abi/

(;;; *** EXPORTS *** ;;;)

(func (export "handle_request") (result (; ctx_next ;) i64)
  ;; --snip--
  ;; return i64(reqCtx) << 32 | i64(1)
  (return
    (i64.or
      (i64.shl (i64.extend_i32_u (local.get $reqCtx)) (i64.const 32))
      (i64.const 1))))


(func (export "handle_response") (result (; ctx_next ;) i64) ;;(return (i64.const 1)))




(;;; *** IMPORTS *** ;;;)


;;; Admin Functions ;;; 

(import "http_handler" "get_config" (func $get_config
  (param $buf i32) (param $buf_limit i32)
  (result (; len ;) i32)))

      (global $feature_buffer_request  i32 (i32.const 1))
      (global $feature_buffer_response i32 (i32.const 2))
      (global $feature_trailers        i32 (i32.const 4))


(import "http_handler" "enable_features" (func $enable_features
  (param $enable_features i32)
  (result  (; features ;) i32)))

;;; Logging Function ;;;

      (global $log_level_debug i32 (i32.const -1))
      (global $log_level_info  i32 (i32.const  0))
      (global $log_level_warn  i32 (i32.const  1))
      (global $log_level_error i32 (i32.const  2))
      (global $log_level_none  i32 (i32.const  3))

(import "http_handler" "log" (func $log
  (param $level (; log_level ;) i32)
  (param $message i32) (param $message_len i32)))

(import "http_handler" "log_enabled" (func $log_enabled
  (param $level i32)
  (result (; 0 or enabled(1) ;) i32)))


;;; Path Functions ;;;

(import "http_handler" "get_path" (func $get_path
  (param $buf i32) (param $buf_limit i32)
  (result (; path_len ;) i32)))


;;; Header Functions ;;;

      (global $header_kind_request           i32 (i32.const 0))
      (global $header_kind_response          i32 (i32.const 1))
      (global $header_kind_request_trailers  i32 (i32.const 2))
      (global $header_kind_response_trailers i32 (i32.const 3))

(import "http_handler" "get_header_names" (func $get_header_names
  (param $kind i32)
  (param  $buf i32) (param $buf_limit i32)
  (result (; count << 32| len ;) i64)))

(import "http_handler" "get_header_values" (func $get_header_values
  (param $kind i32)
  (param $name i32) (param  $name_len i32)
  (param  $buf i32) (param $buf_limit i32)
  (result (; count << 32| len ;) i64)))

(import "http_handler" "set_header_value" (func $set_header_value
  (param  $kind i32)
  (param  $name i32) (param $name_len i32)
  (param $value i32) (param $value_len i32)))

(import "http_handler" "add_header_value" (func $add_header_value
  (param  $kind i32)
  (param  $name i32) (param $name_len i32)
  (param $value i32) (param $value_len i32)))

(import "http_handler" "remove_header" (func $set_header_value
  (param  $kind i32)
  (param  $name i32) (param $name_len i32)))


;;; Body Functions ;;;

      (global $body_kind_request  i32 (i32.const 0))
      (global $body_kind_response i32 (i32.const 1))

(import "http_handler" "read_body" (func $read_body
  (param $kind i32)
  (param  $buf i32) (param $buf_len i32)
  (result (; 0 or EOF(1) << 32 | len ;) i64)))

(import "http_handler" "write_body" (func $write_body
  (param $kind i32)
  (param $body i32) (param $body_len i32)))


;;; Request Only Function ;;;

(import "http_handler" "get_method" (func $get_method
  (param $buf i32) (param $buf_limit i32)
  (result (; len ;) i32)))

(import "http_handler" "set_method" (func $set_method
  (param $method i32) (param $method_len i32)))

(import "http_handler" "get_uri" (func $get_uri
  (param $buf i32) (param $buf_limit i32)
  (result (; len ;) i32)))

(import "http_handler" "set_uri" (func $set_uri
  (param $uri i32) (param $uri_len i32)))

(import "http_handler" "get_protocol_version" (func $get_protocol_version
  (param $buf i32) (param $buf_limit i32)
  (result (; len ;) i32)))

(import "http_handler" "get_source_addr" (func $get_source_addr
  (param $buf i32) (param $buf_limit i32)
  (result (; len ;) i32)))

;;; Response Only Functions 

(import "http_handler" "get_status_code" (func $get_status_code
  (result (; len ;) i32)))

(import "http_handler" "set_status_code" (func $set_status_code
  (param $status_code i32)))