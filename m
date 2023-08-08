Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F259774625
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Aug 2023 20:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjHHSx7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Aug 2023 14:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHHSxi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Aug 2023 14:53:38 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189AE5FDC2;
        Tue,  8 Aug 2023 10:08:28 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 9F66183533;
        Tue,  8 Aug 2023 13:08:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1691514507; bh=00y/3vVJG+zulZ5j0qomwBwj0hM9Ucvwq7H2Bzn4niw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZlYo6r2Sad3YVQFkp5bpVzks59EFOuYZdqrTx1JSck66n1JWf7E3DC+0pVjwp/27C
         DwGxyyhvNqOndzcoBCCE0wv4cjPFa3+yws1+gk5zppWgIoX7zfNWqUCwOorquJjsbS
         2ntkd6RanBdwJ6fY8C8eKfOg8+gtxVOJNZiRoPx1fZa8ggaAHsMsa9N5WUtwZp+eCS
         bgTczNzGa8cAZDbtUMfBinwfugUlGMhFWymVyIo0ojM/yxJ+kKXg9h19S9HWOMyka/
         ayiIaIguhHg1kIn+nsEHipxFjA7w9hpDnOCiMcuzpMMV3HbtT1TDJZ+X0GN57jjwUQ
         dZY7fEhk5Msrw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@meta.com,
        linux-btrfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v6 8/8] fscrypt: make prepared keys record their type
Date:   Tue,  8 Aug 2023 13:08:08 -0400
Message-ID: <64c47243cea5a8eca15538b51f88c0a6d53799cf.1691505830.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1691505830.git.sweettea-kernel@dorminy.me>
References: <cover.1691505830.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Right now fscrypt_infos have two fields dedicated solely to recording
what type of prepared key the info has: whether it solely owns the
prepared key, or has borrowed it from a master key, or from a direct
key.

The ci_direct_key field is only used for v1 direct key policies,
recording the direct key that needs to have its refcount reduced when
the crypt_info is freed. However, now that crypt_info->ci_enc_key is a
pointer to the authoritative prepared key -- embedded in the direct key,
in this case, we no longer need to keep a full pointer to the direct key
-- we can use container_of() to go from the prepared key to its
surrounding direct key.

The key ownership information doesn't change during the lifetime of a
prepared key.  Since at worst there's a prepared key per info, and at
best many infos share a single prepared key, it can be slightly more
efficient to store this ownership info in the prepared key instead of in
the fscrypt_info, especially since we can squash both fields down into
a single enum.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/crypto/fscrypt_private.h | 31 +++++++++++++++++++++++--------
 fs/crypto/keysetup.c        | 21 +++++++++++++--------
 fs/crypto/keysetup_v1.c     |  7 +++++--
 3 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 20b8ea1e3518..e2acd8894ea7 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -174,18 +174,39 @@ struct fscrypt_symlink_data {
 	char encrypted_path[];
 } __packed;
 
+/**
+ * enum fscrypt_prepared_key_type - records a prepared key's ownership
+ *
+ * @FSCRYPT_KEY_PER_INFO: this prepared key is allocated for a specific info
+ *		          and is never shared.
+ * @FSCRYPT_KEY_DIRECT_V1: this prepared key is embedded in a fscrypt_direct_key
+ *		           used in v1 direct key policies.
+ * @FSCRYPT_KEY_MASTER_KEY: this prepared key is a per-mode and policy key,
+ *			    part of a fscrypt_master_key, shared between all
+ *			    users of this master key having this mode and
+ *			    policy.
+ */
+enum fscrypt_prepared_key_type {
+	FSCRYPT_KEY_PER_INFO = 1,
+	FSCRYPT_KEY_DIRECT_V1,
+	FSCRYPT_KEY_MASTER_KEY,
+} __packed;
+
 /**
  * struct fscrypt_prepared_key - a key prepared for actual encryption/decryption
  * @tfm: crypto API transform object
  * @blk_key: key for blk-crypto
+ * @type: records the ownership type of the prepared key
  *
- * Normally only one of the fields will be non-NULL.
+ * Normally only one of @tfm and @blk_key will be non-NULL, although it is
+ * possible if @type is FSCRYPT_KEY_MASTER_KEY.
  */
 struct fscrypt_prepared_key {
 	struct crypto_skcipher *tfm;
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
 	struct blk_crypto_key *blk_key;
 #endif
+	enum fscrypt_prepared_key_type type;
 };
 
 /*
@@ -233,12 +254,6 @@ struct fscrypt_info {
 	 */
 	struct list_head ci_master_key_link;
 
