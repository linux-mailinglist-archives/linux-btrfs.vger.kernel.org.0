Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC8AA450AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 02:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfFNAeM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 20:34:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34851 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfFNAeM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 20:34:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id p1so232724plo.2;
        Thu, 13 Jun 2019 17:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sVYTXiQ9o7WtxYr36lhIYdisyABTyxIOOYbtpASLFbc=;
        b=Nsm52YdQ9/C0YEYNzUwNwfEiT2WrLRKvwF9qHbpVmOXnMDhunyGf06jKohMovZUz+1
         vRkcBhnZvLVK+5UVfWfmkXph53Dsmw+2TagL1PIk/LCfwVSVnWMAu+WXv2Hd3TGMGtYW
         0dpeEfIYGRbkGCpustHJHJ9/BQ4/oCiCFWYE1FW7bwdxH+BdmTve+7rkUubTOBqaFwei
         Yivb4Y7Ct4bcoUI7EJu1+o/VsTcRZuhDtvG9q9aWfx/MMTIGpmXtCbq2ODuXmHXToFew
         jmOS1vuK4qNZAw0mWG/SGojmtmYXK+do8UjtCeTL53yNR3WuCkihI0AyTPolxVRci+pL
         /esA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=sVYTXiQ9o7WtxYr36lhIYdisyABTyxIOOYbtpASLFbc=;
        b=an+NKq6RdKxPbv7top/VXToCnymxBEpXbK/qh5oS4U6AjFhLumr6cgAYGjkJqpbi09
         AsFbE27Osz2PBAP7u2dHQNlH5N2mmuy3A+wm1n53QjTodBzSl+/Qe8wove3k5PtxwRi7
         GhJV/x1PoJyl2HBl+Flp9efEV/R0AGNLbHQPVJ76XaplduYkIrpZ2+Pwn6ZtbABmZxwn
         49M87CiXfhQnBkkulIm31q5JeCdUZyyMeXTq/C7KQ5Vfap/I4Ieb2laiCBM9n5L6FHhx
         kqutXI25fY+bQd1RGAeTQUqMBjk/5tv1tmeh4UVVzJKv8rXb3o6s7pYJZu9MbAzPnWDA
         vohQ==
X-Gm-Message-State: APjAAAUl5L2ttHA2t71l8HqFzZLeUO7jvFXTIgMjbjruU1kOaX6uEAhS
        u4zoYu46WtSgV7YdSWLRzlI=
X-Google-Smtp-Source: APXvYqwz+bmUI0KjWHlNAVTYLIUIInTaR5wR92oR5jpzIEIymkBKlZGhe/zTMBBR7lTiY1ALrT5utg==
X-Received: by 2002:a17:902:5a4c:: with SMTP id f12mr11030750plm.332.1560472451167;
        Thu, 13 Jun 2019 17:34:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id j1sm819526pfe.101.2019.06.13.17.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 17:34:10 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/8] Btrfs: use REQ_CGROUP_PUNT for worker thread submitted bios
Date:   Thu, 13 Jun 2019 17:33:49 -0700
Message-Id: <20190614003350.1178444-8-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614003350.1178444-1-tj@kernel.org>
References: <20190614003350.1178444-1-tj@kernel.org>
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

