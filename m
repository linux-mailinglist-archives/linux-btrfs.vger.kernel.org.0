Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF13294823
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440719AbgJUG0R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:42612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440718AbgJUG0R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/984dPw0TZ6e0w9hf/o8ydoO/aSED0BXaz0rRgHbCy4=;
        b=EhbnpHn6EZvAjljp2SFqMYjgiPR95Bvp/sdbP73Ma2CjD7tqeX2sRk9AeNhAqqsVC0r8J3
        SpnRIaG5MiYPVSPFQWmMCaV9PKoeH8haEZRNUh4XcwqY+Bx6M+0pU2z6OiEpcfDp0qURQM
        wmGo829mtjRusOQrIFtzc4YPsAqoz5A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 44036AC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 07/68] btrfs: disk-io: replace @fs_info and @private_data with @inode for btrfs_wq_submit_bio()
Date:   Wed, 21 Oct 2020 14:24:53 +0800
Message-Id: <20201021062554.68132-8-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All callers for btrfs_wq_submit_bio() passes struct inode as
@private_data, so there is no need for @private_data to be (void *),
just replace it with "struct inode *inode".

While we can extra fs_info from struct inode, also remove the @fs_info
parameter.

Since we're here, also replace all the (void *private_data) into (struct
inode *inode).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   | 21 +++++++++++----------
 fs/btrfs/disk-io.h   |  8 ++++----
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/inode.c     | 21 +++++++++------------
 4 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index be6edbd34934..b7436ab7bba9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -110,7 +110,7 @@ static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
  * just before they are sent down the IO stack.
  */
 struct async_submit_bio {
-	void *private_data;
+	struct inode *inode;
 	struct bio *bio;
 	extent_submit_bio_start_t *submit_bio_start;
 	int mirror_num;
@@ -746,7 +746,7 @@ static void run_one_async_start(struct btrfs_work *work)
 	blk_status_t ret;
 
 	async = container_of(work, struct  async_submit_bio, work);
-	ret = async->submit_bio_start(async->private_data, async->bio,
+	ret = async->submit_bio_start(async->inode, async->bio,
 				      async->bio_offset);
 	if (ret)
 		async->status = ret;
@@ -767,7 +767,7 @@ static void run_one_async_done(struct btrfs_work *work)
 	blk_status_t ret;
 
 	async = container_of(work, struct  async_submit_bio, work);
-	inode = async->private_data;
+	inode = async->inode;
 
 	/* If an error occurred we just want to clean up the bio and move on */
 	if (async->status) {
@@ -797,18 +797,19 @@ static void run_one_async_free(struct btrfs_work *work)
 	kfree(async);
 }
 
-blk_status_t btrfs_wq_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
+blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
 				 int mirror_num, unsigned long bio_flags,
-				 u64 bio_offset, void *private_data,
+				 u64 bio_offset,
 				 extent_submit_bio_start_t *submit_bio_start)
 {
+	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	struct async_submit_bio *async;
 
 	async = kmalloc(sizeof(*async), GFP_NOFS);
 	if (!async)
 		return BLK_STS_RESOURCE;
 
-	async->private_data = private_data;
+	async->inode = inode;
 	async->bio = bio;
 	async->mirror_num = mirror_num;
 	async->submit_bio_start = submit_bio_start;
@@ -845,8 +846,8 @@ static blk_status_t btree_csum_one_bio(struct bio *bio)
 	return errno_to_blk_status(ret);
 }
 
-static blk_status_t btree_submit_bio_start(void *private_data, struct bio *bio,
-					     u64 bio_offset)
+static blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
+					   u64 bio_offset)
 {
 	/*
 	 * when we're called for a write, we're already in the async
@@ -893,8 +894,8 @@ static blk_status_t btree_submit_bio_hook(struct inode *inode, struct bio *bio,
 		 * kthread helpers are used to submit writes so that
 		 * checksumming can happen in parallel across all CPUs
 		 */
-		ret = btrfs_wq_submit_bio(fs_info, bio, mirror_num, 0,
-					  0, inode, btree_submit_bio_start);
+		ret = btrfs_wq_submit_bio(inode, bio, mirror_num, 0,
+					  0, btree_submit_bio_start);
 	}
 
 	if (ret)
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 00dc39d47ed3..2d564e9223e2 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -105,10 +105,10 @@ int btrfs_read_buffer(struct extent_buffer *buf, u64 parent_transid, int level,
 		      struct btrfs_key *first_key);
 blk_status_t btrfs_bio_wq_end_io(struct btrfs_fs_info *info, struct bio *bio,
 			enum btrfs_wq_endio_type metadata);
-blk_status_t btrfs_wq_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
-			int mirror_num, unsigned long bio_flags,
-			u64 bio_offset, void *private_data,
-			extent_submit_bio_start_t *submit_bio_start);
+blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
+				 int mirror_num, unsigned long bio_flags,
+				 u64 bio_offset,
+				 extent_submit_bio_start_t *submit_bio_start);
 blk_status_t btrfs_submit_bio_done(void *private_data, struct bio *bio,
 			  int mirror_num);
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 30794ae58498..3c9252b429e0 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -71,7 +71,7 @@ typedef blk_status_t (submit_bio_hook_t)(struct inode *inode, struct bio *bio,
 					 int mirror_num,
 					 unsigned long bio_flags);
 
-typedef blk_status_t (extent_submit_bio_start_t)(void *private_data,
+typedef blk_status_t (extent_submit_bio_start_t)(struct inode *inode,
 		struct bio *bio, u64 bio_offset);
 
 struct extent_io_ops {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1d2fe21489ca..2a56d3b8eff4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2157,11 +2157,9 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
  * At IO completion time the cums attached on the ordered extent record
  * are inserted into the btree
  */
-static blk_status_t btrfs_submit_bio_start(void *private_data, struct bio *bio,
-				    u64 bio_offset)
+static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
+					   u64 bio_offset)
 {
-	struct inode *inode = private_data;
-
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
 }
 
@@ -2221,8 +2219,8 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 		if (root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID)
 			goto mapit;
 		/* we're doing a write, do the async checksumming */
-		ret = btrfs_wq_submit_bio(fs_info, bio, mirror_num, bio_flags,
-					  0, inode, btrfs_submit_bio_start);
+		ret = btrfs_wq_submit_bio(inode, bio, mirror_num, bio_flags,
+					  0, btrfs_submit_bio_start);
 		goto out;
 	} else if (!skip_sum) {
 		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
@@ -7615,11 +7613,10 @@ static void __endio_write_update_ordered(struct btrfs_inode *inode,
 	}
 }
 
-static blk_status_t btrfs_submit_bio_start_direct_io(void *private_data,
-				    struct bio *bio, u64 offset)
+static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
+						     struct bio *bio,
+						     u64 offset)
 {
-	struct inode *inode = private_data;
-
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, offset, 1);
 }
 
@@ -7670,8 +7667,8 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		goto map;
 
 	if (write && async_submit) {
-		ret = btrfs_wq_submit_bio(fs_info, bio, 0, 0,
-					  file_offset, inode,
+		ret = btrfs_wq_submit_bio(inode, bio, 0, 0,
+					  file_offset,
 					  btrfs_submit_bio_start_direct_io);
 		goto err;
 	} else if (write) {
-- 
2.28.0

