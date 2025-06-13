Return-Path: <linux-btrfs+bounces-14646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A100AD9496
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 20:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36D6178B55
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 18:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE582367D9;
	Fri, 13 Jun 2025 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdS4gT1r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AFF231A57;
	Fri, 13 Jun 2025 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749839953; cv=none; b=petm5FcZPwXRYX8gI3ZLI4OH6f2hO7eCw1yfSXB1MnCl/GXl+1Z3jZ4FAmb/OaazmSYpteXDwVhDJbdDSJHI0w21EaNaub1D295LtGl+Qzce9tiQultQfZ8gP9F80sICOWcPAKC5MsZpxX+3o3ay83/RA9akQ8rcUw6WO5JMd0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749839953; c=relaxed/simple;
	bh=+scNn74TP1gB3uaExUowjPcO7j2GnDZeXdT2PCkyqF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwJROt2H/C/ZfbG/FTl4hqeS9t0QtwBJ5eNFDqzfLRPxBXscttMeQzpwMevciYo4OClt1L9WFxAnhE8GidStxrdHbPUczH3Cc3E9JosaLLiNc2l2AQwtSn5QWKo8psuTnqS1FAVdAox49o046iQ6U6QrI4ioTE0eYhgo1dBnQf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdS4gT1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35D5C4CEF2;
	Fri, 13 Jun 2025 18:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749839953;
	bh=+scNn74TP1gB3uaExUowjPcO7j2GnDZeXdT2PCkyqF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FdS4gT1rF5AwmxBEXf/SxWH2rzz47c/1nrtqZY7HldtMNWt+Io3tNCrEaR9L+bGT8
	 gYN5o97tfojw8ta1kxEcFqzp76XN4jUKGabZFJ8nyPc68QaqW7tc4sPne9wx34LRmf
	 g9FNmejWTEx9+bNgrLRYz1YiRVQvdlsRqRiXkASm7TaDRMzv/nheYX8uk2KnZf7Q4H
	 YPBGV2WtEmOqW3OE12DvlKX9KqZ6AP0nICTeqPsWgdZj8fpSD1BVrteL5Cl+qyOPin
	 iOJB1N6ljBFTN0JxkNEdkiS0WWdWSk6uJ0pwehPTy/Z7MmsOraAtXFH+k0M06NGPev
	 m+vEZmxyBWTrw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-btrfs@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] crypto/crc32[c]: register only "-lib" drivers
Date: Fri, 13 Jun 2025 11:37:53 -0700
Message-ID: <20250613183753.31864-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613183753.31864-1-ebiggers@kernel.org>
References: <20250613183753.31864-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

For the "crc32" and "crc32c" shash algorithms, instead of registering
"*-generic" drivers as well as conditionally registering "*-$(ARCH)"
drivers, instead just register "*-lib" drivers.  These just use the
regular library functions crc32_le() and crc32c(), so they just do the
right thing and are fully accelerated when supported by the CPU.

This eliminates the need for the CRC library to export crc32_le_base()
and crc32c_base().  Separate patches make those static functions.

Since this patch removes the "crc32-generic" and "crc32c-generic" driver
names which crypto/testmgr.c expects to exist, update crypto/testmgr.c
accordingly.  This does mean that crypto/testmgr.c will no longer
fuzz-test the "generic" implementation against the "arch" implementation
for crc32 and crc32c, but this was redundant with crc_kunit anyway.

Besides the above, and btrfs_init_csum_hash() which the previous patch
fixed, no code appears to have been relying on the "crc32-generic" or
"crc32c-generic" driver names specifically.

btrfs does export the checksum driver name in
/sys/fs/btrfs/$uuid/checksum.  This patch makes that file contain
"crc32c-lib" instead of "crc32c-generic" or "crc32c-$(ARCH)".  This
should be fine, since in practice the purpose of this file seems to have
been just to allow users to manually check whether they needed to enable
the optimized CRC32C code.  This was needed only because of the bug in
old kernels where the optimized CRC32C code defaulted to off and even
needed to be explicitly added to the ramdisk to be used.  Now that it
just works in Linux 6.14 and later, there's no need for users to take
any action and this file is basically obsolete.  (Also, note that the
contents of this file already changed in 6.14.)

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/Makefile  |  2 --
 crypto/crc32.c   | 65 +++++------------------------------------------
 crypto/crc32c.c  | 66 ++++--------------------------------------------
 crypto/testmgr.c |  2 ++
 4 files changed, 13 insertions(+), 122 deletions(-)

