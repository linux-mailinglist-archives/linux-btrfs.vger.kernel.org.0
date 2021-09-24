Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1562B416B31
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Sep 2021 07:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbhIXFcq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Sep 2021 01:32:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53638 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242549AbhIXFcq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Sep 2021 01:32:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 202461FFCE;
        Fri, 24 Sep 2021 05:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632461473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kvV1ipwRHJgqU5LnFTLPxqylvexbMgQtvNCbtHi+BwE=;
        b=vBh53CdH4NfCNW6b46prglyXCKFguYNX6KpMC1EcNmHMs/r8vNJLCN6TM+QNb0yGWv4I0l
        g/b8xaVwkxa2Uf7TqzPVjgCzdbmD9d2DgjG6vbckfB3kokYLIQPRNbyErMXbG+yhKT5xHf
        UhjogQAivFoIAGA2hul4Zb8sLgdehao=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47B2A13A09;
        Fri, 24 Sep 2021 05:31:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QGg+BaBiTWH4RAAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 24 Sep 2021 05:31:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 2/2] btrfs: remove btrfs_raid_bio::fs_info member
Date:   Fri, 24 Sep 2021 13:30:53 +0800
Message-Id: <20210924053053.16100-2-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924053053.16100-1-wqu@suse.com>
References: <20210924053053.16100-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can grab fs_info reliably from btrfs_raid_bio::bioc, as the bioc is
always passed into alloc_rbio(), and only get released when the raid bio
is released.

