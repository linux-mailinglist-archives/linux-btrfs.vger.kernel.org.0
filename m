Return-Path: <linux-btrfs+bounces-1720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F0183AFA8
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F2A1F2A967
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627B01292D1;
	Wed, 24 Jan 2024 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RqzaMhaF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5CA12837F
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116801; cv=none; b=qZNeJFlHzz1qEPwq3DYsCqYeEXrylHDJ5By5h1B/t/Kz1BcNQLjLO2aFA/YSYHRpasWZDizsk3HVwQLwHmg8zqRrV4yGYmGMhJh1AB+1ynV41czl0yUyNxXcsDhhI8xV0SjZlZvNCVBaPG5026JrrxipFQikylGSUKqxrMEYJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116801; c=relaxed/simple;
	bh=Onc25aLfG/B4s4fX0RnH+DiY2IRV5EGBNAFaIXEJs3g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndA/zhFIoLVmEofR1s4cOfytU7pt2azl4oGO9tJ9rv3fUNtpuv5/myZXn+uiKnbjTGrcWs7zGhCD353vGIYSihBKMuDtNt5X2iRlY6MJgdm8W4R3N6r+HsvYkXcfYbOHNwU/vQR0Yi3MlU2w74+MICHhVA1OGqv1vw3n9t0fDJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RqzaMhaF; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ffb07bed9bso34644957b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116799; x=1706721599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r84TOrL+swdWBjXzz8BVE6bEsJMqHiJjrZwciOqZ+eE=;
        b=RqzaMhaFPhSk49dGFc5VQ7s4Z12IpPwSrN6tqijacadmlVaUSLPTSLS3S32c/b3uUd
         opcnZvS15STSVKYup9oqfR1aNMnTKhtVKHSqGWePXejJOvmxr1H3KvVDogBOUklhzkGt
         +goiqvZkMWu+W/oNYJCARFy/7chynV48wL6ggCoE6/tV3+cuSBofyMI0P+gRACWNrCRj
         l4ePkI0pNn8BExwFU5GeXDO9FkvUQk/YfgWVGvFBRIfCO++GOElG9yQvM5KaQC4RRaH5
         eUw8qD1ovIKTOAk3MNWc7x8OQsXEaqpjFrQTd9p2M/+GYmWSTnrY7cZfIul+NcTGdcDv
         J9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116799; x=1706721599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r84TOrL+swdWBjXzz8BVE6bEsJMqHiJjrZwciOqZ+eE=;
        b=tvBGDzALfICICohEz7qaNXeezzQp+DLucGmaeZk96Qm41sO+fF1yuy4GBcPZv2yT1E
         svs5OXYkaTQny/ieMjJ2LsXtsKINUx+Q1n8cc1LAreCdNqkUvdVry9O6hiDJ1qItjT2W
         RetaF7iozcu5c5d7sexxuFmsZ5IgaCHqRZt9RBi55QBcrU4nZi+ZsF1t62jGRLaUhOlD
         iMfOR+oyxk2YsbgFFf5a1nbRCDWZrvdIYZcHjtjNQbccz3Fnv6TWAuY3heEdJhGWXqHG
         7vY5L8jtUN2R69ntB7bciN8ylWi+KrSzfOiulD8QAuiA0IiCaTTbSCqLjwewA7gQ9I6I
         Xpkw==
X-Gm-Message-State: AOJu0Yzep7Q1WH1/MwfG1LoNJcmsAS11xNtSoY3KIIuXq6pnzRe9PEEv
	99YEzYdPrnvyQsaWmjhP6HJ94RBU1Z6ys78Rr/2+tip8BiTOpO4Mn2rnmQTO50X6XiL5fKuE7z5
	Y
