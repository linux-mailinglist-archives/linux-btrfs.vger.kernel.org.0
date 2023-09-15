Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2637A1287
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 02:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjIOAsz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 20:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjIOAsy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 20:48:54 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592862700
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 17:48:50 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-65627d499e1so5129046d6.0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 17:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694738929; x=1695343729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0ikcv87aNvDfi1VQsX6iKChTiUVRaLul5QQojIgxts=;
        b=Xa8rxPgjoy16Sh8Wflxe+P0nbDjTZKIQ8HMdsvJvm5F1k/FtHxC/xZkj/HqkGtZ60g
         uQAksETzJwUKZZg48NodrE2Eu0EWnVcVjcj6KDO3+8QEdlFj4VrC5Qz+YDsyqTGUJkq7
         yTA0g7QPPcs/NzJwCbK2LA5pjMNos2+JTw221UvuLAEvL8D9vrN6UC5OAmH2xtBJ/Vy8
         jVb7qjdbePNWs+trGLQJfcryDwF2MjMbzGpZ0D6isYIlDjsmqOAinvZT41RbaX8EsQky
         mcSMDBcEem+zg7b2rlUuqrr2QmjP2XcKBOQZhgLgoExYZPSGZBEnYNtytTsbm8iTU3mT
         /oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694738929; x=1695343729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0ikcv87aNvDfi1VQsX6iKChTiUVRaLul5QQojIgxts=;
        b=gr3x7VFOoMBGJ55FmEVsv5XSK6zVbcSAENaQ/OsK0qcR1bvY1gb+KcYvyDwXUl5kO9
         TTuXJei/rpr4EuNHhRSCVu65g9ESck1tYrdT5sUR8Qq8ckeP8CBcA6Fp+0Em2K05b10c
         Z1SkAp0w9dQ3Ova2qAVA4ZC/dIF7WicemVqfcsciXeVyWctYhG+7jeourOcuerB8Mk2X
         AmWU67f4vbwi12Vt7o2bKeW0dwsuTXYf8gJcz8iOPnkUBjMoKkeGo6huWkbLiaHg9rUB
         Jb1ky48PdvmO7MDi138lwUHPJ5WPRg/7HmlY1/SXIDDN+kSPG62QZ6quJXJw+stvtyom
         mo3g==
X-Gm-Message-State: AOJu0YyqXcysgKytHy5iS4Awo6bq04313vCNMO9Y9wBZV//CwDOASUuw
        EKEfeJnaIPmeZZgfBBskoxiwwda+AhRgR9JqJ7JVJg==
X-Google-Smtp-Source: AGHT+IH0ULFR9CQ+yVi8v8sQnwX4tI45+giRfMIDt75Oy760bLZAD/B4l3EUWDiC/1MpdMjAacSibQ==
X-Received: by 2002:a0c:b455:0:b0:655:e12d:d42d with SMTP id e21-20020a0cb455000000b00655e12dd42dmr226440qvf.28.1694738929183;
        Thu, 14 Sep 2023 17:48:49 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k5-20020a0cf285000000b0062de6537febsm874469qvl.58.2023.09.14.17.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 17:48:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        clm@fb.com, ebiggers@kernel.org, ngompa13@gmail.com,
        sweettea-kernel@dorminy.me, kernel-team@meta.com
