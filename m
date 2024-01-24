Return-Path: <linux-btrfs+bounces-1687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5D583AF8D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59CCAB264EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE087F7CD;
	Wed, 24 Jan 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RrCShjNP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84057E77D
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116769; cv=none; b=bVDqYIjGyybb8Kjl+qFA0FNFPtcxjNrD2se6O/kKIVAWNVwGfpTMkjWm3gR5t8oQrPUch8GXBZDCRizYQOsXO1qzzz9wOk+zq12Tev+jPuj5YYVuAkbknXjPA51sulfC6dIoR3tRVvS1YlZX9N731OwJdzwitzRpemJnfnqE4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116769; c=relaxed/simple;
	bh=NRtqBo1zZ9FtLyhcMXvIlgxi5Ardhc8yFVAbGYyMT3E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHbc7ktyKvz5F8k2m9RLHo8POxpiuj/RiHsVKUOfSA27ZUYXjG7z4VM0Ix61U7ttfxQ/GRt8yL0cRoWQNKeHk8pp9JyZfNTuStwbW3AfQo62Ty1yTJY9LSo5+9X9wpXZ6XUvchXOZOaUN4w6dGBjLBSZf/99fNFlZi5SLrcVbGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RrCShjNP; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5f0629e67f4so60995967b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116767; x=1706721567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PjmqcLEuXSOXKfkjuR746lyxkzTxGmUspoCgA9qnaM=;
        b=RrCShjNP8IT/DcVc8fXKuvJPHiuC+YlsYL+ob5ZsTirlxzQasIBX7b+Ao8WQt9AwrJ
         nuDYrNQPCu9zequf/vJlqrQxlgA3JYAmclacNw7v2iCMulxkx9SjFT5YNOaSmYqMdJ1h
         0nMDP0wf/6HV2rIQlqfRT9QzfVsKz0lpXfA6mLktuLFtCZu3kP0ODafkuYsFYIPg+brS
         gLXzDlr71fq95xUruwyCrBnSbvkbJiVIGCciRUpsUiW9IVSvQr43gbXW5EYhv1GebX0A
         BICBaNTPW/9DI1gAtemvTsOAiEwlCE3mRsK5B/A1wp6m6aUa5cBswH2i07W+GAmE1FA0
         xgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116767; x=1706721567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PjmqcLEuXSOXKfkjuR746lyxkzTxGmUspoCgA9qnaM=;
        b=ZoiplDBUynzUF1s7zKGaw/fZ4CspGFraiwQoTYoI1PcIwQgRbSSvYoxLcGRmeByIvt
         eUFj+xzAL5zPATnixcqu0t3ZRt0j8T0KVAY3HAtJEzcjqR1KZa0DmagULthdC7Ec5xWC
         gaaQBJxZsOrYfhBi/cPm/1uya5awTM/KyGTmEeQ7Ws91to/CsbzYzDv/Q8QnuMkM4il9
         pEXEdrGEnMYeyqKATsQCRtEVsMfsPk3hWIYXGmBxaLilWEFPcQjNE3/LcFj5cWiHZPu0
         qgaCdQjX/R0NmwCO9akiMMbqEsO5W+LfvHTpqTPb+qceUQavscKwHGm9/s93B/ElfyIf
         jzJQ==
X-Gm-Message-State: AOJu0YxkL9lWky9ttTwdMHqsuPYwg7F/071bwg0UHqSMsSnnYFrK1jd0
	rvpdHI6jVEd0NMDexDRuD3J1+mr3fI8KDeZ3CwhaSj0ZCou81qD/BpX0C+6GH7vd4f+KxhfcuK+
	L
X-Google-Smtp-Source: AGHT+IHYFFJ9HREQJtp5Rm+SZXRKC3GVkXJghExNurG2fIJDnBBysGjzfO/ZEIdNLwtTCMgX8OZkUw==
X-Received: by 2002:a81:c310:0:b0:5ff:76ef:688a with SMTP id r16-20020a81c310000000b005ff76ef688amr953126ywk.61.1706116766667;
        Wed, 24 Jan 2024 09:19:26 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ey1-20020a05690c300100b005ffcb4765c9sm64873ywb.28.2024.01.24.09.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:26 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 05/52] blk-crypto: add a process bio callback