diff --git a/crypto/Makefile b/crypto/Makefile
index 017df3a2e4bb3..55dd56332dc80 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -152,14 +152,12 @@ obj-$(CONFIG_CRYPTO_CHACHA20) += chacha.o
 CFLAGS_chacha.o += -DARCH=$(ARCH)
 obj-$(CONFIG_CRYPTO_DEFLATE) += deflate.o
 obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += michael_mic.o
 obj-$(CONFIG_CRYPTO_CRC32C) += crc32c-cryptoapi.o
 crc32c-cryptoapi-y := crc32c.o
-CFLAGS_crc32c.o += -DARCH=$(ARCH)
 obj-$(CONFIG_CRYPTO_CRC32) += crc32-cryptoapi.o
 crc32-cryptoapi-y := crc32.o
-CFLAGS_crc32.o += -DARCH=$(ARCH)
 obj-$(CONFIG_CRYPTO_AUTHENC) += authenc.o authencesn.o
 obj-$(CONFIG_CRYPTO_KRB5ENC) += krb5enc.o
 obj-$(CONFIG_CRYPTO_LZO) += lzo.o lzo-rle.o
 obj-$(CONFIG_CRYPTO_LZ4) += lz4.o
 obj-$(CONFIG_CRYPTO_LZ4HC) += lz4hc.o
diff --git a/crypto/crc32.c b/crypto/crc32.c
index cc371d42601fd..489cbed9422e2 100644
--- a/crypto/crc32.c
+++ b/crypto/crc32.c
@@ -57,33 +57,16 @@ static int crc32_init(struct shash_desc *desc)
 static int crc32_update(struct shash_desc *desc, const u8 *data,
 			unsigned int len)
 {
 	u32 *crcp = shash_desc_ctx(desc);
 
-	*crcp = crc32_le_base(*crcp, data, len);
-	return 0;
-}
-
-static int crc32_update_arch(struct shash_desc *desc, const u8 *data,
-			     unsigned int len)
-{
-	u32 *crcp = shash_desc_ctx(desc);
-
 	*crcp = crc32_le(*crcp, data, len);
 	return 0;
 }
 
 /* No final XOR 0xFFFFFFFF, like crc32_le */
-static int __crc32_finup(u32 *crcp, const u8 *data, unsigned int len,
-			 u8 *out)
-{
-	put_unaligned_le32(crc32_le_base(*crcp, data, len), out);
-	return 0;
-}
-
-static int __crc32_finup_arch(u32 *crcp, const u8 *data, unsigned int len,
-			      u8 *out)
+static int __crc32_finup(u32 *crcp, const u8 *data, unsigned int len, u8 *out)
 {
 	put_unaligned_le32(crc32_le(*crcp, data, len), out);
 	return 0;
 }
 
@@ -91,16 +74,10 @@ static int crc32_finup(struct shash_desc *desc, const u8 *data,
 		       unsigned int len, u8 *out)
 {
 	return __crc32_finup(shash_desc_ctx(desc), data, len, out);
 }
 
