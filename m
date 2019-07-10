Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D23864CC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2019 21:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfGJT2e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jul 2019 15:28:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41336 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbfGJT2e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jul 2019 15:28:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id q4so1697821pgj.8;
        Wed, 10 Jul 2019 12:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KAo4WuDRyf54TlDDwMAgNdT7JU5VFdfLCyBXfAFicR0=;
        b=AJIBfpzy73I3fiEnWjtI1Rq9EaTJalUxkidRxqm5b1kP+SgrCqS1OQP0/l9slWzmxW
         WwX+5HvIvatawBqEdrYJOrkFxAfqQlaYsqzhgYHMFZJaA8sr9e8m6/ULvXoBVM+ddZXS
         ldb6psmsfBDZ21w+HIL+DkNo9geu452qaYd+SgQO0YZieAfHvUxYYtdTmymQ5aMW9WU2
         1ExEjBhc2RgWnYmMh3yMNvvAhyekRIRvmuP9X3jq51/hLFzfr5EG46bm/60IjtJYyMup
         AF1ZyXqglKdM7NM6biviIIrLa9pClhTyJoxyiYoGjANkblO/fasTKXTgnRyvvgFfBXKl
         3UHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=KAo4WuDRyf54TlDDwMAgNdT7JU5VFdfLCyBXfAFicR0=;
        b=A4PMT0Rrf8fABz7OTTWygZJm1HT9LoibrRvvbFR74fn9XiKn60rGBnj02rhTVeOZbT
         QKJZIWq0oEtyCR7R6I3D0TLGk1Cn7iKmFW5p+ZwZdxaawFEfNtr6G2rFwWlbB3xlZMRU
         voneN8/yV2LXO/fz0hVQZJ1iLafEm6xW4Tima/T7DG1KqbQyd85K99VVJFFETMIv7HpX
         jVKYbdRfuyz3L10bPIWNGp/WPttzQWZyp0oE35Bj2MeZrszm/md2MJ9fEUlCnZ8FzFZb
         jL3hoGtnH3YLDeuHstx1paE4rhvqLsYJPS/WgACd9NskiLcdqKMja9Yd32Caay9mmUdp
         8nIQ==
X-Gm-Message-State: APjAAAVp9XBXYVSm5BkZv/f0guf4o5lj1BXGm6gTCulW+D8bzphOfWWr
        fPzm81F7OGZ0Qb5s4GFqK1Q=
X-Google-Smtp-Source: APXvYqyXzZCHQUdHCdzFQDuIckehOf5px056RzVkmTgXv/uggUcEMbxpHIwKZUaPmsddyKYbjqNioA==
X-Received: by 2002:a63:61cb:: with SMTP id v194mr36621307pgb.95.1562786913011;
        Wed, 10 Jul 2019 12:28:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2bbe])
        by smtp.gmail.com with ESMTPSA id t7sm2552894pjq.15.2019.07.10.12.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 12:28:32 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     josef@toxicpanda.com, clm@fb.com, dsterba@suse.com
Cc:     axboe@kernel.dk, jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/5] Btrfs: use REQ_CGROUP_PUNT for worker thread submitted bios
Date:   Wed, 10 Jul 2019 12:28:17 -0700
Message-Id: <20190710192818.1069475-5-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710192818.1069475-1-tj@kernel.org>
References: <20190710192818.1069475-1-tj@kernel.org>
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
 fs/btrfs/inode.c       | 31 ++++++++++++++++++++++++++++---
 5 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index dfc4eb9b7717..5b142d0d0a0b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -288,7 +288,8 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 				 unsigned long compressed_len,
 				 struct page **compressed_pages,
 				 unsigned long nr_pages,
-				 unsigned int write_flags)
+				 unsigned int write_flags,
+				 struct cgroup_subsys_state *blkcg_css)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct bio *bio = NULL;
@@ -322,6 +323,11 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
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
index 323cab06f2a9..cc0aa77b8128 100644
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
index a31574df06aa..3f3942618e92 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4173,6 +4173,9 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 		.nr_to_write	= nr_pages * 2,
 		.range_start	= start,
 		.range_end	= end + 1,
+		/* we're called from an async helper function */
+		.punt_to_cgroup	= 1,
+		.no_cgroup_owner = 1,
 	};
 
 	while (start <= end) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a81e9860ee1f..f5515aea6012 100644
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
@@ -1251,12 +1258,30 @@ static int cow_file_range_async(struct inode *inode, struct page *locked_page,
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
+			wbc_account_cgroup_owner(wbc, locked_page,
+						 cur_end - start);
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
@@ -1653,7 +1678,7 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
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

