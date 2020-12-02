Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCF52CB540
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 07:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgLBGtH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 01:49:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:53226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728673AbgLBGtH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 01:49:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606891700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kpytfpaTj990YZ36+owCZgBDAjsA8jP4wtNUccMQHxw=;
        b=tWvUcATD0YcB88Gh4yOkc7laWS96QmGHGsNT92ZEt15BK7aNODEYH9Y45sZkme/50wkJhu
        G3pZKx/cPlxWAHR+xAWkziPThpKCwUnG5jWo9/d/SiQMtCBUZW0h6FRx8Z2Jt46z+knyOS
        or/eStaZm4AhS9lgAgi/F0HOSscJpWw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 906BFAD5A
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 06:48:20 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 01/15] btrfs: rename bio_offset of extent_submit_bio_start_t to opt_file_offset
Date:   Wed,  2 Dec 2020 14:47:57 +0800
Message-Id: <20201202064811.100688-2-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202064811.100688-1-wqu@suse.com>
References: <20201202064811.100688-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The parameter bio_offset of extent_submit_bio_start_t is very confusing.

If it's really bio_offset (offset to bio), then it should be u32.

But in fact, it's only utilized by dio read, and that member is used as
file offset, which must be u64.

Rename it to opt_file_offset since the only user uses it as file offset,
and add comment for who is using it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   | 17 ++++++++---------
 fs/btrfs/disk-io.h   |  2 +-
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/inode.c     | 10 +++++-----
 4 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 46dd9e0b077e..504636803bc4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -113,11 +113,9 @@ struct async_submit_bio {
 	struct bio *bio;
 	extent_submit_bio_start_t *submit_bio_start;
 	int mirror_num;
-	/*
-	 * bio_offset is optional, can be used if the pages in the bio
-	 * can't tell us where in the file the bio should go
-	 */
-	u64 bio_offset;
+
+	/* Optional parameter for submit_bio_start, used by direct io */
+	u64 opt_file_offset;
 	struct btrfs_work work;
 	blk_status_t status;
 };
@@ -697,7 +695,8 @@ static void run_one_async_start(struct btrfs_work *work)
 	blk_status_t ret;
 
 	async = container_of(work, struct  async_submit_bio, work);
-	ret = async->submit_bio_start(async->inode, async->bio, async->bio_offset);
+	ret = async->submit_bio_start(async->inode, async->bio,
+				      async->opt_file_offset);
 	if (ret)
 		async->status = ret;
 }
@@ -749,7 +748,7 @@ static void run_one_async_free(struct btrfs_work *work)
 
 blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
 				 int mirror_num, unsigned long bio_flags,
-				 u64 bio_offset,
+				 u64 opt_file_offset,
 				 extent_submit_bio_start_t *submit_bio_start)
 {
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
@@ -767,7 +766,7 @@ blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
 	btrfs_init_work(&async->work, run_one_async_start, run_one_async_done,
 			run_one_async_free);
 
-	async->bio_offset = bio_offset;
+	async->opt_file_offset = opt_file_offset;
 
 	async->status = 0;
 
@@ -797,7 +796,7 @@ static blk_status_t btree_csum_one_bio(struct bio *bio)
 }
 
 static blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
-					   u64 bio_offset)
+					   u64 opt_file_offset)
 {
 	/*
 	 * when we're called for a write, we're already in the async
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 7b3ecad88d7e..9c2d6469bf25 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -116,7 +116,7 @@ blk_status_t btrfs_bio_wq_end_io(struct btrfs_fs_info *info, struct bio *bio,
 			enum btrfs_wq_endio_type metadata);
 blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
 				 int mirror_num, unsigned long bio_flags,
-				 u64 bio_offset,
+				 u64 opt_file_offset,
 				 extent_submit_bio_start_t *submit_bio_start);
 blk_status_t btrfs_submit_bio_done(void *private_data, struct bio *bio,
 			  int mirror_num);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 66762c3cdf81..d3c7ad02db24 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -72,7 +72,7 @@ typedef blk_status_t (submit_bio_hook_t)(struct inode *inode, struct bio *bio,
 					 unsigned long bio_flags);
 
 typedef blk_status_t (extent_submit_bio_start_t)(struct inode *inode,
-		struct bio *bio, u64 bio_offset);
+		struct bio *bio, u64 opt_file_offset);
 
 #define INLINE_EXTENT_BUFFER_PAGES 16
 #define MAX_INLINE_EXTENT_BUFFER_SIZE (INLINE_EXTENT_BUFFER_PAGES * PAGE_SIZE)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0ce42d52d53e..cf27729e41c8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2212,7 +2212,7 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
  * are inserted into the btree
  */
 static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
-					   u64 bio_offset)
+					   u64 opt_file_offset)
 {
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
 }
@@ -7795,9 +7795,10 @@ static void __endio_write_update_ordered(struct btrfs_inode *inode,
 }
 
 static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
-						     struct bio *bio, u64 offset)
+						     struct bio *bio,
+						     u64 opt_file_offset)
 {
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, offset, 1);
+	return btrfs_csum_one_bio(BTRFS_I(inode), bio, opt_file_offset, 1);
 }
 
 static void btrfs_end_dio_bio(struct bio *bio)
@@ -7846,8 +7847,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		goto map;
 
 	if (write && async_submit) {
-		ret = btrfs_wq_submit_bio(inode, bio, 0, 0,
-					  file_offset,
+		ret = btrfs_wq_submit_bio(inode, bio, 0, 0, file_offset,
 					  btrfs_submit_bio_start_direct_io);
 		goto err;
 	} else if (write) {
-- 
2.29.2

