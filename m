Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE03C7CB247
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjJPSWE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjJPSWD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:03 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E155CA7
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:00 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66d122e0c85so30563686d6.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480520; x=1698085320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEthQB3Mjbp+ibGcKFUE8oEpsq1+dIrAo94POd0z81Q=;
        b=qhX6cZqm1jNUxAFHGQwMgYue8Gp+vaED9UrT3RIhqsIO0QKERx1pctTXrv3aMvp2bz
         BW9q0ZK2iaM9A0ky23LRtYMreN8UiyoCGGAB9w/g+ukdaNPouulhdclSRfrxbC6qt2B1
         9hlqUckkpZ/b4XUAfMY0uXStIiQA69Y1MpnhsJOWmrvWOPNuE3tCgib6iYCKl/iltM+r
         BeXlpI2uv2MG2usGnUjCQD5yulZPkNu12IugNDcuyuklHSNDeyYHjH6x1ncuk0jpUiX2
         G5Ul6e3j3D09WUtrFZteKZDZ85+T0SmQC4JcniH9rMQr1KCusDppM24gSm2NxE1m7ifm
         beFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480520; x=1698085320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEthQB3Mjbp+ibGcKFUE8oEpsq1+dIrAo94POd0z81Q=;
        b=wMmJX6vf7HlPl+QvDEqGaXqQ0Str+iu0DYtRwX7UBIusm3LLDwuz6TlE+ajgq+a2dh
         zYyHpJPEaSm1g1LFuSez1MIZ3gA8BQZhHtL8dDorn2/Hg9aIPZT2UJ/8X9zbh5RbYzIW
         Rq36bVxmzNc76T5MJSj2a2ATuaLGbZhYQI8zqZC6KYv4lWrcqW5G7wv2xrX0tUTefC7c
         QaNyVchJXRHRc63HhjI/j/Q9l/MRmeKRoAxSFMmOrU/Tj/9UX3NnWMcKwr/nl3GC1nB7
         h54EBnge0b1j24TEdJf0DKLTU5ckE0vlczj77TTXQRQXEuAv+D9PL+BdSymuzl4ZiXaI
         qK7w==
X-Gm-Message-State: AOJu0Yys+14rH2dt4RODGdHkxrs8hLG5tj+/db3mFbQ+/UiJdiiSg1pT
        UD80lPB3veOFGQcxFh10UgBFvgJPwiARmeWZaHmxjg==
X-Google-Smtp-Source: AGHT+IE1htcA0SyCM/leq6bpjpIw/7c8sZknT7haC7KMnG40H2ax2/oD20JjzDhJ6rZpCYo8pQmLzA==
X-Received: by 2002:a05:6214:e85:b0:66d:626b:26ed with SMTP id hf5-20020a0562140e8500b0066d626b26edmr238171qvb.21.1697480519817;
        Mon, 16 Oct 2023 11:21:59 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m10-20020a0cf18a000000b0065d051fc445sm3659045qvl.55.2023.10.16.11.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:21:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 03/34] blk-crypto: add a process bio callback
Date:   Mon, 16 Oct 2023 14:21:10 -0400
Message-ID: <9c001bca584a523dca7a04dd99bfc5454d25b160.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs does checksumming, and the checksums need to match the bytes on
disk.  In order to facilitate this add a process bio callback for the
blk-crypto layer.  This allows the file system to specify a callback and
then can process the encrypted bio as necessary.

For btrfs, writes will have the checksums calculated and saved into our
relevant data structures for storage once the write completes.  For
reads we will validate the checksums match what is on disk and error out
if there is a mismatch.

This is incompatible with native encryption obviously, so make sure we
don't use native encryption if this callback is set.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-crypto-fallback.c | 40 +++++++++++++++++++++++++++++++++++++
 block/blk-crypto-internal.h |  8 ++++++++
 block/blk-crypto-profile.c  |  2 ++
 block/blk-crypto.c          |  6 +++++-
 fs/crypto/inline_crypt.c    |  3 ++-
 include/linux/blk-crypto.h  |  9 +++++++--
 include/linux/fscrypt.h     | 14 +++++++++++++
 7 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index e6468eab2681..1254fed9ffeb 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -346,6 +346,15 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 		}
 	}
 
