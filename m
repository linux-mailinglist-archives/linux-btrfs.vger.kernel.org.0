Return-Path: <linux-btrfs+bounces-17984-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F307BEC75F
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 06:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1451A67809
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 04:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A0E283FF4;
	Sat, 18 Oct 2025 04:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9NWiENx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CE9260585;
	Sat, 18 Oct 2025 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760762182; cv=none; b=P6pncucd6wAZz077lmhLcdXCksP5GuoSYxcRZb5BHHlQyvNAhL8+a3XVrMaDa1WidOs1dyLTM+sgbSw+70zwDSt5GXqAurYBb7d+LFhjyDkkRWZA6960kyCvQ1/Im1WMVy8HeksxnaePptVmvdCLdTQwnO7UCrJWiOii1L5TZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760762182; c=relaxed/simple;
	bh=PzxSfFbOnc7a/0F7T89AfzwtcHq2YTXwzLumyKuku6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzDq+auQPN/IJDPBNQrwr26z6Mgx0x+yZJrWvAMtyLjh91ILt659dbBXriNt+P7WMmIoZE2eesg9K+1Lkc9D2OeLhAvWjLPDvYWTFJ53HOJzJkPBaJkhbUPyIJYcTia8HvUxbUHBowjRS43eW6Ka17SdaHnC8L6Fnp9c0K6uM8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9NWiENx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0772BC116D0;
	Sat, 18 Oct 2025 04:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760762182;
	bh=PzxSfFbOnc7a/0F7T89AfzwtcHq2YTXwzLumyKuku6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O9NWiENxuMMK2HRxvUlwpz4/PrKhTaGAA57aQzr4ojwJDUdQYEc4+CTJ6taIJ8GFi
	 mz5K0QeSmCzozap+oDyHAZm63HywlfqGLa2hmAytzy8D5lYHy6pa01A22lZE9+BwaI
	 nZtD4k5Kc5PGGKw04IGwcK6esKryolxt/0ZIa2PGEEk4v+uiax2Naa4U9CR51qzFV2
	 S8jF4oF+aPSJL6O3wPnCPjg+oLjCbsIkefEu6aH8fgnKnyoP873TGjfpat/XACkeJE
	 qyj53quvGsfxM3l5B0hSGA3vMgD2kmfkj7wesE3hxo4eRfufQw4uFY6/xdwxBuDDOP
	 9x6kjc3JPs0cQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 03/10] lib/crypto: blake2s: Drop excessive const & rename block => data
Date: Fri, 17 Oct 2025 21:30:59 -0700
Message-ID: <20251018043106.375964-4-ebiggers@kernel.org>
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

A couple more small cleanups to the BLAKE2s code before these things get
propagated into the BLAKE2b code:

- Drop 'const' from some non-pointer function parameters.  It was a bit
  excessive and not conventional.

- Rename 'block' argument of blake2s_compress*() to 'data'.  This is for
  consistency with the SHA-* code, and also to avoid the implication
  that it points to a singular "block".

No functional changes.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/crypto/blake2s.h      | 13 ++++++-------
 lib/crypto/arm/blake2s-core.S |  6 +++---
 lib/crypto/arm/blake2s.h      |  2 +-
 lib/crypto/blake2s.c          | 12 ++++++------
 lib/crypto/x86/blake2s.h      | 18 ++++++++----------
 5 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/include/crypto/blake2s.h b/include/crypto/blake2s.h
index 4c8d532ee97b3..33893057eb414 100644
--- a/include/crypto/blake2s.h
+++ b/include/crypto/blake2s.h
@@ -65,31 +65,30 @@ static inline void __blake2s_init(struct blake2s_ctx *ctx, size_t outlen,
 		memset(&ctx->buf[keylen], 0, BLAKE2S_BLOCK_SIZE - keylen);
 		ctx->buflen = BLAKE2S_BLOCK_SIZE;
 	}
 }
 
-static inline void blake2s_init(struct blake2s_ctx *ctx, const size_t outlen)
+static inline void blake2s_init(struct blake2s_ctx *ctx, size_t outlen)
 {
 	__blake2s_init(ctx, outlen, NULL, 0);
 }
 
-static inline void blake2s_init_key(struct blake2s_ctx *ctx,
-				    const size_t outlen, const void *key,
-				    const size_t keylen)
+static inline void blake2s_init_key(struct blake2s_ctx *ctx, size_t outlen,
+				    const void *key, size_t keylen)
 {
 	WARN_ON(IS_ENABLED(DEBUG) && (!outlen || outlen > BLAKE2S_HASH_SIZE ||
 		!key || !keylen || keylen > BLAKE2S_KEY_SIZE));
 
 	__blake2s_init(ctx, outlen, key, keylen);
 }
 
 void blake2s_update(struct blake2s_ctx *ctx, const u8 *in, size_t inlen);
 void blake2s_final(struct blake2s_ctx *ctx, u8 *out);
 
