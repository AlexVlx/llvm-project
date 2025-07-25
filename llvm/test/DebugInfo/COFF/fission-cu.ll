; RUN: llc -split-dwarf-file=baz.dwo -O0 %s -mtriple=x86_64-unknown-windows-msvc -filetype=obj -o %t
; RUN: llvm-dwarfdump -v -all %t | FileCheck %s
; RUN: llvm-readobj --relocations %t | FileCheck --check-prefix=OBJ %s
; RUN: llvm-objdump -h %t | FileCheck --check-prefix=HDR %s

; This test is derived from test/DebugInfo/X86/fission-cu.ll

source_filename = "test/DebugInfo/X86/fission-cu.ll"

@a = common global i32 0, align 4, !dbg !0

!llvm.dbg.cu = !{!4}
!llvm.module.flags = !{!7}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = !DIGlobalVariable(name: "a", scope: null, file: !2, line: 1, type: !3, isLocal: false, isDefinition: true)
!2 = !DIFile(filename: "baz.c", directory: "e:\\llvm-project\\tmp")
!3 = !DIBasicType(name: "int", size: 32, align: 32, encoding: DW_ATE_signed)
!4 = distinct !DICompileUnit(language: DW_LANG_C99, file: !2, producer: "clang version 3.3 (trunk 169021) (llvm/trunk 169020)", isOptimized: false, runtimeVersion: 0, splitDebugFilename: "baz.dwo", emissionKind: FullDebug, enums: !5, retainedTypes: !5, globals: !6, imports: !5)
!5 = !{}
; Check that the skeleton compile unit contains the proper attributes:
; This DIE has the following attributes: DW_AT_comp_dir, DW_AT_stmt_list,
; DW_AT_low_pc, DW_AT_high_pc, DW_AT_ranges, DW_AT_dwo_name, DW_AT_dwo_id,
; DW_AT_ranges_base, DW_AT_addr_base.

; CHECK: .debug_abbrev contents:
; CHECK: Abbrev table for offset: 0x00000000
; CHECK: [1] DW_TAG_compile_unit DW_CHILDREN_no
; CHECK: DW_AT_stmt_list DW_FORM_sec_offset
; CHECK: DW_AT_comp_dir  DW_FORM_strp
; CHECK: DW_AT_GNU_dwo_name      DW_FORM_strp
; CHECK: DW_AT_GNU_dwo_id        DW_FORM_data8

; Check that we're using the right forms.
; CHECK: .debug_abbrev.dwo contents:
; CHECK: Abbrev table for offset: 0x00000000
; CHECK: [1] DW_TAG_compile_unit DW_CHILDREN_yes
; CHECK: DW_AT_producer  DW_FORM_GNU_str_index
; CHECK: DW_AT_language  DW_FORM_data2
; CHECK: DW_AT_name      DW_FORM_GNU_str_index
; CHECK: DW_AT_GNU_dwo_name  DW_FORM_GNU_str_index
; CHECK-NOT: DW_AT_low_pc
; CHECK-NOT: DW_AT_stmt_list
; CHECK-NOT: DW_AT_comp_dir
; CHECK: DW_AT_GNU_dwo_id        DW_FORM_data8

; CHECK: [2] DW_TAG_variable     DW_CHILDREN_no
; CHECK: DW_AT_name      DW_FORM_GNU_str_index
; CHECK: DW_AT_type      DW_FORM_ref4
; CHECK: DW_AT_external  DW_FORM_flag_present
; CHECK: DW_AT_decl_file DW_FORM_data1
; CHECK: DW_AT_decl_line DW_FORM_data1
; CHECK: DW_AT_location  DW_FORM_exprloc

; CHECK: [3] DW_TAG_base_type    DW_CHILDREN_no
; CHECK: DW_AT_name      DW_FORM_GNU_str_index
; CHECK: DW_AT_encoding  DW_FORM_data1
; CHECK: DW_AT_byte_size DW_FORM_data1

