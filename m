Return-Path: <linux-btrfs+bounces-1719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2647583AFA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9179B1F2A7CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA5F12839F;
	Wed, 24 Jan 2024 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wir9TC9k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13004128368
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116800; cv=none; b=RAk1HYd6HCXdmVQ+h26oJGFICUaeWb8SKvntEkKGR+4g7Goz9kmT6aSs3ot85qxCvMgS8qI8ZUgDRAs4/Pb6mq3B0PqC0ylg+A0UTTpUS9O4+nXR43HDHhmGtBJnYEe3EuWUn/OwlCXXinIvFIV5KLliltoAxwxxDPXVwYjfXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116800; c=relaxed/simple;
	bh=pRf4KgFhQJewGEorxJym3Mu/c0nVfTOwgrDzgDVQx4Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KR/z+PiTck8GO/05bDQsOiNQHlFR2nP7ZR8hmZNmVKkSamHLhY/uHkDltORFmApR3af0tuied7UgHdhG937wwOjoGJumFoBnmViXOep6Qm2YgUsxKkgsSR5mKo3ac+TG60bEYZb/YmT/VPNt0TKtKgs/ED2ZcnWgKmlc9ecBe04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wir9TC9k; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6002a655d77so27159297b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116798; x=1706721598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVTpEWY3MntzlRLR3byKAO+alzS64oNCXCog2sNJ60M=;
        b=wir9TC9kWHDPw92B03UiMrWQ8SedXmgWcPAXIFpQqCX637tiYpFF8vN49shu4ngYad
         gNDGvkKs2t1qsyJ+SUSFX8aU+VBxeBsQlSO4g8LDts9GCPzt2L006yB47vS1DlqN0rgP
         3whRQ+zv8yl0p95qnOP26kVgtNzrDwJbyKpTelRtIPxtIZQQcGXiCw6TONw1VynfnsUn
         PW3vduc1gKo5TDaZp2S0IGmwGS67v8b/JC3RKvgiw3izPGeBeGbufsDNZisPCD07uUtB
         XJFE4BJ2Ax7fnescJHuGZW0J6Vw79lIoYiRxjOhi2x0s+5EeNik2qha1FuQ1znQ1hMcX
         SwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116798; x=1706721598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVTpEWY3MntzlRLR3byKAO+alzS64oNCXCog2sNJ60M=;
        b=jUAm5d9gKNGySnZ8yi3KUloixgyFzQ5SLgwfKxMusI3mq559CJkWhiljA3FcjiWIHI
         EejWqbWiDurY3XKc1bhMS/Y0k+BAxnd4THDFHrE2VPtnbfIa9ftlJMhoIuW1rSFsvIn/
         9SSkuQsk3DksLgxuR2jtWdEhTVw2EuE6ZdypH33bGJ0WN36hVvn0IeAWNqDTPsibzLM9
         VdrqywgEdakUgFPqZMZdTxqXaSbaSiRKWwPNwjnTelsGAgBhdJu5nnUniTXTi1VEN5ot
         SZt0m0i8Vw3egMB3BkkWwTeF8CTMkT4Lw+U+zDj0wAlPsV/xqAzxenqNb5NeedR5DKVS
         0Gcg==
X-Gm-Message-State: AOJu0YxISqjreR1AWfHkjQ7AGMff1gDgK9TsKZVJ3BbHz/negds8XoFh
	iijdh7iPaYtbMM9RBZ/EdkeGzPGVUDCZ7D2cFrjE5ycAO4K6UgPzf6da7VBpeCS+mY6UPf133Za
	9
X-Google-Smtp-Source: AGHT+IFrGXJU4ZWL8kutG7gXAJKdnCQH7UZYj3wcchkZ1sK5KdwN0OfXMsv37LYbpQe+Ua92CCQ2OA==
X-Received: by 2002:a81:4f49:0:b0:5ff:3f23:4f87 with SMTP id d70-20020a814f49000000b005ff3f234f87mr922139ywb.71.1706116797898;
        Wed, 24 Jan 2024 09:19:57 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z130-20020a814c88000000b005ff877093easm60232ywa.143.2024.01.24.09.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:57 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 37/52] btrfs: limit encrypted writes to 256 segments
Date: Wed, 24 Jan 2024 12:18:59 -0500
Message-ID: <1fc07b885453495bccea5a37e13d7d26333bd2af.1706116485.git.josef@toxicpanda.com>
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

For the fallback encrypted writes it allocates a bounce buffer to
encrypt, and if the bio is larger than 256 segments it splits the bio we
send down.  This wreaks havoc on us because we need our actual original
bio to be passed into the process_cb callback in order to get at our
ordered extent.  With the split we'll get some cloned bio that has none
of our information.  Handle this by returning the length we need to be
truncated to and then splitting ourselves, which will handle giving us
the correct btrfs_bio that we need.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/bio.c     | 29 ++++++++++++++++++++++++++++-
 fs/btrfs/fscrypt.c | 24 ++++++++++++++++++++++++
 fs/btrfs/fscrypt.h |  6 ++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index cb998048edce..1fb8a198e093 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -15,6 +15,7 @@
 #include "zoned.h"
 #include "file-item.h"
 #include "raid-stripe-tree.h"
