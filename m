Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA60B504BBE
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 06:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbiDREqC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 00:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbiDREqB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 00:46:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E4413E97
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 21:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ax+3gXNcGcHvoJsEEQEhxYgri6qYtyqv8I9ItVCoJ/w=; b=pdywUhIH4op2/aX/5NR84x7Kww
        M0Z7173JNthoy1LlJW2jVt/ev0gBhqMLilxN+HjUz/Ae+Gb4MHZGjZs8f4vG84shXkF+RufA+LIZw
        E6/L+6ACfejEo4gnT3ZtK8fEnDDCbDDl4AxaxQi9GdF7yYAZlhXYGmSSv2Ir6KtCueOvXN7qAsoMf
        UQ9iT8zA8F0Jnko3XxuSVq99lt5rl9Rv3/oHYix90ta7GOOQIPTLyxtvRlvCO0IixzG8IC3PY9UpV
        1Go5IzEtJBEwKaFQrnpXCgOlN2rFEOIkp27/FEU4cFsngajoE/aLqL2Dt13I46GJtKHDgtIMVLBAj
        mtNXO9oQ==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngJEQ-00FYRR-2i; Mon, 18 Apr 2022 04:43:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: use a normal workqueue for rmw_workers
Date:   Mon, 18 Apr 2022 06:43:11 +0200
Message-Id: <20220418044311.359720-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220418044311.359720-1-hch@lst.de>
References: <20220418044311.359720-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

rmw_workers doesn't need ordered execution or thread disabling threshold
(as the thresh parameter is less than DFT_THRESHOLD).

Just switch to the normal workqueues that use a lot less resources,
especially in the work_struct vs btrfs_work structures.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ctree.h   |  2 +-
 fs/btrfs/disk-io.c |  5 ++---
 fs/btrfs/raid56.c  | 29 ++++++++++++++---------------
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 59135f0850a6e..74fbd92f704f9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -853,7 +853,7 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *endio_workers;
 	struct btrfs_workqueue *endio_meta_workers;
 	struct btrfs_workqueue *endio_raid56_workers;
-	struct btrfs_workqueue *rmw_workers;
+	struct workqueue_struct *rmw_workers;
 	struct btrfs_workqueue *endio_meta_write_workers;
 	struct btrfs_workqueue *endio_write_workers;
 	struct btrfs_workqueue *endio_freespace_worker;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 980616cc08bfc..cc7ca8a0df697 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2290,7 +2290,7 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 	btrfs_destroy_workqueue(fs_info->workers);
 	btrfs_destroy_workqueue(fs_info->endio_workers);
 	btrfs_destroy_workqueue(fs_info->endio_raid56_workers);
-	btrfs_destroy_workqueue(fs_info->rmw_workers);
+	destroy_workqueue(fs_info->rmw_workers);
 	btrfs_destroy_workqueue(fs_info->endio_write_workers);
 	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
 	btrfs_destroy_workqueue(fs_info->delayed_workers);
@@ -2500,8 +2500,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	fs_info->endio_raid56_workers =
 		btrfs_alloc_workqueue(fs_info, "endio-raid56", flags,
 				      max_active, 4);
-	fs_info->rmw_workers =
-		btrfs_alloc_workqueue(fs_info, "rmw", flags, max_active, 2);
+	fs_info->rmw_workers = alloc_workqueue("btrfs-rmw", flags, max_active);
 	fs_info->endio_write_workers =
 		btrfs_alloc_workqueue(fs_info, "endio-write", flags,
 				      max_active, 2);
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 79438cdd604ea..c1c320f87216d 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -77,7 +77,7 @@ struct btrfs_raid_bio {
 	/*
 	 * for scheduling work in the helper threads
 	 */
-	struct btrfs_work work;
+	struct work_struct work;
 
 	/*
 	 * bio list and bio_list_lock are used
@@ -176,8 +176,8 @@ struct btrfs_raid_bio {
 
 static int __raid56_parity_recover(struct btrfs_raid_bio *rbio);
 static noinline void finish_rmw(struct btrfs_raid_bio *rbio);
-static void rmw_work(struct btrfs_work *work);
-static void read_rebuild_work(struct btrfs_work *work);
+static void rmw_work(struct work_struct *work);
+static void read_rebuild_work(struct work_struct *work);
 static int fail_bio_stripe(struct btrfs_raid_bio *rbio, struct bio *bio);
 static int fail_rbio_index(struct btrfs_raid_bio *rbio, int failed);
 static void __free_raid_bio(struct btrfs_raid_bio *rbio);
@@ -186,12 +186,12 @@ static int alloc_rbio_pages(struct btrfs_raid_bio *rbio);
 
 static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 					 int need_check);
-static void scrub_parity_work(struct btrfs_work *work);
+static void scrub_parity_work(struct work_struct *work);
 
-static void start_async_work(struct btrfs_raid_bio *rbio, btrfs_func_t work_func)
+static void start_async_work(struct btrfs_raid_bio *rbio, work_func_t work_func)
 {
-	btrfs_init_work(&rbio->work, work_func, NULL, NULL);
-	btrfs_queue_work(rbio->bioc->fs_info->rmw_workers, &rbio->work);
+	INIT_WORK(&rbio->work, work_func);
+	queue_work(rbio->bioc->fs_info->rmw_workers, &rbio->work);
 }
 
 /*
@@ -1599,7 +1599,7 @@ struct btrfs_plug_cb {
 	struct blk_plug_cb cb;
 	struct btrfs_fs_info *info;
 	struct list_head rbio_list;
-	struct btrfs_work work;
+	struct work_struct work;
 };
 
 /*
@@ -1667,7 +1667,7 @@ static void run_plug(struct btrfs_plug_cb *plug)
  * if the unplug comes from schedule, we have to push the
  * work off to a helper thread
  */
-static void unplug_work(struct btrfs_work *work)
+static void unplug_work(struct work_struct *work)
 {
 	struct btrfs_plug_cb *plug;
 	plug = container_of(work, struct btrfs_plug_cb, work);
@@ -1680,9 +1680,8 @@ static void btrfs_raid_unplug(struct blk_plug_cb *cb, bool from_schedule)
 	plug = container_of(cb, struct btrfs_plug_cb, cb);
 
 	if (from_schedule) {
-		btrfs_init_work(&plug->work, unplug_work, NULL, NULL);
-		btrfs_queue_work(plug->info->rmw_workers,
-				 &plug->work);
+		INIT_WORK(&plug->work, unplug_work);
+		queue_work(plug->info->rmw_workers, &plug->work);
 		return;
 	}
 	run_plug(plug);
@@ -2167,7 +2166,7 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 
 }
 
-static void rmw_work(struct btrfs_work *work)
+static void rmw_work(struct work_struct *work)
 {
 	struct btrfs_raid_bio *rbio;
 
@@ -2175,7 +2174,7 @@ static void rmw_work(struct btrfs_work *work)
 	raid56_rmw_stripe(rbio);
 }
 
-static void read_rebuild_work(struct btrfs_work *work)
+static void read_rebuild_work(struct work_struct *work)
 {
 	struct btrfs_raid_bio *rbio;
 
@@ -2621,7 +2620,7 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 	validate_rbio_for_parity_scrub(rbio);
 }
 
-static void scrub_parity_work(struct btrfs_work *work)
+static void scrub_parity_work(struct work_struct *work)
 {
 	struct btrfs_raid_bio *rbio;
 
-- 
2.30.2

