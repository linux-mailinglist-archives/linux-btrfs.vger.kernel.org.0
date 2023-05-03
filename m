Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752DC6F5095
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 09:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjECHGc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 03:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjECHGb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 03:06:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EE4422D
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 00:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=aoQaVeD3u5IhR7hSITYV12FCpghxrrSA5CiiNQNeL04=; b=UzFrXjYP3uXdmbcTqylXRmbVne
        XYCT92L/XH5BiobH+d4bfxMLSGhH/JzyAJTGtbxYOkk5eOKLyoWIFvR9VhDiKSkwmSgo4fQsi+Ihb
        WjRjBtVoxxrtMtIEwBH1XXX+0WBOUka4d7M7EmzbjKGCs8St+GhhDF59Y1TTcrrAQgs3BwXtG3ns9
        ZJeUf8W/MnttApxZt0G8BIZBhNsV4JFy6XbJSrOo9EZt5PvGQboLUCS9zkXASG2G3Sci71QT5V5kr
        X1rGNVEYBsobDXJnpN5HyhogA2g9BQGLmnjRL69iqBv9TD5J6kho01qXIE4Ec94yZFYzQoZ8JI3tp
        /LpHZMFQ==;
Received: from 213-225-6-169.nat.highway.a1.net ([213.225.6.169] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pu6ZI-003aEn-1b;
        Wed, 03 May 2023 07:06:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: remove hipri_workers workqueue
Date:   Wed,  3 May 2023 09:06:15 +0200
Message-Id: <20230503070615.1029820-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230503070615.1029820-1-hch@lst.de>
References: <20230503070615.1029820-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that btrfs_wq_submit_bio is never called for synchronous I/O,
the hipri_workers workqueue is dead code and can be removeḋ.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chris Mason <clm@fb.com>
---
 fs/btrfs/bio.c     | 5 +----
 fs/btrfs/disk-io.c | 6 +-----
 fs/btrfs/fs.h      | 1 -
 fs/btrfs/super.c   | 1 -
 4 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 49324388499cf1..fa07e9fbb7c395 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -619,10 +619,7 @@ static bool btrfs_wq_submit_bio(struct btrfs_bio *bbio,
 
 	btrfs_init_work(&async->work, run_one_async_start, run_one_async_done,
 			run_one_async_free);
-	if (op_is_sync(bbio->bio.bi_opf))
-		btrfs_queue_work(fs_info->hipri_workers, &async->work);
-	else
-		btrfs_queue_work(fs_info->workers, &async->work);
+	btrfs_queue_work(fs_info->workers, &async->work);
 	return true;
 }
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 59ea049fe7ee0d..96f144094af687 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1985,7 +1985,6 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 {
 	btrfs_destroy_workqueue(fs_info->fixup_workers);
 	btrfs_destroy_workqueue(fs_info->delalloc_workers);
-	btrfs_destroy_workqueue(fs_info->hipri_workers);
 	btrfs_destroy_workqueue(fs_info->workers);
 	if (fs_info->endio_workers)
 		destroy_workqueue(fs_info->endio_workers);
@@ -2180,9 +2179,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 
 	fs_info->workers =
 		btrfs_alloc_workqueue(fs_info, "worker", flags, max_active, 16);
-	fs_info->hipri_workers =
-		btrfs_alloc_workqueue(fs_info, "worker-high",
-				      flags | WQ_HIGHPRI, max_active, 16);
 
 	fs_info->delalloc_workers =
 		btrfs_alloc_workqueue(fs_info, "delalloc",
@@ -2219,7 +2215,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	fs_info->discard_ctl.discard_workers =
 		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
 
-	if (!(fs_info->workers && fs_info->hipri_workers &&
+	if (!(fs_info->workers &&
 	      fs_info->delalloc_workers && fs_info->flush_workers &&
 	      fs_info->endio_workers && fs_info->endio_meta_workers &&
 	      fs_info->compressed_write_workers &&
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 0d98fc5f6f44f7..840e4def18b519 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -543,7 +543,6 @@ struct btrfs_fs_info {
 	 * A third pool does submit_bio to avoid deadlocking with the other two.
 	 */
 	struct btrfs_workqueue *workers;
-	struct btrfs_workqueue *hipri_workers;
 	struct btrfs_workqueue *delalloc_workers;
 	struct btrfs_workqueue *flush_workers;
 	struct workqueue_struct *endio_workers;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 0f2f915e42b06a..0ec440cd756671 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1632,7 +1632,6 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
 	       old_pool_size, new_pool_size);
 
 	btrfs_workqueue_set_max(fs_info->workers, new_pool_size);
-	btrfs_workqueue_set_max(fs_info->hipri_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->delalloc_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
 	workqueue_set_max_active(fs_info->endio_workers, new_pool_size);
-- 
2.39.2