This patch will remove btrfs_raid_bio::fs_info member, and cleanup all
the @fs_info parameters for alloc_rbio() callers.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add Nik's reviewed by tag
---
 fs/btrfs/raid56.c  | 48 +++++++++++++++++++++++++---------------------
 fs/btrfs/raid56.h  | 18 ++++++++---------
 fs/btrfs/scrub.c   |  8 ++++----
 fs/btrfs/volumes.c |  7 +++----
 4 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 02aa3fbb8108..5ea70c7def98 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -60,7 +60,6 @@ enum btrfs_rbio_ops {
 };
 
 struct btrfs_raid_bio {
-	struct btrfs_fs_info *fs_info;
 	struct btrfs_io_context *bioc;
 
 	/* while we're doing rmw on a stripe
@@ -192,7 +191,7 @@ static void scrub_parity_work(struct btrfs_work *work);
 static void start_async_work(struct btrfs_raid_bio *rbio, btrfs_func_t work_func)
 {
 	btrfs_init_work(&rbio->work, work_func, NULL, NULL);
-	btrfs_queue_work(rbio->fs_info->rmw_workers, &rbio->work);
+	btrfs_queue_work(rbio->bioc->fs_info->rmw_workers, &rbio->work);
 }
 
 /*
@@ -345,7 +344,7 @@ static void __remove_rbio_from_cache(struct btrfs_raid_bio *rbio)
 	if (!test_bit(RBIO_CACHE_BIT, &rbio->flags))
 		return;
 
-	table = rbio->fs_info->stripe_hash_table;
+	table = rbio->bioc->fs_info->stripe_hash_table;
 	h = table->table + bucket;
 
 	/* hold the lock for the bucket because we may be
@@ -400,7 +399,7 @@ static void remove_rbio_from_cache(struct btrfs_raid_bio *rbio)
 	if (!test_bit(RBIO_CACHE_BIT, &rbio->flags))
 		return;
 
-	table = rbio->fs_info->stripe_hash_table;
+	table = rbio->bioc->fs_info->stripe_hash_table;
 
 	spin_lock_irqsave(&table->cache_lock, flags);
 	__remove_rbio_from_cache(rbio);
@@ -460,7 +459,7 @@ static void cache_rbio(struct btrfs_raid_bio *rbio)
 	if (!test_bit(RBIO_CACHE_READY_BIT, &rbio->flags))
 		return;
 
-	table = rbio->fs_info->stripe_hash_table;
+	table = rbio->bioc->fs_info->stripe_hash_table;
 
 	spin_lock_irqsave(&table->cache_lock, flags);
 	spin_lock(&rbio->bio_list_lock);
@@ -668,7 +667,7 @@ static noinline int lock_stripe_add(struct btrfs_raid_bio *rbio)
 	struct btrfs_raid_bio *cache_drop = NULL;
 	int ret = 0;
 
-	h = rbio->fs_info->stripe_hash_table->table + rbio_bucket(rbio);
+	h = rbio->bioc->fs_info->stripe_hash_table->table + rbio_bucket(rbio);
 
 	spin_lock_irqsave(&h->lock, flags);
 	list_for_each_entry(cur, &h->hash_list, hash_list) {
@@ -750,7 +749,7 @@ static noinline void unlock_stripe(struct btrfs_raid_bio *rbio)
 	int keep_cache = 0;
 
 	bucket = rbio_bucket(rbio);
-	h = rbio->fs_info->stripe_hash_table->table + bucket;
+	h = rbio->bioc->fs_info->stripe_hash_table->table + bucket;
 
 	if (list_empty(&rbio->plug_list))
 		cache_rbio(rbio);
@@ -864,7 +863,8 @@ static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t err)
 	struct bio *extra;
 
 	if (rbio->generic_bio_cnt)
-		btrfs_bio_counter_sub(rbio->fs_info, rbio->generic_bio_cnt);
+		btrfs_bio_counter_sub(rbio->bioc->fs_info,
+				      rbio->generic_bio_cnt);
 
 	/*
 	 * At this moment, rbio->bio_list is empty, however since rbio does not
@@ -987,7 +987,6 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&rbio->stripe_cache);
 	INIT_LIST_HEAD(&rbio->hash_list);
 	rbio->bioc = bioc;
-	rbio->fs_info = fs_info;
 	rbio->stripe_len = stripe_len;
 	rbio->nr_pages = num_pages;
 	rbio->real_stripes = real_stripes;
@@ -1546,7 +1545,8 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 		bio->bi_end_io = raid_rmw_end_io;
 		bio->bi_opf = REQ_OP_READ;
 
-		btrfs_bio_wq_end_io(rbio->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
+		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio,
+				    BTRFS_WQ_ENDIO_RAID56);
 
 		submit_bio(bio);
 	}
@@ -1718,9 +1718,10 @@ static void btrfs_raid_unplug(struct blk_plug_cb *cb, bool from_schedule)
 /*
  * our main entry point for writes from the rest of the FS.
  */
-int raid56_parity_write(struct btrfs_fs_info *fs_info, struct bio *bio,
-			struct btrfs_io_context *bioc, u64 stripe_len)
+int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc,
+			u64 stripe_len)
 {
+	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
 	struct btrfs_plug_cb *plug = NULL;
 	struct blk_plug_cb *cb;
@@ -2091,7 +2092,8 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 		bio->bi_end_io = raid_recover_end_io;
 		bio->bi_opf = REQ_OP_READ;
 
-		btrfs_bio_wq_end_io(rbio->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
+		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio,
+				    BTRFS_WQ_ENDIO_RAID56);
 
 		submit_bio(bio);
 	}
@@ -2115,10 +2117,10 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
  * so we assume the bio they send down corresponds to a failed part
  * of the drive.
  */
