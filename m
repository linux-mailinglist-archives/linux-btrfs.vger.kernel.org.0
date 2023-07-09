Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA2374C7AF
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Jul 2023 20:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjGISyu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Jul 2023 14:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjGISx2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Jul 2023 14:53:28 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD93B10C;
        Sun,  9 Jul 2023 11:53:26 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 44BE980AE0;
        Sun,  9 Jul 2023 14:53:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1688928806; bh=SH9bCUopPBc2b+SdiOgC1mgTiMhvbLSrlVeG8kBU9c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aqlcy5nQh/RRQsbQ2q/ey/fwUYSE65S2vUj36FWT44vue6TCNgqNUsJLWlwWud7ES
         X1QL/uTKr9y1sJ07n0nq+CNsAELZhYVbS+zmTiJQ8EvuOsZvxI66EYNJmeGi3DRy0l
         3HGGdaXVgVwSWQBCW92ZWP50QAJDrjaM3Mxus5jFoWRFLZDDDgnIu89R+eGkZeauBO
         KZypyLkV+hh5gVAvB2eBZ9ZMi8NOzZis1HkGNz0kutAuEuE119uFczmN2Y+ouzSe+m
         R8DpwNAA/orsO5mO2hpYAiO73tawnQNHWWZpt+4CTo7D4pm4+uoyfB/oPBMLoZihKm
         0lOVyf2m9pVCA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v5 7/8] fscrypt: make infos have a pointer to prepared keys
Date:   Sun,  9 Jul 2023 14:53:07 -0400
Message-Id: <e7e91ba546093de48303355311e67a79c32d728f.1688927423.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1688927423.git.sweettea-kernel@dorminy.me>
References: <cover.1688927423.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

At present, it's not entirely clear who owns a prepared key. Under
default policies, infos own the prepared key; but under any of the
policy flag key policies, or with some v1 policies, the info merely has
a copy of the authoritative prepared key; the authoritative copy of the
prepared key lives in the master key or the direct key, but the info has
no way to get to the authoritative key or get updates from it.

A scenario which could occur is the following:

-A directory tree is set up to use v2 policy DIRECT_KEY, mode adiantum.
-One directory is opened, gets a prepared key with a crypto_skcipher.
-A file within it is opened, sets up and gets the 'same' prepared key,
 but it's set up the blk_crypto_key in the prepared key.
-Another directory in the tree is opened, and gets the 'same' prepared
 key, but it's now got a pointer to the blk_crypto_key too.
-The two directories' ci_enc_key values are different, even though for
 practical purposes they are the same.

While it has no correctness implications, it's confusing for debugging
when two directories with the same mode/policy have different prepared
key contents depending on what else happened.

Adding a layer of indirection makes everything clearer at the cost of
another pointer. Now everyone sharing a prepared key within a direct key
or a master key have the same pointer to the single prepared key.
Followups move information from the crypt_info into the prepared key,
which ends up reducing memory usage slightly. And, it makes using
pooled, pre-allocated objects which could be stolen from a dormant
fscrypt_info much easier.

