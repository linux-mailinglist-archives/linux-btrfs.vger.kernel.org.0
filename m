Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1A16CCE9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 02:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjC2ANg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 20:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjC2ANe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 20:13:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394812D68
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 17:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=kOD9gSPGY/jiZFo7uUOcZDMlkB/acRjdCcfIi0hGhgw=; b=qc5NluxNtUueUtGSuzZ/bPI7Kh
        g+/We4zNFxqKmUh08N9C1wAX6RfxRKB/l0SuDRB6X27fvtmwl3eN+XBaDwH4BPf3lrhRjfxc0uOho
        pt7vsSpmOu6wKWlwvtmJ4rs87Du8brAngZwRstgbPXi9JWUVs5RXFUE9h9FmGkjCdF/zBFz1R7Znq
        9SRA2Mi83h+AX0bYJ8a8PgbqvSCW44UicX3M6BDcgACnoAvlXkvX8UFW8YNPdWVHzFcEuunfx0Jzr
        a8OrhXhhEh4P6lEod8EjNGxjUFap9N08N7PgnCb2F6cmegADvCOQnXyqLVcAW7BBuEUdrTiS2P4Uj
        r/gnGgqw==;
Received: from mo146-160-37-65.air.mopera.net ([146.160.37.65] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phJRT-00GB0H-28;
        Wed, 29 Mar 2023 00:13:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: remove hipri_workers workqueue
Date:   Wed, 29 Mar 2023 09:13:08 +0900
Message-Id: <20230329001308.1275299-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329001308.1275299-1-hch@lst.de>
References: <20230329001308.1275299-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that btrfs_wq_submit_bio is never called for synchronous I/O,
the hipri_workers workqueue is dead code and can be removeḋ.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c     | 5 +----
 fs/btrfs/disk-io.c | 6 +-----
 fs/btrfs/fs.h      | 1 -
 fs/btrfs/super.c   | 1 -
 4 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 57c35e920269f4..f1ff33d6726404 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -598,10 +598,7 @@ static bool btrfs_wq_submit_bio(struct btrfs_bio *bbio,
 
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
index ec765d6bc53673..7740bb1b152445 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2000,7 +2000,6 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 {
 	btrfs_destroy_workqueue(fs_info->fixup_workers);
 	btrfs_destroy_workqueue(fs_info->delalloc_workers);
-	btrfs_destroy_workqueue(fs_info->hipri_workers);
 	btrfs_destroy_workqueue(fs_info->workers);
 	if (fs_info->endio_workers)
 		destroy_workqueue(fs_info->endio_workers);
@@ -2195,9 +2194,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 
 	fs_info->workers =
 		btrfs_alloc_workqueue(fs_info, "worker", flags, max_active, 16);
-	fs_info->hipri_workers =
-		btrfs_alloc_workqueue(fs_info, "worker-high",
-				      flags | WQ_HIGHPRI, max_active, 16);
 
 	fs_info->delalloc_workers =
 		btrfs_alloc_workqueue(fs_info, "delalloc",
@@ -2234,7 +2230,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	fs_info->discard_ctl.discard_workers =
 		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
 
-	if (!(fs_info->workers && fs_info->hipri_workers &&
+	if (!(fs_info->workers &&
 	      fs_info->delalloc_workers && fs_info->flush_workers &&
 	      fs_info->endio_workers && fs_info->endio_meta_workers &&
 	      fs_info->compressed_write_workers &&
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index ca17a7fc3ac35c..25faa9de4b5385 100644
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
index e94a4cd06607e1..f2d59be4477cf1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1627,7 +1627,6 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
 	       old_pool_size, new_pool_size);
 
 	btrfs_workqueue_set_max(fs_info->workers, new_pool_size);
-	btrfs_workqueue_set_max(fs_info->hipri_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->delalloc_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->endio_write_workers, new_pool_size);
-- 
2.39.2