-	/*
-	 * If non-NULL, then encryption is done using the master key directly
-	 * and ci_enc_key will equal ci_direct_key->dk_key.
-	 */
-	struct fscrypt_direct_key *ci_direct_key;
-
 	/*
 	 * This inode's hash key for filenames.  This is a 128-bit SipHash-2-4
 	 * key.  This is only set for directories that use a keyed dirhash over
@@ -641,7 +656,7 @@ static inline int fscrypt_require_key(struct inode *inode)
 
 /* keysetup_v1.c */
 
-void fscrypt_put_direct_key(struct fscrypt_direct_key *dk);
+void fscrypt_put_direct_key(struct fscrypt_prepared_key *prep_key);
 
 int fscrypt_setup_v1_file_key(struct fscrypt_info *ci,
 			      const u8 *raw_master_key);
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 4f04999ecfd1..a19650f954e2 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -191,11 +191,11 @@ void fscrypt_destroy_prepared_key(struct super_block *sb,
 /* Given a per-file encryption key, set up the file's crypto transform object */
 int fscrypt_set_per_file_enc_key(struct fscrypt_info *ci, const u8 *raw_key)
 {
-	ci->ci_owns_key = true;
 	ci->ci_enc_key = kzalloc(sizeof(*ci->ci_enc_key), GFP_KERNEL);
 	if (!ci->ci_enc_key)
 		return -ENOMEM;
 
+	ci->ci_enc_key->type = FSCRYPT_KEY_PER_INFO;
 	return fscrypt_prepare_key(ci->ci_enc_key, raw_key, ci);
 }
 
@@ -290,7 +290,8 @@ static int setup_new_mode_prepared_key(struct fscrypt_master_key *mk,
 				  hkdf_context, hkdf_info, hkdf_infolen,
 				  mode_key, mode->keysize);
 	if (err)
-		goto out_unlock;
+		return err;
+	prep_key->type = FSCRYPT_KEY_MASTER_KEY;
 	err = fscrypt_prepare_key(prep_key, mode_key, ci);
 	memzero_explicit(mode_key, mode->keysize);
 
@@ -584,12 +585,16 @@ static void put_crypt_info(struct fscrypt_info *ci)
 	if (!ci)
 		return;
 
-	if (ci->ci_direct_key)
-		fscrypt_put_direct_key(ci->ci_direct_key);
-	else if (ci->ci_owns_key) {
-		fscrypt_destroy_prepared_key(ci->ci_inode->i_sb,
-					     ci->ci_enc_key);
-		kfree_sensitive(ci->ci_enc_key);
+	if (ci->ci_enc_key) {
+		enum fscrypt_prepared_key_type type = ci->ci_enc_key->type;
+
+		if (type == FSCRYPT_KEY_DIRECT_V1)
+			fscrypt_put_direct_key(ci->ci_enc_key);
+		if (type == FSCRYPT_KEY_PER_INFO) {
+			fscrypt_destroy_prepared_key(ci->ci_inode->i_sb,
+						     ci->ci_enc_key);
+			kfree_sensitive(ci->ci_enc_key);
+		}
 	}
 
 	mk = ci->ci_master_key;
diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
index e1d761e8067f..1e785cedead0 100644
--- a/fs/crypto/keysetup_v1.c
+++ b/fs/crypto/keysetup_v1.c
@@ -160,8 +160,11 @@ static void free_direct_key(struct fscrypt_direct_key *dk)
 	}
 }
 
-void fscrypt_put_direct_key(struct fscrypt_direct_key *dk)
+void fscrypt_put_direct_key(struct fscrypt_prepared_key *prep_key)
 {
+	struct fscrypt_direct_key *dk =
+		container_of(prep_key, struct fscrypt_direct_key, dk_key);
+
 	if (!refcount_dec_and_lock(&dk->dk_refcount, &fscrypt_direct_keys_lock))
 		return;
 	hash_del(&dk->dk_node);
@@ -235,6 +238,7 @@ fscrypt_get_direct_key(const struct fscrypt_info *ci, const u8 *raw_key)
 	dk->dk_sb = ci->ci_inode->i_sb;
 	refcount_set(&dk->dk_refcount, 1);
 	dk->dk_mode = ci->ci_mode;
+	dk->dk_key.type = FSCRYPT_KEY_DIRECT_V1;
 	err = fscrypt_prepare_key(&dk->dk_key, raw_key, ci);
 	if (err)
 		goto err_free_dk;
@@ -258,7 +262,6 @@ static int setup_v1_file_key_direct(struct fscrypt_info *ci,
 	dk = fscrypt_get_direct_key(ci, raw_master_key);
 	if (IS_ERR(dk))
 		return PTR_ERR(dk);
-	ci->ci_direct_key = dk;
 	ci->ci_enc_key = &dk->dk_key;
 	return 0;
 }
-- 
2.41.0

