Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0346560DA71
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 07:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiJZFGq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 01:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiJZFGl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 01:06:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95B45BC89
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 22:06:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 768CF2203D
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666760798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rMe5HRa835GoUYhvKKRosO2svnWwfEKIavCWBTpaIs=;
        b=AyB46ZqFm++9lKuwn6ZACQtmZjVwTBwUiimOBoZL6uUrII8HNecuFH1MtToN6ba7BMjeua
        TWr+tPUhn3uj9Ybm8N/28d+zytvTrbKmp8zxakSk26xzSQgq1RbKSKrDSBgkIf66Dw7/uN
        AFnYzag2cjil1xruMAX+eLKQ9Y3kink=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD10913A6E
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oHmxJV3AWGP7XQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: raid56: introduce a new framework for RAID56 writes
Date:   Wed, 26 Oct 2022 13:06:27 +0800
Message-Id: <466e8f662f1a6be41676803b4a0d14981cbef241.1666760699.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1666760699.git.wqu@suse.com>
References: <cover.1666760699.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently raid56 code has a strong distinguish between full-stripe and
sub-stripe writes, and uses end_io functions to jump to the next step of
RMW.

This has several disadvantages:

- Very hard to follow workflow
  One has to jump several times to follow the workflow.

  Just like OS context switch, it's also expensive for human to do
  context switch.

- Not much shared code for raid56 write path
  In fact, there are 3 types of writes for raid56:

  * Sub-stripe writes without cached rbio
    We need to do full RMW cycle.

  * Sub-stripe writes with cached rbio
    We have all the data needed, can submit writes directly

  * Full-stripe writes
    Just the same as sub-stripe writes with cache.

  As one can see, there full stripe is not much different than
  sub-stripe writes, especially if the sub-stripe writes has a cache hit.

  It's more reasonable to handle all the writes in a single function.

So this patch will introduce a skeleton function called
run_one_write_rbio(), to do all the write operation.

Unlike the existing code, it will follow the submit-and-wait idea, so
that there should be much easier to follow the workflow, and will handle
all sub-stripe/full-stripe writes using the same function.

Currently no real read/write path is implemented, just a skeleton to
show the idea.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid56.h |  4 +++
 2 files changed, 71 insertions(+)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index acf36fcaa9f2..c3b33fb8c033 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -988,6 +988,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	}
 
 	bio_list_init(&rbio->bio_list);
+	init_waitqueue_head(&rbio->io_wait);
 	INIT_LIST_HEAD(&rbio->plug_list);
 	spin_lock_init(&rbio->bio_list_lock);
 	INIT_LIST_HEAD(&rbio->stripe_cache);
@@ -1039,6 +1040,19 @@ static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
 	return 0;
 }
 
+static int alloc_rbio_data_pages(struct btrfs_raid_bio *rbio)
+{
+	const int data_pages = rbio->nr_data * rbio->stripe_npages;
+	int ret;
+
+	ret = btrfs_alloc_page_array(data_pages, rbio->stripe_pages);
+	if (ret < 0)
+		return ret;
+
+	index_stripe_sectors(rbio);
+	return 0;
+}
+
 /*
  * Add a single sector @sector into our list of bios for IO.
  *
@@ -2803,3 +2817,56 @@ void raid56_submit_missing_rbio(struct btrfs_raid_bio *rbio)
 	if (!lock_stripe_add(rbio))
 		start_async_work(rbio, read_rebuild_work);
 }
+
+/*
+ * This is the main entry to run a write rbio, which will do read-modify-write
+ * cycle.
+ *
+ * Caller should ensure the rbio is holding the full stripe lock.
+ */
+void run_one_write_rbio(struct btrfs_raid_bio *rbio)
+{
+	int ret = 0;
+
+	/*
+	 * Allocate the pages for parity first, as P/Q pages will always be
+	 * needed for both full-stripe and sub-stripe writes.
+	 */
+	ret = alloc_rbio_parity_pages(rbio);
+	if (ret < 0)
+		goto out;
+
+	/* Full stripe write, can write the full stripe right now. */
+	if (rbio_is_full(rbio))
+		goto write;
+
+	/*
+	 * Now we're doing sub-stripe write, need the extra stripe_pages to do
+	 * the full RMW.
+	 */
+	ret = alloc_rbio_data_pages(rbio);
+	if (ret < 0)
+		goto out;
+
+	/* Place holder for read the missing sectors. */
+
+	/*
+	 * We may or may not submitted any sectors, but it doesn't matter.
+	 * Just wait until stripes_pending is zero.
+	 */
+	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
+
+	/* Place holder for extra verification for above reads and data csum. */
+write:
+	/* Place holder for real write code. */
+	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
+	if (atomic_read(&rbio->error) > rbio->bioc->max_errors)
+		ret = -EIO;
+
+out:
+	/*
+	 * This function needs extra work, as unlock_stripe() will still queue
+	 * the next rbio using the old function entrance.
+	 */
+	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
+}
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 91d5c0adad15..8657cafd32c0 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -95,6 +95,8 @@ struct btrfs_raid_bio {
 
 	atomic_t error;
 
+	wait_queue_head_t io_wait;
+
 	struct work_struct end_io_work;
 
 	/* Bitmap to record which horizontal stripe has data */
@@ -183,4 +185,6 @@ void raid56_submit_missing_rbio(struct btrfs_raid_bio *rbio);
 int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info);
 void btrfs_free_stripe_hash_table(struct btrfs_fs_info *info);
 
+void run_one_write_rbio(struct btrfs_raid_bio *rbio);
+
 #endif
-- 
2.38.1