; CHECK: .debug_info contents:
; CHECK: DW_TAG_compile_unit
; CHECK-NEXT: DW_AT_stmt_list [DW_FORM_sec_offset]   (0x00000000)
; CHECK-NEXT: DW_AT_comp_dir [DW_FORM_strp]     ( .debug_str[0x00000000] = "e:\\llvm-project\\tmp")
; CHECK-NEXT: DW_AT_GNU_dwo_name [DW_FORM_strp] ( .debug_str[0x00000014] = "baz.dwo")
; CHECK-NEXT: DW_AT_GNU_dwo_id [DW_FORM_data8]  ([[HASH:0x[0-9a-f]*]])

; Check that the rest of the compile units have information.
; CHECK: .debug_info.dwo contents:
; CHECK: DW_TAG_compile_unit
; CHECK: DW_AT_producer [DW_FORM_GNU_str_index] (indexed (00000002) string = "clang version 3.3 (trunk 169021) (llvm/trunk 169020)")
; CHECK: DW_AT_language [DW_FORM_data2]        (DW_LANG_C99)
; CHECK: DW_AT_name [DW_FORM_GNU_str_index]    (indexed (00000003) string = "baz.c")
; CHECK: DW_AT_GNU_dwo_name [DW_FORM_GNU_str_index] (indexed (00000004) string = "baz.dwo")
; CHECK-NOT: DW_AT_low_pc
; CHECK-NOT: DW_AT_stmt_list
; CHECK-NOT: DW_AT_comp_dir
; CHECK: DW_AT_GNU_dwo_id [DW_FORM_data8]  ([[HASH]])
; CHECK: DW_TAG_variable
; CHECK: DW_AT_name [DW_FORM_GNU_str_index]     (indexed (00000000) string = "a")
; CHECK: DW_AT_type [DW_FORM_ref4]       (cu + 0x{{[0-9a-f]*}} => {[[TYPE:0x[0-9a-f]*]]}
; CHECK: DW_AT_external [DW_FORM_flag_present]   (true)
; CHECK: DW_AT_decl_file [DW_FORM_data1] (0x01)
; CHECK: DW_AT_decl_line [DW_FORM_data1] (1)
; CHECK: DW_AT_location [DW_FORM_exprloc] (DW_OP_GNU_addr_index 0x0)
; CHECK: [[TYPE]]: DW_TAG_base_type
; CHECK: DW_AT_name [DW_FORM_GNU_str_index]     (indexed (00000001) string = "int")

; CHECK: .debug_str contents:
; CHECK: 0x00000000: "e:\\llvm-project\\tmp"
; CHECK: 0x00000014: "baz.dwo"

; CHECK: .debug_str.dwo contents:
; CHECK: 0x00000000: "a"
; CHECK: 0x00000002: "int"
; CHECK: 0x00000006: "clang version 3.3 (trunk 169021) (llvm/trunk 169020)"
; CHECK: 0x0000003b: "baz.c"
; CHECK: 0x00000041: "baz.dwo"

; CHECK: .debug_str_offsets.dwo contents:
; CHECK: 0x00000000: 00000000
; CHECK: 0x00000004: 00000002
; CHECK: 0x00000008: 00000006
; CHECK: 0x0000000c: 0000003b
; CHECK: 0x00000010: 00000041

; Object file checks
; For COFF we should have this set of relocations for the debug info section
;
; OBJ: .debug_info
; OBJ-NEXT: IMAGE_REL_AMD64_SECREL .debug_abbrev (8)
; OBJ-NEXT: IMAGE_REL_AMD64_SECREL .debug_line (28)
; OBJ-NEXT: IMAGE_REL_AMD64_SECREL .debug_str (12)
; OBJ-NEXT: IMAGE_REL_AMD64_SECREL .debug_str (12)
; OBJ-NEXT: IMAGE_REL_AMD64_SECREL .debug_addr (22)
; OBJ-NEXT: }

; HDR-NOT: .debug_aranges

!6 = !{!0}
!7 = !{i32 1, !"Debug Info Version", i32 3}
