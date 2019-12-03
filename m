Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF2BC10F488
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 02:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfLCBef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 20:34:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45879 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfLCBef (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 20:34:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id k1so763483pgg.12
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 17:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UrJk+POn8jMQiHXm0LIPYNlSc03WablfcHBVVM80qCQ=;
        b=LTl3KXbmLKb2bntr3jEwv/OREpx7IpIX4D2cJ5oHhG8W5nDxQDg5FMsXkJhtcjrLx7
         kd9S2jEDtZg2jlGtDCuWF+tR0EyZwwJiymoAtpXTiXLMzzGPImKBqmxAFLdBttFOTuBd
         l4ZHht8zE/oegZu4BPiu8PcTAIfK0reyR3qdo0R00gIzL68J1lXrHI/ApdpGwf/J1AKy
         acye/Tmlo5DS3fHraLOQT5YqzlNHBfHnuCI8ET/PSOiF8bzj86JWVQaU20lIWyg4CsZ7
         l43uCOo7G9Ft7E+T7pVF0wboj+QOoHC4K6VfOBTDd1kJE59/o8uAkAT05R9LvDaBAOMV
         odQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UrJk+POn8jMQiHXm0LIPYNlSc03WablfcHBVVM80qCQ=;
        b=iYREyf8SPY59qDdsi4o33MoDkfbuQTbpRfSjc9RMJ9TKne43JH7AQd5yQKQ9gCgcyZ
         jYd6FeeMx4Svs8wxw0xlGLr1wHVEypRMWHjsPL9Y8ICjYw1RT4s+32UeCcGJmHd3IVUg
         r1cjUA27iDstwPhvhFDIESEUbKvHHgM+yGH0oXUXRjq+3MJ0mGo1ijDTQS/Joe6VQMOd
         ngOxtkJNJWU2VX42/+3p+qkJnYIsQbGXbHT1FmCGb8RpD+iQsMNArpxnlehgZCKlC9Ss
         M2UXN2YcTSQm8NO5RNCvUuPAYtuVUWXSDguCkXaIQXIMQMTnHxCreGiF5XuvXFwEQo7U
         LlZA==
X-Gm-Message-State: APjAAAWTx27dSzJnDNzZzfkoVs5vDiSA27uf3cuG2npTWbPyog/rqy3l
        nHebrK/QXCrvCaucqLJrBASrY+iEXsaT4Q==
X-Google-Smtp-Source: APXvYqzbULyPROD6Lv4WyLcsUMw5qdn+15N0UOdvYfQAcrN8Vc3IKJp311SDm1gnuogQGVsP//8b7g==
X-Received: by 2002:a63:c103:: with SMTP id w3mr2503050pgf.275.1575336873853;
        Mon, 02 Dec 2019 17:34:33 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::6ddc])
        by smtp.gmail.com with ESMTPSA id u65sm800242pfb.35.2019.12.02.17.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 17:34:33 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/9] btrfs: get rid of trivial __btrfs_lookup_bio_sums() wrappers
Date:   Mon,  2 Dec 2019 17:34:17 -0800
Message-Id: <af5aefd84186419ead73107895ddd6aba02ef8b6.1575336815.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575336815.git.osandov@fb.com>
References: <cover.1575336815.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Currently, we have two wrappers for __btrfs_lookup_bio_sums():
btrfs_lookup_bio_sums_dio(), which is used for direct I/O, and
btrfs_lookup_bio_sums(), which is used everywhere else. The only
difference is that the _dio variant looks up csums starting at the given
offset instead of using the page index, which isn't actually direct
I/O-specific. Let's clean up the signature and return value of
__btrfs_lookup_bio_sums(), rename it to btrfs_lookup_bio_sums(), and get
rid of the trivial helpers.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/compression.c |  4 ++--
 fs/btrfs/ctree.h       |  4 +---
 fs/btrfs/file-item.c   | 35 +++++++++++++++++------------------
 fs/btrfs/inode.c       |  6 +++---
 4 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index ee834ef7beb4..03eb50727038 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -758,7 +758,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 			if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
 				ret = btrfs_lookup_bio_sums(inode, comp_bio,
-							    sums);
+							    false, 0, sums);
 				BUG_ON(ret); /* -ENOMEM */
 			}
 
