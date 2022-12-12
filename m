Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED35649938
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiLLHGV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiLLHGT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:06:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B625F2658
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tbMssNysP93+HjCseutkSR2LBIolNpNVQlKbTUKHsG4=; b=Otfo+tQFBmyUtqTxj0n+A1cRaN
        goGLXnuvekhVlZRNBDEQnSBFJwV4LuBjY59M86g8ywGrjuq7luS8CM0kmrlfpJMOXFhdFr7qKFRLs
        rAnj6ravs/TWZGFxdpTGwEc3WPOIjEy1s+Axaofj9Mgj/ebMrcVVTAjqBpBErJ753bypglsOqbDGe
        3BSw1DGlHxp6oFmGoXSXehMmDAGKJPzhA1R2Pu8/2dwBm6bwioax4j42KTIslzFhL+KvpSHqbhPjl
        paNBylUQAwHgVJFi3TONCXffqVUyRwULanWzqJwDgE6XB003sajzM+08ae/QyejETwWdehodnZXH3
        gdGSTRiA==;
Received: from [2001:4bb8:192:2f53:34e0:118:ce10:200c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4ctE-009Dqb-Ed; Mon, 12 Dec 2022 07:06:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: cleanup raid56_parity_write
Date:   Mon, 12 Dec 2022 08:06:09 +0100
Message-Id: <20221212070611.5209-2-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221212070611.5209-1-hch@lst.de>
References: <20221212070611.5209-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Handle the error return on alloc_rbio failure directly instead of using
a goto, and remove the queue_rbio goto label by moving the plugged
check into the if branch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 2d90a6b5eb00e3..5603ba1af55584 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1660,12 +1660,12 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	struct btrfs_raid_bio *rbio;
 	struct btrfs_plug_cb *plug = NULL;
 	struct blk_plug_cb *cb;
-	int ret = 0;
 
 	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
-		ret = PTR_ERR(rbio);
-		goto fail;
+		bio->bi_status = errno_to_blk_status(PTR_ERR(rbio));
+		bio_endio(bio);
+		return;
 	}
 	rbio->operation = BTRFS_RBIO_WRITE;
 	rbio_add_bio(rbio, bio);
@@ -1674,31 +1674,24 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	 * Don't plug on full rbios, just get them out the door
 	 * as quickly as we can
 	 */
-	if (rbio_is_full(rbio))
-		goto queue_rbio;
-
-	cb = blk_check_plugged(raid_unplug, fs_info, sizeof(*plug));
-	if (cb) {
-		plug = container_of(cb, struct btrfs_plug_cb, cb);
-		if (!plug->info) {
-			plug->info = fs_info;
-			INIT_LIST_HEAD(&plug->rbio_list);
+	if (!rbio_is_full(rbio)) {
+		cb = blk_check_plugged(raid_unplug, fs_info, sizeof(*plug));
+		if (cb) {
+			plug = container_of(cb, struct btrfs_plug_cb, cb);
+			if (!plug->info) {
+				plug->info = fs_info;
+				INIT_LIST_HEAD(&plug->rbio_list);
+			}
+			list_add_tail(&rbio->plug_list, &plug->rbio_list);
+			return;
 		}
-		list_add_tail(&rbio->plug_list, &plug->rbio_list);
-		return;
 	}
-queue_rbio:
+
 	/*
 	 * Either we don't have any existing plug, or we're doing a full stripe,
-	 * can queue the rmw work now.
+	 * queue the rmw work now.
 	 */
 	start_async_work(rbio, rmw_rbio_work);
-
-	return;
-
-fail:
-	bio->bi_status = errno_to_blk_status(ret);
-	bio_endio(bio);
 }
 
 static int verify_one_sector(struct btrfs_raid_bio *rbio,
-- 
2.35.1

