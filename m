Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB39BDF376
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 18:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfJUQpN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 12:45:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:52934 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbfJUQpM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 12:45:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8CC0DAFB1;
        Mon, 21 Oct 2019 16:45:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CFF97DA733; Mon, 21 Oct 2019 18:45:20 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/4] btrfs-progs: add blake2b reference implementation
Date:   Mon, 21 Oct 2019 18:45:20 +0200
Message-Id: <20191021164520.15154-1-dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571674940.git.dsterba@suse.com>
References: <cover.1571674940.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Upstream commit 997fa5ba1e14b52c554fb03ce39e579e6f27b90c,
git repository: git://github.com/BLAKE2/BLAKE2

The reference implemetation added in this patch is unchanged and will be
modified only to compile in current code base and with minimal other
modifications in case of future sync with upstream code. IOW, the coding
style should stay as-is and does not conform to the other btrfs-progs
code. This is an exception for xxhash and sha256 code as well.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 Makefile             |   3 +-
 crypto/blake2-impl.h | 160 ++++++++++++++++++
 crypto/blake2.h      | 195 ++++++++++++++++++++++
 crypto/blake2b-ref.c | 379 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 736 insertions(+), 1 deletion(-)
 create mode 100644 crypto/blake2-impl.h
 create mode 100644 crypto/blake2.h
 create mode 100644 crypto/blake2b-ref.c

diff --git a/Makefile b/Makefile
index 9104764e974c..e9d01d9838d9 100644
--- a/Makefile
+++ b/Makefile
@@ -153,7 +153,8 @@ libbtrfs_objects = send-stream.o send-utils.o kernel-lib/rbtree.o btrfs-list.o \
 		   kernel-lib/radix-tree.o extent-cache.o extent_io.o \
 		   crypto/crc32c.o common/messages.o \
 		   uuid-tree.o utils-lib.o common/rbtree-utils.o \
-		   crypto/hash.o crypto/xxhash.o crypto/sha224-256.o
+		   crypto/hash.o crypto/xxhash.o crypto/sha224-256.o \
+		   crypto/blake2b-ref.o
 libbtrfs_headers = send-stream.h send-utils.h send.h kernel-lib/rbtree.h btrfs-list.h \
 	       crypto/crc32c.h kernel-lib/list.h kerncompat.h \
 	       kernel-lib/radix-tree.h kernel-lib/sizes.h kernel-lib/raid56.h \
