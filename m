Return-Path: <linux-btrfs+bounces-17990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5949BEC79B
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 06:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234CA6E2331
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 04:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AF2299AB3;
	Sat, 18 Oct 2025 04:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZd8IRh/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9681F28DB49;
	Sat, 18 Oct 2025 04:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760762184; cv=none; b=FIV0D2Oi0Ysyz3wKmq9Gozy/zYnMgq3JBQzMOR4yR0c+wKG8Pk8/dgh7lIeZCSOgG3klzIuWh6JsRczHldv376pSr7VEJ6wZF6yxFPl1mhDvb8/HGBxoO8K6TK00/RA9u/eqEOBbNfuvYfnys6tOtRdpE++a23FGgEr75KfWefU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760762184; c=relaxed/simple;
	bh=gHxl67VvaUcVOiMdvSVevlWihc8hLJGPV+jMnGIubSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGZE7lUbl897lWIusgS4hQZW0oUNdJlIVhA8xGDjH6ptHUgay38wyNSN1PVT4pkP8eo0aFaSLt3MbuLqT5mYHP/+GUIbqCm/4KMuvjBDEYlp3oStkzTSAv5BGCQwX4Vo/D2KTOKJQYSIvjGAbumfn5rdpBJorUjzuAJMsofETQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZd8IRh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B79C19422;
	Sat, 18 Oct 2025 04:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760762184;
	bh=gHxl67VvaUcVOiMdvSVevlWihc8hLJGPV+jMnGIubSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZd8IRh/yUC5/1QUxx8z5l1l6TDV9bZbPYF5hNK8dRf8rXRJRZpT74duv1LVf4JHY
	 I2ZLCXidakX4inNzgdjmzIzR9IbEuFPF8OL1mKBAWj1JsTybNV2C9a2edH5AGq7Llx
	 rRc+F/eZl6WJco61B+3NdJekoOSzTMAnDpWfHBf7xmnK7x6D1PWroQ5JWQ7P6B+KBJ
	 ZY8M6y0qR4u/AlFydzu1bdMi++ffNJ1LDPOqoTAT4NtvKIERatI9J5eUMx/Yt1xklH
	 jusjDQdJDhpwLUIn1MJOIHge0/oihlxpYL8FTFT3l2cbU8yNhPTKv7w/wWd+hbu4A+
	 OCSWuwrN0jWMw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 09/10] crypto: blake2b - Reimplement using library API
Date: Fri, 17 Oct 2025 21:31:05 -0700
Message-ID: <20251018043106.375964-10-ebiggers@kernel.org>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251018043106.375964-1-ebiggers@kernel.org>
References: <20251018043106.375964-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace blake2b_generic.c with a new file blake2b.c which implements the
BLAKE2b crypto_shash algorithms on top of the BLAKE2b library API.

Change the driver name suffix from "-generic" to "-lib" to reflect that
these algorithms now just use the (possibly arch-optimized) library.

This closely mirrors crypto/{md5,sha1,sha256,sha512}.c.

Remove include/crypto/internal/blake2b.h since it is no longer used.
Likewise, remove struct blake2b_state from include/crypto/blake2b.h.

Omit support for import_core and export_core, since there are no legacy
drivers that need these for these algorithms.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/Kconfig                    |   1 +
 crypto/Makefile                   |   3 +-
 crypto/blake2b.c                  | 111 +++++++++++++++++
 crypto/blake2b_generic.c          | 192 ------------------------------
 crypto/testmgr.c                  |   4 +
 include/crypto/blake2b.h          |  10 --
 include/crypto/internal/blake2b.h | 116 ------------------
 7 files changed, 117 insertions(+), 320 deletions(-)
 create mode 100644 crypto/blake2b.c
 delete mode 100644 crypto/blake2b_generic.c
 delete mode 100644 include/crypto/internal/blake2b.h

