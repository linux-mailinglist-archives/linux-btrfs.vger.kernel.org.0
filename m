Return-Path: <linux-btrfs+bounces-17987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F25BEC783
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 06:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7126E2629
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 04:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B77B28CF66;
	Sat, 18 Oct 2025 04:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDz/xzp8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC99C28506F;
	Sat, 18 Oct 2025 04:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760762183; cv=none; b=e8A6EUPFJ7L1UrDLMJgOeiGztbV0+Awyvu0Qxn/Jz3wbP4Ya3F4sX9aIZ2dXaSE4/TVV+XLiALTGRSupECKxmw/5eeRxYmvNqgz9c3s6CBdwZOUXXIZ5LZK1PMQnu9i7rmSpWDRnYib1jacwNWTFIfNVcWDTRqIa+m4kNbrdssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760762183; c=relaxed/simple;
	bh=/JwiNbJDKbRFYE+Zq0Bj+ifiGxJlAiciGRgJis3Y+UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTsQQaEQJy8RFEklxRzkBlUvgAUeowF8GFKz6sfgENb807YP0jBmmsHFv8hlkesixxqS2SwH4PcK8x4EN15QaXRrrw3OtqpmC1hTzoklhA7S4zoCuBl6Dp6It6CLdiRN/ZD9DvEnXXIBNw1iyQW5E42NCdV3FFDNA+gO1GEw25w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDz/xzp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B2EC116C6;
	Sat, 18 Oct 2025 04:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760762183;
	bh=/JwiNbJDKbRFYE+Zq0Bj+ifiGxJlAiciGRgJis3Y+UE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hDz/xzp8YliPTDNMF/FAox/aNpRDQxTAgRRYGcWe7YG40nUEC9RRqD64j0ZI03uWs
	 fSynJHjlFF5AhzJDq2iPoUrDqZG0Ky0EwlbLzFeK1lEIZhNF80ytyOWw6cyL/PUvvX
	 6EHx18yB6oNsK56wkCKwNsE4sJV4X0NhXFxVX7Ttd5pIoAEcZNF+ujq9LHHRXPcZqX
	 5HpTB74t5HK0wXkMOZKxY11Suyx36bBuoWZG58WNa/5OviMGkzPlQnedtmptNuO+Hf
	 GoJqptFK3yec+j1RY31G1iF82iXIsVcx6U1ZbKz2x2fv6IUPd1opZGLsgfpRtNkZlq
	 PGiZzfBevCn8g==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 06/10] lib/crypto: blake2b: Add BLAKE2b library functions
Date: Fri, 17 Oct 2025 21:31:02 -0700
Message-ID: <20251018043106.375964-7-ebiggers@kernel.org>
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

Add a library API for BLAKE2b, closely modeled after the BLAKE2s API.

This will allow in-kernel users such as btrfs to use BLAKE2b without
going through the generic crypto layer.  In addition, as usual the
BLAKE2b crypto_shash algorithms will be reimplemented on top of this.

Note: to create lib/crypto/blake2b.c I made a copy of
lib/crypto/blake2s.c and made the updates from BLAKE2s => BLAKE2b.  This
way, the BLAKE2s and BLAKE2b code is kept consistent.  Therefore, it
borrows the SPDX-License-Identifier and Copyright from
lib/crypto/blake2s.c rather than crypto/blake2b_generic.c.

The library API uses 'struct blake2b_ctx', consistent with other
lib/crypto/ APIs.  The existing 'struct blake2b_state' will be removed
once the blake2b crypto_shash algorithms are updated to stop using it.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/crypto/blake2b.h          | 133 ++++++++++++++++++++---
 include/crypto/internal/blake2b.h |  17 ++-
 lib/crypto/Kconfig                |  10 ++
 lib/crypto/Makefile               |   9 ++
 lib/crypto/blake2b.c              | 174 ++++++++++++++++++++++++++++++
 5 files changed, 330 insertions(+), 13 deletions(-)
 create mode 100644 lib/crypto/blake2b.c

diff --git a/include/crypto/blake2b.h b/include/crypto/blake2b.h
index dd7694477e50f..4879e2ec26867 100644
--- a/include/crypto/blake2b.h
+++ b/include/crypto/blake2b.h
@@ -26,10 +26,29 @@ enum blake2b_lengths {
 	BLAKE2B_256_HASH_SIZE = 32,
 	BLAKE2B_384_HASH_SIZE = 48,
 	BLAKE2B_512_HASH_SIZE = 64,
 };
 