diff --git a/crypto/blake2-impl.h b/crypto/blake2-impl.h
new file mode 100644
index 000000000000..c1df82e0c95d
--- /dev/null
+++ b/crypto/blake2-impl.h
@@ -0,0 +1,160 @@
+/*
+   BLAKE2 reference source code package - reference C implementations
+
+   Copyright 2012, Samuel Neves <sneves@dei.uc.pt>.  You may use this under the
+   terms of the CC0, the OpenSSL Licence, or the Apache Public License 2.0, at
+   your option.  The terms of these licenses can be found at:
+
+   - CC0 1.0 Universal : http://creativecommons.org/publicdomain/zero/1.0
+   - OpenSSL license   : https://www.openssl.org/source/license.html
+   - Apache 2.0        : http://www.apache.org/licenses/LICENSE-2.0
+
+   More information about the BLAKE2 hash function can be found at
+   https://blake2.net.
+*/
+#ifndef BLAKE2_IMPL_H
+#define BLAKE2_IMPL_H
+
+#include <stdint.h>
+#include <string.h>
+
+#if !defined(__cplusplus) && (!defined(__STDC_VERSION__) || __STDC_VERSION__ < 199901L)
+  #if   defined(_MSC_VER)
+    #define BLAKE2_INLINE __inline
+  #elif defined(__GNUC__)
+    #define BLAKE2_INLINE __inline__
+  #else
+    #define BLAKE2_INLINE
+  #endif
+#else
+  #define BLAKE2_INLINE inline
+#endif
+
+static BLAKE2_INLINE uint32_t load32( const void *src )
+{
+#if defined(NATIVE_LITTLE_ENDIAN)
+  uint32_t w;
+  memcpy(&w, src, sizeof w);
+  return w;
+#else
+  const uint8_t *p = ( const uint8_t * )src;
+  return (( uint32_t )( p[0] ) <<  0) |
+         (( uint32_t )( p[1] ) <<  8) |
+         (( uint32_t )( p[2] ) << 16) |
+         (( uint32_t )( p[3] ) << 24) ;
+#endif
+}
+
+static BLAKE2_INLINE uint64_t load64( const void *src )
+{
+#if defined(NATIVE_LITTLE_ENDIAN)
+  uint64_t w;
+  memcpy(&w, src, sizeof w);
+  return w;
+#else
+  const uint8_t *p = ( const uint8_t * )src;
+  return (( uint64_t )( p[0] ) <<  0) |
+         (( uint64_t )( p[1] ) <<  8) |
+         (( uint64_t )( p[2] ) << 16) |
+         (( uint64_t )( p[3] ) << 24) |
+         (( uint64_t )( p[4] ) << 32) |
+         (( uint64_t )( p[5] ) << 40) |
+         (( uint64_t )( p[6] ) << 48) |
+         (( uint64_t )( p[7] ) << 56) ;
+#endif
+}
+
+static BLAKE2_INLINE uint16_t load16( const void *src )
+{
+#if defined(NATIVE_LITTLE_ENDIAN)
+  uint16_t w;
+  memcpy(&w, src, sizeof w);
+  return w;
+#else
+  const uint8_t *p = ( const uint8_t * )src;
+  return ( uint16_t )((( uint32_t )( p[0] ) <<  0) |
+                      (( uint32_t )( p[1] ) <<  8));
+#endif
+}
+
+static BLAKE2_INLINE void store16( void *dst, uint16_t w )
+{
+#if defined(NATIVE_LITTLE_ENDIAN)
+  memcpy(dst, &w, sizeof w);
+#else
+  uint8_t *p = ( uint8_t * )dst;
+  *p++ = ( uint8_t )w; w >>= 8;
+  *p++ = ( uint8_t )w;
+#endif
+}
+
+static BLAKE2_INLINE void store32( void *dst, uint32_t w )
+{
+#if defined(NATIVE_LITTLE_ENDIAN)
+  memcpy(dst, &w, sizeof w);
+#else
+  uint8_t *p = ( uint8_t * )dst;
+  p[0] = (uint8_t)(w >>  0);
+  p[1] = (uint8_t)(w >>  8);
+  p[2] = (uint8_t)(w >> 16);
+  p[3] = (uint8_t)(w >> 24);
+#endif
+}
+
+static BLAKE2_INLINE void store64( void *dst, uint64_t w )
+{
+#if defined(NATIVE_LITTLE_ENDIAN)
+  memcpy(dst, &w, sizeof w);
+#else
+  uint8_t *p = ( uint8_t * )dst;
+  p[0] = (uint8_t)(w >>  0);
+  p[1] = (uint8_t)(w >>  8);
+  p[2] = (uint8_t)(w >> 16);
+  p[3] = (uint8_t)(w >> 24);
+  p[4] = (uint8_t)(w >> 32);
+  p[5] = (uint8_t)(w >> 40);
+  p[6] = (uint8_t)(w >> 48);
+  p[7] = (uint8_t)(w >> 56);
+#endif
+}
+
+static BLAKE2_INLINE uint64_t load48( const void *src )
+{
+  const uint8_t *p = ( const uint8_t * )src;
+  return (( uint64_t )( p[0] ) <<  0) |
+         (( uint64_t )( p[1] ) <<  8) |
+         (( uint64_t )( p[2] ) << 16) |
+         (( uint64_t )( p[3] ) << 24) |
+         (( uint64_t )( p[4] ) << 32) |
+         (( uint64_t )( p[5] ) << 40) ;
+}
+
+static BLAKE2_INLINE void store48( void *dst, uint64_t w )
+{
+  uint8_t *p = ( uint8_t * )dst;
+  p[0] = (uint8_t)(w >>  0);
+  p[1] = (uint8_t)(w >>  8);
+  p[2] = (uint8_t)(w >> 16);
+  p[3] = (uint8_t)(w >> 24);
+  p[4] = (uint8_t)(w >> 32);
+  p[5] = (uint8_t)(w >> 40);
+}
+
+static BLAKE2_INLINE uint32_t rotr32( const uint32_t w, const unsigned c )
+{
+  return ( w >> c ) | ( w << ( 32 - c ) );
+}
+
+static BLAKE2_INLINE uint64_t rotr64( const uint64_t w, const unsigned c )
+{
+  return ( w >> c ) | ( w << ( 64 - c ) );
+}
+
+/* prevents compiler optimizing out memset() */
+static BLAKE2_INLINE void secure_zero_memory(void *v, size_t n)
+{
+  static void *(*const volatile memset_v)(void *, int, size_t) = &memset;
+  memset_v(v, 0, n);
+}
+
+#endif
diff --git a/crypto/blake2.h b/crypto/blake2.h
new file mode 100644
index 000000000000..ad62f260e739
--- /dev/null
+++ b/crypto/blake2.h
@@ -0,0 +1,195 @@
+/*
+   BLAKE2 reference source code package - reference C implementations
+
+   Copyright 2012, Samuel Neves <sneves@dei.uc.pt>.  You may use this under the
+   terms of the CC0, the OpenSSL Licence, or the Apache Public License 2.0, at
+   your option.  The terms of these licenses can be found at:
+
+   - CC0 1.0 Universal : http://creativecommons.org/publicdomain/zero/1.0
+   - OpenSSL license   : https://www.openssl.org/source/license.html
+   - Apache 2.0        : http://www.apache.org/licenses/LICENSE-2.0
+
+   More information about the BLAKE2 hash function can be found at
+   https://blake2.net.
+*/
+#ifndef BLAKE2_H
+#define BLAKE2_H
+
+#include <stddef.h>
+#include <stdint.h>
+
+#if defined(_MSC_VER)
+#define BLAKE2_PACKED(x) __pragma(pack(push, 1)) x __pragma(pack(pop))
+#else
+#define BLAKE2_PACKED(x) x __attribute__((packed))
+#endif
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+  enum blake2s_constant
+  {
+    BLAKE2S_BLOCKBYTES = 64,
+    BLAKE2S_OUTBYTES   = 32,
+    BLAKE2S_KEYBYTES   = 32,
+    BLAKE2S_SALTBYTES  = 8,
+    BLAKE2S_PERSONALBYTES = 8
+  };
+
+  enum blake2b_constant
+  {
+    BLAKE2B_BLOCKBYTES = 128,
+    BLAKE2B_OUTBYTES   = 64,
+    BLAKE2B_KEYBYTES   = 64,
+    BLAKE2B_SALTBYTES  = 16,
+    BLAKE2B_PERSONALBYTES = 16
+  };
+
+  typedef struct blake2s_state__
+  {
+    uint32_t h[8];
+    uint32_t t[2];
+    uint32_t f[2];
+    uint8_t  buf[BLAKE2S_BLOCKBYTES];
+    size_t   buflen;
+    size_t   outlen;
+    uint8_t  last_node;
+  } blake2s_state;
+
+  typedef struct blake2b_state__
+  {
+    uint64_t h[8];
+    uint64_t t[2];
+    uint64_t f[2];
+    uint8_t  buf[BLAKE2B_BLOCKBYTES];
+    size_t   buflen;
+    size_t   outlen;
+    uint8_t  last_node;
+  } blake2b_state;
+
+  typedef struct blake2sp_state__
+  {
+    blake2s_state S[8][1];
+    blake2s_state R[1];
+    uint8_t       buf[8 * BLAKE2S_BLOCKBYTES];
+    size_t        buflen;
+    size_t        outlen;
+  } blake2sp_state;
+
+  typedef struct blake2bp_state__
+  {
+    blake2b_state S[4][1];
+    blake2b_state R[1];
+    uint8_t       buf[4 * BLAKE2B_BLOCKBYTES];
+    size_t        buflen;
+    size_t        outlen;
+  } blake2bp_state;
+
+
+  BLAKE2_PACKED(struct blake2s_param__
+  {
+    uint8_t  digest_length; /* 1 */
+    uint8_t  key_length;    /* 2 */
+    uint8_t  fanout;        /* 3 */
+    uint8_t  depth;         /* 4 */
+    uint32_t leaf_length;   /* 8 */
+    uint32_t node_offset;  /* 12 */
+    uint16_t xof_length;    /* 14 */
+    uint8_t  node_depth;    /* 15 */
+    uint8_t  inner_length;  /* 16 */
+    /* uint8_t  reserved[0]; */
+    uint8_t  salt[BLAKE2S_SALTBYTES]; /* 24 */
+    uint8_t  personal[BLAKE2S_PERSONALBYTES];  /* 32 */
+  });
+
+  typedef struct blake2s_param__ blake2s_param;
+
+  BLAKE2_PACKED(struct blake2b_param__
+  {
+    uint8_t  digest_length; /* 1 */
+    uint8_t  key_length;    /* 2 */
+    uint8_t  fanout;        /* 3 */
+    uint8_t  depth;         /* 4 */
+    uint32_t leaf_length;   /* 8 */
+    uint32_t node_offset;   /* 12 */
+    uint32_t xof_length;    /* 16 */
+    uint8_t  node_depth;    /* 17 */
+    uint8_t  inner_length;  /* 18 */
+    uint8_t  reserved[14];  /* 32 */
+    uint8_t  salt[BLAKE2B_SALTBYTES]; /* 48 */
+    uint8_t  personal[BLAKE2B_PERSONALBYTES];  /* 64 */
+  });
+
+  typedef struct blake2b_param__ blake2b_param;
+
+  typedef struct blake2xs_state__
+  {
+    blake2s_state S[1];
+    blake2s_param P[1];
+  } blake2xs_state;
+
+  typedef struct blake2xb_state__
+  {
+    blake2b_state S[1];
+    blake2b_param P[1];
+  } blake2xb_state;
+
+  /* Padded structs result in a compile-time error */
+  enum {
+    BLAKE2_DUMMY_1 = 1/(sizeof(blake2s_param) == BLAKE2S_OUTBYTES),
+    BLAKE2_DUMMY_2 = 1/(sizeof(blake2b_param) == BLAKE2B_OUTBYTES)
+  };
+
+  /* Streaming API */
+  int blake2s_init( blake2s_state *S, size_t outlen );
+  int blake2s_init_key( blake2s_state *S, size_t outlen, const void *key, size_t keylen );
+  int blake2s_init_param( blake2s_state *S, const blake2s_param *P );
+  int blake2s_update( blake2s_state *S, const void *in, size_t inlen );
+  int blake2s_final( blake2s_state *S, void *out, size_t outlen );
+
+  int blake2b_init( blake2b_state *S, size_t outlen );
+  int blake2b_init_key( blake2b_state *S, size_t outlen, const void *key, size_t keylen );
+  int blake2b_init_param( blake2b_state *S, const blake2b_param *P );
+  int blake2b_update( blake2b_state *S, const void *in, size_t inlen );
+  int blake2b_final( blake2b_state *S, void *out, size_t outlen );
+
+  int blake2sp_init( blake2sp_state *S, size_t outlen );
+  int blake2sp_init_key( blake2sp_state *S, size_t outlen, const void *key, size_t keylen );
+  int blake2sp_update( blake2sp_state *S, const void *in, size_t inlen );
+  int blake2sp_final( blake2sp_state *S, void *out, size_t outlen );
+
+  int blake2bp_init( blake2bp_state *S, size_t outlen );
+  int blake2bp_init_key( blake2bp_state *S, size_t outlen, const void *key, size_t keylen );
+  int blake2bp_update( blake2bp_state *S, const void *in, size_t inlen );
+  int blake2bp_final( blake2bp_state *S, void *out, size_t outlen );
+
+  /* Variable output length API */
+  int blake2xs_init( blake2xs_state *S, const size_t outlen );
+  int blake2xs_init_key( blake2xs_state *S, const size_t outlen, const void *key, size_t keylen );
+  int blake2xs_update( blake2xs_state *S, const void *in, size_t inlen );
+  int blake2xs_final(blake2xs_state *S, void *out, size_t outlen);
+
+  int blake2xb_init( blake2xb_state *S, const size_t outlen );
+  int blake2xb_init_key( blake2xb_state *S, const size_t outlen, const void *key, size_t keylen );
+  int blake2xb_update( blake2xb_state *S, const void *in, size_t inlen );
+  int blake2xb_final(blake2xb_state *S, void *out, size_t outlen);
+
+  /* Simple API */
+  int blake2s( void *out, size_t outlen, const void *in, size_t inlen, const void *key, size_t keylen );
+  int blake2b( void *out, size_t outlen, const void *in, size_t inlen, const void *key, size_t keylen );
+
+  int blake2sp( void *out, size_t outlen, const void *in, size_t inlen, const void *key, size_t keylen );
+  int blake2bp( void *out, size_t outlen, const void *in, size_t inlen, const void *key, size_t keylen );
+
+  int blake2xs( void *out, size_t outlen, const void *in, size_t inlen, const void *key, size_t keylen );
+  int blake2xb( void *out, size_t outlen, const void *in, size_t inlen, const void *key, size_t keylen );
+
+  /* This is simply an alias for blake2b */
+  int blake2( void *out, size_t outlen, const void *in, size_t inlen, const void *key, size_t keylen );
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif
diff --git a/crypto/blake2b-ref.c b/crypto/blake2b-ref.c
new file mode 100644
index 000000000000..cd38b1ba0083
--- /dev/null
+++ b/crypto/blake2b-ref.c
@@ -0,0 +1,379 @@
+/*
+   BLAKE2 reference source code package - reference C implementations
+
+   Copyright 2012, Samuel Neves <sneves@dei.uc.pt>.  You may use this under the
+   terms of the CC0, the OpenSSL Licence, or the Apache Public License 2.0, at
+   your option.  The terms of these licenses can be found at:
+
+   - CC0 1.0 Universal : http://creativecommons.org/publicdomain/zero/1.0
+   - OpenSSL license   : https://www.openssl.org/source/license.html
+   - Apache 2.0        : http://www.apache.org/licenses/LICENSE-2.0
+
+   More information about the BLAKE2 hash function can be found at
+   https://blake2.net.
+*/
+
+#include <stdint.h>
+#include <string.h>
+#include <stdio.h>
+
+#include "blake2.h"
+#include "blake2-impl.h"
+
+static const uint64_t blake2b_IV[8] =
+{
+  0x6a09e667f3bcc908ULL, 0xbb67ae8584caa73bULL,
+  0x3c6ef372fe94f82bULL, 0xa54ff53a5f1d36f1ULL,
+  0x510e527fade682d1ULL, 0x9b05688c2b3e6c1fULL,
+  0x1f83d9abfb41bd6bULL, 0x5be0cd19137e2179ULL
+};
+
+static const uint8_t blake2b_sigma[12][16] =
+{
+  {  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15 } ,
+  { 14, 10,  4,  8,  9, 15, 13,  6,  1, 12,  0,  2, 11,  7,  5,  3 } ,
+  { 11,  8, 12,  0,  5,  2, 15, 13, 10, 14,  3,  6,  7,  1,  9,  4 } ,
+  {  7,  9,  3,  1, 13, 12, 11, 14,  2,  6,  5, 10,  4,  0, 15,  8 } ,
+  {  9,  0,  5,  7,  2,  4, 10, 15, 14,  1, 11, 12,  6,  8,  3, 13 } ,
+  {  2, 12,  6, 10,  0, 11,  8,  3,  4, 13,  7,  5, 15, 14,  1,  9 } ,
+  { 12,  5,  1, 15, 14, 13,  4, 10,  0,  7,  6,  3,  9,  2,  8, 11 } ,
+  { 13, 11,  7, 14, 12,  1,  3,  9,  5,  0, 15,  4,  8,  6,  2, 10 } ,
+  {  6, 15, 14,  9, 11,  3,  0,  8, 12,  2, 13,  7,  1,  4, 10,  5 } ,
+  { 10,  2,  8,  4,  7,  6,  1,  5, 15, 11,  9, 14,  3, 12, 13 , 0 } ,
+  {  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15 } ,
+  { 14, 10,  4,  8,  9, 15, 13,  6,  1, 12,  0,  2, 11,  7,  5,  3 }
+};
+
+
+static void blake2b_set_lastnode( blake2b_state *S )
+{
+  S->f[1] = (uint64_t)-1;
+}
+
+/* Some helper functions, not necessarily useful */
+static int blake2b_is_lastblock( const blake2b_state *S )
+{
+  return S->f[0] != 0;
+}
+
+static void blake2b_set_lastblock( blake2b_state *S )
+{
+  if( S->last_node ) blake2b_set_lastnode( S );
+
+  S->f[0] = (uint64_t)-1;
+}
+
+static void blake2b_increment_counter( blake2b_state *S, const uint64_t inc )
+{
+  S->t[0] += inc;
+  S->t[1] += ( S->t[0] < inc );
+}
+
+static void blake2b_init0( blake2b_state *S )
+{
+  size_t i;
+  memset( S, 0, sizeof( blake2b_state ) );
+
+  for( i = 0; i < 8; ++i ) S->h[i] = blake2b_IV[i];
+}
+
+/* init xors IV with input parameter block */
+int blake2b_init_param( blake2b_state *S, const blake2b_param *P )
+{
+  const uint8_t *p = ( const uint8_t * )( P );
+  size_t i;
+
+  blake2b_init0( S );
+
+  /* IV XOR ParamBlock */
+  for( i = 0; i < 8; ++i )
+    S->h[i] ^= load64( p + sizeof( S->h[i] ) * i );
+
+  S->outlen = P->digest_length;
+  return 0;
+}
+
+
+
+int blake2b_init( blake2b_state *S, size_t outlen )
+{
+  blake2b_param P[1];
+
+  if ( ( !outlen ) || ( outlen > BLAKE2B_OUTBYTES ) ) return -1;
+
+  P->digest_length = (uint8_t)outlen;
+  P->key_length    = 0;
+  P->fanout        = 1;
+  P->depth         = 1;
+  store32( &P->leaf_length, 0 );
+  store32( &P->node_offset, 0 );
+  store32( &P->xof_length, 0 );
+  P->node_depth    = 0;
+  P->inner_length  = 0;
+  memset( P->reserved, 0, sizeof( P->reserved ) );
+  memset( P->salt,     0, sizeof( P->salt ) );
+  memset( P->personal, 0, sizeof( P->personal ) );
+  return blake2b_init_param( S, P );
+}
+
+
+int blake2b_init_key( blake2b_state *S, size_t outlen, const void *key, size_t keylen )
+{
+  blake2b_param P[1];
+
+  if ( ( !outlen ) || ( outlen > BLAKE2B_OUTBYTES ) ) return -1;
+
+  if ( !key || !keylen || keylen > BLAKE2B_KEYBYTES ) return -1;
+
+  P->digest_length = (uint8_t)outlen;
+  P->key_length    = (uint8_t)keylen;
+  P->fanout        = 1;
+  P->depth         = 1;
+  store32( &P->leaf_length, 0 );
+  store32( &P->node_offset, 0 );
+  store32( &P->xof_length, 0 );
+  P->node_depth    = 0;
+  P->inner_length  = 0;
+  memset( P->reserved, 0, sizeof( P->reserved ) );
+  memset( P->salt,     0, sizeof( P->salt ) );
+  memset( P->personal, 0, sizeof( P->personal ) );
+
+  if( blake2b_init_param( S, P ) < 0 ) return -1;
+
+  {
+    uint8_t block[BLAKE2B_BLOCKBYTES];
+    memset( block, 0, BLAKE2B_BLOCKBYTES );
+    memcpy( block, key, keylen );
+    blake2b_update( S, block, BLAKE2B_BLOCKBYTES );
+    secure_zero_memory( block, BLAKE2B_BLOCKBYTES ); /* Burn the key from stack */
+  }
+  return 0;
+}
+
+#define G(r,i,a,b,c,d)                      \
+  do {                                      \
+    a = a + b + m[blake2b_sigma[r][2*i+0]]; \
+    d = rotr64(d ^ a, 32);                  \
+    c = c + d;                              \
+    b = rotr64(b ^ c, 24);                  \
+    a = a + b + m[blake2b_sigma[r][2*i+1]]; \
+    d = rotr64(d ^ a, 16);                  \
+    c = c + d;                              \
+    b = rotr64(b ^ c, 63);                  \
+  } while(0)
+
+#define ROUND(r)                    \
+  do {                              \
+    G(r,0,v[ 0],v[ 4],v[ 8],v[12]); \
+    G(r,1,v[ 1],v[ 5],v[ 9],v[13]); \
+    G(r,2,v[ 2],v[ 6],v[10],v[14]); \
+    G(r,3,v[ 3],v[ 7],v[11],v[15]); \
+    G(r,4,v[ 0],v[ 5],v[10],v[15]); \
+    G(r,5,v[ 1],v[ 6],v[11],v[12]); \
+    G(r,6,v[ 2],v[ 7],v[ 8],v[13]); \
+    G(r,7,v[ 3],v[ 4],v[ 9],v[14]); \
+  } while(0)
+
+static void blake2b_compress( blake2b_state *S, const uint8_t block[BLAKE2B_BLOCKBYTES] )
+{
+  uint64_t m[16];
+  uint64_t v[16];
+  size_t i;
+
+  for( i = 0; i < 16; ++i ) {
+    m[i] = load64( block + i * sizeof( m[i] ) );
+  }
+
+  for( i = 0; i < 8; ++i ) {
+    v[i] = S->h[i];
+  }
+
+  v[ 8] = blake2b_IV[0];
+  v[ 9] = blake2b_IV[1];
+  v[10] = blake2b_IV[2];
+  v[11] = blake2b_IV[3];
+  v[12] = blake2b_IV[4] ^ S->t[0];
+  v[13] = blake2b_IV[5] ^ S->t[1];
+  v[14] = blake2b_IV[6] ^ S->f[0];
+  v[15] = blake2b_IV[7] ^ S->f[1];
+
+  ROUND( 0 );
+  ROUND( 1 );
+  ROUND( 2 );
+  ROUND( 3 );
+  ROUND( 4 );
+  ROUND( 5 );
+  ROUND( 6 );
+  ROUND( 7 );
+  ROUND( 8 );
+  ROUND( 9 );
+  ROUND( 10 );
+  ROUND( 11 );
+
+  for( i = 0; i < 8; ++i ) {
+    S->h[i] = S->h[i] ^ v[i] ^ v[i + 8];
+  }
+}
+
+#undef G
+#undef ROUND
+
+int blake2b_update( blake2b_state *S, const void *pin, size_t inlen )
+{
+  const unsigned char * in = (const unsigned char *)pin;
+  if( inlen > 0 )
+  {
+    size_t left = S->buflen;
+    size_t fill = BLAKE2B_BLOCKBYTES - left;
+    if( inlen > fill )
+    {
+      S->buflen = 0;
+      memcpy( S->buf + left, in, fill ); /* Fill buffer */
+      blake2b_increment_counter( S, BLAKE2B_BLOCKBYTES );
+      blake2b_compress( S, S->buf ); /* Compress */
+      in += fill; inlen -= fill;
+      while(inlen > BLAKE2B_BLOCKBYTES) {
+        blake2b_increment_counter(S, BLAKE2B_BLOCKBYTES);
+        blake2b_compress( S, in );
+        in += BLAKE2B_BLOCKBYTES;
+        inlen -= BLAKE2B_BLOCKBYTES;
+      }
+    }
+    memcpy( S->buf + S->buflen, in, inlen );
+    S->buflen += inlen;
+  }
+  return 0;
+}
+
+int blake2b_final( blake2b_state *S, void *out, size_t outlen )
+{
+  uint8_t buffer[BLAKE2B_OUTBYTES] = {0};
+  size_t i;
+
+  if( out == NULL || outlen < S->outlen )
+    return -1;
+
+  if( blake2b_is_lastblock( S ) )
+    return -1;
+
+  blake2b_increment_counter( S, S->buflen );
+  blake2b_set_lastblock( S );
+  memset( S->buf + S->buflen, 0, BLAKE2B_BLOCKBYTES - S->buflen ); /* Padding */
+  blake2b_compress( S, S->buf );
+
+  for( i = 0; i < 8; ++i ) /* Output full hash to temp buffer */
+    store64( buffer + sizeof( S->h[i] ) * i, S->h[i] );
+
+  memcpy( out, buffer, S->outlen );
+  secure_zero_memory(buffer, sizeof(buffer));
+  return 0;
+}
+
+/* inlen, at least, should be uint64_t. Others can be size_t. */
+int blake2b( void *out, size_t outlen, const void *in, size_t inlen, const void *key, size_t keylen )
+{
+  blake2b_state S[1];
+
+  /* Verify parameters */
+  if ( NULL == in && inlen > 0 ) return -1;
+
+  if ( NULL == out ) return -1;
+
+  if( NULL == key && keylen > 0 ) return -1;
+
+  if( !outlen || outlen > BLAKE2B_OUTBYTES ) return -1;
+
+  if( keylen > BLAKE2B_KEYBYTES ) return -1;
+
+  if( keylen > 0 )
+  {
+    if( blake2b_init_key( S, outlen, key, keylen ) < 0 ) return -1;
+  }
+  else
+  {
+    if( blake2b_init( S, outlen ) < 0 ) return -1;
+  }
+
+  blake2b_update( S, ( const uint8_t * )in, inlen );
+  blake2b_final( S, out, outlen );
+  return 0;
+}
+
+int blake2( void *out, size_t outlen, const void *in, size_t inlen, const void *key, size_t keylen ) {
+  return blake2b(out, outlen, in, inlen, key, keylen);
+}
+
+#if defined(SUPERCOP)
+int crypto_hash( unsigned char *out, unsigned char *in, unsigned long long inlen )
+{
+  return blake2b( out, BLAKE2B_OUTBYTES, in, inlen, NULL, 0 );
+}
+#endif
+
+#if defined(BLAKE2B_SELFTEST)
+#include <string.h>
+#include "blake2-kat.h"
+int main( void )
+{
+  uint8_t key[BLAKE2B_KEYBYTES];
+  uint8_t buf[BLAKE2_KAT_LENGTH];
+  size_t i, step;
+
+  for( i = 0; i < BLAKE2B_KEYBYTES; ++i )
+    key[i] = ( uint8_t )i;
+
+  for( i = 0; i < BLAKE2_KAT_LENGTH; ++i )
+    buf[i] = ( uint8_t )i;
+
+  /* Test simple API */
+  for( i = 0; i < BLAKE2_KAT_LENGTH; ++i )
+  {
+    uint8_t hash[BLAKE2B_OUTBYTES];
+    blake2b( hash, BLAKE2B_OUTBYTES, buf, i, key, BLAKE2B_KEYBYTES );
+
+    if( 0 != memcmp( hash, blake2b_keyed_kat[i], BLAKE2B_OUTBYTES ) )
+    {
+      goto fail;
+    }
+  }
+
+  /* Test streaming API */
+  for(step = 1; step < BLAKE2B_BLOCKBYTES; ++step) {
+    for (i = 0; i < BLAKE2_KAT_LENGTH; ++i) {
+      uint8_t hash[BLAKE2B_OUTBYTES];
+      blake2b_state S;
+      uint8_t * p = buf;
+      size_t mlen = i;
+      int err = 0;
+
+      if( (err = blake2b_init_key(&S, BLAKE2B_OUTBYTES, key, BLAKE2B_KEYBYTES)) < 0 ) {
+        goto fail;
+      }
+
+      while (mlen >= step) {
+        if ( (err = blake2b_update(&S, p, step)) < 0 ) {
+          goto fail;
+        }
+        mlen -= step;
+        p += step;
+      }
+      if ( (err = blake2b_update(&S, p, mlen)) < 0) {
+        goto fail;
+      }
+      if ( (err = blake2b_final(&S, hash, BLAKE2B_OUTBYTES)) < 0) {
+        goto fail;
+      }
+
+      if (0 != memcmp(hash, blake2b_keyed_kat[i], BLAKE2B_OUTBYTES)) {
+        goto fail;
+      }
+    }
+  }
+
+  puts( "ok" );
+  return 0;
+fail:
+  puts("error");
+  return -1;
+}
+#endif
-- 
2.23.0