diff --git a/crypto/Kconfig b/crypto/Kconfig
index a04595f9d0ca4..0a7e74ac870b0 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -879,10 +879,11 @@ endmenu
 menu "Hashes, digests, and MACs"
 
 config CRYPTO_BLAKE2B
 	tristate "BLAKE2b"
 	select CRYPTO_HASH
+	select CRYPTO_LIB_BLAKE2B
 	help
 	  BLAKE2b cryptographic hash function (RFC 7693)
 
 	  BLAKE2b is optimized for 64-bit platforms and can produce digests
 	  of any size between 1 and 64 bytes. The keyed hash is also implemented.
diff --git a/crypto/Makefile b/crypto/Makefile
index e430e6e99b6a2..5b02ca2cb04e0 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -81,12 +81,11 @@ obj-$(CONFIG_CRYPTO_SHA512) += sha512.o
 obj-$(CONFIG_CRYPTO_SHA3) += sha3_generic.o
 obj-$(CONFIG_CRYPTO_SM3_GENERIC) += sm3_generic.o
 obj-$(CONFIG_CRYPTO_STREEBOG) += streebog_generic.o
 obj-$(CONFIG_CRYPTO_WP512) += wp512.o
 CFLAGS_wp512.o := $(call cc-option,-fno-schedule-insns)  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=79149
-obj-$(CONFIG_CRYPTO_BLAKE2B) += blake2b_generic.o
-CFLAGS_blake2b_generic.o := -Wframe-larger-than=4096 #  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105930
+obj-$(CONFIG_CRYPTO_BLAKE2B) += blake2b.o
 obj-$(CONFIG_CRYPTO_ECB) += ecb.o
 obj-$(CONFIG_CRYPTO_CBC) += cbc.o
 obj-$(CONFIG_CRYPTO_PCBC) += pcbc.o
 obj-$(CONFIG_CRYPTO_CTS) += cts.o
 obj-$(CONFIG_CRYPTO_LRW) += lrw.o
