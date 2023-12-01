Return-Path: <linux-btrfs+bounces-519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C155F801611
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 23:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17E01C20ED9
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 22:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB1266718;
	Fri,  1 Dec 2023 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="iiXXfmFR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0289410EF
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 14:12:45 -0800 (PST)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-5d40c728fc4so10050447b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 14:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468764; x=1702073564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5v0XMPAwxYBm92FM0C0pU/Uz9MIFNdU5pAo7nP1a6gE=;
        b=iiXXfmFRfENd23CP4W9p77HZ+NYMcmSVgMk0Nyb4qkh5EgToo7UutZjK7QnPRewDAj
         RFDsawRKh2HxVwLRo4LwVfYRHdQIsn5TLD5WnVyaWfKqtpnB7ElUN7/S9bRruqeaMoQY
         UNMfFzqLkJGocG3wc0hI+tWufmutS8YpZjEXcRGoj5V6Vk8e3I6UQD72d+XpyDzjgNit
         50EsOgqm8AgemCEJEqF0pDQlwzPtNPI5CSKhpjLyyOopo4vv+cTRq03/jdX4oVsutLgE
         qhaD1aVkRs7JBeLwCcUUd+clLzA1T6kya9U2lUEQZSjdzk5U/1AQ4ucy6vi8NJJBXxZo
         iCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468764; x=1702073564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5v0XMPAwxYBm92FM0C0pU/Uz9MIFNdU5pAo7nP1a6gE=;
        b=YhTGEcNz6ug2wJijNJwknu12fvtBHurDwupRClO1ge7ZQy8l2T+v1ThwoO+jO798NQ
         axlgQXg22xbj2/oA64BSlMGY1RSa2mMO6TwF0uwmlEjRN88r23XPlqWU2nsQiPUOjTJQ
         zZPeqhwOfZYDCMQQEWJT50vUodUM+zmc8AchV773WP8gbQqqLIU3mTFL5YP/YUbPcuzC
         6Rz9bZX12EL6IkVF8+2vVssa4KhjSopva8GxBJZFa4yFu0TMBdA4UtQrBKD6l17Q5lXz
         4fqdFO4rKipUI6PHAieSPKhpRexO49coB9tu0cttPZ02uYu5DedcSz3Y4m2BIfuY1OoM
         ICwQ==
X-Gm-Message-State: AOJu0YzvewBdrChnmrHAV/i7Fe1SWeEVlL0om1sse15MCmXKpZo+KXb3
	sC3HyLDL0VDXKYtQ/Hmeg9Bnm12wUka2j8jIQrl3gxwY
X-Google-Smtp-Source: AGHT+IFkvM3XUrtssH9qZKSM42wRJBebPHfPbVTfdNsm9seGvGySxoGqGonv/o2sWC2ZwYE4uYErMg==
X-Received: by 2002:a05:690c:1b:b0:5d7:1a33:5ae4 with SMTP id bc27-20020a05690c001b00b005d71a335ae4mr140740ywb.49.1701468764068;
        Fri, 01 Dec 2023 14:12:44 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q2-20020a815c02000000b005a23fc389d8sm1381537ywb.103.2023.12.01.14.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:43 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 37/46] btrfs: limit encrypted writes to 256 segments
Date: Fri,  1 Dec 2023 17:11:34 -0500
Message-ID: <f545b140b085b0278e4b67b776ec4aa57db734ac.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
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
index 52f027877aaa..ef3f98b3ec3f 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -15,6 +15,7 @@
 #include "zoned.h"
 #include "file-item.h"
 #include "raid-stripe-tree.h"
+#include "fscrypt.h"
 
 static struct bio_set btrfs_bioset;
 static struct bio_set btrfs_clone_bioset;
@@ -660,6 +661,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	u64 logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 length = bio->bi_iter.bi_size;
 	u64 map_length = length;
+	u64 max_bio_len = length;
 	bool use_append = btrfs_use_zone_append(bbio);
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_io_stripe smap;
@@ -669,6 +671,31 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
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
@@ -684,7 +711,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	if (bio_op(bio) == REQ_OP_WRITE && is_data_bbio(bbio))
 		bbio->orig_logical = logical;
 
-	map_length = min(map_length, length);
+	map_length = min(map_length, max_bio_len);
 	if (use_append)
 		map_length = min(map_length, fs_info->max_zone_append_size);
 
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 726cb6121934..419b0f6d8629 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -298,6 +298,30 @@ bool btrfs_mergeable_encrypted_bio(struct bio *bio, struct inode *inode,
 	return fscrypt_mergeable_extent_bio(bio, inode, fi, logical_offset);
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
index 756375ade0b6..c4a327be0eeb 100644
--- a/fs/btrfs/fscrypt.h
+++ b/fs/btrfs/fscrypt.h
@@ -35,6 +35,7 @@ void btrfs_set_bio_crypt_ctx_from_extent(struct bio *bio,
 bool btrfs_mergeable_encrypted_bio(struct bio *bio, struct inode *inode,
 				   struct fscrypt_extent_info *fi,
 				   u64 logical_offset);
+int btrfs_fscrypt_bio_length(struct bio *bio, u64 map_length);
 
 #else
 static inline int btrfs_fscrypt_save_extent_info(struct btrfs_inode *inode,
@@ -88,6 +89,11 @@ static inline bool btrfs_mergeable_encrypted_bio(struct bio *bio,
 {
 	return true;
 }
+
+static inline u64 btrfs_fscrypt_bio_length(struct bio *bio, u64 map_length)
+{
+	return map_length;
+}
 #endif /* CONFIG_FS_ENCRYPTION */
 
 extern const struct fscrypt_operations btrfs_fscrypt_ops;
-- 
2.41.0