Subject: [PATCH 1/4] fscrypt: rename fscrypt_info => fscrypt_inode_info
Date:   Thu, 14 Sep 2023 20:47:42 -0400
Message-ID: <f2f653c9ea3a3e5897a988d882a73bab6054fd6f.1694738282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694738282.git.josef@toxicpanda.com>
References: <cover.1694738282.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to track per-extent information, so it'll be necessary to
distinguish between inode infos and extent infos.  Rename fscrypt_info
to fscrypt_inode_info, adjusting any lines that now exceed 80
characters.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/crypto/crypto.c          | 13 ++++++------
 fs/crypto/fname.c           |  6 +++---
 fs/crypto/fscrypt_private.h | 42 ++++++++++++++++++++-----------------
 fs/crypto/hooks.c           |  2 +-
 fs/crypto/inline_crypt.c    | 13 ++++++------
 fs/crypto/keyring.c         |  4 ++--
 fs/crypto/keysetup.c        | 38 +++++++++++++++++----------------
 fs/crypto/keysetup_v1.c     | 14 +++++++------
 fs/crypto/policy.c          | 11 +++++-----
 include/linux/fs.h          |  4 ++--
 include/linux/fscrypt.h     |  6 +++---
 11 files changed, 82 insertions(+), 71 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 6a837e4b80dc..2b2bb5740322 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -39,7 +39,7 @@ static mempool_t *fscrypt_bounce_page_pool = NULL;
 static struct workqueue_struct *fscrypt_read_workqueue;
 static DEFINE_MUTEX(fscrypt_init_mutex);
 
