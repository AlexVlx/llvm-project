// RUN: not llvm-mc -triple=amdgcn -mcpu=gfx1200 %s 2>&1 | FileCheck --check-prefixes=NOGFX12 --implicit-check-not=error: %s

// missing dim
image_atomic_add_flt v0, v0, s[0:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_add_uint v0, v0, s[0:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_and v5, v1, s[8:15] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_cmpswap v[0:1], v0, s[0:7] dmask:0x3
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_dec_uint v0, v0, s[0:7] dmask:0x1 th:TH_ATOMIC_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_inc_uint v0, v0, s[0:7] dmask:0x1 th:TH_ATOMIC_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_max_flt v0, v0, s[0:7] dmask:0x1 th:TH_ATOMIC_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_max_int v0, v0, s[0:7] dmask:0x1 th:TH_ATOMIC_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_max_uint v0, v0, s[0:7] dmask:0x1 th:TH_ATOMIC_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_min_flt v0, v0, s[0:7] dmask:0x1 th:TH_ATOMIC_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_min_int v0, v0, s[0:7] dmask:0x1 th:TH_ATOMIC_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_min_uint v0, v0, s[0:7] dmask:0x1 th:TH_ATOMIC_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_or v0, v0, s[0:7] dmask:0x1 th:TH_ATOMIC_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_pk_add_bf16 v0, v0, s[0:7] dmask:0x1 th:TH_ATOMIC_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_pk_add_f16 v0, v0, s[0:7] dmask:0x1 th:TH_ATOMIC_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_sub_uint v0, v0, s[0:7] dmask:0x1 th:TH_ATOMIC_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_swap v0, v0, s[0:7] dmask:0x1 th:TH_ATOMIC_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_atomic_xor v0, v0, s[0:7] dmask:0x1 th:TH_ATOMIC_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_gather4 v[0:3], [v4, v5], s[0:7], s[100:103] dmask:0x8 unorm
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_gather4_b v[64:67], [v32, v33], s[4:11], s[4:7] dmask:0x1 a16
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_gather4_b_cl v[64:67], [v32, v33, v34], s[4:11], s[4:7] dmask:0x1 a16
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_gather4_c v[64:67], [v32, v33], s[4:11], s[4:7] dmask:0x1 a16
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_gather4_c_b v[64:67], [v32, v33, v34], s[4:11], s[4:7] dmask:0x1 a16
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_gather4_c_b_cl v[64:67], [v32, v33, v34, v35], s[4:11], s[4:7] dmask:0x1 a16
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_gather4_c_cl v[64:67], [v32, v33, v34], s[4:11], s[4:7] dmask:0x1 a16
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_gather4_c_l v[64:67], [v32, v33, v34], s[4:11], s[4:7] dmask:0x1 a16
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_gather4_cl v[64:67], [v32, v33, v34], s[4:11], s[4:7] dmask:0x1 a16
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_gather4_c_lz v[64:67], [v32, v33], s[4:11], s[4:7] dmask:0x1 a16
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_gather4_c_lz_o v[64:67], [v32, v33, v34], s[4:11], s[4:7] dmask:0x1 a16
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_gather4h v[64:67], v32, s[4:11], s[4:7] dmask:0x8 a16
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_gather4_l v[64:67], [v32, v33], s[4:11], s[4:7] dmask:0x1 a16
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_gather4_lz v[64:67], v32, s[4:11], s[4:7] dmask:0x1 a16
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_gather4_lz_o v[64:67], [v32, v33], s[4:11], s[4:7] dmask:0x1 a16
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_get_lod v[64:67], [v32, v33, v34], s[4:11], s[100:103] dmask:0xf
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_get_resinfo v4, v32, s[96:103] dmask:0x1 th:TH_LOAD_RT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_load v0, v0, s[0:7] dmask:0x1 th:TH_STORE_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_load_mip v[252:255], [v0, v1], s[0:7] dmask:0xf th:TH_LOAD_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_load_pck v5, v1, s[8:15] dmask:0x1 th:TH_LOAD_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_load_pck_sgn v5, v1, s[8:15] dmask:0x1 th:TH_LOAD_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_load_mip_pck v5, [v0, v1], s[8:15] dmask:0x1 th:TH_LOAD_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_load_mip_pck_sgn v5, [v0, v1], s[8:15] dmask:0x1 th:TH_LOAD_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample v[34:36], v37, s[36:43], s[64:67] dmask:0x3 tfe
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_b v64, [v32, v33], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_b_cl v64, [v32, v33, v34], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_b_cl_o v64, [v32, v33, v34, v35], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_b_o v64, [v32, v33, v34], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c v64, [v32, v33], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_b v64, [v32, v33, v34], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_b_cl v64, [v32, v33, v34, v35], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_b_cl_o v64, [v32, v33, v34, v[35:36]], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_b_o v64, [v32, v33, v34, v35], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_cl v64, [v32, v33, v34], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_cl_o v64, [v32, v33, v34, v35], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_d v64, [v32, v33, v34, v35], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_d_cl v64, [v32, v33, v34, v[35:36]], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_d_cl_g16 v64, [v32, v33, v34, v[35:36]], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_d_cl_o v64, [v32, v33, v34, v[35:37]], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_d_cl_o_g16 v64, [v32, v33, v34, v[35:37]], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_d_g16 v64, [v32, v33, v34, v35], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_d_o v64, [v32, v33, v34, v[35:36]], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_d_o_g16 v64, [v32, v33, v34, v[35:36]], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_l v64, [v32, v33, v34], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_cl v64, [v32, v33], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_l_o v64, [v32, v33, v34, v35], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_cl_o v64, [v32, v33, v34], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_lz v64, [v32, v33], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_lz_o v64, [v32, v33, v34], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_c_o v64, [v32, v33, v34], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_d v64, [v32, v33, v34], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_d_cl v64, [v32, v33, v34, v35], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_d_cl_g16 v64, [v32, v33, v34, v35], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_d_cl_o v64, [v32, v33, v34, v[35:36]], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_d_cl_o_g16 v64, [v32, v33, v34, v[35:36]], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_d_g16 v64, [v32, v33, v34], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_d_o v64, [v32, v33, v34, v35], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_d_o_g16 v64, [v32, v33, v34, v35], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_l v64, [v32, v33], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_l_o v64, [v32, v33, v34], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_lz v64, v32, s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_lz_o v64, [v32, v33], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_sample_o v64, [v32, v33], s[4:11], s[4:7] dmask:0x1
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_store v[0:3], v0, s[0:7] dmask:0xf a16
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_store_mip v[252:255], [v0, v1], s[0:7] dmask:0xf th:TH_STORE_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_store_pck v5, v1, s[8:15] dmask:0x1 th:TH_STORE_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

image_store_mip_pck v5, [v0, v1], s[8:15] dmask:0x1 th:TH_STORE_NT
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: missing dim operand

// null is not allowed as SRSRC or SSAMP
image_atomic_add v1, v[10:11], null dmask:0x1 dim:SQ_RSRC_IMG_2D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_atomic_and v1, v[10:11], null dmask:0x1 dim:SQ_RSRC_IMG_2D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_atomic_cmpswap v[0:1], v[10:11], null dmask:0x3 dim:SQ_RSRC_IMG_2D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_atomic_dec v1, v[10:11], null dmask:0x1 dim:SQ_RSRC_IMG_2D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_atomic_inc v1, v[10:11], null dmask:0x1 dim:SQ_RSRC_IMG_2D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_atomic_or v1, v[10:11], null dmask:0x1 dim:SQ_RSRC_IMG_2D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_atomic_smax v1, v[10:11], null dmask:0x1 dim:SQ_RSRC_IMG_2D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_atomic_smin v1, v[10:11], null dmask:0x1 dim:SQ_RSRC_IMG_2D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_atomic_sub v1, v[10:11], null dmask:0x1 dim:SQ_RSRC_IMG_2D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_atomic_swap v1, v[10:11], null dmask:0x1 dim:SQ_RSRC_IMG_2D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_atomic_umax v1, v[10:11], null dmask:0x1 dim:SQ_RSRC_IMG_2D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_atomic_umin v1, v[10:11], null dmask:0x1 dim:SQ_RSRC_IMG_2D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_atomic_xor v1, v[10:11], null dmask:0x1 dim:SQ_RSRC_IMG_2D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_gather4 v[64:67], v32, null, s[4:11], dmask:0x1 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_gather4 v[64:67], v32, s[4:11], null dmask:0x1 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_gather4_b v[64:67], [v32, v33], null, s[100:103] dmask:0x1 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_gather4_b v[64:67], [v32, v33], s[4:11], null dmask:0x1 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_gather4_c v[64:67], [v32, v33], null, s[100:103] dmask:0x1 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_gather4_c v[64:67], [v32, v33], s[4:11], null dmask:0x1 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_gather4h v[64:67], v32, null, s[100:103] dmask:0x1 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_gather4h v[64:67], v32, s[4:11], null dmask:0x1 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_gather4_l v[64:67], v[32:33], null, s[100:103] dmask:0x1 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_gather4_l v[64:67], v[32:33], s[4:11], null dmask:0x1 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_gather4_o v[64:67], [v32, v33], null, s[100:103] dmask:0x1 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_gather4_o v[64:67], [v32, v33], s[4:11], null dmask:0x1 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_load v[4:7], v0, null dmask:0xf dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_store v[0:3], v[254:255], null dmask:0xf dim:SQ_RSRC_IMG_2D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_sample v[5:6], v1, null, s[12:15] dmask:0x3 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_sample v[5:6], v1, s[8:15], null dmask:0x3 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_sample_b v[5:6], [v1, v2], null, s[12:15] dmask:0x3 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_sample_b v[5:6], [v1, v2], s[8:15], null dmask:0x3 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_sample_c v[5:6], [v1, v2], null, s[12:15] dmask:0x3 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_sample_c v[5:6], [v1, v2], s[8:15], null dmask:0x3 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_sample_d v[5:6], [v1, v2, v3], null, s[12:15] dmask:0x3 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_sample_d v[5:6], [v1, v2, v3], s[8:15], null dmask:0x3 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_sample_l v[5:6], v[1:2], null, s[12:15] dmask:0x3 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_sample_l v[5:6], v[1:2], s[8:15], null dmask:0x3 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_sample_o v[5:6], [v1, v2], null, s[12:15] dmask:0x3 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_sample_o v[5:6], [v1, v2], s[8:15], null dmask:0x3 dim:SQ_RSRC_IMG_1D
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_bvh_intersect_ray v[4:7], [v9, v10, v[11:13], v[14:16], v[17:19]], null
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

image_bvh64_intersect_ray v[4:7], [v[9:10], v11, v[12:14], v[15:17], v[18:20]], null
// NOGFX12: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction
