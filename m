Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E140573445
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbiGMKbW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiGMKbU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:31:20 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F46FD204
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:31:19 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 57891802A1;
        Wed, 13 Jul 2022 06:31:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657708278; bh=LYkopNIK/2hwMIJB11zpRVXHzS56/xAM/+TjbaJIjrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MjWFI38ndzoHaQ2+blJMeKzIHbpOF3o0h+sf4B9G6xJSSaP4kDqABedpcQlKrdgt4
         4/LOauXHTN8pb+UtLHVS9Ox6P6GHnAGodGEZb+CtHTO5MkrtrYVJ/7cZWgWyllGp8M
         DjJAhvbAcypDPe3A2qIOW+QvTxWF69j1TFMoUrEyBXc3eCeNSTqmtsWe4mtiEX1Nd1
         Qe3nJLOP7D7N/VRvuh97UJjVbBqfm4QvLiJCTUTOZJFLxOr1RHZ6IDZXPJP+WZg0Ja
         o30M/CmDlD1Wfr9foFwcyxO0q3AqNf/6VoVNIgS7ivNMYXZZh1cdy8f+/Kb55A3hVh
         mBj9eBRkpGrUw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [RFC ONLY 17/23] fscrypt: Add new encryption policy for btrfs.
Date:   Wed, 13 Jul 2022 06:29:50 -0400
Message-Id: <b61466e5104011a4a4ee6529bdcfc9ccdc382c8e.1657707687.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1657707686.git.sweettea-kernel@dorminy.me>
References: <cover.1657707686.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Certain filesystems want to generate an IV for a particular block in
some way other than by inode number plus block number. In particular,
btrfs can change the block number for a particular piece of data, and
can have multiple inodes using the same block, so to use a IV generated
from the inode or the block number would interfere with normal
filesystem operation.

In order to prevent needing to plumb arbitrary methods of IV generation
into fscrypt, this change adds a new policy, IV_FROM_FS. If this policy
is used, the filesystem is required to provide an operation function
pointer, get_fs_derived_iv, which takes the inode and the offset of the
block within the inode and fills in the IV buffer itself. Such a
filesystem is expected to appropriately generate and store a persistent
random IV for each block of data.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/crypto/crypto.c           | 28 ++++++++++++++++++++++++++--
 fs/crypto/fname.c            | 17 ++++++++++++++++-
 fs/crypto/fscrypt_private.h  |  4 ++--
 fs/crypto/inline_crypt.c     | 20 ++++++++++++++------
 fs/crypto/keysetup.c         |  6 ++++++
 fs/crypto/policy.c           |  8 +++++++-
 include/linux/fscrypt.h      | 23 ++++++++++++++++++++++-
 include/uapi/linux/fscrypt.h |  1 +
 8 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index e78be66bbf01..e1dee6f27f69 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -69,6 +69,20 @@ void fscrypt_free_bounce_page(struct page *bounce_page)
 }
 EXPORT_SYMBOL(fscrypt_free_bounce_page);
 
