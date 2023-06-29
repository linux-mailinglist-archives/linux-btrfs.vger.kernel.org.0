Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D46741D08
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 02:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjF2Aev (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 20:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjF2Aet (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 20:34:49 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455F61FC2;
        Wed, 28 Jun 2023 17:34:48 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id D22BF80B08;
        Wed, 28 Jun 2023 20:34:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1687998888; bh=8v03nnczaIeh7mNlBa4A7aeLNxXZn5vYckHRNeknOOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nImJzyVHzC3hNlt9+uUmuFQsosZug3xD90vrPV2Krw+7bhbFV011ta7SqH9p23Uf1
         p2W6Ka5vekNnz45lqT4BaV1rIpgEskjXQHk3eUaZU4RWmhpi4lW9jn9Pw0xIwEBSMy
         p4u9aVC41Br8Zw3ACAOzIRU23LTYlXof0ZL+C4BG95KDYCOlxM2c6pvnrkIlfo+3R/
         1W43ZNmaFoE4Djcovrv3pwwpR+pAGdu5nh/J96VNnWxZLL6wQoZmFnjOI9wzcwkrvs
         XS8iIqCIFmKPPk7rrcLdluyOFbseBJMKezt3ZIpRSHtaMFIKpqM0A/YRL8K6QME22S
         nCbQqrUPZ/PGw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@meta.com,
        linux-btrfs@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v1 09/12] fscrypt: add creation/usage/freeing of per-extent infos
Date:   Wed, 28 Jun 2023 20:29:39 -0400
Message-Id: <69695a1673993911f080ea16d565055fa619ffee.1687988246.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1687988246.git.sweettea-kernel@dorminy.me>
References: <cover.1687988246.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This change adds the superblock function pointer to get the info
corresponding to a specific block in an inode for a filesystem using
per-extent infos. It allows creating a info for a new extent and freeing
that info, and uses the extent's info if appropriate in encrypting
blocks of data.

This change does not deal with saving and loading an extent's info, but
introduces the mechanics necessary therefore.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/crypto/crypto.c          |  2 ++
 fs/crypto/fscrypt_private.h | 46 ++++++++++++++++++-----------
 fs/crypto/keyring.c         | 15 +++++++++-
 fs/crypto/keysetup.c        | 59 +++++++++++++++++++++++++++++++++++--
 include/linux/fscrypt.h     | 39 ++++++++++++++++++++++++
 5 files changed, 140 insertions(+), 21 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index d75f1b3f5795..0f0c721e40fe 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -113,6 +113,8 @@ int fscrypt_crypt_block(const struct inode *inode, fscrypt_direction_t rw,
 	struct crypto_skcipher *tfm = ci->ci_enc_key->tfm;
 	int res = 0;
 
+	if (!ci)
+		return -EINVAL;
 	if (WARN_ON_ONCE(len <= 0))
 		return -EINVAL;
 	if (WARN_ON_ONCE(len % FSCRYPT_CONTENTS_ALIGNMENT != 0))
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 8bf27ceeecd1..5eafa50a3298 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -286,6 +286,23 @@ typedef enum {
 	FS_ENCRYPT,
 } fscrypt_direction_t;
 
+/**
+ * fscrypt_uses_extent_encryption() -- whether an inode uses per-extent
+ *				       encryption
+ *
+ * @inode: the inode in question
+ *
+ * Return: true if the inode uses per-extent fscrypt_infos, false otherwise
+ */
+static inline bool fscrypt_uses_extent_encryption(const struct inode *inode)
+{
+	// Non-regular files don't have extents
+	if (!S_ISREG(inode->i_mode))
+		return false;
+
+	return !!inode->i_sb->s_cop->get_extent_info;
+}
+
 /**
  * fscrypt_get_lblk_info() - get the fscrypt_info to crypt a particular block
  *
@@ -306,6 +323,17 @@ static inline struct fscrypt_info *
 fscrypt_get_lblk_info(const struct inode *inode, u64 lblk, u64 *offset,
 		      u64 *extent_len)
 {
+	if (fscrypt_uses_extent_encryption(inode)) {
+		struct fscrypt_info *info;
+		int res;
+
+		res = inode->i_sb->s_cop->get_extent_info(inode, lblk, &info,
+							  offset, extent_len);
+		if (res == 0)
+			return info;
+		return NULL;
+	}
+
 	if (offset)
 		*offset = lblk;
 	if (extent_len)
@@ -314,24 +342,6 @@ fscrypt_get_lblk_info(const struct inode *inode, u64 lblk, u64 *offset,
 	return inode->i_crypt_info;
 }
 
-/**
- * fscrypt_uses_extent_encryption() -- whether an inode uses per-extent
- *				       encryption
- *
- * @inode: the inode in question
- *
- * Return: true if the inode uses per-extent fscrypt_infos, false otherwise
- */
-static inline bool fscrypt_uses_extent_encryption(const struct inode *inode)
-{
-	// Non-regular files don't have extents
-	if (!S_ISREG(inode->i_mode))
-		return false;
-
-	// No filesystems currently use per-extent infos
-	return false;
-}
-
 /**
  * fscrypt_get_info_ino() - get the ino or ino equivalent for an info
  *
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index bfcd2ecbe481..93f99b0fc20a 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -875,7 +875,7 @@ static void evict_dentries_for_decrypted_inodes(struct fscrypt_master_key *mk)
 
 	list_for_each_entry(ci, &mk->mk_decrypted_inodes, ci_master_key_link) {
 		inode = ci->ci_inode;
-		if (!inode) {
+		if (ci->ci_info_ptr) {
 			if (!ci->ci_sb->s_cop->forget_extent_info)
 				continue;
 
@@ -1036,6 +1036,19 @@ static int do_remove_key(struct file *filp, void __user *_uarg, bool all_users)
 	mk = fscrypt_find_master_key(sb, &arg.key_spec);
 	if (!mk)
 		return -ENOKEY;
+
+	/*
+	 * For filesystems with extent encryption, there may be extents which
+	 * need to come into existence and get the key, lest their data be
+	 * stuck in memory and not be flushable for lack of key. So just sync
+	 * the filesystem to encourage all the dirty pages to be written out.
+	 */
+	if (sb->s_cop->get_extent_info) {
+		down_read(&sb->s_umount);
+		sync_filesystem(sb);
+		up_read(&sb->s_umount);
+	}
+
 	down_write(&mk->mk_sem);
 
 	/* If relevant, remove current user's (or all users) claim to the key */
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index f166fabb7f73..0efa2800b50d 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -647,8 +647,8 @@ fscrypt_setup_encryption_info(struct inode *inode,
 
 	if (fscrypt_uses_extent_encryption(inode) && info_for_extent)
 		crypt_info->ci_info_ptr = info_ptr;
-	else
-		crypt_info->ci_inode = inode;
+
+	crypt_info->ci_inode = inode;
 
 	crypt_info->ci_sb = inode->i_sb;
 	crypt_info->ci_policy = *policy;
@@ -662,6 +662,7 @@ fscrypt_setup_encryption_info(struct inode *inode,
 	WARN_ON_ONCE(mode->ivsize > FSCRYPT_MAX_IV_SIZE);
 	crypt_info->ci_mode = mode;
 
+	pr_err("fsei1");
 	res = fscrypt_select_encryption_impl(crypt_info);
 	if (res)
 		goto out;
@@ -888,6 +889,60 @@ int fscrypt_prepare_new_inode(struct inode *dir, struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(fscrypt_prepare_new_inode);
 
+/**
+ * fscrypt_prepare_new_extent() - set up the fscrypt_info for a new extent
+ * @inode: the inode to which the extent belongs
+ * @info_ptr: a pointer to return the extent's fscrypt_info into. Should be
+ *	      a pointer to a member of the extent struct, as it will be passed
+ *	      back to the filesystem if key removal demands removal of the
+ *	      info from the extent
+ * @encrypt_ret: (output) set to %true if the new inode will be encrypted
+ *
+ * If the extent is part of an encrypted inode, set up its fscrypt_info in
+ * preparation for encrypting data and set *encrypt_ret=true.
+ *
+ * This isn't %GFP_NOFS-safe, and therefore it should be called before starting
+ * any filesystem transaction to create the inode.
+ *
+ * This doesn't persist the new inode's encryption context.  That still needs to
+ * be done later by calling fscrypt_set_context().
+ *
+ * Return: 0 on success, -ENOKEY if the encryption key is missing, or another
+ *	   -errno code
+ */
+int fscrypt_prepare_new_extent(struct inode *inode,
+			       struct fscrypt_info **info_ptr)
+{
+	const union fscrypt_policy *policy;
+	u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
+
+	policy = fscrypt_policy_to_inherit(inode);
+	if (policy == NULL)
+		return 0;
+	if (IS_ERR(policy))
+		return PTR_ERR(policy);
+
+	/* Only regular files can have extents.  */
+	if (WARN_ON_ONCE(!S_ISREG(inode->i_mode)))
+		return -EINVAL;
+
+	get_random_bytes(nonce, FSCRYPT_FILE_NONCE_SIZE);
+	return fscrypt_setup_encryption_info(inode, policy, nonce,
+					     false, info_ptr);
+}
+EXPORT_SYMBOL_GPL(fscrypt_prepare_new_extent);
+
+/**
+ * fscrypt_free_extent_info() - free an extent's fscrypt_info
+ * @info_ptr: a pointer containing the extent's fscrypt_info pointer.
+ */
+void fscrypt_free_extent_info(struct fscrypt_info **info_ptr)
+{
+	put_crypt_info(*info_ptr);
+	*info_ptr = NULL;
+}
+EXPORT_SYMBOL_GPL(fscrypt_free_extent_info);
+
 /**
  * fscrypt_put_encryption_info() - free most of an inode's fscrypt data
  * @inode: an inode being evicted
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 22affbb15706..1965b900f62f 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -113,6 +113,29 @@ struct fscrypt_operations {
 	int (*set_context)(struct inode *inode, const void *ctx, size_t len,
 			   void *fs_data);
 
+	/*
+	 * Get the fscrypt_info for the given inode at the given block, for
+	 * extent-based encryption only.
+	 *
+	 * @inode: the inode in question
+	 * @lblk: the logical block number in question
+	 * @ci: a pointer to return the fscrypt_info
+	 * @offset: a pointer to return the offset of @lblk into the extent,
+	 *          in blocks (may be NULL)
+	 * @extent_len: a pointer to return the number of blocks in this extent
+	 *              starting at this point (may be NULL)
+	 *
+	 * May cause the filesystem to allocate memory, which the filesystem
+	 * must do with %GFP_NOFS, including calls into fscrypt to create or
+	 * load an fscrypt_info.
+	 *
+	 * Return: 0 if an extent is found with an info, -ENODATA if the key is
+	 *         unavailable, or another -errno.
+	 */
+	int (*get_extent_info)(const struct inode *inode, u64 lblk,
+			       struct fscrypt_info **ci, u64 *offset,
+			       u64 *extent_len);
+
 	/*
 	 * Get the dummy fscrypt policy in use on the filesystem (if any).
 	 *
@@ -348,6 +371,10 @@ void fscrypt_put_encryption_info(struct inode *inode);
 void fscrypt_free_inode(struct inode *inode);
 int fscrypt_drop_inode(struct inode *inode);
 
+int fscrypt_prepare_new_extent(struct inode *inode,
+			       struct fscrypt_info **info_ptr);
+void fscrypt_free_extent_info(struct fscrypt_info **info_ptr);
+
 /* fname.c */
 int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
 			  u8 *out, unsigned int olen);
@@ -609,6 +636,18 @@ static inline int fscrypt_drop_inode(struct inode *inode)
 	return 0;
 }
 
+static inline int fscrypt_prepare_new_extent(struct inode *inode,
+					     struct fscrypt_info **info_ptr)
+{
+	if (IS_ENCRYPTED(inode))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static inline void fscrypt_free_extent_info(struct fscrypt_info **info_ptr)
+{
+}
+
  /* fname.c */
 static inline int fscrypt_setup_filename(struct inode *dir,
 					 const struct qstr *iname,
-- 
2.40.1