-static int crc32_finup_arch(struct shash_desc *desc, const u8 *data,
-		       unsigned int len, u8 *out)
-{
-	return __crc32_finup_arch(shash_desc_ctx(desc), data, len, out);
-}
-
 static int crc32_final(struct shash_desc *desc, u8 *out)
 {
 	u32 *crcp = shash_desc_ctx(desc);
 
 	put_unaligned_le32(*crcp, out);
@@ -111,72 +88,42 @@ static int crc32_digest(struct shash_desc *desc, const u8 *data,
 			unsigned int len, u8 *out)
 {
 	return __crc32_finup(crypto_shash_ctx(desc->tfm), data, len, out);
 }
 
-static int crc32_digest_arch(struct shash_desc *desc, const u8 *data,
-			     unsigned int len, u8 *out)
-{
-	return __crc32_finup_arch(crypto_shash_ctx(desc->tfm), data, len, out);
-}
-
-static struct shash_alg algs[] = {{
+static struct shash_alg alg = {
 	.setkey			= crc32_setkey,
 	.init			= crc32_init,
 	.update			= crc32_update,
 	.final			= crc32_final,
 	.finup			= crc32_finup,
 	.digest			= crc32_digest,
 	.descsize		= sizeof(u32),
 	.digestsize		= CHKSUM_DIGEST_SIZE,
 
 	.base.cra_name		= "crc32",
-	.base.cra_driver_name	= "crc32-generic",
+	.base.cra_driver_name	= "crc32-lib",
 	.base.cra_priority	= 100,
 	.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 	.base.cra_blocksize	= CHKSUM_BLOCK_SIZE,
 	.base.cra_ctxsize	= sizeof(u32),
 	.base.cra_module	= THIS_MODULE,
 	.base.cra_init		= crc32_cra_init,
-}, {
-	.setkey			= crc32_setkey,
-	.init			= crc32_init,
-	.update			= crc32_update_arch,
-	.final			= crc32_final,
-	.finup			= crc32_finup_arch,
-	.digest			= crc32_digest_arch,
-	.descsize		= sizeof(u32),
-	.digestsize		= CHKSUM_DIGEST_SIZE,
-
-	.base.cra_name		= "crc32",
-	.base.cra_driver_name	= "crc32-" __stringify(ARCH),
-	.base.cra_priority	= 150,
-	.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
-	.base.cra_blocksize	= CHKSUM_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(u32),
-	.base.cra_module	= THIS_MODULE,
-	.base.cra_init		= crc32_cra_init,
-}};
-
-static int num_algs;
+};
 
 static int __init crc32_mod_init(void)
 {
-	/* register the arch flavor only if it differs from the generic one */
-	num_algs = 1 + ((crc32_optimizations() & CRC32_LE_OPTIMIZATION) != 0);
-
-	return crypto_register_shashes(algs, num_algs);
+	return crypto_register_shash(&alg);
 }
 
 static void __exit crc32_mod_fini(void)
 {
-	crypto_unregister_shashes(algs, num_algs);
+	crypto_unregister_shash(&alg);
 }
 
 module_init(crc32_mod_init);
 module_exit(crc32_mod_fini);
 
 MODULE_AUTHOR("Alexander Boyko <alexander_boyko@xyratex.com>");
 MODULE_DESCRIPTION("CRC32 calculations wrapper for lib/crc32");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CRYPTO("crc32");
-MODULE_ALIAS_CRYPTO("crc32-generic");
diff --git a/crypto/crc32c.c b/crypto/crc32c.c
index e5377898414a2..1eff54dde2f74 100644
--- a/crypto/crc32c.c
+++ b/crypto/crc32c.c
@@ -83,19 +83,10 @@ static int chksum_setkey(struct crypto_shash *tfm, const u8 *key,
 static int chksum_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int length)
 {
 	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
 
-	ctx->crc = crc32c_base(ctx->crc, data, length);
-	return 0;
-}
-
-static int chksum_update_arch(struct shash_desc *desc, const u8 *data,
-			      unsigned int length)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
 	ctx->crc = crc32c(ctx->crc, data, length);
 	return 0;
 }
 
 static int chksum_final(struct shash_desc *desc, u8 *out)
@@ -105,17 +96,10 @@ static int chksum_final(struct shash_desc *desc, u8 *out)
 	put_unaligned_le32(~ctx->crc, out);
 	return 0;
 }
 
 static int __chksum_finup(u32 *crcp, const u8 *data, unsigned int len, u8 *out)
-{
-	put_unaligned_le32(~crc32c_base(*crcp, data, len), out);
-	return 0;
-}
-
-static int __chksum_finup_arch(u32 *crcp, const u8 *data, unsigned int len,
-			       u8 *out)
 {
 	put_unaligned_le32(~crc32c(*crcp, data, len), out);
 	return 0;
 }
 
@@ -125,98 +109,58 @@ static int chksum_finup(struct shash_desc *desc, const u8 *data,
 	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
 
 	return __chksum_finup(&ctx->crc, data, len, out);
 }
 
