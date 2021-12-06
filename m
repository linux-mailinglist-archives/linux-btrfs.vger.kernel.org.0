Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701A7469041
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 06:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbhLFF4r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 00:56:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56894 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbhLFF4q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 00:56:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A541D1FD5F
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 05:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638769997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjYy2qXApH9QUhSFKUBZNJoeyxqgQTzSNhIBaqV+acw=;
        b=TsGixlA1Or6Ibv6T3+X3C2FDwsvYq37mR65ZlKWtvDh5KePFiM2jykS8lQ8p3wFX94AeQd
        Bpzfa3/o2veSgbVkGV/voAfpt7BsTjLtPk0VC9jvskmoD0B7zuOdObn6y/HGnSIYtVJLe1
        EXXdfhhQXjn4XjjS2WYo7ZzZKyHE64M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0272313A08
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 05:53:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qCxRL0ylrWG/XAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Dec 2021 05:53:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: merge SCRUB_PAGES_PER_RD_BIO and SCRUB_PAGES_PER_WR_BIO
Date:   Mon,  6 Dec 2021 13:52:58 +0800
Message-Id: <20211206055258.49061-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206055258.49061-1-wqu@suse.com>
References: <20211206055258.49061-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These two values are introduced in commit ff023aac3119 ("Btrfs: add code
to scrub to copy read data to another disk") as an optimization.

But the truth is, block layer schedule can do whatever they want to
merge/split bios to improve performance.

Doing such "optimization" is not really going to affect much, especially
considering how good current block layer guys are doing.

Remove such old and immature optimization.

Since we're here, also change BUG_ON()s using these two macros to use
ASSERT()s.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 0870d8db92cd..5c67cf94c6d6 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -39,14 +39,14 @@ struct scrub_block;
 struct scrub_ctx;
 
 /*
- * the following three values only influence the performance.
+ * The following three values only influence the performance.
+ *
  * The last one configures the number of parallel and outstanding I/O
- * operations. The first two values configure an upper limit for the number
+ * operations. The first one configures an upper limit for the number
  * of (dynamically allocated) pages that are added to a bio.
  */
-#define SCRUB_PAGES_PER_RD_BIO	32	/* 128k per bio */
-#define SCRUB_PAGES_PER_WR_BIO	32	/* 128k per bio */
-#define SCRUB_BIOS_PER_SCTX	64	/* 8MB per device in flight */
+#define SCRUB_PAGES_PER_BIO	32	/* 128k per bio for x86 */
+#define SCRUB_BIOS_PER_SCTX	64	/* 8MB per device in flight for x86 */
 
 /*
  * The following value times PAGE_SIZE needs to be large enough to match the
@@ -87,11 +87,7 @@ struct scrub_bio {
 	blk_status_t		status;
 	u64			logical;
 	u64			physical;
-#if SCRUB_PAGES_PER_WR_BIO >= SCRUB_PAGES_PER_RD_BIO
-	struct scrub_page	*pagev[SCRUB_PAGES_PER_WR_BIO];
-#else
-	struct scrub_page	*pagev[SCRUB_PAGES_PER_RD_BIO];
-#endif
+	struct scrub_page	*pagev[SCRUB_PAGES_PER_BIO];
 	int			page_count;
 	int			next_free;
 	struct btrfs_work	work;
@@ -162,7 +158,7 @@ struct scrub_ctx {
 	struct list_head	csum_list;
 	atomic_t		cancel_req;
 	int			readonly;
-	int			pages_per_rd_bio;
+	int			pages_per_bio;
 
 	/* State of IO submission throttling affecting the associated device */
 	ktime_t			throttle_deadline;
@@ -173,7 +169,6 @@ struct scrub_ctx {
 
 	struct scrub_bio        *wr_curr_bio;
 	struct mutex            wr_lock;
-	int                     pages_per_wr_bio; /* <= SCRUB_PAGES_PER_WR_BIO */
 	struct btrfs_device     *wr_tgtdev;
 	bool                    flush_all_writes;
 
@@ -577,7 +572,7 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 		goto nomem;
 	refcount_set(&sctx->refs, 1);
 	sctx->is_dev_replace = is_dev_replace;
-	sctx->pages_per_rd_bio = SCRUB_PAGES_PER_RD_BIO;
+	sctx->pages_per_bio = SCRUB_PAGES_PER_BIO;
 	sctx->curr = -1;
 	sctx->fs_info = fs_info;
 	INIT_LIST_HEAD(&sctx->csum_list);
@@ -615,7 +610,6 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	sctx->wr_curr_bio = NULL;
 	if (is_dev_replace) {
 		WARN_ON(!fs_info->dev_replace.tgtdev);
-		sctx->pages_per_wr_bio = SCRUB_PAGES_PER_WR_BIO;
 		sctx->wr_tgtdev = fs_info->dev_replace.tgtdev;
 		sctx->flush_all_writes = false;
 	}
@@ -1674,7 +1668,7 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 		sbio->dev = sctx->wr_tgtdev;
 		bio = sbio->bio;
 		if (!bio) {
-			bio = btrfs_bio_alloc(sctx->pages_per_wr_bio);
+			bio = btrfs_bio_alloc(sctx->pages_per_bio);
 			sbio->bio = bio;
 		}
 
@@ -1707,7 +1701,7 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 	sbio->pagev[sbio->page_count] = spage;
 	scrub_page_get(spage);
 	sbio->page_count++;
-	if (sbio->page_count == sctx->pages_per_wr_bio)
+	if (sbio->page_count == sctx->pages_per_bio)
 		scrub_wr_submit(sctx);
 	mutex_unlock(&sctx->wr_lock);
 
@@ -1754,7 +1748,7 @@ static void scrub_wr_bio_end_io_worker(struct btrfs_work *work)
 	struct scrub_ctx *sctx = sbio->sctx;
 	int i;
 
-	WARN_ON(sbio->page_count > SCRUB_PAGES_PER_WR_BIO);
+	ASSERT(sbio->page_count <= SCRUB_PAGES_PER_BIO);
 	if (sbio->status) {
 		struct btrfs_dev_replace *dev_replace =
 			&sbio->sctx->fs_info->dev_replace;
@@ -2100,7 +2094,7 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 		sbio->dev = spage->dev;
 		bio = sbio->bio;
 		if (!bio) {
-			bio = btrfs_bio_alloc(sctx->pages_per_rd_bio);
+			bio = btrfs_bio_alloc(sctx->pages_per_bio);
 			sbio->bio = bio;
 		}
 
@@ -2134,7 +2128,7 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 	scrub_block_get(sblock); /* one for the page added to the bio */
 	atomic_inc(&sblock->outstanding_pages);
 	sbio->page_count++;
-	if (sbio->page_count == sctx->pages_per_rd_bio)
+	if (sbio->page_count == sctx->pages_per_bio)
 		scrub_submit(sctx);
 
 	return 0;
@@ -2368,7 +2362,7 @@ static void scrub_bio_end_io_worker(struct btrfs_work *work)
 	struct scrub_ctx *sctx = sbio->sctx;
 	int i;
 
-	BUG_ON(sbio->page_count > SCRUB_PAGES_PER_RD_BIO);
+	ASSERT(sbio->page_count <= SCRUB_PAGES_PER_BIO);
 	if (sbio->status) {
 		for (i = 0; i < sbio->page_count; i++) {
 			struct scrub_page *spage = sbio->pagev[i];
-- 
2.34.1