+#include "fscrypt.h"
 
 static struct bio_set btrfs_bioset;
 static struct bio_set btrfs_clone_bioset;
@@ -664,6 +665,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	u64 logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 length = bio->bi_iter.bi_size;
 	u64 map_length = length;
+	u64 max_bio_len = length;
 	bool use_append = btrfs_use_zone_append(bbio);
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_io_stripe smap;
@@ -673,6 +675,31 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	smap.is_scrub = !bbio->inode;
 
 	btrfs_bio_counter_inc_blocked(fs_info);
+
+	/*
+	 * The blk-crypto-fallback limits bio sizes to 256 segments, because it
+	 * has no way of controlling the pages it gets for the bounce bio it
+	 * submits.
+	 *
+	 * If we don't pre-split our bio blk-crypto-fallback will do it for us,
+	 * and then call into our checksum callback with a random cloned bio
+	 * that isn't a btrfs_bio.
+	 *
+	 * To account for this we must truncate the bio ourselves, so we need to
+	 * get our length at 256 segments and return that.  We must do this
+	 * before btrfs_map_block because the RAID5/6 code relies on having
+	 * properly stripe aligned things, so we return the truncated length
+	 * here so that btrfs_map_block() does the correct thing.  Further down
+	 * we actually truncate map_length to map_bio_len because map_length
+	 * will be set to whatever the mapping length is for the underlying
+	 * geometry.  This will work properly with RAID5/6 as it will have
+	 * already setup everything for the expected length, and everything else
+	 * can handle with a truncated map_length.
+	 */
+	if (bio_has_crypt_ctx(bio))
+		max_bio_len = btrfs_fscrypt_bio_length(bio, map_length);
+
+	map_length = max_bio_len;
 	error = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
 				&bioc, &smap, &mirror_num);
 	if (error) {
@@ -688,7 +715,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	if (bio_op(bio) == REQ_OP_WRITE && is_data_bbio(bbio))
 		bbio->orig_logical = logical;
 
-	map_length = min(map_length, length);
+	map_length = min(map_length, max_bio_len);
 	if (use_append)
 		map_length = min(map_length, fs_info->max_zone_append_size);
 
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index b93fce2db3d5..9f4811b2fb4e 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -308,6 +308,30 @@ bool btrfs_mergeable_encrypted_bio(struct bio *bio, struct inode *inode,
 	return fscrypt_mergeable_extent_bio(bio, fi, logical_offset);
 }
 
+/*
+ * The block crypto stuff allocates bounce buffers for encryption, so splits at
+ * BIO_MAX_VECS worth of segments.  If we are larger than that number of
+ * segments then we need to limit the size to the size that BIO_MAX_VECS covers.
+ */
+int btrfs_fscrypt_bio_length(struct bio *bio, u64 map_length)
+{
+	unsigned int i = 0;
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	u64 segments_length = 0;
+
+	if (bio_op(bio) != REQ_OP_WRITE)
+		return map_length;
+
+	bio_for_each_segment(bv, bio, iter) {
+		segments_length += bv.bv_len;
+		if (++i == BIO_MAX_VECS)
+			return segments_length;
+	}
+
+	return map_length;
+}
+
 const struct fscrypt_operations btrfs_fscrypt_ops = {
 	.has_per_extent_encryption = 1,
 	.get_context = btrfs_fscrypt_get_context,
diff --git a/fs/btrfs/fscrypt.h b/fs/btrfs/fscrypt.h
index 4da80090361f..703122e8d57f 100644
--- a/fs/btrfs/fscrypt.h
+++ b/fs/btrfs/fscrypt.h
@@ -37,6 +37,7 @@ void btrfs_set_bio_crypt_ctx_from_extent(struct bio *bio,
 bool btrfs_mergeable_encrypted_bio(struct bio *bio, struct inode *inode,
 				   struct fscrypt_extent_info *fi,
 				   u64 logical_offset);
+int btrfs_fscrypt_bio_length(struct bio *bio, u64 map_length);
 
 #else
 static inline void btrfs_fscrypt_save_extent_info(struct btrfs_inode *inode,
@@ -92,6 +93,11 @@ static inline bool btrfs_mergeable_encrypted_bio(struct bio *bio,
 	return true;
 }
 
+static inline u64 btrfs_fscrypt_bio_length(struct bio *bio, u64 map_length)
+{
+	return map_length;
+}
+
 #endif /* CONFIG_FS_ENCRYPTION */
 
 extern const struct fscrypt_operations btrfs_fscrypt_ops;
-- 
2.43.0