X-Google-Smtp-Source: AGHT+IGoXOcOUWFXDeKKQ5wflDef/WZMTmLPf7tHm/umb4HRrIUxgLrImIxkcTrB4TaBc9NPDphJkg==
X-Received: by 2002:a0d:cb08:0:b0:5ff:9567:c81 with SMTP id n8-20020a0dcb08000000b005ff95670c81mr912006ywd.22.1706116798866;
        Wed, 24 Jan 2024 09:19:58 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fu7-20020a05690c368700b00602a88f43cbsm65701ywb.7.2024.01.24.09.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:58 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 38/52] btrfs: implement process_bio cb for fscrypt
Date: Wed, 24 Jan 2024 12:19:00 -0500
Message-ID: <ca32684b01ff8c252be515509137e0a4a0e5db7a.1706116485.git.josef@toxicpanda.com>
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

We are going to be checksumming the encrypted data, so we have to
implement the ->process_bio fscrypt callback.  This will provide us with
the original bio and the encrypted bio to do work on.  For WRITE's this
will happen after the encrypted bio has been encrypted.  For READ's this
will happen after the read has completed and before the decryption step
is done.

For write's this is straightforward, we can just pass in the encrypted
bio to btrfs_csum_one_bio and then the csums will be added to the bbio
as normal.

For read's this is relatively straightforward, but requires some care.
We assume (because that's how it works currently) that the encrypted bio
match the original bio, this is important because we save the iter of
the bio before we submit.  If this changes in the future we'll need a
hook to give us the bi_iter of the decryption bio before it's submitted.
We check the csums before decryption.  If it doesn't match we simply
error out and we let the normal path handle the repair work.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/bio.c       | 39 +++++++++++++++++++++++++++++++++++++--
 fs/btrfs/bio.h       |  3 +++
 fs/btrfs/file-item.c | 14 ++++++++++++--
 fs/btrfs/fscrypt.c   | 29 +++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 1fb8a198e093..e85c0f539ab7 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -288,6 +288,34 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 	return fbio;
 }
 
