// RUN: %empty-directory(%t)
// RUN: cp %s %t/main.swift
// RUN: %target-build-swift -Xfrontend -playground -Xfrontend -playground-high-performance -o %t/main %S/Inputs/PlaygroundsRuntime.swift %t/main.swift
// RUN: %target-codesign %t/main
// RUN: %target-run %t/main | %FileCheck %s
// RUN: %target-build-swift -Xfrontend -pc-macro -Xfrontend -playground -Xfrontend -playground-high-performance -o %t/main2 %S/Inputs/PlaygroundsRuntime.swift %S/Inputs/SilentPCMacroRuntime.swift %t/main.swift
// RUN: %target-codesign %t/main2
// RUN: %target-run %t/main2 | %FileCheck %s
// REQUIRES: executable_test

var a = true
if (a) {
  5
} else {
  7
}

for i in 0..<3 {
  i
}
// CHECK: [{{.*}}] __builtin_log[a='true']
// CHECK-NEXT: [{{.*}}] __builtin_log[='5']
// CHECK-NEXT: [{{.*}}] __builtin_log[='0']
// CHECK-NEXT: [{{.*}}] __builtin_log[='1']
// CHECK-NEXT: [{{.*}}] __builtin_log[='2']

var b = true
for i in 0..<3 {
  i
  continue
}
// CHECK-NEXT: [{{.*}}] __builtin_log[b='true']
// CHECK-NEXT: [{{.*}}] __builtin_log[='0']
// CHECK-NEXT: [{{.*}}] __builtin_log[='1']
// CHECK-NEXT: [{{.*}}] __builtin_log[='2']

var c = true
for i in 0..<3 {
  i
  break
}
// CHECK-NEXT: [{{.*}}] __builtin_log[c='true']
// CHECK-NEXT: [{{.*}}] __builtin_log[='0']
