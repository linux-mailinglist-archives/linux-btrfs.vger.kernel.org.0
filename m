Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8862BA35C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2019 13:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfH3Lcs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Aug 2019 07:32:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:48886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727948AbfH3Lcm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Aug 2019 07:32:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31FFDB087;
        Fri, 30 Aug 2019 11:32:39 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 09/12] btrfs-progs: add xxhash sources
Date:   Fri, 30 Aug 2019 13:32:31 +0200
Message-Id: <20190830113234.16615-10-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190830113234.16615-1-jthumshirn@suse.de>
References: <20190830113234.16615-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.com>

git://github.com/Cyan4973/xxHash

Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 crypto/xxhash.c | 1025 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 crypto/xxhash.h |  445 ++++++++++++++++++++++++
 2 files changed, 1470 insertions(+)
 create mode 100644 crypto/xxhash.c
 create mode 100644 crypto/xxhash.h

diff --git a/crypto/xxhash.c b/crypto/xxhash.c
new file mode 100644
index 000000000000..58bb749d3078
--- /dev/null
+++ b/crypto/xxhash.c
@@ -0,0 +1,1025 @@
+/*
+*  xxHash - Fast Hash algorithm
+*  Copyright (C) 2012-2016, Yann Collet
+*
+*  BSD 2-Clause License (http://www.opensource.org/licenses/bsd-license.php)
+*
+*  Redistribution and use in source and binary forms, with or without
+*  modification, are permitted provided that the following conditions are
+*  met:
+*
+*  * Redistributions of source code must retain the above copyright
+*  notice, this list of conditions and the following disclaimer.
+*  * Redistributions in binary form must reproduce the above
+*  copyright notice, this list of conditions and the following disclaimer
+*  in the documentation and/or other materials provided with the
+*  distribution.
+*
+*  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+*  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+*  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+*  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+*  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+*  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+*  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+*  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+*  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+*  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+*
+*  You can contact the author at :
+*  - xxHash homepage: http://www.xxhash.com
+*  - xxHash source repository : https://github.com/Cyan4973/xxHash
+*/
+
+
+/* *************************************
+*  Tuning parameters
+***************************************/
+/*!XXH_FORCE_MEMORY_ACCESS :
+ * By default, access to unaligned memory is controlled by `memcpy()`, which is safe and portable.
+ * Unfortunately, on some target/compiler combinations, the generated assembly is sub-optimal.
+ * The below switch allow to select different access method for improved performance.
+ * Method 0 (default) : use `memcpy()`. Safe and portable.
+ * Method 1 : `__packed` statement. It depends on compiler extension (ie, not portable).
+ *            This method is safe if your compiler supports it, and *generally* as fast or faster than `memcpy`.
+ * Method 2 : direct access. This method doesn't depend on compiler but violate C standard.
+ *            It can generate buggy code on targets which do not support unaligned memory accesses.
+ *            But in some circumstances, it's the only known way to get the most performance (ie GCC + ARMv6)
+ * See http://stackoverflow.com/a/32095106/646947 for details.
+ * Prefer these methods in priority order (0 > 1 > 2)
+ */
+#ifndef XXH_FORCE_MEMORY_ACCESS   /* can be defined externally, on command line for example */
+#  if defined(__GNUC__) && ( defined(__ARM_ARCH_6__) || defined(__ARM_ARCH_6J__) \
+                        || defined(__ARM_ARCH_6K__) || defined(__ARM_ARCH_6Z__) \
+                        || defined(__ARM_ARCH_6ZK__) || defined(__ARM_ARCH_6T2__) )
+#    define XXH_FORCE_MEMORY_ACCESS 2
+#  elif (defined(__INTEL_COMPILER) && !defined(_WIN32)) || \
+  (defined(__GNUC__) && ( defined(__ARM_ARCH_7__) || defined(__ARM_ARCH_7A__) \
+                    || defined(__ARM_ARCH_7R__) || defined(__ARM_ARCH_7M__) \
+                    || defined(__ARM_ARCH_7S__) ))
+#    define XXH_FORCE_MEMORY_ACCESS 1
+#  endif
+#endif
+
+/*!XXH_ACCEPT_NULL_INPUT_POINTER :
+ * If input pointer is NULL, xxHash default behavior is to dereference it, triggering a segfault.
+ * When this macro is enabled, xxHash actively checks input for null pointer.
+ * It it is, result for null input pointers is the same as a null-length input.
+ */
+#ifndef XXH_ACCEPT_NULL_INPUT_POINTER   /* can be defined externally */
+#  define XXH_ACCEPT_NULL_INPUT_POINTER 0
+#endif
+
+/*!XXH_FORCE_ALIGN_CHECK :
+ * This is a minor performance trick, only useful with lots of very small keys.
+ * It means : check for aligned/unaligned input.
+ * The check costs one initial branch per hash;
+ * set it to 0 when the input is guaranteed to be aligned,
+ * or when alignment doesn't matter for performance.
+ */
+#ifndef XXH_FORCE_ALIGN_CHECK /* can be defined externally */
+#  if defined(__i386) || defined(_M_IX86) || defined(__x86_64__) || defined(_M_X64)
+#    define XXH_FORCE_ALIGN_CHECK 0
+#  else
+#    define XXH_FORCE_ALIGN_CHECK 1
+#  endif
+#endif
+
+
+/* *************************************
+*  Includes & Memory related functions
+***************************************/
+/*! Modify the local functions below should you wish to use some other memory routines
+*   for malloc(), free() */
+#include <stdlib.h>
+static void* XXH_malloc(size_t s) { return malloc(s); }
+static void  XXH_free  (void* p)  { free(p); }
+/*! and for memcpy() */
+#include <string.h>
+static void* XXH_memcpy(void* dest, const void* src, size_t size) { return memcpy(dest,src,size); }
+
+#include <assert.h>   /* assert */
+
+#define XXH_STATIC_LINKING_ONLY
+#include "xxhash.h"
+
+
+/* *************************************
+*  Compiler Specific Options
+***************************************/
+#ifdef _MSC_VER    /* Visual Studio */
+#  pragma warning(disable : 4127)      /* disable: C4127: conditional expression is constant */
+#  define XXH_FORCE_INLINE static __forceinline
+#  define XXH_NO_INLINE static __declspec(noinline)
+#else
+#  if defined (__cplusplus) || defined (__STDC_VERSION__) && __STDC_VERSION__ >= 199901L   /* C99 */
+#    ifdef __GNUC__
+#      define XXH_FORCE_INLINE static inline __attribute__((always_inline))
+#      define XXH_NO_INLINE static __attribute__((noinline))
+#    else
+#      define XXH_FORCE_INLINE static inline
+#      define XXH_NO_INLINE static
+#    endif
+#  else
+#    define XXH_FORCE_INLINE static
+#    define XXH_NO_INLINE static
+#  endif /* __STDC_VERSION__ */
+#endif
+
+
+/* *************************************
+*  Basic Types
+***************************************/
+#ifndef MEM_MODULE
+# if !defined (__VMS) \
+  && (defined (__cplusplus) \
+  || (defined (__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) /* C99 */) )
+#   include <stdint.h>
+    typedef uint8_t  BYTE;
+    typedef uint16_t U16;
+    typedef uint32_t U32;
+# else
+    typedef unsigned char      BYTE;
+    typedef unsigned short     U16;
+    typedef unsigned int       U32;
+# endif
+#endif
+
+
+/* ===   Memory access   === */
+
+#if (defined(XXH_FORCE_MEMORY_ACCESS) && (XXH_FORCE_MEMORY_ACCESS==2))
+
+/* Force direct memory access. Only works on CPU which support unaligned memory access in hardware */
+static U32 XXH_read32(const void* memPtr) { return *(const U32*) memPtr; }
+
+#elif (defined(XXH_FORCE_MEMORY_ACCESS) && (XXH_FORCE_MEMORY_ACCESS==1))
+
+/* __pack instructions are safer, but compiler specific, hence potentially problematic for some compilers */
+/* currently only defined for gcc and icc */
+typedef union { U32 u32; } __attribute__((packed)) unalign;
+static U32 XXH_read32(const void* ptr) { return ((const unalign*)ptr)->u32; }
+
+#else
+
+/* portable and safe solution. Generally efficient.
+ * see : http://stackoverflow.com/a/32095106/646947
+ */
+static U32 XXH_read32(const void* memPtr)
+{
+    U32 val;
+    memcpy(&val, memPtr, sizeof(val));
+    return val;
+}
+
+#endif   /* XXH_FORCE_DIRECT_MEMORY_ACCESS */
+
+
+/* ===   Endianess   === */
+typedef enum { XXH_bigEndian=0, XXH_littleEndian=1 } XXH_endianess;
+
+/* XXH_CPU_LITTLE_ENDIAN can be defined externally, for example on the compiler command line */
+#ifndef XXH_CPU_LITTLE_ENDIAN
+static int XXH_isLittleEndian(void)
+{
+    const union { U32 u; BYTE c[4]; } one = { 1 };   /* don't use static : performance detrimental  */
+    return one.c[0];
+}
+#   define XXH_CPU_LITTLE_ENDIAN   XXH_isLittleEndian()
+#endif
+
+
+
+
+/* ****************************************
+*  Compiler-specific Functions and Macros
+******************************************/
+#define XXH_GCC_VERSION (__GNUC__ * 100 + __GNUC_MINOR__)
+
+/* Note : although _rotl exists for minGW (GCC under windows), performance seems poor */
+#if defined(_MSC_VER)
+#  define XXH_rotl32(x,r) _rotl(x,r)
+#  define XXH_rotl64(x,r) _rotl64(x,r)
+#else
+#  define XXH_rotl32(x,r) (((x) << (r)) | ((x) >> (32 - (r))))
+#  define XXH_rotl64(x,r) (((x) << (r)) | ((x) >> (64 - (r))))
+#endif
+
+#if defined(_MSC_VER)     /* Visual Studio */
+#  define XXH_swap32 _byteswap_ulong
+#elif XXH_GCC_VERSION >= 403
+#  define XXH_swap32 __builtin_bswap32
+#else
+static U32 XXH_swap32 (U32 x)
+{
+    return  ((x << 24) & 0xff000000 ) |
+            ((x <<  8) & 0x00ff0000 ) |
+            ((x >>  8) & 0x0000ff00 ) |
+            ((x >> 24) & 0x000000ff );
+}
+#endif
+
+
+/* ***************************
+*  Memory reads
+*****************************/
+typedef enum { XXH_aligned, XXH_unaligned } XXH_alignment;
+
+XXH_FORCE_INLINE U32 XXH_readLE32(const void* ptr)
+{
+    return XXH_CPU_LITTLE_ENDIAN ? XXH_read32(ptr) : XXH_swap32(XXH_read32(ptr));
+}
+
+static U32 XXH_readBE32(const void* ptr)
+{
+    return XXH_CPU_LITTLE_ENDIAN ? XXH_swap32(XXH_read32(ptr)) : XXH_read32(ptr);
+}
+
+XXH_FORCE_INLINE U32
+XXH_readLE32_align(const void* ptr, XXH_alignment align)
+{
+    if (align==XXH_unaligned) {
+        return XXH_readLE32(ptr);
+    } else {
+        return XXH_CPU_LITTLE_ENDIAN ? *(const U32*)ptr : XXH_swap32(*(const U32*)ptr);
+    }
+}
+
+
+/* *************************************
+*  Macros
+***************************************/
+#define XXH_STATIC_ASSERT(c)  { enum { XXH_sa = 1/(int)(!!(c)) }; }  /* use after variable declarations */
+XXH_PUBLIC_API unsigned XXH_versionNumber (void) { return XXH_VERSION_NUMBER; }
+
+
+/* *******************************************************************
+*  32-bit hash functions
+*********************************************************************/
+static const U32 PRIME32_1 = 2654435761U;   /* 0b10011110001101110111100110110001 */
+static const U32 PRIME32_2 = 2246822519U;   /* 0b10000101111010111100101001110111 */
+static const U32 PRIME32_3 = 3266489917U;   /* 0b11000010101100101010111000111101 */
+static const U32 PRIME32_4 =  668265263U;   /* 0b00100111110101001110101100101111 */
+static const U32 PRIME32_5 =  374761393U;   /* 0b00010110010101100110011110110001 */
+
+static U32 XXH32_round(U32 acc, U32 input)
+{
+    acc += input * PRIME32_2;
+    acc  = XXH_rotl32(acc, 13);
+    acc *= PRIME32_1;
+#if defined(__GNUC__) && defined(__SSE4_1__) && !defined(XXH_ENABLE_AUTOVECTORIZE)
+    /* UGLY HACK:
+     * This inline assembly hack forces acc into a normal register. This is the
+     * only thing that prevents GCC and Clang from autovectorizing the XXH32 loop
+     * (pragmas and attributes don't work for some resason) without globally
+     * disabling SSE4.1.
+     *
+     * The reason we want to avoid vectorization is because despite working on
+     * 4 integers at a time, there are multiple factors slowing XXH32 down on
+     * SSE4:
+     * - There's a ridiculous amount of lag from pmulld (10 cycles of latency on newer chips!)
+     *   making it slightly slower to multiply four integers at once compared to four
+     *   integers independently. Even when pmulld was fastest, Sandy/Ivy Bridge, it is
+     *   still not worth it to go into SSE just to multiply unless doing a long operation.
+     *
+     * - Four instructions are required to rotate,
+     *      movqda tmp,  v // not required with VEX encoding
+     *      pslld  tmp, 13 // tmp <<= 13
+     *      psrld  v,   19 // x >>= 19
+     *      por    v,  tmp // x |= tmp
+     *   compared to one for scalar:
+     *      roll   v, 13    // reliably fast across the board
+     *      shldl  v, v, 13 // Sandy Bridge and later prefer this for some reason
+     *
+     * - Instruction level parallelism is actually more beneficial here because the
+     *   SIMD actually serializes this operation: While v1 is rotating, v2 can load data,
+     *   while v3 can multiply. SSE forces them to operate together.
+     *
+     * How this hack works:
+     * __asm__(""       // Declare an assembly block but don't declare any instructions
+     *          :       // However, as an Input/Output Operand,
+     *          "+r"    // constrain a read/write operand (+) as a general purpose register (r).
+     *          (acc)   // and set acc as the operand
+     * );
+     *
+     * Because of the 'r', the compiler has promised that seed will be in a
+     * general purpose register and the '+' says that it will be 'read/write',
+     * so it has to assume it has changed. It is like volatile without all the
+     * loads and stores.
+     *
+     * Since the argument has to be in a normal register (not an SSE register),
+     * each time XXH32_round is called, it is impossible to vectorize. */
+    __asm__("" : "+r" (acc));
+#endif
+    return acc;
+}
+
+/* mix all bits */
+static U32 XXH32_avalanche(U32 h32)
+{
+    h32 ^= h32 >> 15;
+    h32 *= PRIME32_2;
+    h32 ^= h32 >> 13;
+    h32 *= PRIME32_3;
+    h32 ^= h32 >> 16;
+    return(h32);
+}
+
+#define XXH_get32bits(p) XXH_readLE32_align(p, align)
+
+static U32
+XXH32_finalize(U32 h32, const void* ptr, size_t len, XXH_alignment align)
+
+{
+    const BYTE* p = (const BYTE*)ptr;
+
+#define PROCESS1               \
+    h32 += (*p++) * PRIME32_5; \
+    h32 = XXH_rotl32(h32, 11) * PRIME32_1 ;
+
+#define PROCESS4                         \
+    h32 += XXH_get32bits(p) * PRIME32_3; \
+    p+=4;                                \
+    h32  = XXH_rotl32(h32, 17) * PRIME32_4 ;
+
+    switch(len&15)  /* or switch(bEnd - p) */
+    {
+      case 12:      PROCESS4;
+                    /* fallthrough */
+      case 8:       PROCESS4;
+                    /* fallthrough */
+      case 4:       PROCESS4;
+                    return XXH32_avalanche(h32);
+
+      case 13:      PROCESS4;
+                    /* fallthrough */
+      case 9:       PROCESS4;
+                    /* fallthrough */
+      case 5:       PROCESS4;
+                    PROCESS1;
+                    return XXH32_avalanche(h32);
+
+      case 14:      PROCESS4;
+                    /* fallthrough */
+      case 10:      PROCESS4;
+                    /* fallthrough */
+      case 6:       PROCESS4;
+                    PROCESS1;
+                    PROCESS1;
+                    return XXH32_avalanche(h32);
+
+      case 15:      PROCESS4;
+                    /* fallthrough */
+      case 11:      PROCESS4;
+                    /* fallthrough */
+      case 7:       PROCESS4;
+                    /* fallthrough */
+      case 3:       PROCESS1;
+                    /* fallthrough */
+      case 2:       PROCESS1;
+                    /* fallthrough */
+      case 1:       PROCESS1;
+                    /* fallthrough */
+      case 0:       return XXH32_avalanche(h32);
+    }
+    assert(0);
+    return h32;   /* reaching this point is deemed impossible */
+}
+
+XXH_FORCE_INLINE U32
+XXH32_endian_align(const void* input, size_t len, U32 seed, XXH_alignment align)
+{
+    const BYTE* p = (const BYTE*)input;
+    const BYTE* bEnd = p + len;
+    U32 h32;
+
+#if defined(XXH_ACCEPT_NULL_INPUT_POINTER) && (XXH_ACCEPT_NULL_INPUT_POINTER>=1)
+    if (p==NULL) {
+        len=0;
+        bEnd=p=(const BYTE*)(size_t)16;
+    }
+#endif
+
+    if (len>=16) {
+        const BYTE* const limit = bEnd - 15;
+        U32 v1 = seed + PRIME32_1 + PRIME32_2;
+        U32 v2 = seed + PRIME32_2;
+        U32 v3 = seed + 0;
+        U32 v4 = seed - PRIME32_1;
+
+        do {
+            v1 = XXH32_round(v1, XXH_get32bits(p)); p+=4;
+            v2 = XXH32_round(v2, XXH_get32bits(p)); p+=4;
+            v3 = XXH32_round(v3, XXH_get32bits(p)); p+=4;
+            v4 = XXH32_round(v4, XXH_get32bits(p)); p+=4;
+        } while (p < limit);
+
+        h32 = XXH_rotl32(v1, 1)  + XXH_rotl32(v2, 7)
+            + XXH_rotl32(v3, 12) + XXH_rotl32(v4, 18);
+    } else {
+        h32  = seed + PRIME32_5;
+    }
+
+    h32 += (U32)len;
+
+    return XXH32_finalize(h32, p, len&15, align);
+}
+
+
+XXH_PUBLIC_API unsigned int XXH32 (const void* input, size_t len, unsigned int seed)
+{
+#if 0
+    /* Simple version, good for code maintenance, but unfortunately slow for small inputs */
+    XXH32_state_t state;
+    XXH32_reset(&state, seed);
+    XXH32_update(&state, input, len);
+    return XXH32_digest(&state);
+
+#else
+
+    if (XXH_FORCE_ALIGN_CHECK) {
+        if ((((size_t)input) & 3) == 0) {   /* Input is 4-bytes aligned, leverage the speed benefit */
+            return XXH32_endian_align(input, len, seed, XXH_aligned);
+    }   }
+
+    return XXH32_endian_align(input, len, seed, XXH_unaligned);
+#endif
+}
+
+
+
+/*======   Hash streaming   ======*/
+
+XXH_PUBLIC_API XXH32_state_t* XXH32_createState(void)
+{
+    return (XXH32_state_t*)XXH_malloc(sizeof(XXH32_state_t));
+}
+XXH_PUBLIC_API XXH_errorcode XXH32_freeState(XXH32_state_t* statePtr)
+{
+    XXH_free(statePtr);
+    return XXH_OK;
+}
+
+XXH_PUBLIC_API void XXH32_copyState(XXH32_state_t* dstState, const XXH32_state_t* srcState)
+{
+    memcpy(dstState, srcState, sizeof(*dstState));
+}
+
+XXH_PUBLIC_API XXH_errorcode XXH32_reset(XXH32_state_t* statePtr, unsigned int seed)
+{
+    XXH32_state_t state;   /* using a local state to memcpy() in order to avoid strict-aliasing warnings */
+    memset(&state, 0, sizeof(state));
+    state.v1 = seed + PRIME32_1 + PRIME32_2;
+    state.v2 = seed + PRIME32_2;
+    state.v3 = seed + 0;
+    state.v4 = seed - PRIME32_1;
+    /* do not write into reserved, planned to be removed in a future version */
+    memcpy(statePtr, &state, sizeof(state) - sizeof(state.reserved));
+    return XXH_OK;
+}
+
+
+XXH_PUBLIC_API XXH_errorcode
+XXH32_update(XXH32_state_t* state, const void* input, size_t len)
+{
+    if (input==NULL)
+#if defined(XXH_ACCEPT_NULL_INPUT_POINTER) && (XXH_ACCEPT_NULL_INPUT_POINTER>=1)
+        return XXH_OK;
+#else
+        return XXH_ERROR;
+#endif
+
+    {   const BYTE* p = (const BYTE*)input;
+        const BYTE* const bEnd = p + len;
+
+        state->total_len_32 += (XXH32_hash_t)len;
+        state->large_len |= (XXH32_hash_t)((len>=16) | (state->total_len_32>=16));
+
+        if (state->memsize + len < 16)  {   /* fill in tmp buffer */
+            XXH_memcpy((BYTE*)(state->mem32) + state->memsize, input, len);
+            state->memsize += (XXH32_hash_t)len;
+            return XXH_OK;
+        }
+
+        if (state->memsize) {   /* some data left from previous update */
+            XXH_memcpy((BYTE*)(state->mem32) + state->memsize, input, 16-state->memsize);
+            {   const U32* p32 = state->mem32;
+                state->v1 = XXH32_round(state->v1, XXH_readLE32(p32)); p32++;
+                state->v2 = XXH32_round(state->v2, XXH_readLE32(p32)); p32++;
+                state->v3 = XXH32_round(state->v3, XXH_readLE32(p32)); p32++;
+                state->v4 = XXH32_round(state->v4, XXH_readLE32(p32));
+            }
+            p += 16-state->memsize;
+            state->memsize = 0;
+        }
+
+        if (p <= bEnd-16) {
+            const BYTE* const limit = bEnd - 16;
+            U32 v1 = state->v1;
+            U32 v2 = state->v2;
+            U32 v3 = state->v3;
+            U32 v4 = state->v4;
+
+            do {
+                v1 = XXH32_round(v1, XXH_readLE32(p)); p+=4;
+                v2 = XXH32_round(v2, XXH_readLE32(p)); p+=4;
+                v3 = XXH32_round(v3, XXH_readLE32(p)); p+=4;
+                v4 = XXH32_round(v4, XXH_readLE32(p)); p+=4;
+            } while (p<=limit);
+
+            state->v1 = v1;
+            state->v2 = v2;
+            state->v3 = v3;
+            state->v4 = v4;
+        }
+
+        if (p < bEnd) {
+            XXH_memcpy(state->mem32, p, (size_t)(bEnd-p));
+            state->memsize = (unsigned)(bEnd-p);
+        }
+    }
+
+    return XXH_OK;
+}
+
+
+XXH_PUBLIC_API unsigned int XXH32_digest (const XXH32_state_t* state)
+{
+    U32 h32;
+
+    if (state->large_len) {
+        h32 = XXH_rotl32(state->v1, 1)
+            + XXH_rotl32(state->v2, 7)
+            + XXH_rotl32(state->v3, 12)
+            + XXH_rotl32(state->v4, 18);
+    } else {
+        h32 = state->v3 /* == seed */ + PRIME32_5;
+    }
+
+    h32 += state->total_len_32;
+
+    return XXH32_finalize(h32, state->mem32, state->memsize, XXH_aligned);
+}
+
+
+/*======   Canonical representation   ======*/
+
+/*! Default XXH result types are basic unsigned 32 and 64 bits.
+*   The canonical representation follows human-readable write convention, aka big-endian (large digits first).
+*   These functions allow transformation of hash result into and from its canonical format.
+*   This way, hash values can be written into a file or buffer, remaining comparable across different systems.
+*/
+
+XXH_PUBLIC_API void XXH32_canonicalFromHash(XXH32_canonical_t* dst, XXH32_hash_t hash)
+{
+    XXH_STATIC_ASSERT(sizeof(XXH32_canonical_t) == sizeof(XXH32_hash_t));
+    if (XXH_CPU_LITTLE_ENDIAN) hash = XXH_swap32(hash);
+    memcpy(dst, &hash, sizeof(*dst));
+}
+
+XXH_PUBLIC_API XXH32_hash_t XXH32_hashFromCanonical(const XXH32_canonical_t* src)
+{
+    return XXH_readBE32(src);
+}
+
+
+#ifndef XXH_NO_LONG_LONG
+
+/* *******************************************************************
+*  64-bit hash functions
+*********************************************************************/
+
+/*======   Memory access   ======*/
+
+#ifndef MEM_MODULE
+# define MEM_MODULE
+# if !defined (__VMS) \
+  && (defined (__cplusplus) \
+  || (defined (__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) /* C99 */) )
+#   include <stdint.h>
+    typedef uint64_t U64;
+# else
+    /* if compiler doesn't support unsigned long long, replace by another 64-bit type */
+    typedef unsigned long long U64;
+# endif
+#endif
+
+
+#if (defined(XXH_FORCE_MEMORY_ACCESS) && (XXH_FORCE_MEMORY_ACCESS==2))
+
+/* Force direct memory access. Only works on CPU which support unaligned memory access in hardware */
+static U64 XXH_read64(const void* memPtr) { return *(const U64*) memPtr; }
+
+#elif (defined(XXH_FORCE_MEMORY_ACCESS) && (XXH_FORCE_MEMORY_ACCESS==1))
+
+/* __pack instructions are safer, but compiler specific, hence potentially problematic for some compilers */
+/* currently only defined for gcc and icc */
+typedef union { U32 u32; U64 u64; } __attribute__((packed)) unalign64;
+static U64 XXH_read64(const void* ptr) { return ((const unalign64*)ptr)->u64; }
+
+#else
+
+/* portable and safe solution. Generally efficient.
+ * see : http://stackoverflow.com/a/32095106/646947
+ */
+
+static U64 XXH_read64(const void* memPtr)
+{
+    U64 val;
+    memcpy(&val, memPtr, sizeof(val));
+    return val;
+}
+
+#endif   /* XXH_FORCE_DIRECT_MEMORY_ACCESS */
+
+#if defined(_MSC_VER)     /* Visual Studio */
+#  define XXH_swap64 _byteswap_uint64
+#elif XXH_GCC_VERSION >= 403
+#  define XXH_swap64 __builtin_bswap64
+#else
+static U64 XXH_swap64 (U64 x)
+{
+    return  ((x << 56) & 0xff00000000000000ULL) |
+            ((x << 40) & 0x00ff000000000000ULL) |
+            ((x << 24) & 0x0000ff0000000000ULL) |
+            ((x << 8)  & 0x000000ff00000000ULL) |
+            ((x >> 8)  & 0x00000000ff000000ULL) |
+            ((x >> 24) & 0x0000000000ff0000ULL) |
+            ((x >> 40) & 0x000000000000ff00ULL) |
+            ((x >> 56) & 0x00000000000000ffULL);
+}
+#endif
+
+XXH_FORCE_INLINE U64 XXH_readLE64(const void* ptr)
+{
+    return XXH_CPU_LITTLE_ENDIAN ? XXH_read64(ptr) : XXH_swap64(XXH_read64(ptr));
+}
+
+static U64 XXH_readBE64(const void* ptr)
+{
+    return XXH_CPU_LITTLE_ENDIAN ? XXH_swap64(XXH_read64(ptr)) : XXH_read64(ptr);
+}
+
+XXH_FORCE_INLINE U64
+XXH_readLE64_align(const void* ptr, XXH_alignment align)
+{
+    if (align==XXH_unaligned)
+        return XXH_readLE64(ptr);
+    else
+        return XXH_CPU_LITTLE_ENDIAN ? *(const U64*)ptr : XXH_swap64(*(const U64*)ptr);
+}
+
+
+/*======   xxh64   ======*/
+
+static const U64 PRIME64_1 = 11400714785074694791ULL;   /* 0b1001111000110111011110011011000110000101111010111100101010000111 */
+static const U64 PRIME64_2 = 14029467366897019727ULL;   /* 0b1100001010110010101011100011110100100111110101001110101101001111 */
+static const U64 PRIME64_3 =  1609587929392839161ULL;   /* 0b0001011001010110011001111011000110011110001101110111100111111001 */
+static const U64 PRIME64_4 =  9650029242287828579ULL;   /* 0b1000010111101011110010100111011111000010101100101010111001100011 */
+static const U64 PRIME64_5 =  2870177450012600261ULL;   /* 0b0010011111010100111010110010111100010110010101100110011111000101 */
+
+static U64 XXH64_round(U64 acc, U64 input)
+{
+    acc += input * PRIME64_2;
+    acc  = XXH_rotl64(acc, 31);
+    acc *= PRIME64_1;
+    return acc;
+}
+
+static U64 XXH64_mergeRound(U64 acc, U64 val)
+{
+    val  = XXH64_round(0, val);
+    acc ^= val;
+    acc  = acc * PRIME64_1 + PRIME64_4;
+    return acc;
+}
+
+static U64 XXH64_avalanche(U64 h64)
+{
+    h64 ^= h64 >> 33;
+    h64 *= PRIME64_2;
+    h64 ^= h64 >> 29;
+    h64 *= PRIME64_3;
+    h64 ^= h64 >> 32;
+    return h64;
+}
+
+
+#define XXH_get64bits(p) XXH_readLE64_align(p, align)
+
+static U64
+XXH64_finalize(U64 h64, const void* ptr, size_t len, XXH_alignment align)
+{
+    const BYTE* p = (const BYTE*)ptr;
+
+#define PROCESS1_64            \
+    h64 ^= (*p++) * PRIME64_5; \
+    h64 = XXH_rotl64(h64, 11) * PRIME64_1;
+
+#define PROCESS4_64          \
+    h64 ^= (U64)(XXH_get32bits(p)) * PRIME64_1; \
+    p+=4;                    \
+    h64 = XXH_rotl64(h64, 23) * PRIME64_2 + PRIME64_3;
+
+#define PROCESS8_64 {        \
+    U64 const k1 = XXH64_round(0, XXH_get64bits(p)); \
+    p+=8;                    \
+    h64 ^= k1;               \
+    h64  = XXH_rotl64(h64,27) * PRIME64_1 + PRIME64_4; \
+}
+
+    switch(len&31) {
+      case 24: PROCESS8_64;
+                    /* fallthrough */
+      case 16: PROCESS8_64;
+                    /* fallthrough */
+      case  8: PROCESS8_64;
+               return XXH64_avalanche(h64);
+
+      case 28: PROCESS8_64;
+                    /* fallthrough */
+      case 20: PROCESS8_64;
+                    /* fallthrough */
+      case 12: PROCESS8_64;
+                    /* fallthrough */
+      case  4: PROCESS4_64;
+               return XXH64_avalanche(h64);
+
+      case 25: PROCESS8_64;
+                    /* fallthrough */
+      case 17: PROCESS8_64;
+                    /* fallthrough */
+      case  9: PROCESS8_64;
+               PROCESS1_64;
+               return XXH64_avalanche(h64);
+
+      case 29: PROCESS8_64;
+                    /* fallthrough */
+      case 21: PROCESS8_64;
+                    /* fallthrough */
+      case 13: PROCESS8_64;
+                    /* fallthrough */
+      case  5: PROCESS4_64;
+               PROCESS1_64;
+               return XXH64_avalanche(h64);
+
+      case 26: PROCESS8_64;
+                    /* fallthrough */
+      case 18: PROCESS8_64;
+                    /* fallthrough */
+      case 10: PROCESS8_64;
+               PROCESS1_64;
+               PROCESS1_64;
+               return XXH64_avalanche(h64);
+
+      case 30: PROCESS8_64;
+                    /* fallthrough */
+      case 22: PROCESS8_64;
+                    /* fallthrough */
+      case 14: PROCESS8_64;
+                    /* fallthrough */
+      case  6: PROCESS4_64;
+               PROCESS1_64;
+               PROCESS1_64;
+               return XXH64_avalanche(h64);
+
+      case 27: PROCESS8_64;
+                    /* fallthrough */
+      case 19: PROCESS8_64;
+                    /* fallthrough */
+      case 11: PROCESS8_64;
+               PROCESS1_64;
+               PROCESS1_64;
+               PROCESS1_64;
+               return XXH64_avalanche(h64);
+
+      case 31: PROCESS8_64;
+                    /* fallthrough */
+      case 23: PROCESS8_64;
+                    /* fallthrough */
+      case 15: PROCESS8_64;
+                    /* fallthrough */
+      case  7: PROCESS4_64;
+                    /* fallthrough */
+      case  3: PROCESS1_64;
+                    /* fallthrough */
+      case  2: PROCESS1_64;
+                    /* fallthrough */
+      case  1: PROCESS1_64;
+                    /* fallthrough */
+      case  0: return XXH64_avalanche(h64);
+    }
+
+    /* impossible to reach */
+    assert(0);
+    return 0;  /* unreachable, but some compilers complain without it */
+}
+
+XXH_FORCE_INLINE U64
+XXH64_endian_align(const void* input, size_t len, U64 seed, XXH_alignment align)
+{
+    const BYTE* p = (const BYTE*)input;
+    const BYTE* bEnd = p + len;
+    U64 h64;
+
+#if defined(XXH_ACCEPT_NULL_INPUT_POINTER) && (XXH_ACCEPT_NULL_INPUT_POINTER>=1)
+    if (p==NULL) {
+        len=0;
+        bEnd=p=(const BYTE*)(size_t)32;
+    }
+#endif
+
+    if (len>=32) {
+        const BYTE* const limit = bEnd - 32;
+        U64 v1 = seed + PRIME64_1 + PRIME64_2;
+        U64 v2 = seed + PRIME64_2;
+        U64 v3 = seed + 0;
+        U64 v4 = seed - PRIME64_1;
+
+        do {
+            v1 = XXH64_round(v1, XXH_get64bits(p)); p+=8;
+            v2 = XXH64_round(v2, XXH_get64bits(p)); p+=8;
+            v3 = XXH64_round(v3, XXH_get64bits(p)); p+=8;
+            v4 = XXH64_round(v4, XXH_get64bits(p)); p+=8;
+        } while (p<=limit);
+
+        h64 = XXH_rotl64(v1, 1) + XXH_rotl64(v2, 7) + XXH_rotl64(v3, 12) + XXH_rotl64(v4, 18);
+        h64 = XXH64_mergeRound(h64, v1);
+        h64 = XXH64_mergeRound(h64, v2);
+        h64 = XXH64_mergeRound(h64, v3);
+        h64 = XXH64_mergeRound(h64, v4);
+
+    } else {
+        h64  = seed + PRIME64_5;
+    }
+
+    h64 += (U64) len;
+
+    return XXH64_finalize(h64, p, len, align);
+}
+
+
+XXH_PUBLIC_API unsigned long long XXH64 (const void* input, size_t len, unsigned long long seed)
+{
+#if 0
+    /* Simple version, good for code maintenance, but unfortunately slow for small inputs */
+    XXH64_state_t state;
+    XXH64_reset(&state, seed);
+    XXH64_update(&state, input, len);
+    return XXH64_digest(&state);
+
+#else
+
+    if (XXH_FORCE_ALIGN_CHECK) {
+        if ((((size_t)input) & 7)==0) {  /* Input is aligned, let's leverage the speed advantage */
+            return XXH64_endian_align(input, len, seed, XXH_aligned);
+    }   }
+
+    return XXH64_endian_align(input, len, seed, XXH_unaligned);
+
+#endif
+}
+
+/*======   Hash Streaming   ======*/
+
+XXH_PUBLIC_API XXH64_state_t* XXH64_createState(void)
+{
+    return (XXH64_state_t*)XXH_malloc(sizeof(XXH64_state_t));
+}
+XXH_PUBLIC_API XXH_errorcode XXH64_freeState(XXH64_state_t* statePtr)
+{
+    XXH_free(statePtr);
+    return XXH_OK;
+}
+
+XXH_PUBLIC_API void XXH64_copyState(XXH64_state_t* dstState, const XXH64_state_t* srcState)
+{
+    memcpy(dstState, srcState, sizeof(*dstState));
+}
+
+XXH_PUBLIC_API XXH_errorcode XXH64_reset(XXH64_state_t* statePtr, unsigned long long seed)
+{
+    XXH64_state_t state;   /* using a local state to memcpy() in order to avoid strict-aliasing warnings */
+    memset(&state, 0, sizeof(state));
+    state.v1 = seed + PRIME64_1 + PRIME64_2;
+    state.v2 = seed + PRIME64_2;
+    state.v3 = seed + 0;
+    state.v4 = seed - PRIME64_1;
+     /* do not write into reserved, planned to be removed in a future version */
+    memcpy(statePtr, &state, sizeof(state) - sizeof(state.reserved));
+    return XXH_OK;
+}
+
+XXH_PUBLIC_API XXH_errorcode
+XXH64_update (XXH64_state_t* state, const void* input, size_t len)
+{
+    if (input==NULL)
+#if defined(XXH_ACCEPT_NULL_INPUT_POINTER) && (XXH_ACCEPT_NULL_INPUT_POINTER>=1)
+        return XXH_OK;
+#else
+        return XXH_ERROR;
+#endif
+
+    {   const BYTE* p = (const BYTE*)input;
+        const BYTE* const bEnd = p + len;
+
+        state->total_len += len;
+
+        if (state->memsize + len < 32) {  /* fill in tmp buffer */
+            XXH_memcpy(((BYTE*)state->mem64) + state->memsize, input, len);
+            state->memsize += (U32)len;
+            return XXH_OK;
+        }
+
+        if (state->memsize) {   /* tmp buffer is full */
+            XXH_memcpy(((BYTE*)state->mem64) + state->memsize, input, 32-state->memsize);
+            state->v1 = XXH64_round(state->v1, XXH_readLE64(state->mem64+0));
+            state->v2 = XXH64_round(state->v2, XXH_readLE64(state->mem64+1));
+            state->v3 = XXH64_round(state->v3, XXH_readLE64(state->mem64+2));
+            state->v4 = XXH64_round(state->v4, XXH_readLE64(state->mem64+3));
+            p += 32-state->memsize;
+            state->memsize = 0;
+        }
+
+        if (p+32 <= bEnd) {
+            const BYTE* const limit = bEnd - 32;
+            U64 v1 = state->v1;
+            U64 v2 = state->v2;
+            U64 v3 = state->v3;
+            U64 v4 = state->v4;
+
+            do {
+                v1 = XXH64_round(v1, XXH_readLE64(p)); p+=8;
+                v2 = XXH64_round(v2, XXH_readLE64(p)); p+=8;
+                v3 = XXH64_round(v3, XXH_readLE64(p)); p+=8;
+                v4 = XXH64_round(v4, XXH_readLE64(p)); p+=8;
+            } while (p<=limit);
+
+            state->v1 = v1;
+            state->v2 = v2;
+            state->v3 = v3;
+            state->v4 = v4;
+        }
+
+        if (p < bEnd) {
+            XXH_memcpy(state->mem64, p, (size_t)(bEnd-p));
+            state->memsize = (unsigned)(bEnd-p);
+        }
+    }
+
+    return XXH_OK;
+}
+
+
+XXH_PUBLIC_API unsigned long long XXH64_digest (const XXH64_state_t* state)
+{
+    U64 h64;
+
+    if (state->total_len >= 32) {
+        U64 const v1 = state->v1;
+        U64 const v2 = state->v2;
+        U64 const v3 = state->v3;
+        U64 const v4 = state->v4;
+
+        h64 = XXH_rotl64(v1, 1) + XXH_rotl64(v2, 7) + XXH_rotl64(v3, 12) + XXH_rotl64(v4, 18);
+        h64 = XXH64_mergeRound(h64, v1);
+        h64 = XXH64_mergeRound(h64, v2);
+        h64 = XXH64_mergeRound(h64, v3);
+        h64 = XXH64_mergeRound(h64, v4);
+    } else {
+        h64  = state->v3 /*seed*/ + PRIME64_5;
+    }
+
+    h64 += (U64) state->total_len;
+
+    return XXH64_finalize(h64, state->mem64, (size_t)state->total_len, XXH_aligned);
+}
+
+
+/*====== Canonical representation   ======*/
+
+XXH_PUBLIC_API void XXH64_canonicalFromHash(XXH64_canonical_t* dst, XXH64_hash_t hash)
+{
+    XXH_STATIC_ASSERT(sizeof(XXH64_canonical_t) == sizeof(XXH64_hash_t));
+    if (XXH_CPU_LITTLE_ENDIAN) hash = XXH_swap64(hash);
+    memcpy(dst, &hash, sizeof(*dst));
+}
+
+XXH_PUBLIC_API XXH64_hash_t XXH64_hashFromCanonical(const XXH64_canonical_t* src)
+{
+    return XXH_readBE64(src);
+}
+
+
+
+/* *********************************************************************
+*  XXH3
+*  New generation hash designed for speed on small keys and vectorization
+************************************************************************ */
+
+/* #include "xxh3.h" */
+
+
+
+#endif  /* XXH_NO_LONG_LONG */
diff --git a/crypto/xxhash.h b/crypto/xxhash.h
new file mode 100644
index 000000000000..9ee05e5dc146
--- /dev/null
+++ b/crypto/xxhash.h
@@ -0,0 +1,445 @@
+/*
+   xxHash - Extremely Fast Hash algorithm
+   Header File
+   Copyright (C) 2012-2016, Yann Collet.
+
+   BSD 2-Clause License (http://www.opensource.org/licenses/bsd-license.php)
+
+   Redistribution and use in source and binary forms, with or without
+   modification, are permitted provided that the following conditions are
+   met:
+
+       * Redistributions of source code must retain the above copyright
+   notice, this list of conditions and the following disclaimer.
+       * Redistributions in binary form must reproduce the above
+   copyright notice, this list of conditions and the following disclaimer
+   in the documentation and/or other materials provided with the
+   distribution.
+
+   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+   You can contact the author at :
+   - xxHash source repository : https://github.com/Cyan4973/xxHash
+*/
+
+/* Notice extracted from xxHash homepage :
+
+xxHash is an extremely fast Hash algorithm, running at RAM speed limits.
+It also successfully passes all tests from the SMHasher suite.
+
+Comparison (single thread, Windows Seven 32 bits, using SMHasher on a Core 2 Duo @3GHz)
+
+Name            Speed       Q.Score   Author
+xxHash          5.4 GB/s     10
+CrapWow         3.2 GB/s      2       Andrew
+MumurHash 3a    2.7 GB/s     10       Austin Appleby
+SpookyHash      2.0 GB/s     10       Bob Jenkins
+SBox            1.4 GB/s      9       Bret Mulvey
+Lookup3         1.2 GB/s      9       Bob Jenkins
+SuperFastHash   1.2 GB/s      1       Paul Hsieh
+CityHash64      1.05 GB/s    10       Pike & Alakuijala
+FNV             0.55 GB/s     5       Fowler, Noll, Vo
+CRC32           0.43 GB/s     9
+MD5-32          0.33 GB/s    10       Ronald L. Rivest
+SHA1-32         0.28 GB/s    10
+
+Q.Score is a measure of quality of the hash function.
+It depends on successfully passing SMHasher test set.
+10 is a perfect score.
+
+A 64-bit version, named XXH64, is available since r35.
+It offers much better speed, but for 64-bit applications only.
+Name     Speed on 64 bits    Speed on 32 bits
+XXH64       13.8 GB/s            1.9 GB/s
+XXH32        6.8 GB/s            6.0 GB/s
+*/
+
+#ifndef XXHASH_H_5627135585666179
+#define XXHASH_H_5627135585666179 1
+
+#if defined (__cplusplus)
+extern "C" {
+#endif
+
+
+/* ****************************
+*  Definitions
+******************************/
+#include <stddef.h>   /* size_t */
+typedef enum { XXH_OK=0, XXH_ERROR } XXH_errorcode;
+
+
+/* ****************************
+ *  API modifier
+ ******************************/
+/** XXH_INLINE_ALL (and XXH_PRIVATE_API)
+ *  This is useful to include xxhash functions in `static` mode
+ *  in order to inline them, and remove their symbol from the public list.
+ *  Inlining can offer dramatic performance improvement on small keys.
+ *  Methodology :
+ *     #define XXH_INLINE_ALL
+ *     #include "xxhash.h"
+ * `xxhash.c` is automatically included.
+ *  It's not useful to compile and link it as a separate module.
+ */
+#if defined(XXH_INLINE_ALL) || defined(XXH_PRIVATE_API)
+#  ifndef XXH_STATIC_LINKING_ONLY
+#    define XXH_STATIC_LINKING_ONLY
+#  endif
+#  if defined(__GNUC__)
+#    define XXH_PUBLIC_API static __inline __attribute__((unused))
+#  elif defined (__cplusplus) || (defined (__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) /* C99 */)
+#    define XXH_PUBLIC_API static inline
+#  elif defined(_MSC_VER)
+#    define XXH_PUBLIC_API static __inline
+#  else
+     /* this version may generate warnings for unused static functions */
+#    define XXH_PUBLIC_API static
+#  endif
+#else
+#  if defined(WIN32) && defined(_MSC_VER) && (defined(XXH_IMPORT) || defined(XXH_EXPORT))
+#    ifdef XXH_EXPORT
+#      define XXH_PUBLIC_API __declspec(dllexport)
+#    elif XXH_IMPORT
+#      define XXH_PUBLIC_API __declspec(dllimport)
+#    endif
+#  else
+#    define XXH_PUBLIC_API   /* do nothing */
+#  endif
+#endif /* XXH_INLINE_ALL || XXH_PRIVATE_API */
+
+/*! XXH_NAMESPACE, aka Namespace Emulation :
+ *
+ * If you want to include _and expose_ xxHash functions from within your own library,
+ * but also want to avoid symbol collisions with other libraries which may also include xxHash,
+ *
+ * you can use XXH_NAMESPACE, to automatically prefix any public symbol from xxhash library
+ * with the value of XXH_NAMESPACE (therefore, avoid NULL and numeric values).
+ *
+ * Note that no change is required within the calling program as long as it includes `xxhash.h` :
+ * regular symbol name will be automatically translated by this header.
+ */
+#ifdef XXH_NAMESPACE
+#  define XXH_CAT(A,B) A##B
+#  define XXH_NAME2(A,B) XXH_CAT(A,B)
+#  define XXH_versionNumber XXH_NAME2(XXH_NAMESPACE, XXH_versionNumber)
+#  define XXH32 XXH_NAME2(XXH_NAMESPACE, XXH32)
+#  define XXH32_createState XXH_NAME2(XXH_NAMESPACE, XXH32_createState)
+#  define XXH32_freeState XXH_NAME2(XXH_NAMESPACE, XXH32_freeState)
+#  define XXH32_reset XXH_NAME2(XXH_NAMESPACE, XXH32_reset)
+#  define XXH32_update XXH_NAME2(XXH_NAMESPACE, XXH32_update)
+#  define XXH32_digest XXH_NAME2(XXH_NAMESPACE, XXH32_digest)
+#  define XXH32_copyState XXH_NAME2(XXH_NAMESPACE, XXH32_copyState)
+#  define XXH32_canonicalFromHash XXH_NAME2(XXH_NAMESPACE, XXH32_canonicalFromHash)
+#  define XXH32_hashFromCanonical XXH_NAME2(XXH_NAMESPACE, XXH32_hashFromCanonical)
+#  define XXH64 XXH_NAME2(XXH_NAMESPACE, XXH64)
+#  define XXH64_createState XXH_NAME2(XXH_NAMESPACE, XXH64_createState)
+#  define XXH64_freeState XXH_NAME2(XXH_NAMESPACE, XXH64_freeState)
+#  define XXH64_reset XXH_NAME2(XXH_NAMESPACE, XXH64_reset)
+#  define XXH64_update XXH_NAME2(XXH_NAMESPACE, XXH64_update)
+#  define XXH64_digest XXH_NAME2(XXH_NAMESPACE, XXH64_digest)
+#  define XXH64_copyState XXH_NAME2(XXH_NAMESPACE, XXH64_copyState)
+#  define XXH64_canonicalFromHash XXH_NAME2(XXH_NAMESPACE, XXH64_canonicalFromHash)
+#  define XXH64_hashFromCanonical XXH_NAME2(XXH_NAMESPACE, XXH64_hashFromCanonical)
+#endif
+
+
+/* *************************************
+*  Version
+***************************************/
+#define XXH_VERSION_MAJOR    0
+#define XXH_VERSION_MINOR    7
+#define XXH_VERSION_RELEASE  0
+#define XXH_VERSION_NUMBER  (XXH_VERSION_MAJOR *100*100 + XXH_VERSION_MINOR *100 + XXH_VERSION_RELEASE)
+XXH_PUBLIC_API unsigned XXH_versionNumber (void);
+
+
+/*-**********************************************************************
+*  32-bit hash
+************************************************************************/
+typedef unsigned int XXH32_hash_t;
+
+/*! XXH32() :
+    Calculate the 32-bit hash of sequence "length" bytes stored at memory address "input".
+    The memory between input & input+length must be valid (allocated and read-accessible).
+    "seed" can be used to alter the result predictably.
+    Speed on Core 2 Duo @ 3 GHz (single thread, SMHasher benchmark) : 5.4 GB/s */
+XXH_PUBLIC_API XXH32_hash_t XXH32 (const void* input, size_t length, unsigned int seed);
+
+/*======   Streaming   ======*/
+typedef struct XXH32_state_s XXH32_state_t;   /* incomplete type */
+XXH_PUBLIC_API XXH32_state_t* XXH32_createState(void);
+XXH_PUBLIC_API XXH_errorcode  XXH32_freeState(XXH32_state_t* statePtr);
+XXH_PUBLIC_API void XXH32_copyState(XXH32_state_t* dst_state, const XXH32_state_t* src_state);
+
+XXH_PUBLIC_API XXH_errorcode XXH32_reset  (XXH32_state_t* statePtr, unsigned int seed);
+XXH_PUBLIC_API XXH_errorcode XXH32_update (XXH32_state_t* statePtr, const void* input, size_t length);
+XXH_PUBLIC_API XXH32_hash_t  XXH32_digest (const XXH32_state_t* statePtr);
+
+/*
+ * Streaming functions generate the xxHash of an input provided in multiple segments.
+ * Note that, for small input, they are slower than single-call functions, due to state management.
+ * For small inputs, prefer `XXH32()` and `XXH64()`, which are better optimized.
+ *
+ * XXH state must first be allocated, using XXH*_createState() .
+ *
+ * Start a new hash by initializing state with a seed, using XXH*_reset().
+ *
+ * Then, feed the hash state by calling XXH*_update() as many times as necessary.
+ * The function returns an error code, with 0 meaning OK, and any other value meaning there is an error.
+ *
+ * Finally, a hash value can be produced anytime, by using XXH*_digest().
+ * This function returns the nn-bits hash as an int or long long.
+ *
+ * It's still possible to continue inserting input into the hash state after a digest,
+ * and generate some new hashes later on, by calling again XXH*_digest().
+ *
+ * When done, free XXH state space if it was allocated dynamically.
+ */
+
+/*======   Canonical representation   ======*/
+
+typedef struct { unsigned char digest[4]; } XXH32_canonical_t;
+XXH_PUBLIC_API void XXH32_canonicalFromHash(XXH32_canonical_t* dst, XXH32_hash_t hash);
+XXH_PUBLIC_API XXH32_hash_t XXH32_hashFromCanonical(const XXH32_canonical_t* src);
+
+/* Default result type for XXH functions are primitive unsigned 32 and 64 bits.
+ * The canonical representation uses human-readable write convention, aka big-endian (large digits first).
+ * These functions allow transformation of hash result into and from its canonical format.
+ * This way, hash values can be written into a file / memory, and remain comparable on different systems and programs.
+ */
+
+
+#ifndef XXH_NO_LONG_LONG
+/*-**********************************************************************
+*  64-bit hash
+************************************************************************/
+typedef unsigned long long XXH64_hash_t;
+
+/*! XXH64() :
+    Calculate the 64-bit hash of sequence of length "len" stored at memory address "input".
+    "seed" can be used to alter the result predictably.
+    This function runs faster on 64-bit systems, but slower on 32-bit systems (see benchmark).
+*/
+XXH_PUBLIC_API XXH64_hash_t XXH64 (const void* input, size_t length, unsigned long long seed);
+
+/*======   Streaming   ======*/
+typedef struct XXH64_state_s XXH64_state_t;   /* incomplete type */
+XXH_PUBLIC_API XXH64_state_t* XXH64_createState(void);
+XXH_PUBLIC_API XXH_errorcode  XXH64_freeState(XXH64_state_t* statePtr);
+XXH_PUBLIC_API void XXH64_copyState(XXH64_state_t* dst_state, const XXH64_state_t* src_state);
+
+XXH_PUBLIC_API XXH_errorcode XXH64_reset  (XXH64_state_t* statePtr, unsigned long long seed);
+XXH_PUBLIC_API XXH_errorcode XXH64_update (XXH64_state_t* statePtr, const void* input, size_t length);
+XXH_PUBLIC_API XXH64_hash_t  XXH64_digest (const XXH64_state_t* statePtr);
+
+/*======   Canonical representation   ======*/
+typedef struct { unsigned char digest[8]; } XXH64_canonical_t;
+XXH_PUBLIC_API void XXH64_canonicalFromHash(XXH64_canonical_t* dst, XXH64_hash_t hash);
+XXH_PUBLIC_API XXH64_hash_t XXH64_hashFromCanonical(const XXH64_canonical_t* src);
+
+
+#endif  /* XXH_NO_LONG_LONG */
+
+
+
+#ifdef XXH_STATIC_LINKING_ONLY
+
+/* ================================================================================================
+   This section contains declarations which are not guaranteed to remain stable.
+   They may change in future versions, becoming incompatible with a different version of the library.
+   These declarations should only be used with static linking.
+   Never use them in association with dynamic linking !
+=================================================================================================== */
+
+/* These definitions are only present to allow
+ * static allocation of XXH state, on stack or in a struct for example.
+ * Never **ever** use members directly. */
+
+#if !defined (__VMS) \
+  && (defined (__cplusplus) \
+  || (defined (__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) /* C99 */) )
+#   include <stdint.h>
+
+struct XXH32_state_s {
+   uint32_t total_len_32;
+   uint32_t large_len;
+   uint32_t v1;
+   uint32_t v2;
+   uint32_t v3;
+   uint32_t v4;
+   uint32_t mem32[4];
+   uint32_t memsize;
+   uint32_t reserved;   /* never read nor write, might be removed in a future version */
+};   /* typedef'd to XXH32_state_t */
+
+struct XXH64_state_s {
+   uint64_t total_len;
+   uint64_t v1;
+   uint64_t v2;
+   uint64_t v3;
+   uint64_t v4;
+   uint64_t mem64[4];
+   uint32_t memsize;
+   uint32_t reserved[2];   /* never read nor write, might be removed in a future version */
+};   /* typedef'd to XXH64_state_t */
+
+# else
+
+struct XXH32_state_s {
+   XXH32_hash_t total_len_32;
+   XXH32_hash_t large_len;
+   XXH32_hash_t v1;
+   XXH32_hash_t v2;
+   XXH32_hash_t v3;
+   XXH32_hash_t v4;
+   XXH32_hash_t mem32[4];
+   XXH32_hash_t memsize;
+   XXH32_hash_t reserved;   /* never read nor write, might be removed in a future version */
+};   /* typedef'd to XXH32_state_t */
+
+#   ifndef XXH_NO_LONG_LONG  /* remove 64-bit support */
+struct XXH64_state_s {
+   XXH64_hash_t total_len;
+   XXH64_hash_t v1;
+   XXH64_hash_t v2;
+   XXH64_hash_t v3;
+   XXH64_hash_t v4;
+   XXH64_hash_t mem64[4];
+   XXH32_hash_t memsize;
+   XXH32_hash_t reserved[2];     /* never read nor write, might be removed in a future version */
+};   /* typedef'd to XXH64_state_t */
+#    endif
+
+# endif
+
+
+/*-**********************************************************************
+*  XXH3
+*  New experimental hash
+************************************************************************/
+#ifndef XXH_NO_LONG_LONG
+
+
+/* ============================================
+ * XXH3 is a new hash algorithm,
+ * featuring vastly improved speed performance
+ * for both small and large inputs.
+ * A full speed analysis will be published,
+ * it requires a lot more space than this comment can handle.
+ * In general, expect XXH3 to run about ~2x faster on large inputs,
+ * and >3x faster on small ones, though exact difference depend on platform.
+ *
+ * The algorithm is portable, will generate the same hash on all platforms.
+ * It benefits greatly from vectorization units, but does not require it.
+ *
+ * XXH3 offers 2 variants, _64bits and _128bits.
+ * When only 64 bits are needed, prefer calling the _64bits variant :
+ * it reduces the amount of mixing, resulting in faster speed on small inputs.
+ * It's also generally simpler to manipulate a scalar type than a struct.
+ * Note : the low 64-bit field of the _128bits variant is the same as _64bits result.
+ *
+ * The XXH3 algorithm is still considered experimental.
+ * It's possible to use it for ephemeral data, but avoid storing long-term values for later re-use.
+ * While labelled experimental, the produced result can still change between versions.
+ *
+ * The API currently supports one-shot hashing only.
+ * The full version will include streaming capability, and canonical representation
+ * Long term optional feature may include custom secret keys, and secret key generation.
+ *
+ * There are still a number of opened questions that community can influence during the experimental period.
+ * I'm trying to list a few of them below, though don't consider this list as complete.
+ *
+ * - 128-bits output type : currently defined as a structure of 2 64-bits fields.
+ *                          That's because 128-bit values do not exist in C standard.
+ *                          Note that it means that, at byte level, result is not identical depending on endianess.
+ *                          However, at field level, they are identical on all platforms.
+ *                          The canonical representation will solve the issue of identical byte-level representation across platforms,
+ *                          which is necessary for serialization.
+ *                          Would there be a better representation for a 128-bit hash result ?
+ *                          Are the names of the inner 64-bit fields important ? Should they be changed ?
+ *
+ * - Canonical representation : for the 64-bit variant, canonical representation is the same as XXH64() (aka big-endian).
+ *                          What should it be for the 128-bit variant ?
+ *                          Since it's no longer a scalar value, big-endian representation is no longer an obvious choice.
+ *                          One possibility : represent it as the concatenation of two 64-bits canonical representation (aka 2x big-endian)
+ *                          Another one : represent it in the same order as natural order in the struct for little-endian platforms.
+ *                                        Less consistent with existing convention for XXH32/XXH64, but may be more natural for little-endian platforms.
+ *
+ * - Associated functions for 128-bit hash : simple things, such as checking if 2 hashes are equal, become more difficult with struct.
+ *                          Granted, it's not terribly difficult to create a comparator, but it's still a workload.
+ *                          Would it be beneficial to declare and define a comparator function for XXH128_hash_t ?
+ *                          Are there other operations on XXH128_hash_t which would be desirable ?
+ *
+ * - Variant compatibility : The low 64-bit field of the _128bits variant is the same as the result of _64bits.
+ *                          This is not a compulsory behavior. It just felt that it "wouldn't hurt", and might even help in some (unidentified) cases.
+ *                          But it might influence the design of XXH128_hash_t, in ways which may block other possibilities.
+ *                          Good idea, bad idea ?
+ *
+ * - Seed type for 128-bits variant : currently, it's a single 64-bit value, like the 64-bit variant.
+ *                          It could be argued that it's more logical to offer a 128-bit seed input parameter for a 128-bit hash.
+ *                          Although it's also more difficult to use, since it requires to declare and pass a structure instead of a value.
+ *                          It would either replace current choice, or add a new one.
+ *                          Farmhash, for example, offers both variants (the 128-bits seed variant is called `doubleSeed`).
+ *                          If both 64-bit and 128-bit seeds are possible, which variant should be called XXH128 ?
+ *
+ * - Result for len==0 : Currently, the result of hashing a zero-length input is the seed.
+ *                          This mimics the behavior of a crc : in which case, a seed is effectively an accumulator, so it's not updated if input is empty.
+ *                          Consequently, by default, when no seed specified, it returns zero. That part seems okay (it used to be a request for XXH32/XXH64).
+ *                          But is it still fine to return the seed when the seed is non-zero ?
+ *                          Are there use case which would depend on this behavior, or would prefer a mixing of the seed ?
+ */
+
+#ifdef XXH_NAMESPACE
+#  define XXH128 XXH_NAME2(XXH_NAMESPACE, XXH128)
+#  define XXH3_64bits XXH_NAME2(XXH_NAMESPACE, XXH3_64bits)
+#  define XXH3_64bits_withSeed XXH_NAME2(XXH_NAMESPACE, XXH3_64bits_withSeed)
+#  define XXH3_128bits XXH_NAME2(XXH_NAMESPACE, XXH3_128bits)
+#  define XXH3_128bits_withSeed XXH_NAME2(XXH_NAMESPACE, XXH3_128bits_withSeed)
+#endif
+
+
+typedef struct {
+    XXH64_hash_t low64;
+    XXH64_hash_t high64;
+} XXH128_hash_t;
+
+XXH_PUBLIC_API XXH128_hash_t XXH128(const void* data, size_t len, unsigned long long seed);
+
+/* note : variants without seed produce same result as variant with seed == 0 */
+XXH_PUBLIC_API XXH64_hash_t  XXH3_64bits(const void* data, size_t len);
+XXH_PUBLIC_API XXH64_hash_t  XXH3_64bits_withSeed(const void* data, size_t len, unsigned long long seed);
+XXH_PUBLIC_API XXH128_hash_t XXH3_128bits(const void* data, size_t len);
+XXH_PUBLIC_API XXH128_hash_t XXH3_128bits_withSeed(const void* data, size_t len, unsigned long long seed);  /* == XXH128() */
+
+
+#endif  /* XXH_NO_LONG_LONG */
+
+
+/*-**********************************************************************
+*  XXH_INLINE_ALL
+************************************************************************/
+#if defined(XXH_INLINE_ALL) || defined(XXH_PRIVATE_API)
+#  include "xxhash.c"   /* include xxhash function bodies as `static`, for inlining */
+#endif
+
+
+
+#endif /* XXH_STATIC_LINKING_ONLY */
+
+
+#if defined (__cplusplus)
+}
+#endif
+
+#endif /* XXHASH_H_5627135585666179 */
-- 
2.16.4