+int fscrypt_mode_ivsize(struct inode *inode)
+{
+	struct fscrypt_info *ci;
+
+	if (!fscrypt_needs_contents_encryption(inode))
+		return 0;
+
+	ci = inode->i_crypt_info;
+	if (WARN_ON_ONCE(!ci))
+		return 0;
+	return ci->ci_mode->ivsize;
+}
+EXPORT_SYMBOL(fscrypt_mode_ivsize);
+
 /*
  * Generate the IV for the given logical block number within the given file.
  * For filenames encryption, lblk_num == 0.
@@ -81,13 +95,23 @@ void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 			 const struct fscrypt_info *ci)
 {
 	u8 flags = fscrypt_policy_flags(&ci->ci_policy);
+	struct inode *inode = ci->ci_inode;
 
 	memset(iv, 0, ci->ci_mode->ivsize);
+	if (flags & FSCRYPT_POLICY_FLAG_IV_FROM_FS) {
+		struct fscrypt_operations *s_cop = inode->i_sb->s_cop;
+		/* Provide the nonce in case the filesystem wants to use it */
+		memcpy(iv->nonce, ci->ci_nonce, FSCRYPT_FILE_NONCE_SIZE);
+		s_cop->get_fs_defined_iv(iv->raw, ci->ci_mode->ivsize, inode,
+					 lblk_num);
+		return;
+	}
+
 
 	if (flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) {
 		WARN_ON_ONCE(lblk_num > U32_MAX);
-		WARN_ON_ONCE(ci->ci_inode->i_ino > U32_MAX);
-		lblk_num |= (u64)ci->ci_inode->i_ino << 32;
+		WARN_ON_ONCE(inode->i_ino > U32_MAX);
+		lblk_num |= (u64)inode->i_ino << 32;
 	} else if (flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32) {
 		WARN_ON_ONCE(lblk_num > U32_MAX);
 		lblk_num = (u32)(ci->ci_hashed_ino + lblk_num);
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 5d5c26d827fd..c5dd19c1d19e 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -389,6 +389,7 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	fname->usr_fname = iname;
 
 	if (!IS_ENCRYPTED(dir) || fscrypt_is_dot_dotdot(iname)) {
+unencrypted:
 		fname->disk_name.name = (unsigned char *)iname->name;
 		fname->disk_name.len = iname->len;
 		return 0;
@@ -424,8 +425,16 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	 * user-supplied name
 	 */
 
-	if (iname->len > FSCRYPT_NOKEY_NAME_MAX_ENCODED)
+	if (iname->len > FSCRYPT_NOKEY_NAME_MAX_ENCODED) {
+		/*
+		 * This isn't a valid nokey name, but it could be an unencrypted
+		 * name if the filesystem allows partially encrypted
+		 * directories.
+		 */
+		if (dir->i_sb->s_cop->flags & FS_CFLG_ALLOW_PARTIAL)
+			goto unencrypted;
 		return -ENOENT;
+	}
 
 	fname->crypto_buf.name = kmalloc(FSCRYPT_NOKEY_NAME_MAX, GFP_KERNEL);
 	if (fname->crypto_buf.name == NULL)
@@ -436,6 +445,12 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	if (ret < (int)offsetof(struct fscrypt_nokey_name, bytes[1]) ||
 	    (ret > offsetof(struct fscrypt_nokey_name, sha256) &&
 	     ret != FSCRYPT_NOKEY_NAME_MAX)) {
+		/* Again, this could be an unencrypted name. */
+		if (dir->i_sb->s_cop->flags & FS_CFLG_ALLOW_PARTIAL) {
+			kfree(fname->crypto_buf.name);
+			fname->crypto_buf.name = NULL;
+			goto unencrypted;
+		}
 		ret = -ENOENT;
 		goto errout;
 	}
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 6b4c8094cc7b..084c6ba1e766 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -279,8 +279,6 @@ fscrypt_msg(const struct inode *inode, const char *level, const char *fmt, ...);
 #define fscrypt_err(inode, fmt, ...)		\
 	fscrypt_msg((inode), KERN_ERR, fmt, ##__VA_ARGS__)
 
-#define FSCRYPT_MAX_IV_SIZE	32
-
 union fscrypt_iv {
 	struct {
 		/* logical block number within the file */
@@ -326,6 +324,7 @@ int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
 #define HKDF_CONTEXT_DIRHASH_KEY	5 /* info=file_nonce		*/
 #define HKDF_CONTEXT_IV_INO_LBLK_32_KEY	6 /* info=mode_num||fs_uuid	*/
 #define HKDF_CONTEXT_INODE_HASH_KEY	7 /* info=<empty>		*/
+#define HKDF_CONTEXT_IV_FROM_FS_KEY	8 /* info=mode_num	*/
 
 int fscrypt_hkdf_expand(const struct fscrypt_hkdf *hkdf, u8 context,
 			const u8 *info, unsigned int infolen,
@@ -498,6 +497,7 @@ struct fscrypt_master_key {
 	struct fscrypt_prepared_key mk_direct_keys[FSCRYPT_MODE_MAX + 1];
 	struct fscrypt_prepared_key mk_iv_ino_lblk_64_keys[FSCRYPT_MODE_MAX + 1];
 	struct fscrypt_prepared_key mk_iv_ino_lblk_32_keys[FSCRYPT_MODE_MAX + 1];
+	struct fscrypt_prepared_key mk_iv_from_fs_keys[FSCRYPT_MODE_MAX + 1];
 
 	/* Hash key for inode numbers.  Initialized only when needed. */
 	siphash_key_t		mk_ino_hash_key;
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 90f3e68f166e..8a8330caadfa 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -476,14 +476,22 @@ u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks)
 		return nr_blocks;
 
 	ci = inode->i_crypt_info;
-	if (!(fscrypt_policy_flags(&ci->ci_policy) &
-	      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32))
-		return nr_blocks;
 
-	/* With IV_INO_LBLK_32, the DUN can wrap around from U32_MAX to 0. */
+	if (fscrypt_policy_flags(&ci->ci_policy) &
+	    FSCRYPT_POLICY_FLAG_IV_FROM_FS) {
+		return 1;
+	}
 
-	dun = ci->ci_hashed_ino + lblk;
+	if ((fscrypt_policy_flags(&ci->ci_policy) &
+	      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32)) {
+		/*
+		 * With IV_INO_LBLK_32, the DUN can wrap around from U32_MAX to
+		 * 0.
+		 */
+		dun = ci->ci_hashed_ino + lblk;
+		return min_t(u64, nr_blocks, (u64)U32_MAX + 1 - dun);
+	}
 
-	return min_t(u64, nr_blocks, (u64)U32_MAX + 1 - dun);
+	return nr_blocks;
 }
 EXPORT_SYMBOL_GPL(fscrypt_limit_io_blocks);
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index c35711896bd4..fa4c1951f9bf 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -323,6 +323,12 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 		 */
 		err = setup_per_mode_enc_key(ci, mk, mk->mk_direct_keys,
 					     HKDF_CONTEXT_DIRECT_KEY, false);
+	} else if ((ci->ci_policy.v2.flags & FSCRYPT_POLICY_FLAG_IV_FROM_FS) &&
+		   S_ISREG(ci->ci_inode->i_mode)) {
+		err = setup_per_mode_enc_key(ci, mk,
+					     mk->mk_iv_from_fs_keys,
+					     HKDF_CONTEXT_IV_FROM_FS_KEY,
+					     false);
 	} else if (ci->ci_policy.v2.flags &
 		   FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) {
 		/*
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 5763462af9e8..0c2066098211 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -199,7 +199,8 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 	if (policy->flags & ~(FSCRYPT_POLICY_FLAGS_PAD_MASK |
 			      FSCRYPT_POLICY_FLAG_DIRECT_KEY |
 			      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64 |
-			      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32)) {
+			      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32 |
+			      FSCRYPT_POLICY_FLAG_IV_FROM_FS)) {
 		fscrypt_warn(inode, "Unsupported encryption flags (0x%02x)",
 			     policy->flags);
 		return false;
@@ -208,6 +209,7 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 	count += !!(policy->flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY);
 	count += !!(policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64);
 	count += !!(policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32);
+	count += !!(policy->flags & FSCRYPT_POLICY_FLAG_IV_FROM_FS);
 	if (count > 1) {
 		fscrypt_warn(inode, "Mutually exclusive encryption flags (0x%02x)",
 			     policy->flags);
@@ -235,6 +237,10 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 					  32, 32))
 		return false;
 
+	if ((policy->flags & FSCRYPT_POLICY_FLAG_IV_FROM_FS) &&
+	    !inode->i_sb->s_cop->get_fs_defined_iv)
+		return false;
+
 	if (memchr_inv(policy->__reserved, 0, sizeof(policy->__reserved))) {
 		fscrypt_warn(inode, "Reserved bits set in encryption policy");
 		return false;
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index f3d1f5438a6c..3eab327960ca 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -100,6 +100,12 @@ struct fscrypt_nokey_name {
 /* Maximum value for the third parameter of fscrypt_operations.set_context(). */
 #define FSCRYPT_SET_CONTEXT_MAX_SIZE	40
 
+/*
+ * Maximum size needed for an IV. Defines the size of the buffer passed to a
+ * get_fs_defined_iv() function.
+ */
+#define FSCRYPT_MAX_IV_SIZE	32
+
 #ifdef CONFIG_FS_ENCRYPTION
 
 /*
@@ -108,6 +114,8 @@ struct fscrypt_nokey_name {
  * pages for writes and therefore won't need the fscrypt bounce page pool.
  */
 #define FS_CFLG_OWN_PAGES (1U << 1)
+/* The filesystem allows partially encrypted directories/files. */
+#define FS_CFLG_ALLOW_PARTIAL (1U << 2)
 
 /* Crypto operations for filesystems */
 struct fscrypt_operations {
@@ -202,7 +210,13 @@ struct fscrypt_operations {
 	 */
 	void (*get_ino_and_lblk_bits)(struct super_block *sb,
 				      int *ino_bits_ret, int *lblk_bits_ret);
-
+	/*
+	 * Generate an IV for a given inode and lblk number, for filesystems
+	 * where additional filesystem-internal information is necessary to
+	 * keep the IV stable.
+	 */
+	void (*get_fs_defined_iv)(u8 *iv, int ivsize, struct inode *inode,
+				  u64 lblk_num);
 	/*
 	 * Return the number of block devices to which the filesystem may write
 	 * encrypted file contents.
@@ -321,6 +335,8 @@ static inline struct page *fscrypt_pagecache_page(struct page *bounce_page)
 
 void fscrypt_free_bounce_page(struct page *bounce_page);
 
+int fscrypt_mode_ivsize(struct inode *inode);
+
 /* policy.c */
 int fscrypt_have_same_policy(struct inode *inode1, struct inode *inode2);
 int fscrypt_ioctl_set_policy(struct file *filp, const void __user *arg);
@@ -496,6 +512,11 @@ static inline void fscrypt_free_bounce_page(struct page *bounce_page)
 {
 }
 
+static inline int fscrypt_mode_ivsize(struct inode *inode)
+{
+	return 0;
+}
+
 /* policy.c */
 static inline int fscrypt_ioctl_set_policy(struct file *filp,
 					   const void __user *arg)
diff --git a/include/uapi/linux/fscrypt.h b/include/uapi/linux/fscrypt.h
index 9f4428be3e36..3fbde7668b07 100644
--- a/include/uapi/linux/fscrypt.h
+++ b/include/uapi/linux/fscrypt.h
@@ -20,6 +20,7 @@
 #define FSCRYPT_POLICY_FLAG_DIRECT_KEY		0x04
 #define FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64	0x08
 #define FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32	0x10
+#define FSCRYPT_POLICY_FLAG_IV_FROM_FS		0x20
 
 /* Encryption algorithms */
 #define FSCRYPT_MODE_AES_256_XTS		1
-- 
2.35.1