-struct kmem_cache *fscrypt_info_cachep;
+struct kmem_cache *fscrypt_inode_info_cachep;
 
 void fscrypt_enqueue_decrypt_work(struct work_struct *work)
 {
@@ -78,7 +78,7 @@ EXPORT_SYMBOL(fscrypt_free_bounce_page);
  * simply contain the lblk_num (e.g., IV_INO_LBLK_32).
  */
 void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
-			 const struct fscrypt_info *ci)
+			 const struct fscrypt_inode_info *ci)
 {
 	u8 flags = fscrypt_policy_flags(&ci->ci_policy);
 
@@ -107,7 +107,7 @@ int fscrypt_crypt_block(const struct inode *inode, fscrypt_direction_t rw,
 	struct skcipher_request *req = NULL;
 	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist dst, src;
-	struct fscrypt_info *ci = inode->i_crypt_info;
+	struct fscrypt_inode_info *ci = inode->i_crypt_info;
 	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
 	int res = 0;
 
@@ -391,8 +391,9 @@ static int __init fscrypt_init(void)
 	if (!fscrypt_read_workqueue)
 		goto fail;
 
-	fscrypt_info_cachep = KMEM_CACHE(fscrypt_info, SLAB_RECLAIM_ACCOUNT);
-	if (!fscrypt_info_cachep)
+	fscrypt_inode_info_cachep = KMEM_CACHE(fscrypt_inode_info,
+					       SLAB_RECLAIM_ACCOUNT);
+	if (!fscrypt_inode_info_cachep)
 		goto fail_free_queue;
 
 	err = fscrypt_init_keyring();
@@ -402,7 +403,7 @@ static int __init fscrypt_init(void)
 	return 0;
 
 fail_free_info:
-	kmem_cache_destroy(fscrypt_info_cachep);
+	kmem_cache_destroy(fscrypt_inode_info_cachep);
 fail_free_queue:
 	destroy_workqueue(fscrypt_read_workqueue);
 fail:
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 6eae3f12ad50..7b3fc189593a 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -100,7 +100,7 @@ int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
 {
 	struct skcipher_request *req = NULL;
 	DECLARE_CRYPTO_WAIT(wait);
-	const struct fscrypt_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
 	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
 	union fscrypt_iv iv;
 	struct scatterlist sg;
@@ -157,7 +157,7 @@ static int fname_decrypt(const struct inode *inode,
 	struct skcipher_request *req = NULL;
 	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist src_sg, dst_sg;
-	const struct fscrypt_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
 	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
 	union fscrypt_iv iv;
 	int res;
@@ -568,7 +568,7 @@ EXPORT_SYMBOL_GPL(fscrypt_match_name);
  */
 u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name)
 {
-	const struct fscrypt_info *ci = dir->i_crypt_info;
+	const struct fscrypt_inode_info *ci = dir->i_crypt_info;
 
 	WARN_ON_ONCE(!ci->ci_dirhash_key_initialized);
 
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 2d63da48635a..b982073d1fe2 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -189,18 +189,21 @@ struct fscrypt_prepared_key {
 };
 
 /*
- * fscrypt_info - the "encryption key" for an inode
+ * fscrypt_inode_info - the "encryption key" for an inode
  *
  * When an encrypted file's key is made available, an instance of this struct is
  * allocated and stored in ->i_crypt_info.  Once created, it remains until the
  * inode is evicted.
  */
-struct fscrypt_info {
+struct fscrypt_inode_info {
 
 	/* The key in a form prepared for actual encryption/decryption */
 	struct fscrypt_prepared_key ci_enc_key;
 
-	/* True if ci_enc_key should be freed when this fscrypt_info is freed */
+	/*
+	 * True if ci_enc_key should be freed when this fscrypt_inode_info is
+	 * freed
+	 */
 	bool ci_owns_key;
 
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
@@ -263,7 +266,7 @@ typedef enum {
 } fscrypt_direction_t;
 
 /* crypto.c */
-extern struct kmem_cache *fscrypt_info_cachep;
+extern struct kmem_cache *fscrypt_inode_info_cachep;
 int fscrypt_initialize(struct super_block *sb);
 int fscrypt_crypt_block(const struct inode *inode, fscrypt_direction_t rw,
 			u64 lblk_num, struct page *src_page,
@@ -294,7 +297,7 @@ union fscrypt_iv {
 };
 
 void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
-			 const struct fscrypt_info *ci);
+			 const struct fscrypt_inode_info *ci);
 
 /* fname.c */
 bool __fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
@@ -332,17 +335,17 @@ void fscrypt_destroy_hkdf(struct fscrypt_hkdf *hkdf);
 
 /* inline_crypt.c */
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
-int fscrypt_select_encryption_impl(struct fscrypt_info *ci);
+int fscrypt_select_encryption_impl(struct fscrypt_inode_info *ci);
 
 static inline bool
-fscrypt_using_inline_encryption(const struct fscrypt_info *ci)
+fscrypt_using_inline_encryption(const struct fscrypt_inode_info *ci)
 {
 	return ci->ci_inlinecrypt;
 }
 
 int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 				     const u8 *raw_key,
-				     const struct fscrypt_info *ci);
+				     const struct fscrypt_inode_info *ci);
 
 void fscrypt_destroy_inline_crypt_key(struct super_block *sb,
 				      struct fscrypt_prepared_key *prep_key);
@@ -353,7 +356,7 @@ void fscrypt_destroy_inline_crypt_key(struct super_block *sb,
  */
 static inline bool
 fscrypt_is_key_prepared(struct fscrypt_prepared_key *prep_key,
-			const struct fscrypt_info *ci)
+			const struct fscrypt_inode_info *ci)
 {
 	/*
 	 * The two smp_load_acquire()'s here pair with the smp_store_release()'s
@@ -370,13 +373,13 @@ fscrypt_is_key_prepared(struct fscrypt_prepared_key *prep_key,
 
 #else /* CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
 
-static inline int fscrypt_select_encryption_impl(struct fscrypt_info *ci)
+static inline int fscrypt_select_encryption_impl(struct fscrypt_inode_info *ci)
 {
 	return 0;
 }
 
 static inline bool
-fscrypt_using_inline_encryption(const struct fscrypt_info *ci)
+fscrypt_using_inline_encryption(const struct fscrypt_inode_info *ci)
 {
 	return false;
 }
@@ -384,7 +387,7 @@ fscrypt_using_inline_encryption(const struct fscrypt_info *ci)
 static inline int
 fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 				 const u8 *raw_key,
-				 const struct fscrypt_info *ci)
+				 const struct fscrypt_inode_info *ci)
 {
 	WARN_ON_ONCE(1);
 	return -EOPNOTSUPP;
@@ -398,7 +401,7 @@ fscrypt_destroy_inline_crypt_key(struct super_block *sb,
 
 static inline bool
 fscrypt_is_key_prepared(struct fscrypt_prepared_key *prep_key,
-			const struct fscrypt_info *ci)
+			const struct fscrypt_inode_info *ci)
 {
 	return smp_load_acquire(&prep_key->tfm) != NULL;
 }
@@ -598,17 +601,18 @@ struct fscrypt_mode {
 extern struct fscrypt_mode fscrypt_modes[];
 
 int fscrypt_prepare_key(struct fscrypt_prepared_key *prep_key,
-			const u8 *raw_key, const struct fscrypt_info *ci);
+			const u8 *raw_key, const struct fscrypt_inode_info *ci);
 
 void fscrypt_destroy_prepared_key(struct super_block *sb,
 				  struct fscrypt_prepared_key *prep_key);
 
-int fscrypt_set_per_file_enc_key(struct fscrypt_info *ci, const u8 *raw_key);
+int fscrypt_set_per_file_enc_key(struct fscrypt_inode_info *ci,
+				 const u8 *raw_key);
 
-int fscrypt_derive_dirhash_key(struct fscrypt_info *ci,
+int fscrypt_derive_dirhash_key(struct fscrypt_inode_info *ci,
 			       const struct fscrypt_master_key *mk);
 
-void fscrypt_hash_inode_number(struct fscrypt_info *ci,
+void fscrypt_hash_inode_number(struct fscrypt_inode_info *ci,
 			       const struct fscrypt_master_key *mk);
 
 int fscrypt_get_encryption_info(struct inode *inode, bool allow_unsupported);
@@ -643,10 +647,10 @@ static inline int fscrypt_require_key(struct inode *inode)
 
 void fscrypt_put_direct_key(struct fscrypt_direct_key *dk);
 
-int fscrypt_setup_v1_file_key(struct fscrypt_info *ci,
+int fscrypt_setup_v1_file_key(struct fscrypt_inode_info *ci,
 			      const u8 *raw_master_key);
 
-int fscrypt_setup_v1_file_key_via_subscribed_keyrings(struct fscrypt_info *ci);
+int fscrypt_setup_v1_file_key_via_subscribed_keyrings(struct fscrypt_inode_info *ci);
 
 /* policy.c */
 
diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 6238dbcadcad..85d2975b69b7 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -169,7 +169,7 @@ EXPORT_SYMBOL_GPL(__fscrypt_prepare_setattr);
 int fscrypt_prepare_setflags(struct inode *inode,
 			     unsigned int oldflags, unsigned int flags)
 {
-	struct fscrypt_info *ci;
+	struct fscrypt_inode_info *ci;
 	struct fscrypt_master_key *mk;
 	int err;
 
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 8bfb3ce86476..3cfb04b8b64f 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -39,7 +39,7 @@ static struct block_device **fscrypt_get_devices(struct super_block *sb,
 	return devs;
 }
 
-static unsigned int fscrypt_get_dun_bytes(const struct fscrypt_info *ci)
+static unsigned int fscrypt_get_dun_bytes(const struct fscrypt_inode_info *ci)
 {
 	struct super_block *sb = ci->ci_inode->i_sb;
 	unsigned int flags = fscrypt_policy_flags(&ci->ci_policy);
@@ -90,7 +90,7 @@ static void fscrypt_log_blk_crypto_impl(struct fscrypt_mode *mode,
 }
 
 /* Enable inline encryption for this file if supported. */
-int fscrypt_select_encryption_impl(struct fscrypt_info *ci)
+int fscrypt_select_encryption_impl(struct fscrypt_inode_info *ci)
 {
 	const struct inode *inode = ci->ci_inode;
 	struct super_block *sb = inode->i_sb;
@@ -152,7 +152,7 @@ int fscrypt_select_encryption_impl(struct fscrypt_info *ci)
 
 int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 				     const u8 *raw_key,
-				     const struct fscrypt_info *ci)
+				     const struct fscrypt_inode_info *ci)
 {
 	const struct inode *inode = ci->ci_inode;
 	struct super_block *sb = inode->i_sb;
@@ -232,7 +232,8 @@ bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
 }
 EXPORT_SYMBOL_GPL(__fscrypt_inode_uses_inline_crypto);
 
-static void fscrypt_generate_dun(const struct fscrypt_info *ci, u64 lblk_num,
+static void fscrypt_generate_dun(const struct fscrypt_inode_info *ci,
+				 u64 lblk_num,
 				 u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE])
 {
 	union fscrypt_iv iv;
@@ -265,7 +266,7 @@ static void fscrypt_generate_dun(const struct fscrypt_info *ci, u64 lblk_num,
 void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 			       u64 first_lblk, gfp_t gfp_mask)
 {
-	const struct fscrypt_info *ci;
+	const struct fscrypt_inode_info *ci;
 	u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
 
 	if (!fscrypt_inode_uses_inline_crypto(inode))
@@ -456,7 +457,7 @@ EXPORT_SYMBOL_GPL(fscrypt_dio_supported);
  */
 u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks)
 {
-	const struct fscrypt_info *ci;
+	const struct fscrypt_inode_info *ci;
 	u32 dun;
 
 	if (!fscrypt_inode_uses_inline_crypto(inode))
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 7cbb1fd872ac..a51fa6a33de1 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -867,7 +867,7 @@ static void shrink_dcache_inode(struct inode *inode)
 
 static void evict_dentries_for_decrypted_inodes(struct fscrypt_master_key *mk)
 {
-	struct fscrypt_info *ci;
+	struct fscrypt_inode_info *ci;
 	struct inode *inode;
 	struct inode *toput_inode = NULL;
 
@@ -917,7 +917,7 @@ static int check_for_busy_inodes(struct super_block *sb,
 		/* select an example file to show for debugging purposes */
 		struct inode *inode =
 			list_first_entry(&mk->mk_decrypted_inodes,
-					 struct fscrypt_info,
+					 struct fscrypt_inode_info,
 					 ci_master_key_link)->ci_inode;
 		ino = inode->i_ino;
 	}
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 361f41ef46c7..cbcbe582737e 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -148,7 +148,7 @@ fscrypt_allocate_skcipher(struct fscrypt_mode *mode, const u8 *raw_key,
  * and IV generation method (@ci->ci_policy.flags).
  */
 int fscrypt_prepare_key(struct fscrypt_prepared_key *prep_key,
-			const u8 *raw_key, const struct fscrypt_info *ci)
+			const u8 *raw_key, const struct fscrypt_inode_info *ci)
 {
 	struct crypto_skcipher *tfm;
 
@@ -178,13 +178,14 @@ void fscrypt_destroy_prepared_key(struct super_block *sb,
 }
 
 /* Given a per-file encryption key, set up the file's crypto transform object */
-int fscrypt_set_per_file_enc_key(struct fscrypt_info *ci, const u8 *raw_key)
+int fscrypt_set_per_file_enc_key(struct fscrypt_inode_info *ci,
+				 const u8 *raw_key)
 {
 	ci->ci_owns_key = true;
 	return fscrypt_prepare_key(&ci->ci_enc_key, raw_key, ci);
 }
 
-static int setup_per_mode_enc_key(struct fscrypt_info *ci,
+static int setup_per_mode_enc_key(struct fscrypt_inode_info *ci,
 				  struct fscrypt_master_key *mk,
 				  struct fscrypt_prepared_key *keys,
 				  u8 hkdf_context, bool include_fs_uuid)
@@ -265,7 +266,7 @@ static int fscrypt_derive_siphash_key(const struct fscrypt_master_key *mk,
 	return 0;
 }
 
-int fscrypt_derive_dirhash_key(struct fscrypt_info *ci,
+int fscrypt_derive_dirhash_key(struct fscrypt_inode_info *ci,
 			       const struct fscrypt_master_key *mk)
 {
 	int err;
@@ -279,7 +280,7 @@ int fscrypt_derive_dirhash_key(struct fscrypt_info *ci,
 	return 0;
 }
 
-void fscrypt_hash_inode_number(struct fscrypt_info *ci,
+void fscrypt_hash_inode_number(struct fscrypt_inode_info *ci,
 			       const struct fscrypt_master_key *mk)
 {
 	WARN_ON_ONCE(ci->ci_inode->i_ino == 0);
@@ -289,7 +290,7 @@ void fscrypt_hash_inode_number(struct fscrypt_info *ci,
 					      &mk->mk_ino_hash_key);
 }
 
-static int fscrypt_setup_iv_ino_lblk_32_key(struct fscrypt_info *ci,
+static int fscrypt_setup_iv_ino_lblk_32_key(struct fscrypt_inode_info *ci,
 					    struct fscrypt_master_key *mk)
 {
 	int err;
@@ -329,7 +330,7 @@ static int fscrypt_setup_iv_ino_lblk_32_key(struct fscrypt_info *ci,
 	return 0;
 }
 
-static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
+static int fscrypt_setup_v2_file_key(struct fscrypt_inode_info *ci,
 				     struct fscrypt_master_key *mk,
 				     bool need_dirhash_key)
 {
@@ -404,7 +405,7 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
  * still allow 512-bit master keys if the user chooses to use them, though.)
  */
 static bool fscrypt_valid_master_key_size(const struct fscrypt_master_key *mk,
-					  const struct fscrypt_info *ci)
+					  const struct fscrypt_inode_info *ci)
 {
 	unsigned int min_keysize;
 
@@ -430,11 +431,12 @@ static bool fscrypt_valid_master_key_size(const struct fscrypt_master_key *mk,
  *
  * If the master key is found in the filesystem-level keyring, then it is
  * returned in *mk_ret with its semaphore read-locked.  This is needed to ensure
- * that only one task links the fscrypt_info into ->mk_decrypted_inodes (as
- * multiple tasks may race to create an fscrypt_info for the same inode), and to
- * synchronize the master key being removed with a new inode starting to use it.
+ * that only one task links the fscrypt_inode_info into ->mk_decrypted_inodes
+ * (as multiple tasks may race to create an fscrypt_inode_info for the same
+ * inode), and to synchronize the master key being removed with a new inode
+ * starting to use it.
  */
-static int setup_file_encryption_key(struct fscrypt_info *ci,
+static int setup_file_encryption_key(struct fscrypt_inode_info *ci,
 				     bool need_dirhash_key,
 				     struct fscrypt_master_key **mk_ret)
 {
@@ -519,7 +521,7 @@ static int setup_file_encryption_key(struct fscrypt_info *ci,
 	return err;
 }
 
-static void put_crypt_info(struct fscrypt_info *ci)
+static void put_crypt_info(struct fscrypt_inode_info *ci)
 {
 	struct fscrypt_master_key *mk;
 
@@ -546,7 +548,7 @@ static void put_crypt_info(struct fscrypt_info *ci)
 		fscrypt_put_master_key_activeref(ci->ci_inode->i_sb, mk);
 	}
 	memzero_explicit(ci, sizeof(*ci));
-	kmem_cache_free(fscrypt_info_cachep, ci);
+	kmem_cache_free(fscrypt_inode_info_cachep, ci);
 }
 
 static int
@@ -555,7 +557,7 @@ fscrypt_setup_encryption_info(struct inode *inode,
 			      const u8 nonce[FSCRYPT_FILE_NONCE_SIZE],
 			      bool need_dirhash_key)
 {
-	struct fscrypt_info *crypt_info;
+	struct fscrypt_inode_info *crypt_info;
 	struct fscrypt_mode *mode;
 	struct fscrypt_master_key *mk = NULL;
 	int res;
@@ -564,7 +566,7 @@ fscrypt_setup_encryption_info(struct inode *inode,
 	if (res)
 		return res;
 
-	crypt_info = kmem_cache_zalloc(fscrypt_info_cachep, GFP_KERNEL);
+	crypt_info = kmem_cache_zalloc(fscrypt_inode_info_cachep, GFP_KERNEL);
 	if (!crypt_info)
 		return -ENOMEM;
 
@@ -735,7 +737,7 @@ EXPORT_SYMBOL_GPL(fscrypt_prepare_new_inode);
  * fscrypt_put_encryption_info() - free most of an inode's fscrypt data
  * @inode: an inode being evicted
  *
- * Free the inode's fscrypt_info.  Filesystems must call this when the inode is
+ * Free the inode's fscrypt_inode_info.  Filesystems must call this when the inode is
  * being evicted.  An RCU grace period need not have elapsed yet.
  */
 void fscrypt_put_encryption_info(struct inode *inode)
@@ -773,7 +775,7 @@ EXPORT_SYMBOL(fscrypt_free_inode);
  */
 int fscrypt_drop_inode(struct inode *inode)
 {
-	const struct fscrypt_info *ci = fscrypt_get_info(inode);
+	const struct fscrypt_inode_info *ci = fscrypt_get_info(inode);
 
 	/*
 	 * If ci is NULL, then the inode doesn't have an encryption key set up
diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
index 75dabd9b27f9..b1e36494facf 100644
--- a/fs/crypto/keysetup_v1.c
+++ b/fs/crypto/keysetup_v1.c
@@ -178,7 +178,8 @@ void fscrypt_put_direct_key(struct fscrypt_direct_key *dk)
  */
 static struct fscrypt_direct_key *
 find_or_insert_direct_key(struct fscrypt_direct_key *to_insert,
-			  const u8 *raw_key, const struct fscrypt_info *ci)
+			  const u8 *raw_key,
+			  const struct fscrypt_inode_info *ci)
 {
 	unsigned long hash_key;
 	struct fscrypt_direct_key *dk;
@@ -218,7 +219,7 @@ find_or_insert_direct_key(struct fscrypt_direct_key *to_insert,
 
 /* Prepare to encrypt directly using the master key in the given mode */
 static struct fscrypt_direct_key *
-fscrypt_get_direct_key(const struct fscrypt_info *ci, const u8 *raw_key)
+fscrypt_get_direct_key(const struct fscrypt_inode_info *ci, const u8 *raw_key)
 {
 	struct fscrypt_direct_key *dk;
 	int err;
@@ -250,7 +251,7 @@ fscrypt_get_direct_key(const struct fscrypt_info *ci, const u8 *raw_key)
 }
 
 /* v1 policy, DIRECT_KEY: use the master key directly */
-static int setup_v1_file_key_direct(struct fscrypt_info *ci,
+static int setup_v1_file_key_direct(struct fscrypt_inode_info *ci,
 				    const u8 *raw_master_key)
 {
 	struct fscrypt_direct_key *dk;
@@ -264,7 +265,7 @@ static int setup_v1_file_key_direct(struct fscrypt_info *ci,
 }
 
 /* v1 policy, !DIRECT_KEY: derive the file's encryption key */
-static int setup_v1_file_key_derived(struct fscrypt_info *ci,
+static int setup_v1_file_key_derived(struct fscrypt_inode_info *ci,
 				     const u8 *raw_master_key)
 {
 	u8 *derived_key;
@@ -289,7 +290,8 @@ static int setup_v1_file_key_derived(struct fscrypt_info *ci,
 	return err;
 }
 
-int fscrypt_setup_v1_file_key(struct fscrypt_info *ci, const u8 *raw_master_key)
+int fscrypt_setup_v1_file_key(struct fscrypt_inode_info *ci,
+			      const u8 *raw_master_key)
 {
 	if (ci->ci_policy.v1.flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY)
 		return setup_v1_file_key_direct(ci, raw_master_key);
@@ -297,7 +299,7 @@ int fscrypt_setup_v1_file_key(struct fscrypt_info *ci, const u8 *raw_master_key)
 		return setup_v1_file_key_derived(ci, raw_master_key);
 }
 
-int fscrypt_setup_v1_file_key_via_subscribed_keyrings(struct fscrypt_info *ci)
+int fscrypt_setup_v1_file_key_via_subscribed_keyrings(struct fscrypt_inode_info *ci)
 {
 	struct key *key;
 	const struct fscrypt_key *payload;
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index f4456ecb3f87..aa94bfe6c172 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -405,7 +405,7 @@ int fscrypt_policy_from_context(union fscrypt_policy *policy_u,
 /* Retrieve an inode's encryption policy */
 static int fscrypt_get_policy(struct inode *inode, union fscrypt_policy *policy)
 {
-	const struct fscrypt_info *ci;
+	const struct fscrypt_inode_info *ci;
 	union fscrypt_context ctx;
 	int ret;
 
@@ -647,8 +647,9 @@ int fscrypt_has_permitted_context(struct inode *parent, struct inode *child)
 
 	/*
 	 * Both parent and child are encrypted, so verify they use the same
-	 * encryption policy.  Compare the fscrypt_info structs if the keys are
-	 * available, otherwise retrieve and compare the fscrypt_contexts.
+	 * encryption policy.  Compare the fscrypt_inode_info structs if the
+	 * keys are available, otherwise retrieve and compare the
+	 * fscrypt_contexts.
 	 *
 	 * Note that the fscrypt_context retrieval will be required frequently
 	 * when accessing an encrypted directory tree without the key.
@@ -717,7 +718,7 @@ const union fscrypt_policy *fscrypt_policy_to_inherit(struct inode *dir)
  */
 int fscrypt_context_for_new_inode(void *ctx, struct inode *inode)
 {
-	struct fscrypt_info *ci = inode->i_crypt_info;
+	struct fscrypt_inode_info *ci = inode->i_crypt_info;
 
 	BUILD_BUG_ON(sizeof(union fscrypt_context) !=
 			FSCRYPT_SET_CONTEXT_MAX_SIZE);
@@ -742,7 +743,7 @@ EXPORT_SYMBOL_GPL(fscrypt_context_for_new_inode);
  */
 int fscrypt_set_context(struct inode *inode, void *fs_data)
 {
-	struct fscrypt_info *ci = inode->i_crypt_info;
+	struct fscrypt_inode_info *ci = inode->i_crypt_info;
 	union fscrypt_context ctx;
 	int ctxsize;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 562f2623c9c9..05fe3aebef93 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -67,7 +67,7 @@ struct swap_info_struct;
 struct seq_file;
 struct workqueue_struct;
 struct iov_iter;
-struct fscrypt_info;
+struct fscrypt_inode_info;
 struct fscrypt_operations;
 struct fsverity_info;
 struct fsverity_operations;
@@ -707,7 +707,7 @@ struct inode {
 #endif
 
 #ifdef CONFIG_FS_ENCRYPTION
-	struct fscrypt_info	*i_crypt_info;
+	struct fscrypt_inode_info	*i_crypt_info;
 #endif
 
 #ifdef CONFIG_FS_VERITY
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index c895b12737a1..ece426ac1d73 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -31,7 +31,7 @@
 #define FSCRYPT_CONTENTS_ALIGNMENT 16
 
 union fscrypt_policy;
-struct fscrypt_info;
+struct fscrypt_inode_info;
 struct fs_parameter;
 struct seq_file;
 
@@ -178,7 +178,7 @@ struct fscrypt_operations {
 					     unsigned int *num_devs);
 };
 
-static inline struct fscrypt_info *fscrypt_get_info(const struct inode *inode)
+static inline struct fscrypt_inode_info *fscrypt_get_info(const struct inode *inode)
 {
 	/*
 	 * Pairs with the cmpxchg_release() in fscrypt_setup_encryption_info().
@@ -390,7 +390,7 @@ static inline void fscrypt_set_ops(struct super_block *sb,
 }
 #else  /* !CONFIG_FS_ENCRYPTION */
 
-static inline struct fscrypt_info *fscrypt_get_info(const struct inode *inode)
+static inline struct fscrypt_inode_info *fscrypt_get_info(const struct inode *inode)
 {
 	return NULL;
 }
-- 
2.41.0

