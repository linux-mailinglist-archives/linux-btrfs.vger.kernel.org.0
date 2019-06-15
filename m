Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B72471A2
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jun 2019 20:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfFOSZ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jun 2019 14:25:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45763 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfFOSZ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jun 2019 14:25:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id j19so6302553qtr.12;
        Sat, 15 Jun 2019 11:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pLgqiVc8WgttgL57a6zlFC+HBkK0RO6jy2y58MUbUT4=;
        b=UZBAdIST64h9/L93v+Uv8msKsSVnKhFMSQHg/22JuYK5k3DLY/0ykkOzXlAYktzoyA
         v6yMG4HP/Cg7E6aVGsWeRShi/BT7SoUaeb7NE1z+nfXwf6iY5Kd3fhuRKn+4W9Dx/CJr
         ywfu61mF/aCeW0pTFl6k1hnRd+n/kvPPIioJ0R+45ggMDYfN4ykJFUbS5LGrRaIEbp8s
         97d+QR7U3waeG2YNS8sAwUHXRoZ92E3X8Iwh2J6FUKA9SVOquDLHHow7yeT0gWKps6+h
         1Rc17No2J6q6G9Q/iXZgyoGNeJoEGHpNYvBda3xjLKF6252KROvKW7ksXAwZbA4Qp8UT
         51Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=pLgqiVc8WgttgL57a6zlFC+HBkK0RO6jy2y58MUbUT4=;
        b=Mx9S4t1i+3N/jjMbYWjrxTqwNC58MLeOyZNFJNzdUkJIWcPdgL0/sKg7Gb97cUln6c
         2tJKgSwviYK/tCYoVisfGLS671fqd+Tz0E7cLc5w9L7NWN78ey8OXcyfsXoRUKLUXYQS
         sHea6uapU/+XL+NTfQKp90HmBcswWjrvAWkIFglWLcL8XNnA2P44Uxvu8q/HFNYdfye6
         Q7sPdmHzhmb+mmCJ/7ehjSp057829y/NA+PMKJGMVrHcfKi+/sj+1B+NOr62yJVtQmt9
         jcpwL4LK5v3pouFebMnkRQ+qI98x1mO2QD3WEiZLeGXaY+6OdoREkC/qSdoUuJPozfsk
         QYnw==
X-Gm-Message-State: APjAAAWNGvg9XiFZY9TWgfx2Gpe5a5/z8wjJbBM+MEASbiW5Qzagf58C
        HVwbOG3AtX/cREtPdtdg9L4=
X-Google-Smtp-Source: APXvYqwNb+FCgzHWpIHkiWYcW19s6mZ0HR17PRI49sbK0dH0AnCBjMzU7HFOWMMcPTe0ecfsAFSaxQ==
X-Received: by 2002:a0c:fb07:: with SMTP id c7mr14426266qvp.229.1560623125887;
        Sat, 15 Jun 2019 11:25:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4883])
        by smtp.gmail.com with ESMTPSA id j66sm3749897qkf.86.2019.06.15.11.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 11:25:24 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/9] Btrfs: use REQ_CGROUP_PUNT for worker thread submitted bios
Date:   Sat, 15 Jun 2019 11:24:52 -0700
Message-Id: <20190615182453.843275-9-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190615182453.843275-1-tj@kernel.org>
References: <20190615182453.843275-1-tj@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Chris Mason <clm@fb.com>

Async CRCs and compression submit IO through helper threads, which
means they have IO priority inversions when cgroup IO controllers are
in use.

This flags all of the writes submitted by btrfs helper threads as
REQ_CGROUP_PUNT.  submit_bio() will punt these to dedicated per-blkcg
work items to avoid the priority inversion.

For the compression code, we take a reference on the wbc's blkg css and
pass it down to the async workers.

For the async crcs, the bio already has the correct css, we just need to
tell the block layer to use REQ_CGROUP_PUNT.

Signed-off-by: Chris Mason <clm@fb.com>
Modified-and-reviewed-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c |  8 +++++++-
 fs/btrfs/compression.h |  3 ++-
 fs/btrfs/disk-io.c     |  6 ++++++
 fs/btrfs/extent_io.c   |  3 +++
 fs/btrfs/inode.c       | 30 +++++++++++++++++++++++++++---
 5 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 873261b932b8..138479a9576c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -289,7 +289,8 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 				 unsigned long compressed_len,
 				 struct page **compressed_pages,
 				 unsigned long nr_pages,
-				 unsigned int write_flags)
+				 unsigned int write_flags,
+				 struct cgroup_subsys_state *blkcg_css)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct bio *bio = NULL;
@@ -323,6 +324,11 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 	bio->bi_opf = REQ_OP_WRITE | write_flags;
 	bio->bi_private = cb;
 	bio->bi_end_io = end_compressed_bio_write;