So this change makes crypt_info->ci_enc_key a pointer and updates all
users thereof.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/crypto/crypto.c          |  2 +-
 fs/crypto/fname.c           |  4 ++--
 fs/crypto/fscrypt_private.h |  2 +-
 fs/crypto/inline_crypt.c    |  4 ++--
 fs/crypto/keysetup.c        | 16 +++++++++++-----
 fs/crypto/keysetup_v1.c     |  2 +-
 6 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 6a837e4b80dc..9f3bda18c797 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -108,7 +108,7 @@ int fscrypt_crypt_block(const struct inode *inode, fscrypt_direction_t rw,
 	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist dst, src;
 	struct fscrypt_info *ci = inode->i_crypt_info;
-	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
+	struct crypto_skcipher *tfm = ci->ci_enc_key->tfm;
 	int res = 0;
 
 	if (WARN_ON_ONCE(len <= 0))
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 6eae3f12ad50..edb78cd1b0e7 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -101,7 +101,7 @@ int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
 	struct skcipher_request *req = NULL;
 	DECLARE_CRYPTO_WAIT(wait);
 	const struct fscrypt_info *ci = inode->i_crypt_info;
-	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
+	struct crypto_skcipher *tfm = ci->ci_enc_key->tfm;
 	union fscrypt_iv iv;
 	struct scatterlist sg;
 	int res;
@@ -158,7 +158,7 @@ static int fname_decrypt(const struct inode *inode,
 	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist src_sg, dst_sg;
 	const struct fscrypt_info *ci = inode->i_crypt_info;
-	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
+	struct crypto_skcipher *tfm = ci->ci_enc_key->tfm;
 	union fscrypt_iv iv;
 	int res;
 
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 7ab5a7b7eef8..5011737b60b3 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -198,7 +198,7 @@ struct fscrypt_prepared_key {
 struct fscrypt_info {
 
 	/* The key in a form prepared for actual encryption/decryption */
-	struct fscrypt_prepared_key ci_enc_key;
+	struct fscrypt_prepared_key *ci_enc_key;
 
 	/* True if ci_enc_key should be freed when this fscrypt_info is freed */
 	bool ci_owns_key;
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 8bfb3ce86476..2063f7941ce6 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -273,7 +273,7 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 	ci = inode->i_crypt_info;
 
 	fscrypt_generate_dun(ci, first_lblk, dun);
-	bio_crypt_set_ctx(bio, ci->ci_enc_key.blk_key, dun, gfp_mask);
+	bio_crypt_set_ctx(bio, ci->ci_enc_key->blk_key, dun, gfp_mask);
 }
 EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
 
@@ -360,7 +360,7 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 	 * uses the same pointer.  I.e., there's currently no need to support
 	 * merging requests where the keys are the same but the pointers differ.
 	 */
-	if (bc->bc_key != inode->i_crypt_info->ci_enc_key.blk_key)
+	if (bc->bc_key != inode->i_crypt_info->ci_enc_key->blk_key)
 		return false;
 
 	fscrypt_generate_dun(inode->i_crypt_info, next_lblk, next_dun);
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 7dd12c1821dd..4f04999ecfd1 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -192,7 +192,11 @@ void fscrypt_destroy_prepared_key(struct super_block *sb,
 int fscrypt_set_per_file_enc_key(struct fscrypt_info *ci, const u8 *raw_key)
 {
 	ci->ci_owns_key = true;
-	return fscrypt_prepare_key(&ci->ci_enc_key, raw_key, ci);
+	ci->ci_enc_key = kzalloc(sizeof(*ci->ci_enc_key), GFP_KERNEL);
+	if (!ci->ci_enc_key)
+		return -ENOMEM;
+
+	return fscrypt_prepare_key(ci->ci_enc_key, raw_key, ci);
 }
 
 static struct fscrypt_prepared_key *
@@ -311,14 +315,14 @@ static int setup_mode_prepared_key(struct fscrypt_info *ci,
 		return PTR_ERR(prep_key);
 
 	if (fscrypt_is_key_prepared(prep_key, ci)) {
-		ci->ci_enc_key = *prep_key;
+		ci->ci_enc_key = prep_key;
 		return 0;
 	}
 	err = setup_new_mode_prepared_key(mk, prep_key, ci);
 	if (err)
 		return err;
 
-	ci->ci_enc_key = *prep_key;
+	ci->ci_enc_key = prep_key;
 	return 0;
 }
 
@@ -582,9 +586,11 @@ static void put_crypt_info(struct fscrypt_info *ci)
 
 	if (ci->ci_direct_key)
 		fscrypt_put_direct_key(ci->ci_direct_key);
-	else if (ci->ci_owns_key)
+	else if (ci->ci_owns_key) {
 		fscrypt_destroy_prepared_key(ci->ci_inode->i_sb,
-					     &ci->ci_enc_key);
+					     ci->ci_enc_key);
+		kfree_sensitive(ci->ci_enc_key);
+	}
 
 	mk = ci->ci_master_key;
 	if (mk) {
diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
index 75dabd9b27f9..e1d761e8067f 100644
--- a/fs/crypto/keysetup_v1.c
+++ b/fs/crypto/keysetup_v1.c
@@ -259,7 +259,7 @@ static int setup_v1_file_key_direct(struct fscrypt_info *ci,
 	if (IS_ERR(dk))
 		return PTR_ERR(dk);
 	ci->ci_direct_key = dk;
-	ci->ci_enc_key = dk->dk_key;
+	ci->ci_enc_key = &dk->dk_key;
 	return 0;
 }
 
-- 
2.40.1

