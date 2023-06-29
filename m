Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09048741CF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 02:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjF2Aef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 20:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjF2Aee (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 20:34:34 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14A01FC2;
        Wed, 28 Jun 2023 17:34:33 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 0267A80B0C;
        Wed, 28 Jun 2023 20:34:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1687998873; bh=BIdg34OLmPUpDpRKC4NmZKILUZwUGsXTWhefVvmTUSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HbtL6dGLz/QYHDq9vfZbTKj3vH1lcqnvCeyLrfF1i1FGFjydG+K0hZ7yy6ZfmzXYY
         2YW22OBYvsDQCeEBchs+afaSZWT7Ivu/qz7CXJTS2u9VR83p1wHEFjWvPol0MPjqsc
         8FXy57z8v4UYIjYd/oQcTRwR0V2LQAgRPZIQgNFAq7qP8KuTey9N8VkO52qg2ZFbdc
         P6+UXZla/pw/FcCuK7XsZiB7Y6rPOAcKDjDRG+b3W0Oj2Op5Way2//GREvrpjiNzzM
         0Ik4Pyb8fR5FBxg4Y9fNighQOqDzm2I6vuKtjYqN4wlwFK4oM5WC56U0CnVZQEnsDA
         3JHITfWjOfkmg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@meta.com,
        linux-btrfs@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v1 03/12] fscrypt: adjust effective lblks based on extents
Date:   Wed, 28 Jun 2023 20:29:33 -0400
Message-Id: <fa9b75d8de555036fe20a97e7da2649f575d34a7.1687988246.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1687988246.git.sweettea-kernel@dorminy.me>
References: <cover.1687988246.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If a filesystem uses extent-based encryption, then the offset within a
file is not a constant which can be used for calculating an IV.
For instance, the same extent could be blocks 0-8 in one file, and
blocks 100-108 in another file. Instead, the block offset within the
extent must be used instead.

Update all uses of logical block offset within the file to use logical
block offset within the extent, if applicable.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/crypto/crypto.c       |  3 ++-
 fs/crypto/inline_crypt.c | 22 ++++++++++++++++------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 1b7e375b1c6b..d75f1b3f5795 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -107,8 +107,9 @@ int fscrypt_crypt_block(const struct inode *inode, fscrypt_direction_t rw,
 	struct skcipher_request *req = NULL;
 	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist dst, src;
+	u64 ci_offset = 0;
 	struct fscrypt_info *ci =
-		fscrypt_get_lblk_info(inode, lblk_num, NULL, NULL);
+		fscrypt_get_lblk_info(inode, lblk_num, &ci_offset, NULL);
 	struct crypto_skcipher *tfm = ci->ci_enc_key->tfm;
 	int res = 0;
 
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 885a2ec3d711..689ab342ae34 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -267,12 +267,15 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 {
 	const struct fscrypt_info *ci;
 	u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
+	u64 ci_offset = 0;
 
 	if (!fscrypt_inode_uses_inline_crypto(inode))
 		return;
-	ci = fscrypt_get_lblk_info(inode, first_lblk, NULL, NULL);
+	ci = fscrypt_get_lblk_info(inode, first_lblk, &ci_offset, NULL);
+	if (!ci)
+		return;
 
-	fscrypt_generate_dun(ci, first_lblk, dun);
+	fscrypt_generate_dun(ci, ci_offset, dun);
 	bio_crypt_set_ctx(bio, ci->ci_enc_key->blk_key, dun, gfp_mask);
 }
 EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
@@ -350,13 +353,14 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 	const struct bio_crypt_ctx *bc = bio->bi_crypt_context;
 	u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
 	struct fscrypt_info *ci;
+	u64 ci_offset = 0;
 
 	if (!!bc != fscrypt_inode_uses_inline_crypto(inode))
 		return false;
 	if (!bc)
 		return true;
 
-	ci = fscrypt_get_lblk_info(inode, next_lblk, NULL, NULL);
+	ci = fscrypt_get_lblk_info(inode, next_lblk, &ci_offset, NULL);
 	/*
 	 * Comparing the key pointers is good enough, as all I/O for each key
 	 * uses the same pointer.  I.e., there's currently no need to support
@@ -365,7 +369,7 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 	if (bc->bc_key != ci->ci_enc_key->blk_key)
 		return false;
 
-	fscrypt_generate_dun(ci, next_lblk, next_dun);
+	fscrypt_generate_dun(ci, ci_offset, next_dun);
 	return bio_crypt_dun_is_contiguous(bc, bio->bi_iter.bi_size, next_dun);
 }
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio);
@@ -460,6 +464,8 @@ u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks)
 {
 	const struct fscrypt_info *ci;
 	u32 dun;
+	u64 ci_offset = 0;
+	u64 extent_len = 0;
 
 	if (!fscrypt_inode_uses_inline_crypto(inode))
 		return nr_blocks;
@@ -467,14 +473,18 @@ u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks)
 	if (nr_blocks <= 1)
 		return nr_blocks;
 
-	ci = fscrypt_get_lblk_info(inode, lblk, NULL, NULL);
+	ci = fscrypt_get_lblk_info(inode, lblk, &ci_offset, &extent_len);
+
+	/* Spanning an extent boundary will change the DUN */
+	nr_blocks = min_t(u64, nr_blocks, extent_len);
+
 	if (!(fscrypt_policy_flags(&ci->ci_policy) &
 	      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32))
 		return nr_blocks;
 
 	/* With IV_INO_LBLK_32, the DUN can wrap around from U32_MAX to 0. */
 
-	dun = ci->ci_hashed_ino + lblk;
+	dun = ci->ci_hashed_ino + ci_offset;
 
 	return min_t(u64, nr_blocks, (u64)U32_MAX + 1 - dun);
 }
-- 
2.40.1