diff --git a/crypto/blake2b.c b/crypto/blake2b.c
new file mode 100644
index 0000000000000..67a6dae43a54b
--- /dev/null
+++ b/crypto/blake2b.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Crypto API support for BLAKE2b
+ *
+ * Copyright 2025 Google LLC
+ */
+#include <crypto/blake2b.h>
+#include <crypto/internal/hash.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+struct blake2b_tfm_ctx {
+	unsigned int keylen;
+	u8 key[BLAKE2B_KEY_SIZE];
+};
+
+static int crypto_blake2b_setkey(struct crypto_shash *tfm,
+				 const u8 *key, unsigned int keylen)
+{
+	struct blake2b_tfm_ctx *tctx = crypto_shash_ctx(tfm);
+
+	if (keylen > BLAKE2B_KEY_SIZE)
+		return -EINVAL;
+	memcpy(tctx->key, key, keylen);
+	tctx->keylen = keylen;
+	return 0;
+}
+
+#define BLAKE2B_CTX(desc) ((struct blake2b_ctx *)shash_desc_ctx(desc))
+
+static int crypto_blake2b_init(struct shash_desc *desc)
+{
+	const struct blake2b_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	unsigned int digestsize = crypto_shash_digestsize(desc->tfm);
+
+	blake2b_init_key(BLAKE2B_CTX(desc), digestsize,
+			 tctx->key, tctx->keylen);
+	return 0;
+}
+
+static int crypto_blake2b_update(struct shash_desc *desc,
+				 const u8 *data, unsigned int len)
+{
+	blake2b_update(BLAKE2B_CTX(desc), data, len);
+	return 0;
+}
+
+static int crypto_blake2b_final(struct shash_desc *desc, u8 *out)
+{
+	blake2b_final(BLAKE2B_CTX(desc), out);
+	return 0;
+}
+
+static int crypto_blake2b_digest(struct shash_desc *desc,
+				 const u8 *data, unsigned int len, u8 *out)
+{
+	const struct blake2b_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	unsigned int digestsize = crypto_shash_digestsize(desc->tfm);
+
+	blake2b(tctx->key, tctx->keylen, data, len, out, digestsize);
+	return 0;
+}
+
+#define BLAKE2B_ALG(name, digest_size)					\
+	{								\
+		.base.cra_name		= name,				\
+		.base.cra_driver_name	= name "-lib",			\
+		.base.cra_priority	= 300,				\
+		.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,	\
+		.base.cra_blocksize	= BLAKE2B_BLOCK_SIZE,		\
+		.base.cra_ctxsize	= sizeof(struct blake2b_tfm_ctx), \
+		.base.cra_module	= THIS_MODULE,			\
+		.digestsize		= digest_size,			\
+		.setkey			= crypto_blake2b_setkey,	\
+		.init			= crypto_blake2b_init,		\
+		.update			= crypto_blake2b_update,	\
+		.final			= crypto_blake2b_final,		\
+		.digest			= crypto_blake2b_digest,	\
+		.descsize		= sizeof(struct blake2b_ctx),	\
+	}
+
+static struct shash_alg algs[] = {
+	BLAKE2B_ALG("blake2b-160", BLAKE2B_160_HASH_SIZE),
+	BLAKE2B_ALG("blake2b-256", BLAKE2B_256_HASH_SIZE),
+	BLAKE2B_ALG("blake2b-384", BLAKE2B_384_HASH_SIZE),
+	BLAKE2B_ALG("blake2b-512", BLAKE2B_512_HASH_SIZE),
+};
+
+static int __init crypto_blake2b_mod_init(void)
+{
+	return crypto_register_shashes(algs, ARRAY_SIZE(algs));
+}
+module_init(crypto_blake2b_mod_init);
+
+static void __exit crypto_blake2b_mod_exit(void)
+{
+	crypto_unregister_shashes(algs, ARRAY_SIZE(algs));
+}
+module_exit(crypto_blake2b_mod_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Crypto API support for BLAKE2b");
+
+MODULE_ALIAS_CRYPTO("blake2b-160");
+MODULE_ALIAS_CRYPTO("blake2b-160-lib");
+MODULE_ALIAS_CRYPTO("blake2b-256");
+MODULE_ALIAS_CRYPTO("blake2b-256-lib");
+MODULE_ALIAS_CRYPTO("blake2b-384");
+MODULE_ALIAS_CRYPTO("blake2b-384-lib");
+MODULE_ALIAS_CRYPTO("blake2b-512");
+MODULE_ALIAS_CRYPTO("blake2b-512-lib");
diff --git a/crypto/blake2b_generic.c b/crypto/blake2b_generic.c
deleted file mode 100644
index 60f0562175104..0000000000000
--- a/crypto/blake2b_generic.c
+++ /dev/null
@@ -1,192 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0-only OR Apache-2.0)
-/*
- * Generic implementation of the BLAKE2b digest algorithm.  Based on the BLAKE2b
- * reference implementation, but it has been heavily modified for use in the
- * kernel.  The reference implementation was:
- *
- *	Copyright 2012, Samuel Neves <sneves@dei.uc.pt>.  You may use this under
- *	the terms of the CC0, the OpenSSL Licence, or the Apache Public License
- *	2.0, at your option.  The terms of these licenses can be found at:
- *
- *	- CC0 1.0 Universal : http://creativecommons.org/publicdomain/zero/1.0
- *	- OpenSSL license   : https://www.openssl.org/source/license.html
- *	- Apache 2.0        : https://www.apache.org/licenses/LICENSE-2.0
- *
- * More information about BLAKE2 can be found at https://blake2.net.
- */
-
-#include <crypto/internal/blake2b.h>
-#include <crypto/internal/hash.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/unaligned.h>
-
-static const u8 blake2b_sigma[12][16] = {
-	{  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15 },
-	{ 14, 10,  4,  8,  9, 15, 13,  6,  1, 12,  0,  2, 11,  7,  5,  3 },
-	{ 11,  8, 12,  0,  5,  2, 15, 13, 10, 14,  3,  6,  7,  1,  9,  4 },
-	{  7,  9,  3,  1, 13, 12, 11, 14,  2,  6,  5, 10,  4,  0, 15,  8 },
-	{  9,  0,  5,  7,  2,  4, 10, 15, 14,  1, 11, 12,  6,  8,  3, 13 },
-	{  2, 12,  6, 10,  0, 11,  8,  3,  4, 13,  7,  5, 15, 14,  1,  9 },
-	{ 12,  5,  1, 15, 14, 13,  4, 10,  0,  7,  6,  3,  9,  2,  8, 11 },
-	{ 13, 11,  7, 14, 12,  1,  3,  9,  5,  0, 15,  4,  8,  6,  2, 10 },
-	{  6, 15, 14,  9, 11,  3,  0,  8, 12,  2, 13,  7,  1,  4, 10,  5 },
-	{ 10,  2,  8,  4,  7,  6,  1,  5, 15, 11,  9, 14,  3, 12, 13,  0 },
-	{  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15 },
-	{ 14, 10,  4,  8,  9, 15, 13,  6,  1, 12,  0,  2, 11,  7,  5,  3 }
-};
-
-static void blake2b_increment_counter(struct blake2b_state *S, const u64 inc)
-{
-	S->t[0] += inc;
-	S->t[1] += (S->t[0] < inc);
-}
-
-#define G(r,i,a,b,c,d)                                  \
-	do {                                            \
-		a = a + b + m[blake2b_sigma[r][2*i+0]]; \
-		d = ror64(d ^ a, 32);                   \
-		c = c + d;                              \
-		b = ror64(b ^ c, 24);                   \
-		a = a + b + m[blake2b_sigma[r][2*i+1]]; \
-		d = ror64(d ^ a, 16);                   \
-		c = c + d;                              \
-		b = ror64(b ^ c, 63);                   \
-	} while (0)
-
-#define ROUND(r)                                \
-	do {                                    \
-		G(r,0,v[ 0],v[ 4],v[ 8],v[12]); \
-		G(r,1,v[ 1],v[ 5],v[ 9],v[13]); \
-		G(r,2,v[ 2],v[ 6],v[10],v[14]); \
-		G(r,3,v[ 3],v[ 7],v[11],v[15]); \
-		G(r,4,v[ 0],v[ 5],v[10],v[15]); \
-		G(r,5,v[ 1],v[ 6],v[11],v[12]); \
-		G(r,6,v[ 2],v[ 7],v[ 8],v[13]); \
-		G(r,7,v[ 3],v[ 4],v[ 9],v[14]); \
-	} while (0)
-
-static void blake2b_compress_one_generic(struct blake2b_state *S,
-					 const u8 block[BLAKE2B_BLOCK_SIZE])
-{
-	u64 m[16];
-	u64 v[16];
-	size_t i;
-
-	for (i = 0; i < 16; ++i)
-		m[i] = get_unaligned_le64(block + i * sizeof(m[i]));
-
-	for (i = 0; i < 8; ++i)
-		v[i] = S->h[i];
-
-	v[ 8] = BLAKE2B_IV0;
-	v[ 9] = BLAKE2B_IV1;
-	v[10] = BLAKE2B_IV2;
-	v[11] = BLAKE2B_IV3;
-	v[12] = BLAKE2B_IV4 ^ S->t[0];
-	v[13] = BLAKE2B_IV5 ^ S->t[1];
-	v[14] = BLAKE2B_IV6 ^ S->f[0];
-	v[15] = BLAKE2B_IV7 ^ S->f[1];
-
-	ROUND(0);
-	ROUND(1);
-	ROUND(2);
-	ROUND(3);
-	ROUND(4);
-	ROUND(5);
-	ROUND(6);
-	ROUND(7);
-	ROUND(8);
-	ROUND(9);
-	ROUND(10);
-	ROUND(11);
-#ifdef CONFIG_CC_IS_CLANG
-#pragma nounroll /* https://llvm.org/pr45803 */
-#endif
-	for (i = 0; i < 8; ++i)
-		S->h[i] = S->h[i] ^ v[i] ^ v[i + 8];
-}
-
-#undef G
-#undef ROUND
-
-static void blake2b_compress_generic(struct blake2b_state *state,
-				     const u8 *block, size_t nblocks, u32 inc)
-{
-	do {
-		blake2b_increment_counter(state, inc);
-		blake2b_compress_one_generic(state, block);
-		block += BLAKE2B_BLOCK_SIZE;
-	} while (--nblocks);
-}
-
-static int crypto_blake2b_update_generic(struct shash_desc *desc,
-					 const u8 *in, unsigned int inlen)
-{
-	return crypto_blake2b_update_bo(desc, in, inlen,
-					blake2b_compress_generic);
-}
-
-static int crypto_blake2b_finup_generic(struct shash_desc *desc, const u8 *in,
-					unsigned int inlen, u8 *out)
-{
-	return crypto_blake2b_finup(desc, in, inlen, out,
-				    blake2b_compress_generic);
-}
-
-#define BLAKE2B_ALG(name, driver_name, digest_size)			\
-	{								\
-		.base.cra_name		= name,				\
-		.base.cra_driver_name	= driver_name,			\
-		.base.cra_priority	= 100,				\
-		.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY |	\
-					  CRYPTO_AHASH_ALG_BLOCK_ONLY |	\
-					  CRYPTO_AHASH_ALG_FINAL_NONZERO, \
-		.base.cra_blocksize	= BLAKE2B_BLOCK_SIZE,		\
-		.base.cra_ctxsize	= sizeof(struct blake2b_tfm_ctx), \
-		.base.cra_module	= THIS_MODULE,			\
-		.digestsize		= digest_size,			\
-		.setkey			= crypto_blake2b_setkey,	\
-		.init			= crypto_blake2b_init,		\
-		.update			= crypto_blake2b_update_generic, \
-		.finup			= crypto_blake2b_finup_generic,	\
-		.descsize		= BLAKE2B_DESC_SIZE,		\
-		.statesize		= BLAKE2B_STATE_SIZE,		\
-	}
-
-static struct shash_alg blake2b_algs[] = {
-	BLAKE2B_ALG("blake2b-160", "blake2b-160-generic",
-		    BLAKE2B_160_HASH_SIZE),
-	BLAKE2B_ALG("blake2b-256", "blake2b-256-generic",
-		    BLAKE2B_256_HASH_SIZE),
-	BLAKE2B_ALG("blake2b-384", "blake2b-384-generic",
-		    BLAKE2B_384_HASH_SIZE),
-	BLAKE2B_ALG("blake2b-512", "blake2b-512-generic",
-		    BLAKE2B_512_HASH_SIZE),
-};
-
-static int __init blake2b_mod_init(void)
-{
-	return crypto_register_shashes(blake2b_algs, ARRAY_SIZE(blake2b_algs));
-}
-
-static void __exit blake2b_mod_fini(void)
-{
-	crypto_unregister_shashes(blake2b_algs, ARRAY_SIZE(blake2b_algs));
-}
-
-module_init(blake2b_mod_init);
-module_exit(blake2b_mod_fini);
-
-MODULE_AUTHOR("David Sterba <kdave@kernel.org>");
-MODULE_DESCRIPTION("BLAKE2b generic implementation");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_CRYPTO("blake2b-160");
-MODULE_ALIAS_CRYPTO("blake2b-160-generic");
-MODULE_ALIAS_CRYPTO("blake2b-256");
-MODULE_ALIAS_CRYPTO("blake2b-256-generic");
-MODULE_ALIAS_CRYPTO("blake2b-384");
-MODULE_ALIAS_CRYPTO("blake2b-384-generic");
-MODULE_ALIAS_CRYPTO("blake2b-512");
-MODULE_ALIAS_CRYPTO("blake2b-512-generic");
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 6a490aaa71b9a..3ab7adc1cdce5 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4330,31 +4330,35 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.alg = "authenc(hmac(sha512),rfc3686(ctr(aes)))",
 		.test = alg_test_null,
 		.fips_allowed = 1,
 	}, {
 		.alg = "blake2b-160",
+		.generic_driver = "blake2b-160-lib",
 		.test = alg_test_hash,
 		.fips_allowed = 0,
 		.suite = {
 			.hash = __VECS(blake2b_160_tv_template)
 		}
 	}, {
 		.alg = "blake2b-256",
+		.generic_driver = "blake2b-256-lib",
 		.test = alg_test_hash,
 		.fips_allowed = 0,
 		.suite = {
 			.hash = __VECS(blake2b_256_tv_template)
 		}
 	}, {
 		.alg = "blake2b-384",
+		.generic_driver = "blake2b-384-lib",
 		.test = alg_test_hash,
 		.fips_allowed = 0,
 		.suite = {
 			.hash = __VECS(blake2b_384_tv_template)
 		}
 	}, {
 		.alg = "blake2b-512",
+		.generic_driver = "blake2b-512-lib",
 		.test = alg_test_hash,
 		.fips_allowed = 0,
 		.suite = {
 			.hash = __VECS(blake2b_512_tv_template)
 		}
diff --git a/include/crypto/blake2b.h b/include/crypto/blake2b.h
index 4879e2ec26867..3bc37fd103a7a 100644
--- a/include/crypto/blake2b.h
+++ b/include/crypto/blake2b.h
@@ -5,24 +5,14 @@
 
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/string.h>
 
-struct blake2b_state {
-	/* 'h', 't', and 'f' are used in assembly code, so keep them as-is. */
-	u64 h[8];
-	u64 t[2];
-	/* The true state ends here.  The rest is temporary storage. */
-	u64 f[2];
-};
-
 enum blake2b_lengths {
 	BLAKE2B_BLOCK_SIZE = 128,
 	BLAKE2B_HASH_SIZE = 64,
 	BLAKE2B_KEY_SIZE = 64,
-	BLAKE2B_STATE_SIZE = offsetof(struct blake2b_state, f),
-	BLAKE2B_DESC_SIZE = sizeof(struct blake2b_state),
 
 	BLAKE2B_160_HASH_SIZE = 20,
 	BLAKE2B_256_HASH_SIZE = 32,
 	BLAKE2B_384_HASH_SIZE = 48,
 	BLAKE2B_512_HASH_SIZE = 64,
diff --git a/include/crypto/internal/blake2b.h b/include/crypto/internal/blake2b.h
deleted file mode 100644
index 3712df69def18..0000000000000
--- a/include/crypto/internal/blake2b.h
+++ /dev/null
@@ -1,116 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR MIT */
-/*
- * Helper functions for BLAKE2b implementations.
- * Keep this in sync with the corresponding BLAKE2s header.
- */
-
-#ifndef _CRYPTO_INTERNAL_BLAKE2B_H
-#define _CRYPTO_INTERNAL_BLAKE2B_H
-
-#include <asm/byteorder.h>
-#include <crypto/blake2b.h>
-#include <crypto/internal/hash.h>
-#include <linux/array_size.h>
-#include <linux/compiler.h>
-#include <linux/build_bug.h>
-#include <linux/errno.h>
-#include <linux/math.h>
-#include <linux/string.h>
-#include <linux/types.h>
-
-static inline void blake2b_set_lastblock(struct blake2b_state *state)
-{
-	state->f[0] = -1;
-	state->f[1] = 0;
-}
-
-static inline void blake2b_set_nonlast(struct blake2b_state *state)
-{
-	state->f[0] = 0;
-	state->f[1] = 0;
-}
-
-typedef void (*blake2b_compress_t)(struct blake2b_state *state,
-				   const u8 *block, size_t nblocks, u32 inc);
-
-/* Helper functions for shash implementations of BLAKE2b */
-
-struct blake2b_tfm_ctx {
-	u8 key[BLAKE2B_BLOCK_SIZE];
-	unsigned int keylen;
-};
-
-static inline int crypto_blake2b_setkey(struct crypto_shash *tfm,
-					const u8 *key, unsigned int keylen)
-{
-	struct blake2b_tfm_ctx *tctx = crypto_shash_ctx(tfm);
-
-	if (keylen > BLAKE2B_KEY_SIZE)
-		return -EINVAL;
-
-	BUILD_BUG_ON(BLAKE2B_KEY_SIZE > BLAKE2B_BLOCK_SIZE);
-
-	memcpy(tctx->key, key, keylen);
-	memset(tctx->key + keylen, 0, BLAKE2B_BLOCK_SIZE - keylen);
-	tctx->keylen = keylen;
-
-	return 0;
-}
-
-static inline void __crypto_blake2b_init(struct blake2b_state *state,
-					 size_t outlen, size_t keylen)
-{
-	state->h[0] = BLAKE2B_IV0 ^ (0x01010000 | keylen << 8 | outlen);
-	state->h[1] = BLAKE2B_IV1;
-	state->h[2] = BLAKE2B_IV2;
-	state->h[3] = BLAKE2B_IV3;
-	state->h[4] = BLAKE2B_IV4;
-	state->h[5] = BLAKE2B_IV5;
-	state->h[6] = BLAKE2B_IV6;
-	state->h[7] = BLAKE2B_IV7;
-	state->t[0] = 0;
-	state->t[1] = 0;
-}
-
-static inline int crypto_blake2b_init(struct shash_desc *desc)
-{
-	const struct blake2b_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
-	struct blake2b_state *state = shash_desc_ctx(desc);
-	unsigned int outlen = crypto_shash_digestsize(desc->tfm);
-
-	__crypto_blake2b_init(state, outlen, tctx->keylen);
-	return tctx->keylen ?
-	       crypto_shash_update(desc, tctx->key, BLAKE2B_BLOCK_SIZE) : 0;
-}
-
-static inline int crypto_blake2b_update_bo(struct shash_desc *desc,
-					   const u8 *in, unsigned int inlen,
-					   blake2b_compress_t compress)
-{
-	struct blake2b_state *state = shash_desc_ctx(desc);
-
-	blake2b_set_nonlast(state);
-	compress(state, in, inlen / BLAKE2B_BLOCK_SIZE, BLAKE2B_BLOCK_SIZE);
-	return inlen - round_down(inlen, BLAKE2B_BLOCK_SIZE);
-}
-
-static inline int crypto_blake2b_finup(struct shash_desc *desc, const u8 *in,
-				       unsigned int inlen, u8 *out,
-				       blake2b_compress_t compress)
-{
-	struct blake2b_state *state = shash_desc_ctx(desc);
-	u8 buf[BLAKE2B_BLOCK_SIZE];
-	int i;
-
-	memcpy(buf, in, inlen);
-	memset(buf + inlen, 0, BLAKE2B_BLOCK_SIZE - inlen);
-	blake2b_set_lastblock(state);
-	compress(state, buf, 1, inlen);
-	for (i = 0; i < ARRAY_SIZE(state->h); i++)
-		__cpu_to_le64s(&state->h[i]);
-	memcpy(out, state->h, crypto_shash_digestsize(desc->tfm));
-	memzero_explicit(buf, sizeof(buf));
-	return 0;
-}
-
-#endif /* _CRYPTO_INTERNAL_BLAKE2B_H */
-- 
2.51.1.dirty


