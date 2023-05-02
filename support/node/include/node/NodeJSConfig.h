#pragma once

#ifndef NODE_JS_CONFIG_H_INCLUDED

/** test whether the NodeJSConfig.h file was (already) included */
#define NODE_JS_CONFIG_H_INCLUDED


/** When set to 'true', 1, 2, 3, or an empty string causes NO_COLOR and NODE_DISABLE_COLORS to be ignored. */
#define FORCE_COLOR

/** Alias for NODE_DISABLE_COLORS. */
#define NO_COLOR

/** ','-separated list of core modules that should print debug information. */
#define NODE_DEBUG

/** ','-separated list of C++ core debug categories that should print debug output. */
#define NODE_DEBUG_NATIVE

/** Set to 1 to disable colors in the REPL. */
#define NODE_DISABLE_COLORS

/** path to additional CA certificates file. Only read once during process startup. */
#define NODE_EXTRA_CA_CERTS

/** set to 1 to silence process warnings. */
#define NODE_NO_WARNINGS

/** ';'-separated list of directories prefixed to the module search path. */
#define NODE_PATH

/** set to 1 to emit pending deprecation warnings. */
#define NODE_PENDING_DEPRECATION

/** set the number of pending pipe instance handles on Windows. */
#define NODE_PENDING_PIPE_INSTANCES

/** set to 1 to preserve symbolic links when resolving and caching modules. */
#define NODE_PRESERVE_SYMLINKS

/** write warnings to path instead of stderr. */
#define NODE_REDIRECT_WARNINGS

/** path to a Node.js module which will be loaded in place of the built-in REPL. */
#define NODE_REPL_EXTERNAL_MODULE

/** path to the persistent REPL history file. */
#define NODE_REPL_HISTORY

/** set to 1 to skip the check for a supported platform during Node.js startup. */
#define NODE_SKIP_PLATFORM_CHECK

/** set to 0 to disable TLS certificate validation. */
#define NODE_TLS_REJECT_UNAUTHORIZED

/** directory to output v8 coverage JSON to. */
#define NODE_V8_COVERAGE

/** specify the timezone configuration */
#define TZ

/** sets the number of threads used in libuv's threadpool. */
#define UV_THREADPOOL_SIZE


#endif // NODE_JS_CONFIG_H_INCLUDED