+blk_status_t btrfs_check_encrypted_read_bio(struct btrfs_bio *bbio,
+					    struct bio *enc_bio)
+{
+	struct btrfs_inode *inode = bbio->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	u32 sectorsize = fs_info->sectorsize;
+	struct bvec_iter iter = bbio->saved_iter;
+	struct btrfs_device *dev = bbio->bio.bi_private;
+	u32 offset = 0;
+
+	/*
+	 * We have to use a copy of iter in case there's an error,
+	 * btrfs_check_read_bio will handle submitting the repair bios.
+	 */
+	while (iter.bi_size) {
+		struct bio_vec bv = bio_iter_iovec(enc_bio, iter);
+
+		bv.bv_len = min(bv.bv_len, sectorsize);
+		if (!btrfs_data_csum_ok(bbio, dev, offset, &bv))
+			return BLK_STS_IOERR;
+		bio_advance_iter_single(enc_bio, &iter, sectorsize);
+		offset += sectorsize;
+	}
+
+	bbio->csum_done = true;
+	return BLK_STS_OK;
+}
+
 static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *dev)
 {
 	struct btrfs_inode *inode = bbio->inode;
@@ -313,6 +341,10 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 	/* Clear the I/O error. A failed repair will reset it. */
 	bbio->bio.bi_status = BLK_STS_OK;
 
+	/* This was an encrypted bio and we've already done the csum check. */
+	if (status == BLK_STS_OK && bbio->csum_done)
+		goto out;
+
 	while (iter->bi_size) {
 		struct bio_vec bv = bio_iter_iovec(&bbio->bio, *iter);
 
@@ -323,7 +355,7 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 		bio_advance_iter_single(&bbio->bio, iter, sectorsize);
 		offset += sectorsize;
 	}
-
+out:
 	if (bbio->csum != bbio->csum_inline)
 		kfree(bbio->csum);
 
@@ -756,10 +788,13 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		/*
 		 * Csum items for reloc roots have already been cloned at this
 		 * point, so they are handled as part of the no-checksum case.
+		 *
+		 * Encrypted inodes are csum'ed via the ->process_bio callback.
 		 */
 		if (inode && !(inode->flags & BTRFS_INODE_NODATASUM) &&
 		    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
-		    !btrfs_is_data_reloc_root(inode->root)) {
+		    !btrfs_is_data_reloc_root(inode->root) &&
+		    !IS_ENCRYPTED(&inode->vfs_inode)) {
 			if (should_async_write(bbio) &&
 			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
 				goto done;
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index a5c5371e99e2..9465c23acb84 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -45,6 +45,7 @@ struct btrfs_bio {
 		struct {
 			u8 *csum;
 			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
+			bool csum_done;
 			struct bvec_iter saved_iter;
 		};
 
@@ -110,5 +111,7 @@ void btrfs_submit_repair_write(struct btrfs_bio *bbio, int mirror_num, bool dev_
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 			    u64 length, u64 logical, struct folio *folio,
 			    unsigned int folio_offset, int mirror_num);
+blk_status_t btrfs_check_encrypted_read_bio(struct btrfs_bio *bbio,
+					    struct bio *enc_bio);
 
 #endif
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index a7e545e7461f..a8a8a4f943d1 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -337,6 +337,14 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static inline bool inode_skip_csum(struct btrfs_inode *inode)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+
+	return (inode->flags & BTRFS_INODE_NODATASUM) ||
+		test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
+}
+
 /*
  * Lookup the checksum for the read bio in csum tree.
  *
@@ -356,8 +364,7 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 	blk_status_t ret = BLK_STS_OK;
 	u32 bio_offset = 0;
 
-	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
-	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
+	if (inode_skip_csum(inode))
 		return BLK_STS_OK;
 
 	/*
@@ -745,6 +752,9 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio)
 	int i;
 	unsigned nofs_flag;
 
+	if (inode_skip_csum(inode))
+		return BLK_STS_OK;
+
 	nofs_flag = memalloc_nofs_save();
 	sums = kvzalloc(btrfs_ordered_sum_size(fs_info, bio->bi_iter.bi_size),
 		       GFP_KERNEL);
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 9f4811b2fb4e..560243d732e7 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -16,6 +16,7 @@
 #include "transaction.h"
 #include "volumes.h"
 #include "xattr.h"
+#include "file-item.h"
 
 /*
  * From a given location in a leaf, read a name into a qstr (usually a
@@ -215,6 +216,33 @@ static struct block_device **btrfs_fscrypt_get_devices(struct super_block *sb,
 	return devs;
 }
 
+static blk_status_t btrfs_process_encrypted_bio(struct bio *orig_bio,
+						struct bio *enc_bio)
+{
+	struct btrfs_bio *bbio;
+
+	/*
+	 * If our bio is from the normal fs_bio_set then we know this is a
+	 * mirror split and we can skip it, we'll get the real bio on the last
+	 * mirror and we can process that one.
+	 */
+	if (orig_bio->bi_pool == &fs_bio_set)
+		return BLK_STS_OK;
+
+	bbio = btrfs_bio(orig_bio);
+
+	if (bio_op(orig_bio) == REQ_OP_READ) {
+		/*
+		 * We have ->saved_iter based on the orig_bio, so if the block
+		 * layer changes we need to notice this asap so we can update
+		 * our code to handle the new world order.
+		 */
+		ASSERT(orig_bio == enc_bio);
+		return btrfs_check_encrypted_read_bio(bbio, enc_bio);
+	}
+	return btrfs_csum_one_bio(bbio, enc_bio);
+}
+
 int btrfs_fscrypt_load_extent_info(struct btrfs_inode *inode,
 				   struct extent_map *em,
 				   struct btrfs_fscrypt_ctx *ctx)
@@ -338,4 +366,5 @@ const struct fscrypt_operations btrfs_fscrypt_ops = {
 	.set_context = btrfs_fscrypt_set_context,
 	.empty_dir = btrfs_fscrypt_empty_dir,
 	.get_devices = btrfs_fscrypt_get_devices,
+	.process_bio = btrfs_process_encrypted_bio,
 };
-- 
2.43.0