Date: Wed, 24 Jan 2024 12:18:27 -0500
Message-ID: <66c781f3b2afdf2c558efdf33a7bba8bcfe47ce7.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 block/blk-crypto-fallback.c | 43 +++++++++++++++++++++++++++++++++++++
 block/blk-crypto-internal.h |  8 +++++++
 block/blk-crypto-profile.c  |  2 ++
 block/blk-crypto.c          |  6 +++++-
 fs/crypto/inline_crypt.c    |  2 +-
 include/linux/blk-crypto.h  | 15 +++++++++++--
 6 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index e6468eab2681..ee0e12815a12 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -209,12 +209,15 @@ blk_crypto_fallback_alloc_cipher_req(struct blk_crypto_keyslot *slot,
 
 static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
 {
+	struct bio_crypt_ctx *bc;
 	struct bio *bio = *bio_ptr;
 	unsigned int i = 0;
 	unsigned int num_sectors = 0;
 	struct bio_vec bv;
 	struct bvec_iter iter;
 
+	bc = bio->bi_crypt_context;
+
 	bio_for_each_segment(bv, bio, iter) {
 		num_sectors += bv.bv_len >> SECTOR_SHIFT;
 		if (++i == BIO_MAX_VECS)
@@ -223,6 +226,16 @@ static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
 	if (num_sectors < bio_sectors(bio)) {
 		struct bio *split_bio;
 
+		/*
+		 * We cannot split bio's that have process_bio, as they require
+		 * the original bio.  The upper layer must make sure to limit
+		 * the submitted bio's appropriately.
+		 */
+		if (bc->bc_key->crypto_cfg.process_bio) {
+			bio->bi_status = BLK_STS_RESOURCE;
+			return false;
+		}
+
 		split_bio = bio_split(bio, num_sectors, GFP_NOIO,
 				      &crypto_bio_split);
 		if (!split_bio) {
@@ -346,6 +359,15 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
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
@@ -391,6 +413,15 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
 	unsigned int i;
 	blk_status_t blk_st;
 
+	/* Process the bio first before trying to decrypt. */
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
@@ -440,6 +471,18 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
 	bio_endio(bio);
 }
 
+/**
+ * blk_crypto_profile_is_fallback - check if this profile is the fallback
+ *				    profile
+ * @profile: the profile we're checking
+ *
+ * This is just a quick check to make sure @profile is the fallback profile.
+ */
+bool blk_crypto_profile_is_fallback(struct blk_crypto_profile *profile)
+{
+	return profile == blk_crypto_fallback_profile;
+}
+
 /**
  * blk_crypto_fallback_decrypt_endio - queue bio for fallback decryption
  *
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 93a141979694..5696d1fbda24 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -213,6 +213,8 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr);
 
 int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key);
 
+bool blk_crypto_profile_is_fallback(struct blk_crypto_profile *profile);
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
 
 static inline int
@@ -235,6 +237,12 @@ blk_crypto_fallback_evict_key(const struct blk_crypto_key *key)
 	return 0;
 }
 
+static inline bool
+blk_crypto_profile_is_fallback(struct blk_crypto_profile *profile)
+{
+	return false;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
 
 #endif /* __LINUX_BLK_CRYPTO_INTERNAL_H */
diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 7fabc883e39f..bc1acabca51b 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -352,6 +352,8 @@ bool __blk_crypto_cfg_supported(struct blk_crypto_profile *profile,
 		return false;
 	if (profile->max_dun_bytes_supported < cfg->dun_bytes)
 		return false;
+	if (cfg->process_bio && !blk_crypto_profile_is_fallback(profile))
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
index c64ef93b6157..52c4a24e2657 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -171,7 +171,7 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 
 	err = blk_crypto_init_key(blk_key, raw_key, crypto_mode,
 				  fscrypt_get_dun_bytes(ci),
-				  1U << ci->ci_data_unit_bits);
+				  1U << ci->ci_data_unit_bits, NULL);
 	if (err) {
 		fscrypt_err(inode, "error %d initializing blk-crypto key", err);
 		goto fail;
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 5e5822c18ee4..bf7d2e85f0bf 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -6,7 +6,7 @@
 #ifndef __LINUX_BLK_CRYPTO_H
 #define __LINUX_BLK_CRYPTO_H
 
-#include <linux/types.h>
+#include <linux/blk_types.h>
 
 enum blk_crypto_mode_num {
 	BLK_ENCRYPTION_MODE_INVALID,
@@ -17,6 +17,14 @@ enum blk_crypto_mode_num {
 	BLK_ENCRYPTION_MODE_MAX,
 };
 
+/*
+ * orig_bio must be the bio that was submitted from the upper layer as the upper
+ * layer could have used a specific bioset and expect the orig_bio to be from
+ * its bioset.
+ */
+typedef blk_status_t (*blk_crypto_process_bio_t)(struct bio *orig_bio,
+						 struct bio *enc_bio);
+
 #define BLK_CRYPTO_MAX_KEY_SIZE		64
 /**
  * struct blk_crypto_config - an inline encryption key's crypto configuration
@@ -26,11 +34,13 @@ enum blk_crypto_mode_num {
  *	ciphertext.  This is always a power of 2.  It might be e.g. the
  *	filesystem block size or the disk sector size.
  * @dun_bytes: the maximum number of bytes of DUN used when using this key
+ * @proces_bio: optional callback to process encrypted bios.
  */
 struct blk_crypto_config {
 	enum blk_crypto_mode_num crypto_mode;
 	unsigned int data_unit_size;
 	unsigned int dun_bytes;
+	blk_crypto_process_bio_t process_bio;
 };
 
 /**
@@ -90,7 +100,8 @@ bool bio_crypt_dun_is_contiguous(const struct bio_crypt_ctx *bc,
 int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
 			enum blk_crypto_mode_num crypto_mode,
 			unsigned int dun_bytes,
-			unsigned int data_unit_size);
+			unsigned int data_unit_size,
+			blk_crypto_process_bio_t process_bio);
 
 int blk_crypto_start_using_key(struct block_device *bdev,
 			       const struct blk_crypto_key *key);
-- 
2.43.0