-static int chksum_finup_arch(struct shash_desc *desc, const u8 *data,
-			     unsigned int len, u8 *out)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	return __chksum_finup_arch(&ctx->crc, data, len, out);
-}
-
 static int chksum_digest(struct shash_desc *desc, const u8 *data,
 			 unsigned int length, u8 *out)
 {
 	struct chksum_ctx *mctx = crypto_shash_ctx(desc->tfm);
 
 	return __chksum_finup(&mctx->key, data, length, out);
 }
 
-static int chksum_digest_arch(struct shash_desc *desc, const u8 *data,
-			      unsigned int length, u8 *out)
-{
-	struct chksum_ctx *mctx = crypto_shash_ctx(desc->tfm);
-
-	return __chksum_finup_arch(&mctx->key, data, length, out);
-}
-
 static int crc32c_cra_init(struct crypto_tfm *tfm)
 {
 	struct chksum_ctx *mctx = crypto_tfm_ctx(tfm);
 
 	mctx->key = ~0;
 	return 0;
 }
 
-static struct shash_alg algs[] = {{
+static struct shash_alg alg = {
 	.digestsize		= CHKSUM_DIGEST_SIZE,
 	.setkey			= chksum_setkey,
 	.init			= chksum_init,
 	.update			= chksum_update,
 	.final			= chksum_final,
 	.finup			= chksum_finup,
 	.digest			= chksum_digest,
 	.descsize		= sizeof(struct chksum_desc_ctx),
 
 	.base.cra_name		= "crc32c",
-	.base.cra_driver_name	= "crc32c-generic",
+	.base.cra_driver_name	= "crc32c-lib",
 	.base.cra_priority	= 100,
 	.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 	.base.cra_blocksize	= CHKSUM_BLOCK_SIZE,
 	.base.cra_ctxsize	= sizeof(struct chksum_ctx),
 	.base.cra_module	= THIS_MODULE,
 	.base.cra_init		= crc32c_cra_init,
-}, {
-	.digestsize		= CHKSUM_DIGEST_SIZE,
-	.setkey			= chksum_setkey,
-	.init			= chksum_init,
-	.update			= chksum_update_arch,
-	.final			= chksum_final,
-	.finup			= chksum_finup_arch,
-	.digest			= chksum_digest_arch,
-	.descsize		= sizeof(struct chksum_desc_ctx),
-
-	.base.cra_name		= "crc32c",
-	.base.cra_driver_name	= "crc32c-" __stringify(ARCH),
-	.base.cra_priority	= 150,
-	.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
-	.base.cra_blocksize	= CHKSUM_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct chksum_ctx),
-	.base.cra_module	= THIS_MODULE,
-	.base.cra_init		= crc32c_cra_init,
-}};
-
-static int num_algs;
+};
 
 static int __init crc32c_mod_init(void)
 {
-	/* register the arch flavor only if it differs from the generic one */
-	num_algs = 1 + ((crc32_optimizations() & CRC32C_OPTIMIZATION) != 0);
-
-	return crypto_register_shashes(algs, num_algs);
+	return crypto_register_shash(&alg);
 }
 
 static void __exit crc32c_mod_fini(void)
 {
-	crypto_unregister_shashes(algs, num_algs);
+	crypto_unregister_shash(&alg);
 }
 
 module_init(crc32c_mod_init);
 module_exit(crc32c_mod_fini);
 
 MODULE_AUTHOR("Clay Haapala <chaapala@cisco.com>");
 MODULE_DESCRIPTION("CRC32c (Castagnoli) calculations wrapper for lib/crc32c");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CRYPTO("crc32c");
-MODULE_ALIAS_CRYPTO("crc32c-generic");
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 72005074a5c26..3b947b828ff83 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4544,17 +4544,19 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.hash = __VECS(sm4_cmac128_tv_template)
 		}
 	}, {
 		.alg = "crc32",
+		.generic_driver = "crc32-lib",
 		.test = alg_test_hash,
 		.fips_allowed = 1,
 		.suite = {
 			.hash = __VECS(crc32_tv_template)
 		}
 	}, {
 		.alg = "crc32c",
+		.generic_driver = "crc32c-lib",
 		.test = alg_test_crc32c,
 		.fips_allowed = 1,
 		.suite = {
 			.hash = __VECS(crc32c_tv_template)
 		}
-- 
2.49.0