+
+	if (blkcg_css) {
+		bio->bi_opf |= REQ_CGROUP_PUNT;
+		bio_associate_blkg_from_css(bio, blkcg_css);
+	}
 	refcount_set(&cb->pending_bios, 1);
 
 	/* create and submit bios for the compressed pages */
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 9976fe0f7526..7cbefab96ecf 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -93,7 +93,8 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 				  unsigned long compressed_len,
 				  struct page **compressed_pages,
 				  unsigned long nr_pages,
-				  unsigned int write_flags);
+				  unsigned int write_flags,
+				  struct cgroup_subsys_state *blkcg_css);
 blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 				 int mirror_num, unsigned long bio_flags);
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9dbe4ba3995d..a5ebbf3d0833 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -799,6 +799,12 @@ static void run_one_async_done(struct btrfs_work *work)
 		return;
 	}
 
+	/*
+	 * All of the bios that pass through here are from async helpers.
+	 * Use REQ_CGROUP_PUNT to issue them from the owning cgroup's
+	 * context.  This changes nothing when cgroups aren't in use.
+	 */
+	async->bio->bi_opf |= REQ_CGROUP_PUNT;
 	ret = btrfs_map_bio(btrfs_sb(inode->i_sb), async->bio,
 			    async->mirror_num);
 	if (ret) {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9f223d7d78c0..d7b57341ff1a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4175,6 +4175,9 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 		.nr_to_write	= nr_pages * 2,
 		.range_start	= start,
 		.range_end	= end + 1,
+		/* we're called from an async helper function */
+		.punt_to_cgroup	= 1,
+		.no_wbc_acct	= 1,
 	};
 
 	while (start <= end) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index df5527cc07b9..3f9b35bc0455 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -357,6 +357,7 @@ struct async_extent {
 };
 
 struct async_chunk {
+	struct cgroup_subsys_state *blkcg_css;
 	struct inode *inode;
 	struct page *locked_page;
 	u64 start;
@@ -846,7 +847,8 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 				    ins.objectid,
 				    ins.offset, async_extent->pages,
 				    async_extent->nr_pages,
-				    async_chunk->write_flags)) {
+				    async_chunk->write_flags,
+				    async_chunk->blkcg_css)) {
 			struct page *p = async_extent->pages[0];
 			const u64 start = async_extent->start;
 			const u64 end = start + async_extent->ram_size - 1;
@@ -1170,6 +1172,8 @@ static noinline void async_cow_free(struct btrfs_work *work)
 	async_chunk = container_of(work, struct async_chunk, work);
 	if (async_chunk->inode)
 		btrfs_add_delayed_iput(async_chunk->inode);
+	if (async_chunk->blkcg_css)
+		css_put(async_chunk->blkcg_css);
 	/*
 	 * Since the pointer to 'pending' is at the beginning of the array of
 	 * async_chunk's, freeing it ensures the whole array has been freed.
@@ -1178,12 +1182,15 @@ static noinline void async_cow_free(struct btrfs_work *work)
 		kvfree(async_chunk->pending);
 }
 
-static int cow_file_range_async(struct inode *inode, struct page *locked_page,
+static int cow_file_range_async(struct inode *inode,
+				struct writeback_control *wbc,
+				struct page *locked_page,
 				u64 start, u64 end, int *page_started,
 				unsigned long *nr_written,
 				unsigned int write_flags)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct cgroup_subsys_state *blkcg_css = wbc_blkcg_css(wbc);
 	struct async_cow *ctx;
 	struct async_chunk *async_chunk;
 	unsigned long nr_pages;
@@ -1251,12 +1258,29 @@ static int cow_file_range_async(struct inode *inode, struct page *locked_page,
 		 * to unlock it.
 		 */
 		if (locked_page) {
+			/*
+			 * Depending on the compressibility, the pages
+			 * might or might not go through async.  We want
+			 * all of them to be accounted against @wbc once.
+			 * Let's do it here before the paths diverge.  wbc
+			 * accounting is used only for foreign writeback
+			 * detection and doesn't need full accuracy.  Just
+			 * account the whole thing against the first page.
+			 */
+			wbc_account_io(wbc, locked_page, cur_end - start);
 			async_chunk[i].locked_page = locked_page;
 			locked_page = NULL;
 		} else {
 			async_chunk[i].locked_page = NULL;
 		}
 
+		if (blkcg_css != blkcg_root_css) {
+			css_get(blkcg_css);
+			async_chunk[i].blkcg_css = blkcg_css;
+		} else {
+			async_chunk[i].blkcg_css = NULL;
+		}
+
 		btrfs_init_work(&async_chunk[i].work,
 				btrfs_delalloc_helper,
 				async_cow_start, async_cow_submit,
@@ -1653,7 +1677,7 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 	} else {
 		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
 			&BTRFS_I(inode)->runtime_flags);
-		ret = cow_file_range_async(inode, locked_page, start, end,
+		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
 					   page_started, nr_written,
 					   write_flags);
 	}
-- 
2.17.1