+	/* Process the encrypted bio before we submit it. */
+	if (bc->bc_key->crypto_cfg.process_bio) {
+		blk_st = bc->bc_key->crypto_cfg.process_bio(src_bio, enc_bio);
+		if (blk_st != BLK_STS_OK) {
+			src_bio->bi_status = blk_st;
+			goto out_free_bounce_pages;
+		}
+	}
+
 	enc_bio->bi_private = src_bio;
 	enc_bio->bi_end_io = blk_crypto_fallback_encrypt_endio;
 	*bio_ptr = enc_bio;
@@ -391,6 +400,24 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
 	unsigned int i;
 	blk_status_t blk_st;
 
+	/*
+	 * Process the bio first before trying to decrypt.
+	 *
+	 * NOTE: btrfs expects that this bio is the same that was submitted.  If
+	 * at any point this changes we will need to update process_bio to take
+	 * f_ctx->crypt_iter in order to make sure we can iterate the pages for
+	 * checksumming.  We're currently saving this in our btrfs_bio, so this
+	 * works, but if at any point in the future we start allocating a bounce
+	 * bio or something we need to update this callback.
+	 */
+	if (bc->bc_key->crypto_cfg.process_bio) {
+		blk_st = bc->bc_key->crypto_cfg.process_bio(bio, bio);
+		if (blk_st != BLK_STS_OK) {
+			bio->bi_status = blk_st;
+			goto out_no_keyslot;
+		}
+	}
+
 	/*
 	 * Get a blk-crypto-fallback keyslot that contains a crypto_skcipher for
 	 * this bio's algorithm and key.
@@ -440,6 +467,19 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
 	bio_endio(bio);
 }
 
+/**
+ * blk_crypto_cfg_supports_process_bio - check if this config supports
+ *					 process_bio
+ * @profile: the profile we're checking
+ *
+ * This is just a quick check to make sure @profile is the fallback profile, as
+ * no other offload implementations support process_bio.
+ */
+bool blk_crypto_cfg_supports_process_bio(struct blk_crypto_profile *profile)
+{
+	return profile == blk_crypto_fallback_profile;
+}
+
 /**
  * blk_crypto_fallback_decrypt_endio - queue bio for fallback decryption
  *
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 93a141979694..6664a04cb6ad 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -213,6 +213,8 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr);
 
 int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key);
 
+bool blk_crypto_cfg_supports_process_bio(struct blk_crypto_profile *profile);
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
 
 static inline int
@@ -235,6 +237,12 @@ blk_crypto_fallback_evict_key(const struct blk_crypto_key *key)
 	return 0;
 }
 
+static inline bool
+blk_crypto_cfg_supports_process_bio(struct blk_crypto_profile *profile)
+{
+	return false;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
 
 #endif /* __LINUX_BLK_CRYPTO_INTERNAL_H */
diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 7fabc883e39f..5d26d49d9372 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -352,6 +352,8 @@ bool __blk_crypto_cfg_supported(struct blk_crypto_profile *profile,
 		return false;
 	if (profile->max_dun_bytes_supported < cfg->dun_bytes)
 		return false;
+	if (cfg->process_bio && !blk_crypto_cfg_supports_process_bio(profile))
+		return false;
 	return true;
 }
 
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 4d760b092deb..50556952df19 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -321,6 +321,8 @@ int __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
  * @dun_bytes: number of bytes that will be used to specify the DUN when this
  *	       key is used
  * @data_unit_size: the data unit size to use for en/decryption
+ * @process_bio: the call back if the upper layer needs to process the encrypted
+ *		 bio
  *
  * Return: 0 on success, -errno on failure.  The caller is responsible for
  *	   zeroizing both blk_key and raw_key when done with them.
