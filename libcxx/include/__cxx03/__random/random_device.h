//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef _LIBCPP___CXX03___RANDOM_RANDOM_DEVICE_H
#define _LIBCPP___CXX03___RANDOM_RANDOM_DEVICE_H

#include <__cxx03/__config>
#include <__cxx03/string>

#if !defined(_LIBCPP_HAS_NO_PRAGMA_SYSTEM_HEADER)
#  pragma GCC system_header
#endif

_LIBCPP_PUSH_MACROS
#include <__cxx03/__undef_macros>

_LIBCPP_BEGIN_NAMESPACE_STD

#if !defined(_LIBCPP_HAS_NO_RANDOM_DEVICE)

class _LIBCPP_EXPORTED_FROM_ABI random_device {
#  ifdef _LIBCPP_USING_DEV_RANDOM
  int __f_;
#  elif !defined(_LIBCPP_ABI_NO_RANDOM_DEVICE_COMPATIBILITY_LAYOUT)
  _LIBCPP_DIAGNOSTIC_PUSH
  _LIBCPP_CLANG_DIAGNOSTIC_IGNORED("-Wunused-private-field")

  // Apple platforms used to use the `_LIBCPP_USING_DEV_RANDOM` code path, and now
  // use `arc4random()` as of this comment. In order to avoid breaking the ABI, we
  // retain the same layout as before.
#    if defined(__APPLE__)
  int __padding_; // padding to fake the `__f_` field above
#    endif

  // ... vendors can add workarounds here if they switch to a different representation ...

  _LIBCPP_DIAGNOSTIC_POP
#  endif

public:
  // types
  typedef unsigned result_type;

  // generator characteristics
  static const result_type _Min = 0;
  static const result_type _Max = 0xFFFFFFFFu;

  _LIBCPP_HIDE_FROM_ABI static result_type min() { return _Min; }
  _LIBCPP_HIDE_FROM_ABI static result_type max() { return _Max; }

  // constructors
  explicit random_device(const string& __token = "/dev/urandom");
  ~random_device();

  // generating functions
  result_type operator()();

  // property functions
  double entropy() const _NOEXCEPT;

  random_device(const random_device&)  = delete;
  void operator=(const random_device&) = delete;
};

#endif // !_LIBCPP_HAS_NO_RANDOM_DEVICE

_LIBCPP_END_NAMESPACE_STD

_LIBCPP_POP_MACROS

#endif // _LIBCPP___CXX03___RANDOM_RANDOM_DEVICE_H