-static inline void blake2s(const u8 *key, const size_t keylen,
-			   const u8 *in, const size_t inlen,
-			   u8 *out, const size_t outlen)
+static inline void blake2s(const u8 *key, size_t keylen,
+			   const u8 *in, size_t inlen,
+			   u8 *out, size_t outlen)
 {
 	struct blake2s_ctx ctx;
 
 	WARN_ON(IS_ENABLED(DEBUG) && ((!in && inlen > 0) || !out || !outlen ||
 		outlen > BLAKE2S_HASH_SIZE || keylen > BLAKE2S_KEY_SIZE ||
diff --git a/lib/crypto/arm/blake2s-core.S b/lib/crypto/arm/blake2s-core.S
index 78e758a7cb3e2..14eb7c18a8365 100644
--- a/lib/crypto/arm/blake2s-core.S
+++ b/lib/crypto/arm/blake2s-core.S
@@ -169,11 +169,11 @@
 	__strd		r10, r11, sp, 20
 .endm
 
 //
 // void blake2s_compress(struct blake2s_ctx *ctx,
-//			 const u8 *block, size_t nblocks, u32 inc);
+//			 const u8 *data, size_t nblocks, u32 inc);
 //
 // Only the first three fields of struct blake2s_ctx are used:
 //	u32 h[8];	(inout)
 //	u32 t[2];	(inout)
 //	u32 f[2];	(in)
@@ -182,11 +182,11 @@
 ENTRY(blake2s_compress)
 	push		{r0-r2,r4-r11,lr}	// keep this an even number
 
 .Lnext_block:
 	// r0 is 'ctx'
-	// r1 is 'block'
+	// r1 is 'data'
 	// r3 is 'inc'
 
 	// Load and increment the counter t[0..1].
 	__ldrd		r10, r11, r0, 32
 	adds		r10, r10, r3
@@ -273,11 +273,11 @@ ENTRY(blake2s_compress)
 	stm		r14, {r0-r3}		// store new h[4..7]
 
 	// Advance to the next block, if there is one.  Note that if there are
 	// multiple blocks, then 'inc' (the counter increment amount) must be
 	// 64.  So we can simply set it to 64 without re-loading it.
-	ldm		sp, {r0, r1, r2}	// load (ctx, block, nblocks)
+	ldm		sp, {r0, r1, r2}	// load (ctx, data, nblocks)
 	mov		r3, #64			// set 'inc'
 	subs		r2, r2, #1		// nblocks--
 	str		r2, [sp, #8]
 	bne		.Lnext_block		// nblocks != 0?
 
diff --git a/lib/crypto/arm/blake2s.h b/lib/crypto/arm/blake2s.h
index ce009cd98de90..42c04440c1913 100644
--- a/lib/crypto/arm/blake2s.h
+++ b/lib/crypto/arm/blake2s.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 /* defined in blake2s-core.S */
 void blake2s_compress(struct blake2s_ctx *ctx,
-		      const u8 *block, size_t nblocks, u32 inc);
+		      const u8 *data, size_t nblocks, u32 inc);
diff --git a/lib/crypto/blake2s.c b/lib/crypto/blake2s.c
index 1ad36cb29835f..6182c21ed943d 100644
--- a/lib/crypto/blake2s.c
+++ b/lib/crypto/blake2s.c
@@ -27,31 +27,30 @@ static const u8 blake2s_sigma[10][16] = {
 	{ 13, 11, 7, 14, 12, 1, 3, 9, 5, 0, 15, 4, 8, 6, 2, 10 },
 	{ 6, 15, 14, 9, 11, 3, 0, 8, 12, 2, 13, 7, 1, 4, 10, 5 },
 	{ 10, 2, 8, 4, 7, 6, 1, 5, 15, 11, 9, 14, 3, 12, 13, 0 },
 };
 
-static inline void blake2s_increment_counter(struct blake2s_ctx *ctx,
-					     const u32 inc)
+static inline void blake2s_increment_counter(struct blake2s_ctx *ctx, u32 inc)
 {
 	ctx->t[0] += inc;
 	ctx->t[1] += (ctx->t[0] < inc);
 }
 
 static void __maybe_unused
-blake2s_compress_generic(struct blake2s_ctx *ctx, const u8 *block,
-			 size_t nblocks, const u32 inc)
+blake2s_compress_generic(struct blake2s_ctx *ctx,
+			 const u8 *data, size_t nblocks, u32 inc)
 {
 	u32 m[16];
 	u32 v[16];
 	int i;
 
 	WARN_ON(IS_ENABLED(DEBUG) &&
 		(nblocks > 1 && inc != BLAKE2S_BLOCK_SIZE));
 
 	while (nblocks > 0) {
 		blake2s_increment_counter(ctx, inc);
-		memcpy(m, block, BLAKE2S_BLOCK_SIZE);
+		memcpy(m, data, BLAKE2S_BLOCK_SIZE);
 		le32_to_cpu_array(m, ARRAY_SIZE(m));
 		memcpy(v, ctx->h, 32);
 		v[ 8] = BLAKE2S_IV0;
 		v[ 9] = BLAKE2S_IV1;
 		v[10] = BLAKE2S_IV2;
@@ -97,11 +96,11 @@ blake2s_compress_generic(struct blake2s_ctx *ctx, const u8 *block,
 #undef ROUND
 
 		for (i = 0; i < 8; ++i)
 			ctx->h[i] ^= v[i] ^ v[i + 8];
 
-		block += BLAKE2S_BLOCK_SIZE;
+		data += BLAKE2S_BLOCK_SIZE;
 		--nblocks;
 	}
 }
 
 #ifdef CONFIG_CRYPTO_LIB_BLAKE2S_ARCH
@@ -128,10 +127,11 @@ void blake2s_update(struct blake2s_ctx *ctx, const u8 *in, size_t inlen)
 		in += fill;
 		inlen -= fill;
 	}
 	if (inlen > BLAKE2S_BLOCK_SIZE) {
 		const size_t nblocks = DIV_ROUND_UP(inlen, BLAKE2S_BLOCK_SIZE);
+
 		blake2s_compress(ctx, in, nblocks - 1, BLAKE2S_BLOCK_SIZE);
 		in += BLAKE2S_BLOCK_SIZE * (nblocks - 1);
 		inlen -= BLAKE2S_BLOCK_SIZE * (nblocks - 1);
 	}
 	memcpy(ctx->buf + ctx->buflen, in, inlen);
diff --git a/lib/crypto/x86/blake2s.h b/lib/crypto/x86/blake2s.h
index de360935b8204..f8eed6cb042e4 100644
--- a/lib/crypto/x86/blake2s.h
+++ b/lib/crypto/x86/blake2s.h
@@ -10,43 +10,41 @@
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
 #include <linux/sizes.h>
 
 asmlinkage void blake2s_compress_ssse3(struct blake2s_ctx *ctx,
-				       const u8 *block, const size_t nblocks,
-				       const u32 inc);
+				       const u8 *data, size_t nblocks, u32 inc);
 asmlinkage void blake2s_compress_avx512(struct blake2s_ctx *ctx,
-					const u8 *block, const size_t nblocks,
-					const u32 inc);
+					const u8 *data, size_t nblocks, u32 inc);
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(blake2s_use_ssse3);
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(blake2s_use_avx512);
 
-static void blake2s_compress(struct blake2s_ctx *ctx, const u8 *block,
-			     size_t nblocks, const u32 inc)
+static void blake2s_compress(struct blake2s_ctx *ctx,
+			     const u8 *data, size_t nblocks, u32 inc)
 {
 	/* SIMD disables preemption, so relax after processing each page. */
 	BUILD_BUG_ON(SZ_4K / BLAKE2S_BLOCK_SIZE < 8);
 
 	if (!static_branch_likely(&blake2s_use_ssse3) || !may_use_simd()) {
-		blake2s_compress_generic(ctx, block, nblocks, inc);
+		blake2s_compress_generic(ctx, data, nblocks, inc);
 		return;
 	}
 
 	do {
 		const size_t blocks = min_t(size_t, nblocks,
 					    SZ_4K / BLAKE2S_BLOCK_SIZE);
 
 		kernel_fpu_begin();
 		if (static_branch_likely(&blake2s_use_avx512))
-			blake2s_compress_avx512(ctx, block, blocks, inc);
+			blake2s_compress_avx512(ctx, data, blocks, inc);
 		else
-			blake2s_compress_ssse3(ctx, block, blocks, inc);
+			blake2s_compress_ssse3(ctx, data, blocks, inc);
 		kernel_fpu_end();
 
+		data += blocks * BLAKE2S_BLOCK_SIZE;
 		nblocks -= blocks;
-		block += blocks * BLAKE2S_BLOCK_SIZE;
 	} while (nblocks);
 }
 
 #define blake2s_mod_init_arch blake2s_mod_init_arch
 static void blake2s_mod_init_arch(void)
-- 
2.51.1.dirty


