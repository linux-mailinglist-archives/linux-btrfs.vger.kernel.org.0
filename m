Return-Path: <linux-btrfs+bounces-19534-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A03CFCA622A
	for <lists+linux-btrfs@lfdr.de>; Fri, 05 Dec 2025 06:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E33E3180111
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Dec 2025 05:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF592E0919;
	Fri,  5 Dec 2025 05:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv46VaZr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF2378F2E;
	Fri,  5 Dec 2025 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764911143; cv=none; b=HGm2RtxgF22uttnalgJUBd31Xi+jnhiYrCCdF7smxM0KIZzQw3flR9Ga7p8rxBicRjQ2DQWJVgKU2AS5j0r3ZAOGRRQKkV5tVUgRIYPHAW5itOpGjb8cB/2L1fXULQ/TyWVHannuxCAMTQ6JMruvzqYmjqX1FP3K0yZYy/4U2ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764911143; c=relaxed/simple;
	bh=ONwT4dJ8vrsFPPa33jduMzaQRuPORhk3QQYmMZPBe88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q7hALwPs7jo1oagWAQl5RV+yOKSxGcioRI9zpp+QeX9aUPbVFDc5lc5gNe23XoEWx6WgI41ULRljkWKZDAIWQ4iBrKFmlvC1jzWhp9X04NZRkmEpWuhv1TKUR/MqOT9gSRacUAC4t8WWf5TZYgENOo+CFQSWkjsyqpuOCl/b1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv46VaZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEED4C4CEF1;
	Fri,  5 Dec 2025 05:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764911143;
	bh=ONwT4dJ8vrsFPPa33jduMzaQRuPORhk3QQYmMZPBe88=;
	h=From:To:Cc:Subject:Date:From;
	b=hv46VaZrhakZWAuAg+EBqLARnXJsP1ypdRAionvLU6nWeqCS1qheCuxeDr4ArlcYL
	 DPtLQuHDTaNOKgf4yGDGzr4ofxZvK/9oBysl8u4lL3v80yfpNZt8rv4KfxPXuHBcjU
	 verKlb+611ALgJBGnD431hKR88Q/8aUh41BPkT8avlM37j/dbtxLY4YphCOLdCBwTu
	 vH2BQUVQCoUj1ngsfLxrx+A6YM9JCZFw0C6JPNjFEldJtxb4DyX6qGS/9ddsPRqUn9
	 Bennugml6CXO3lKLhn7vouWvnq6ZsI88O8dA5rWVCxvfZauO2/5jtdTW2McdXF9CQt
	 suxRaokWHd0+g==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	David Laight <david.laight@runbox.com>,
	David Sterba <dsterba@suse.com>,
	llvm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2] lib/crypto: blake2b: Roll up BLAKE2b round loop on 32-bit
Date: Thu,  4 Dec 2025 21:03:30 -0800
Message-ID: <20251205050330.89704-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BLAKE2b has a state of 16 64-bit words.  Add the message data in and
there are 32 64-bit words.  With the current code where all the rounds
are unrolled to enable constant-folding of the blake2b_sigma values,
this results in a very large code size on 32-bit kernels, including a
recurring issue where gcc uses a large amount of stack.

There's just not much benefit to this unrolling when the code is already
so large.  Let's roll up the rounds when !CONFIG_64BIT.

To avoid having to duplicate the code, just write code once using a
loop, and conditionally use 'unrolled_full' from <linux/unroll.h>.

Then, fold the now-unneeded ROUND() macro into the loop.  Finally, also
remove the now-unneeded override of the stack frame size warning.

Code size improvements for blake2b_compress_generic():

                  Size before (bytes)    Size after (bytes)
                  -------------------    ------------------
    i386, gcc           27584                 3632
    i386, clang         18208                 3248
    arm32, gcc          19912                 2860
    arm32, clang        21336                 3344

Running the BLAKE2b benchmark on a !CONFIG_64BIT kernel on an x86_64
processor shows a 16384B throughput change of 351 => 340 MB/s (gcc) or
442 MB/s => 375 MB/s (clang).  So clearly not much of a slowdown either.
But also that microbenchmark also effectively disregards cache usage,
which is important in practice and is far better in the smaller code.