+/**
+ * struct blake2b_ctx - Context for hashing a message with BLAKE2b
+ * @h: compression function state
+ * @t: block counter
+ * @f: finalization indicator
+ * @buf: partial block buffer; 'buflen' bytes are valid
+ * @buflen: number of bytes buffered in @buf
+ * @outlen: length of output hash value in bytes, at most BLAKE2B_HASH_SIZE
+ */
+struct blake2b_ctx {
+	/* 'h', 't', and 'f' are used in assembly code, so keep them as-is. */
+	u64 h[8];
+	u64 t[2];
+	u64 f[2];
+	u8 buf[BLAKE2B_BLOCK_SIZE];
+	unsigned int buflen;
+	unsigned int outlen;
+};
+
 enum blake2b_iv {
 	BLAKE2B_IV0 = 0x6A09E667F3BCC908ULL,
 	BLAKE2B_IV1 = 0xBB67AE8584CAA73BULL,
 	BLAKE2B_IV2 = 0x3C6EF372FE94F82BULL,
 	BLAKE2B_IV3 = 0xA54FF53A5F1D36F1ULL,
@@ -37,21 +56,111 @@ enum blake2b_iv {
 	BLAKE2B_IV5 = 0x9B05688C2B3E6C1FULL,
 	BLAKE2B_IV6 = 0x1F83D9ABFB41BD6BULL,
 	BLAKE2B_IV7 = 0x5BE0CD19137E2179ULL,
 };
 
-static inline void __blake2b_init(struct blake2b_state *state, size_t outlen,
-				  size_t keylen)
+static inline void __blake2b_init(struct blake2b_ctx *ctx, size_t outlen,
+				  const void *key, size_t keylen)
+{
+	ctx->h[0] = BLAKE2B_IV0 ^ (0x01010000 | keylen << 8 | outlen);
+	ctx->h[1] = BLAKE2B_IV1;
+	ctx->h[2] = BLAKE2B_IV2;
+	ctx->h[3] = BLAKE2B_IV3;
+	ctx->h[4] = BLAKE2B_IV4;
+	ctx->h[5] = BLAKE2B_IV5;
+	ctx->h[6] = BLAKE2B_IV6;
+	ctx->h[7] = BLAKE2B_IV7;
+	ctx->t[0] = 0;
+	ctx->t[1] = 0;
+	ctx->f[0] = 0;
+	ctx->f[1] = 0;
+	ctx->buflen = 0;
+	ctx->outlen = outlen;
+	if (keylen) {
+		memcpy(ctx->buf, key, keylen);
+		memset(&ctx->buf[keylen], 0, BLAKE2B_BLOCK_SIZE - keylen);
+		ctx->buflen = BLAKE2B_BLOCK_SIZE;
+	}
+}
+
+/**
+ * blake2b_init() - Initialize a BLAKE2b context for a new message (unkeyed)
+ * @ctx: the context to initialize
+ * @outlen: length of output hash value in bytes, at most BLAKE2B_HASH_SIZE
+ *
+ * Context: Any context.
+ */
+static inline void blake2b_init(struct blake2b_ctx *ctx, size_t outlen)
+{
+	__blake2b_init(ctx, outlen, NULL, 0);
+}
+
+/**
+ * blake2b_init_key() - Initialize a BLAKE2b context for a new message (keyed)
+ * @ctx: the context to initialize
+ * @outlen: length of output hash value in bytes, at most BLAKE2B_HASH_SIZE
+ * @key: the key
+ * @keylen: the key length in bytes, at most BLAKE2B_KEY_SIZE
+ *
+ * Context: Any context.
+ */
+static inline void blake2b_init_key(struct blake2b_ctx *ctx, size_t outlen,
+				    const void *key, size_t keylen)
+{
+	WARN_ON(IS_ENABLED(DEBUG) && (!outlen || outlen > BLAKE2B_HASH_SIZE ||
+		!key || !keylen || keylen > BLAKE2B_KEY_SIZE));
+
+	__blake2b_init(ctx, outlen, key, keylen);
+}
+
+/**
+ * blake2b_update() - Update a BLAKE2b context with message data
+ * @ctx: the context to update; must have been initialized
+ * @in: the message data
+ * @inlen: the data length in bytes
+ *
+ * This can be called any number of times.
+ *
+ * Context: Any context.
+ */
+void blake2b_update(struct blake2b_ctx *ctx, const u8 *in, size_t inlen);
+
+/**
+ * blake2b_final() - Finish computing a BLAKE2b hash
+ * @ctx: the context to finalize; must have been initialized
+ * @out: (output) the resulting BLAKE2b hash.  Its length will be equal to the
+ *	 @outlen that was passed to blake2b_init() or blake2b_init_key().
+ *
+ * After finishing, this zeroizes @ctx.  So the caller does not need to do it.
+ *
+ * Context: Any context.
+ */
+void blake2b_final(struct blake2b_ctx *ctx, u8 *out);
+
+/**
+ * blake2b() - Compute BLAKE2b hash in one shot
+ * @key: the key, or NULL for an unkeyed hash
+ * @keylen: the key length in bytes (at most BLAKE2B_KEY_SIZE), or 0 for an
+ *	    unkeyed hash
+ * @in: the message data
+ * @inlen: the data length in bytes
+ * @out: (output) the resulting BLAKE2b hash, with length @outlen
+ * @outlen: length of output hash value in bytes, at most BLAKE2B_HASH_SIZE
+ *
+ * Context: Any context.
+ */
+static inline void blake2b(const u8 *key, size_t keylen,
+			   const u8 *in, size_t inlen,
+			   u8 *out, size_t outlen)
 {
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
+	struct blake2b_ctx ctx;
+
+	WARN_ON(IS_ENABLED(DEBUG) && ((!in && inlen > 0) || !out || !outlen ||
+		outlen > BLAKE2B_HASH_SIZE || keylen > BLAKE2B_KEY_SIZE ||
+		(!key && keylen)));
+
+	__blake2b_init(&ctx, outlen, key, keylen);
+	blake2b_update(&ctx, in, inlen);
+	blake2b_final(&ctx, out);
 }
 
 #endif /* _CRYPTO_BLAKE2B_H */
diff --git a/include/crypto/internal/blake2b.h b/include/crypto/internal/blake2b.h
index 3e09e24853060..3712df69def18 100644
--- a/include/crypto/internal/blake2b.h
+++ b/include/crypto/internal/blake2b.h
@@ -55,17 +55,32 @@ static inline int crypto_blake2b_setkey(struct crypto_shash *tfm,
 	tctx->keylen = keylen;
 
 	return 0;
 }
 
+static inline void __crypto_blake2b_init(struct blake2b_state *state,
+					 size_t outlen, size_t keylen)
+{
+	state->h[0] = BLAKE2B_IV0 ^ (0x01010000 | keylen << 8 | outlen);
+	state->h[1] = BLAKE2B_IV1;
+	state->h[2] = BLAKE2B_IV2;
+	state->h[3] = BLAKE2B_IV3;
+	state->h[4] = BLAKE2B_IV4;
+	state->h[5] = BLAKE2B_IV5;
+	state->h[6] = BLAKE2B_IV6;
+	state->h[7] = BLAKE2B_IV7;
+	state->t[0] = 0;
+	state->t[1] = 0;
+}
+
 static inline int crypto_blake2b_init(struct shash_desc *desc)
 {
 	const struct blake2b_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
 	struct blake2b_state *state = shash_desc_ctx(desc);
 	unsigned int outlen = crypto_shash_digestsize(desc->tfm);
 
-	__blake2b_init(state, outlen, tctx->keylen);
+	__crypto_blake2b_init(state, outlen, tctx->keylen);
 	return tctx->keylen ?
 	       crypto_shash_update(desc, tctx->key, BLAKE2B_BLOCK_SIZE) : 0;
 }
 
 static inline int crypto_blake2b_update_bo(struct shash_desc *desc,
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index eea17e36a22be..045fd79cc1bed 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -26,10 +26,20 @@ config CRYPTO_LIB_ARC4
 	tristate
 
 config CRYPTO_LIB_GF128MUL
 	tristate
 
+config CRYPTO_LIB_BLAKE2B
+	tristate
+	help
+	  The BLAKE2b library functions.  Select this if your module uses any of
+	  the functions from <crypto/blake2b.h>.
+
+config CRYPTO_LIB_BLAKE2B_ARCH
+	bool
+	depends on CRYPTO_LIB_BLAKE2B && !UML
+
 # BLAKE2s support is always built-in, so there's no CRYPTO_LIB_BLAKE2S option.
 
 config CRYPTO_LIB_BLAKE2S_ARCH
 	bool
 	depends on !UML
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index bded351aeacef..f863417b16817 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -29,10 +29,19 @@ libarc4-y					:= arc4.o
 
 obj-$(CONFIG_CRYPTO_LIB_GF128MUL)		+= gf128mul.o
 
 ################################################################################
 
+obj-$(CONFIG_CRYPTO_LIB_BLAKE2B) += libblake2b.o
+libblake2b-y := blake2b.o
+CFLAGS_blake2b.o := -Wframe-larger-than=4096 #  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105930
+ifeq ($(CONFIG_CRYPTO_LIB_BLAKE2B_ARCH),y)
+CFLAGS_blake2b.o += -I$(src)/$(SRCARCH)
+endif # CONFIG_CRYPTO_LIB_BLAKE2B_ARCH
+
+################################################################################
+
 # blake2s is used by the /dev/random driver which is always builtin
 obj-y += blake2s.o
 ifeq ($(CONFIG_CRYPTO_LIB_BLAKE2S_ARCH),y)
 CFLAGS_blake2s.o += -I$(src)/$(SRCARCH)
 obj-$(CONFIG_ARM) += arm/blake2s-core.o
diff --git a/lib/crypto/blake2b.c b/lib/crypto/blake2b.c
new file mode 100644
index 0000000000000..09c6d65d8a6e6
--- /dev/null
+++ b/lib/crypto/blake2b.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ * Copyright 2025 Google LLC
+ *
+ * This is an implementation of the BLAKE2b hash and PRF functions.
+ *
+ * Information: https://blake2.net/
+ */
+
+#include <crypto/blake2b.h>
+#include <linux/bug.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+static const u8 blake2b_sigma[12][16] = {
+	{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
+	{ 14, 10, 4, 8, 9, 15, 13, 6, 1, 12, 0, 2, 11, 7, 5, 3 },
+	{ 11, 8, 12, 0, 5, 2, 15, 13, 10, 14, 3, 6, 7, 1, 9, 4 },
+	{ 7, 9, 3, 1, 13, 12, 11, 14, 2, 6, 5, 10, 4, 0, 15, 8 },
+	{ 9, 0, 5, 7, 2, 4, 10, 15, 14, 1, 11, 12, 6, 8, 3, 13 },
+	{ 2, 12, 6, 10, 0, 11, 8, 3, 4, 13, 7, 5, 15, 14, 1, 9 },
+	{ 12, 5, 1, 15, 14, 13, 4, 10, 0, 7, 6, 3, 9, 2, 8, 11 },
+	{ 13, 11, 7, 14, 12, 1, 3, 9, 5, 0, 15, 4, 8, 6, 2, 10 },
+	{ 6, 15, 14, 9, 11, 3, 0, 8, 12, 2, 13, 7, 1, 4, 10, 5 },
+	{ 10, 2, 8, 4, 7, 6, 1, 5, 15, 11, 9, 14, 3, 12, 13, 0 },
+	{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
+	{ 14, 10, 4, 8, 9, 15, 13, 6, 1, 12, 0, 2, 11, 7, 5, 3 }
+};
+
+static inline void blake2b_increment_counter(struct blake2b_ctx *ctx, u32 inc)
+{
+	ctx->t[0] += inc;
+	ctx->t[1] += (ctx->t[0] < inc);
+}
+
+static void __maybe_unused
+blake2b_compress_generic(struct blake2b_ctx *ctx,
+			 const u8 *data, size_t nblocks, u32 inc)
+{
+	u64 m[16];
+	u64 v[16];
+	int i;
+
+	WARN_ON(IS_ENABLED(DEBUG) &&
+		(nblocks > 1 && inc != BLAKE2B_BLOCK_SIZE));
+
+	while (nblocks > 0) {
+		blake2b_increment_counter(ctx, inc);
+		memcpy(m, data, BLAKE2B_BLOCK_SIZE);
+		le64_to_cpu_array(m, ARRAY_SIZE(m));
+		memcpy(v, ctx->h, 64);
+		v[ 8] = BLAKE2B_IV0;
+		v[ 9] = BLAKE2B_IV1;
+		v[10] = BLAKE2B_IV2;
+		v[11] = BLAKE2B_IV3;
+		v[12] = BLAKE2B_IV4 ^ ctx->t[0];
+		v[13] = BLAKE2B_IV5 ^ ctx->t[1];
+		v[14] = BLAKE2B_IV6 ^ ctx->f[0];
+		v[15] = BLAKE2B_IV7 ^ ctx->f[1];
+
+#define G(r, i, a, b, c, d) do { \
+	a += b + m[blake2b_sigma[r][2 * i + 0]]; \
+	d = ror64(d ^ a, 32); \
+	c += d; \
+	b = ror64(b ^ c, 24); \
+	a += b + m[blake2b_sigma[r][2 * i + 1]]; \
+	d = ror64(d ^ a, 16); \
+	c += d; \
+	b = ror64(b ^ c, 63); \
+} while (0)
+
+#define ROUND(r) do { \
+	G(r, 0, v[0], v[ 4], v[ 8], v[12]); \
+	G(r, 1, v[1], v[ 5], v[ 9], v[13]); \
+	G(r, 2, v[2], v[ 6], v[10], v[14]); \
+	G(r, 3, v[3], v[ 7], v[11], v[15]); \
+	G(r, 4, v[0], v[ 5], v[10], v[15]); \
+	G(r, 5, v[1], v[ 6], v[11], v[12]); \
+	G(r, 6, v[2], v[ 7], v[ 8], v[13]); \
+	G(r, 7, v[3], v[ 4], v[ 9], v[14]); \
+} while (0)
+		ROUND(0);
+		ROUND(1);
+		ROUND(2);
+		ROUND(3);
+		ROUND(4);
+		ROUND(5);
+		ROUND(6);
+		ROUND(7);
+		ROUND(8);
+		ROUND(9);
+		ROUND(10);
+		ROUND(11);
+
+#undef G
+#undef ROUND
+
+		for (i = 0; i < 8; ++i)
+			ctx->h[i] ^= v[i] ^ v[i + 8];
+
+		data += BLAKE2B_BLOCK_SIZE;
+		--nblocks;
+	}
+}
+
+#ifdef CONFIG_CRYPTO_LIB_BLAKE2B_ARCH
+#include "blake2b.h" /* $(SRCARCH)/blake2b.h */
+#else
+#define blake2b_compress blake2b_compress_generic
+#endif
+
+static inline void blake2b_set_lastblock(struct blake2b_ctx *ctx)
+{
+	ctx->f[0] = -1;
+}
+
+void blake2b_update(struct blake2b_ctx *ctx, const u8 *in, size_t inlen)
+{
+	const size_t fill = BLAKE2B_BLOCK_SIZE - ctx->buflen;
+
+	if (unlikely(!inlen))
+		return;
+	if (inlen > fill) {
+		memcpy(ctx->buf + ctx->buflen, in, fill);
+		blake2b_compress(ctx, ctx->buf, 1, BLAKE2B_BLOCK_SIZE);
+		ctx->buflen = 0;
+		in += fill;
+		inlen -= fill;
+	}
+	if (inlen > BLAKE2B_BLOCK_SIZE) {
+		const size_t nblocks = DIV_ROUND_UP(inlen, BLAKE2B_BLOCK_SIZE);
+
+		blake2b_compress(ctx, in, nblocks - 1, BLAKE2B_BLOCK_SIZE);
+		in += BLAKE2B_BLOCK_SIZE * (nblocks - 1);
+		inlen -= BLAKE2B_BLOCK_SIZE * (nblocks - 1);
+	}
+	memcpy(ctx->buf + ctx->buflen, in, inlen);
+	ctx->buflen += inlen;
+}
+EXPORT_SYMBOL(blake2b_update);
+
+void blake2b_final(struct blake2b_ctx *ctx, u8 *out)
+{
+	WARN_ON(IS_ENABLED(DEBUG) && !out);
+	blake2b_set_lastblock(ctx);
+	memset(ctx->buf + ctx->buflen, 0,
+	       BLAKE2B_BLOCK_SIZE - ctx->buflen); /* Padding */
+	blake2b_compress(ctx, ctx->buf, 1, ctx->buflen);
+	cpu_to_le64_array(ctx->h, ARRAY_SIZE(ctx->h));
+	memcpy(out, ctx->h, ctx->outlen);
+	memzero_explicit(ctx, sizeof(*ctx));
+}
+EXPORT_SYMBOL(blake2b_final);
+
+#ifdef blake2b_mod_init_arch
+static int __init blake2b_mod_init(void)
+{
+	blake2b_mod_init_arch();
+	return 0;
+}
+subsys_initcall(blake2b_mod_init);
+
+static void __exit blake2b_mod_exit(void)
+{
+}
+module_exit(blake2b_mod_exit);
+#endif
+
+MODULE_DESCRIPTION("BLAKE2b hash function");
+MODULE_LICENSE("GPL");
-- 
2.51.1.dirty