@@ -328,7 +330,8 @@ int __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
 int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
 			enum blk_crypto_mode_num crypto_mode,
 			unsigned int dun_bytes,
-			unsigned int data_unit_size)
+			unsigned int data_unit_size,
+			blk_crypto_process_bio_t process_bio)
 {
 	const struct blk_crypto_mode *mode;
 
@@ -350,6 +353,7 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
 	blk_key->crypto_cfg.crypto_mode = crypto_mode;
 	blk_key->crypto_cfg.dun_bytes = dun_bytes;
 	blk_key->crypto_cfg.data_unit_size = data_unit_size;
+	blk_key->crypto_cfg.process_bio = process_bio;
 	blk_key->data_unit_size_bits = ilog2(data_unit_size);
 	blk_key->size = mode->keysize;
 	memcpy(blk_key->raw, raw_key, mode->keysize);
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 4eeb75410ba8..57776c548a06 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -168,7 +168,8 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 
 	err = blk_crypto_init_key(blk_key, raw_key, crypto_mode,
 				  fscrypt_get_dun_bytes(ci),
-				  1U << ci->ci_data_unit_bits);
+				  1U << ci->ci_data_unit_bits,
+				  sb->s_cop->process_bio);
 	if (err) {
 		fscrypt_err(inode, "error %d initializing blk-crypto key", err);
 		goto fail;
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 5e5822c18ee4..194c1d727013 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -6,7 +6,7 @@
 #ifndef __LINUX_BLK_CRYPTO_H
 #define __LINUX_BLK_CRYPTO_H
 
-#include <linux/types.h>
+#include <linux/blk_types.h>
 
 enum blk_crypto_mode_num {
 	BLK_ENCRYPTION_MODE_INVALID,
@@ -17,6 +17,9 @@ enum blk_crypto_mode_num {
 	BLK_ENCRYPTION_MODE_MAX,
 };
 
+typedef blk_status_t (blk_crypto_process_bio_t)(struct bio *orig_bio,
+						struct bio *enc_bio);
+
 #define BLK_CRYPTO_MAX_KEY_SIZE		64
 /**
  * struct blk_crypto_config - an inline encryption key's crypto configuration
@@ -31,6 +34,7 @@ struct blk_crypto_config {
 	enum blk_crypto_mode_num crypto_mode;
 	unsigned int data_unit_size;
 	unsigned int dun_bytes;
+	blk_crypto_process_bio_t *process_bio;
 };
 
 /**
@@ -90,7 +94,8 @@ bool bio_crypt_dun_is_contiguous(const struct bio_crypt_ctx *bc,
 int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
 			enum blk_crypto_mode_num crypto_mode,
 			unsigned int dun_bytes,
-			unsigned int data_unit_size);
+			unsigned int data_unit_size,
+			blk_crypto_process_bio_t process_bio);
 
 int blk_crypto_start_using_key(struct block_device *bdev,
 			       const struct blk_crypto_key *key);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index ea8fdc6f3b83..a3576da6a9fa 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/blk-crypto.h>
 #include <uapi/linux/fscrypt.h>
 
 /*
@@ -199,6 +200,19 @@ struct fscrypt_operations {
 	 */
 	struct block_device **(*get_devices)(struct super_block *sb,
 					     unsigned int *num_devs);
+
+	/*
+	 * A callback if the file system requires the ability to process the
+	 * encrypted bio.
+	 *
+	 * @orig_bio: the original bio submitted.
+	 * @enc_bio: the encrypted bio.
+	 *
+	 * For writes the enc_bio will be different from the orig_bio, for reads
+	 * they will be the same.  For reads we get the bio before it is
+	 * decrypted, for writes we get the bio before it is submitted.
+	 */
+	blk_crypto_process_bio_t *process_bio;
 };
 
 static inline struct fscrypt_inode_info *
-- 
2.41.0