Note: If we rolled up the loop on x86_64 too, the change would be
7024 bytes => 1584 bytes and 1960 MB/s => 1396 MB/s (gcc), or
6848 bytes => 1696 bytes and 1920 MB/s => 1263 MB/s (clang).
Maybe still worth it, though not quite as clearly beneficial.

Fixes: 91d689337fe8 ("crypto: blake2b - add blake2b generic implementation")
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crypto/Makefile  |  1 -
 lib/crypto/blake2b.c | 44 ++++++++++++++++++++------------------------
 2 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index b5346cebbb55..330ab65b29c4 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -31,11 +31,10 @@ obj-$(CONFIG_CRYPTO_LIB_GF128MUL)		+= gf128mul.o
 
 ################################################################################
 
 obj-$(CONFIG_CRYPTO_LIB_BLAKE2B) += libblake2b.o
 libblake2b-y := blake2b.o
-CFLAGS_blake2b.o := -Wframe-larger-than=4096 #  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105930
 ifeq ($(CONFIG_CRYPTO_LIB_BLAKE2B_ARCH),y)
 CFLAGS_blake2b.o += -I$(src)/$(SRCARCH)
 libblake2b-$(CONFIG_ARM) += arm/blake2b-neon-core.o
 endif # CONFIG_CRYPTO_LIB_BLAKE2B_ARCH
 
diff --git a/lib/crypto/blake2b.c b/lib/crypto/blake2b.c
index 09c6d65d8a6e..581b7f8486fa 100644
--- a/lib/crypto/blake2b.c
+++ b/lib/crypto/blake2b.c
@@ -12,10 +12,11 @@
 #include <linux/bug.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/unroll.h>
 #include <linux/types.h>
 
 static const u8 blake2b_sigma[12][16] = {
 	{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
 	{ 14, 10, 4, 8, 9, 15, 13, 6, 1, 12, 0, 2, 11, 7, 5, 3 },
@@ -71,35 +72,30 @@ blake2b_compress_generic(struct blake2b_ctx *ctx,
 	d = ror64(d ^ a, 16); \
 	c += d; \
 	b = ror64(b ^ c, 63); \
 } while (0)
 
-#define ROUND(r) do { \
-	G(r, 0, v[0], v[ 4], v[ 8], v[12]); \
-	G(r, 1, v[1], v[ 5], v[ 9], v[13]); \
-	G(r, 2, v[2], v[ 6], v[10], v[14]); \
-	G(r, 3, v[3], v[ 7], v[11], v[15]); \
-	G(r, 4, v[0], v[ 5], v[10], v[15]); \
-	G(r, 5, v[1], v[ 6], v[11], v[12]); \
-	G(r, 6, v[2], v[ 7], v[ 8], v[13]); \
-	G(r, 7, v[3], v[ 4], v[ 9], v[14]); \
-} while (0)
-		ROUND(0);
-		ROUND(1);
-		ROUND(2);
-		ROUND(3);
-		ROUND(4);
-		ROUND(5);
-		ROUND(6);
-		ROUND(7);
-		ROUND(8);
-		ROUND(9);
-		ROUND(10);
-		ROUND(11);
-
+#ifdef CONFIG_64BIT
+		/*
+		 * Unroll the rounds loop to enable constant-folding of the
+		 * blake2b_sigma values.  Seems worthwhile on 64-bit kernels.
+		 * Not worthwhile on 32-bit kernels because the code size is
+		 * already so large there due to BLAKE2b using 64-bit words.
+		 */
+		unrolled_full
+#endif
+		for (int r = 0; r < 12; r++) {
+			G(r, 0, v[0], v[4], v[8], v[12]);
+			G(r, 1, v[1], v[5], v[9], v[13]);
+			G(r, 2, v[2], v[6], v[10], v[14]);
+			G(r, 3, v[3], v[7], v[11], v[15]);
+			G(r, 4, v[0], v[5], v[10], v[15]);
+			G(r, 5, v[1], v[6], v[11], v[12]);
+			G(r, 6, v[2], v[7], v[8], v[13]);
+			G(r, 7, v[3], v[4], v[9], v[14]);
+		}
 #undef G
-#undef ROUND
 
 		for (i = 0; i < 8; ++i)
 			ctx->h[i] ^= v[i] ^ v[i + 8];
 
 		data += BLAKE2B_BLOCK_SIZE;

base-commit: 3f9f0252130e7dd60d41be0802bf58f6471c691d
-- 
2.52.0