@@ -786,7 +786,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	BUG_ON(ret); /* -ENOMEM */
 
 	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
-		ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
+		ret = btrfs_lookup_bio_sums(inode, comp_bio, false, 0, sums);
 		BUG_ON(ret); /* -ENOMEM */
 	}
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b2e8fd8a8e59..5ad45171e482 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2789,9 +2789,7 @@ struct btrfs_dio_private;
 int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		    struct btrfs_fs_info *fs_info, u64 bytenr, u64 len);
 blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
-				   u8 *dst);
-blk_status_t btrfs_lookup_bio_sums_dio(struct inode *inode, struct bio *bio,
-			      u64 logical_offset);
+				   bool at_offset, u64 offset, u8 *dst);
 int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
 			     u64 objectid, u64 pos,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 3270a40b0777..b001ad073d16 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -148,8 +148,21 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
-				   u64 logical_offset, u8 *dst, int dio)
+/**
+ * btrfs_lookup_bio_sums - Look up checksums for a bio.
+ * @inode: inode that the bio is for.
+ * @bio: bio embedded in btrfs_io_bio.
+ * @at_offset: If true, look up checksums for the extent at @offset.
+ *             If false, use the page offsets from the bio.
+ * @offset: If @at_offset is true, offset in file to look up checksums for.
+ *          Ignored otherwise.
+ * @dst: Buffer of size btrfs_super_csum_size() used to return checksum. If
+ *       NULL, the checksum is returned in btrfs_io_bio(bio)->csum instead.
+ *
+ * Return: BLK_STS_RESOURCE if allocating memory fails, BLK_STS_OK otherwise.
+ */
+blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
+				   bool at_offset, u64 offset, u8 *dst)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct bio_vec bvec;
@@ -159,7 +172,6 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_path *path;
 	u8 *csum;
-	u64 offset = 0;
 	u64 item_start_offset = 0;
 	u64 item_last_offset = 0;
 	u64 disk_bytenr;
@@ -205,15 +217,13 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
 	}
 
 	disk_bytenr = (u64)bio->bi_iter.bi_sector << 9;
-	if (dio)
-		offset = logical_offset;
 
 	bio_for_each_segment(bvec, bio, iter) {
 		page_bytes_left = bvec.bv_len;
 		if (count)
 			goto next;
 
-		if (!dio)
+		if (!at_offset)
 			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
 		count = btrfs_find_ordered_sum(inode, offset, disk_bytenr,
 					       csum, nblocks);
@@ -285,18 +295,7 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
 
 	WARN_ON_ONCE(count);
 	btrfs_free_path(path);
-	return 0;
-}
-
-blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
-				   u8 *dst)
-{
-	return __btrfs_lookup_bio_sums(inode, bio, 0, dst, 0);
-}
-
-blk_status_t btrfs_lookup_bio_sums_dio(struct inode *inode, struct bio *bio, u64 offset)
-{
-	return __btrfs_lookup_bio_sums(inode, bio, offset, NULL, 1);
+	return BLK_STS_OK;
 }
 
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e3c76645cad7..1fe4e5ec7907 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2128,7 +2128,7 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 							   bio_flags);
 			goto out;
 		} else if (!skip_sum) {
-			ret = btrfs_lookup_bio_sums(inode, bio, NULL);
+			ret = btrfs_lookup_bio_sums(inode, bio, false, 0, NULL);
 			if (ret)
 				goto out;
 		}
@@ -8356,8 +8356,8 @@ static inline blk_status_t btrfs_lookup_and_bind_dio_csum(struct inode *inode,
 	 * contention.
 	 */
 	if (dip->logical_offset == file_offset) {
-		ret = btrfs_lookup_bio_sums_dio(inode, dip->orig_bio,
-						file_offset);
+		ret = btrfs_lookup_bio_sums(inode, dip->orig_bio, true,
+					    file_offset, NULL);
 		if (ret)
 			return ret;
 	}
-- 
2.24.0

