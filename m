Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D5364993A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiLLHGa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiLLHGY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:06:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FC7384
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=a7LH+RBHGAkWhBUqCzd/C4+uk4+mTZmKZcPdECddLFs=; b=TX5LVSVGJ71/7QjjMWGba+8jfC
        ZvEoFkY/4qXYombH63bnGFZxflPWAOuFoCkVM7cZ/BH9W7kaPWJi6cyvqTorNsQUsq1ohpfRsRzu2
        daUb5s7igq27tyu6ZtmEv+7pnwPEH1OK8dUaM/rZBjrSWEl2XOjxcSOeRY95iZIuhMGX7Ektem4V2
        Pi9J1RDyrvxDpbSc9bd4Gr2FyF2d9VpDihoYSt/MdQuo+sEzjmQ4apcRJa87RSvjWrOypUerrh46Q
        ulj5a8bTNGNDc9SVjkQac6sljM8CrT2lhd0EcZU+Qdr/1/CEneT4eF7GTpvWA3FnswsT+7wajp4LN
        L1hHIWtw==;
Received: from [2001:4bb8:192:2f53:34e0:118:ce10:200c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4ctJ-009Duq-Jn; Mon, 12 Dec 2022 07:06:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: call rbio_orig_end_io from rmw_rbio
Date:   Mon, 12 Dec 2022 08:06:11 +0100
Message-Id: <20221212070611.5209-4-hch@lst.de>
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

Both callers of rmv_rbio call rbio_orig_end_io right after it, so
move the call into the shared function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 5035e2b20a5e02..14d71076a222f9 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2275,7 +2275,7 @@ static bool need_read_stripe_sectors(struct btrfs_raid_bio *rbio)
 	return false;
 }
 
-static int rmw_rbio(struct btrfs_raid_bio *rbio)
+static void rmw_rbio(struct btrfs_raid_bio *rbio)
 {
 	struct bio_list bio_list;
 	int sectornr;
@@ -2287,7 +2287,7 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
 	 */
 	ret = alloc_rbio_parity_pages(rbio);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/*
 	 * Either full stripe write, or we have every data sector already
@@ -2300,13 +2300,13 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
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
@@ -2339,7 +2339,7 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
 	bio_list_init(&bio_list);
 	ret = rmw_assemble_write_bios(rbio, &bio_list);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/* We should have at least one bio assembled. */
 	ASSERT(bio_list_size(&bio_list));
@@ -2356,32 +2356,22 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
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