-int raid56_parity_recover(struct btrfs_fs_info *fs_info, struct bio *bio,
-			  struct btrfs_io_context *bioc, u64 stripe_len,
-			  int mirror_num, int generic_io)
+int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
+			  u64 stripe_len, int mirror_num, int generic_io)
 {
+	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
 	int ret;
 
@@ -2221,11 +2223,11 @@ static void read_rebuild_work(struct btrfs_work *work)
  */
 
 struct btrfs_raid_bio *
-raid56_parity_alloc_scrub_rbio(struct btrfs_fs_info *fs_info, struct bio *bio,
-			       struct btrfs_io_context *bioc, u64 stripe_len,
-			       struct btrfs_device *scrub_dev,
+raid56_parity_alloc_scrub_rbio(struct bio *bio, struct btrfs_io_context *bioc,
+			       u64 stripe_len, struct btrfs_device *scrub_dev,
 			       unsigned long *dbitmap, int stripe_nsectors)
 {
+	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
 	int i;
 
@@ -2633,7 +2635,8 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 		bio->bi_end_io = raid56_parity_scrub_end_io;
 		bio->bi_opf = REQ_OP_READ;
 
-		btrfs_bio_wq_end_io(rbio->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
+		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio,
+				    BTRFS_WQ_ENDIO_RAID56);
 
 		submit_bio(bio);
 	}
@@ -2669,9 +2672,10 @@ void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)
 /* The following code is used for dev replace of a missing RAID 5/6 device. */
 
 struct btrfs_raid_bio *
-raid56_alloc_missing_rbio(struct btrfs_fs_info *fs_info, struct bio *bio,
-			  struct btrfs_io_context *bioc, u64 length)
+raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc,
+			  u64 length)
 {
+	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
 
 	rbio = alloc_rbio(fs_info, bioc, length);
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 838d3a5e07ef..3fd1a0e03993 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -30,25 +30,23 @@ static inline int nr_data_stripes(const struct map_lookup *map)
 struct btrfs_raid_bio;
 struct btrfs_device;
 
-int raid56_parity_recover(struct btrfs_fs_info *fs_info, struct bio *bio,
-			  struct btrfs_io_context *bioc, u64 stripe_len,
-			  int mirror_num, int generic_io);
-int raid56_parity_write(struct btrfs_fs_info *fs_info, struct bio *bio,
-			struct btrfs_io_context *bioc, u64 stripe_len);
+int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
+			  u64 stripe_len, int mirror_num, int generic_io);
+int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc,
+			u64 stripe_len);
 
 void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
 			    u64 logical);
 
 struct btrfs_raid_bio *
-raid56_parity_alloc_scrub_rbio(struct btrfs_fs_info *fs_info, struct bio *bio,
-			       struct btrfs_io_context *bioc, u64 stripe_len,
-			       struct btrfs_device *scrub_dev,
+raid56_parity_alloc_scrub_rbio(struct bio *bio, struct btrfs_io_context *bioc,
+			       u64 stripe_len, struct btrfs_device *scrub_dev,
 			       unsigned long *dbitmap, int stripe_nsectors);
 void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio);
 
 struct btrfs_raid_bio *
-raid56_alloc_missing_rbio(struct btrfs_fs_info *fs_info, struct bio *bio,
-			  struct btrfs_io_context *bioc, u64 length);
+raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc,
+			  u64 length);
 void raid56_submit_missing_rbio(struct btrfs_raid_bio *rbio);
 
 int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c8658546607f..bd3cd7427391 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1400,7 +1400,7 @@ static int scrub_submit_raid56_bio_wait(struct btrfs_fs_info *fs_info,
 	bio->bi_end_io = scrub_bio_wait_endio;
 
 	mirror_num = spage->sblock->pagev[0]->mirror_num;
-	ret = raid56_parity_recover(fs_info, bio, spage->recover->bioc,
+	ret = raid56_parity_recover(bio, spage->recover->bioc,
 				    spage->recover->map_length,
 				    mirror_num, 0);
 	if (ret)
@@ -2230,7 +2230,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 	bio->bi_private = sblock;
 	bio->bi_end_io = scrub_missing_raid56_end_io;
 
-	rbio = raid56_alloc_missing_rbio(fs_info, bio, bioc, length);
+	rbio = raid56_alloc_missing_rbio(bio, bioc, length);
 	if (!rbio)
 		goto rbio_out;
 
@@ -2846,8 +2846,8 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 	bio->bi_private = sparity;
 	bio->bi_end_io = scrub_parity_bio_endio;
 
-	rbio = raid56_parity_alloc_scrub_rbio(fs_info, bio, bioc,
-					      length, sparity->scrub_dev,
+	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, length,
+					      sparity->scrub_dev,
 					      sparity->dbitmap,
 					      sparity->nsectors);
 	if (!rbio)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 89c802f8b35b..8fa443891558 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6709,11 +6709,10 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		/* In this case, map_length has been set to the length of
 		   a single stripe; not the whole write */
 		if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-			ret = raid56_parity_write(fs_info, bio, bioc,
-						  map_length);
+			ret = raid56_parity_write(bio, bioc, map_length);
 		} else {
-			ret = raid56_parity_recover(fs_info, bio, bioc,
-						    map_length, mirror_num, 1);
+			ret = raid56_parity_recover(bio, bioc, map_length,
+						    mirror_num, 1);
 		}
 
 		btrfs_bio_counter_dec(fs_info);
-- 
2.33.0

