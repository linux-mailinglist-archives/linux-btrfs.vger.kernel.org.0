Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CD564B152
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiLMIlr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbiLMIlq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:41:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA1917E1C
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Mvf89poLTXiQYdxlQr469aITce2wj9QhCX6YFUR9jD0=; b=lJ1/a1oYbOMQn/ywEtfvHEffWJ
        tk774D9wL3OqOEojTeMPMZ1HJ6gQO7R7UBMVjp7boNFj16ED3Ut86ydjmDbaZfl7kexRVa2w3rozz
        cDteeRFxpq7rxA//5zgjOke0dj6th5foc/npR1MwTuMNdfpdDZRknrywzi0dQj76q/Dtt5hjFrCNW
        cmkW2ZeMpvcJFVASea1a8ZFBf/qhxazZrUCDPcxuA4C2d02S1HlOdp3fY8MyxN9Kgu97h+DsxHuOW
        SaUZNBMevQ4bPUkzQbzlGkMTEWSiBDtYH/q0UIoWM4GcmV4g+/WvPzTrsNER+kj33AUQEJ37H9nis
        AbIuezEg==;
Received: from [2001:4bb8:192:2f53:30b:ddad:22aa:f9f9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p50r8-00E0vZ-Pk; Tue, 13 Dec 2022 08:41:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: call rbio_orig_end_io from rmw_rbio
Date:   Tue, 13 Dec 2022 09:41:21 +0100
Message-Id: <20221213084123.309790-7-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221213084123.309790-1-hch@lst.de>
References: <20221213084123.309790-1-hch@lst.de>
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

Both callers of rmv_rbio call rbio_orig_end_io right after it, so
move the call into the shared function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 2a5857d42fff20..2432c2d7fcbed0 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2262,7 +2262,7 @@ static bool need_read_stripe_sectors(struct btrfs_raid_bio *rbio)
 	return false;
 }
 
-static int rmw_rbio(struct btrfs_raid_bio *rbio)
+static void rmw_rbio(struct btrfs_raid_bio *rbio)
 {
 	struct bio_list bio_list;
 	int sectornr;
@@ -2274,7 +2274,7 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
 	 */
 	ret = alloc_rbio_parity_pages(rbio);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/*
 	 * Either full stripe write, or we have every data sector already
@@ -2287,13 +2287,13 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
 		 */
 		ret = alloc_rbio_data_pages(rbio);
 		if (ret < 0)
-			return ret;
+			goto out;
 
 		index_rbio_pages(rbio);
 
 		ret = rmw_read_wait_recover(rbio);
 		if (ret < 0)
-			return ret;
+			goto out;
 	}
 
 	/*
@@ -2326,7 +2326,7 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
 	bio_list_init(&bio_list);
 	ret = rmw_assemble_write_bios(rbio, &bio_list);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/* We should have at least one bio assembled. */
 	ASSERT(bio_list_size(&bio_list));
@@ -2343,32 +2343,22 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
 			break;
 		}
 	}
-	return ret;
+out:
+	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
 }
 
 static void rmw_rbio_work(struct work_struct *work)
 {
 	struct btrfs_raid_bio *rbio;
-	int ret;
 
 	rbio = container_of(work, struct btrfs_raid_bio, work);
-
-	ret = lock_stripe_add(rbio);
-	if (ret == 0) {
-		ret = rmw_rbio(rbio);
-		rbio_orig_end_io(rbio, errno_to_blk_status(ret));
-	}
+	if (lock_stripe_add(rbio) == 0)
+		rmw_rbio(rbio);
 }
 
 static void rmw_rbio_work_locked(struct work_struct *work)
 {
-	struct btrfs_raid_bio *rbio;
-	int ret;
-
-	rbio = container_of(work, struct btrfs_raid_bio, work);
-
-	ret = rmw_rbio(rbio);
-	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
+	rmw_rbio(container_of(work, struct btrfs_raid_bio, work));
 }
 
 /*
-- 
2.35.1

