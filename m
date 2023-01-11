Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67A566547C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjAKGYR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjAKGYJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:24:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1863310FDD
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vPP54o7lUFawDjAaztmYyfY8VPwCHTjntJEnkfzwFQk=; b=GHi43m+8MM17lbJRCaPBSZUpYR
        BQaVJTnVrf+rplT+J9lh+PFvGal36VTuoJcOtPRe5InciTxswT1TIBiU+JjOWfheK2jpkw8Syr6SA
        B76pdKCgB+MZmvllnuOYDUuptik1Zapgl5i57cMpl9iLjJowhRvjUhZZoHrUheSzv/QbEddxMQOvL
        jJU91De5xfzclyvx9bMRj9N4Jh8FYnjUeCC/ov4OP6qG83VvDRn3B9CY3w/+aL1IV/QIBIr20HTxZ
        hT9wwZoBoJBDW0F5CuapfgA/7mrkn7tFeAvYQSsQIdbdeoImPTq2y/pRCP4uduju6Kp/ApioC4jKh
        JW3pjB2g==;
Received: from [2001:4bb8:181:656b:8732:62ba:c286:a05b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFUWm-009rCi-09; Wed, 11 Jan 2023 06:24:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 09/10] btrfs: call rbio_orig_end_io from recover_rbio
Date:   Wed, 11 Jan 2023 07:23:33 +0100
Message-Id: <20230111062335.1023353-10-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230111062335.1023353-1-hch@lst.de>
References: <20230111062335.1023353-1-hch@lst.de>
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

Both callers of recover_rbio call rbio_orig_end_io right after it, so
move the call into the shared function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index a9947477daf26d..c007992bf4426c 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1907,7 +1907,7 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
 	return ret;
 }
 
-static int recover_rbio(struct btrfs_raid_bio *rbio)
+static void recover_rbio(struct btrfs_raid_bio *rbio)
 {
 	struct bio_list bio_list = BIO_EMPTY_LIST;
 	int total_sector_nr;
@@ -1922,7 +1922,7 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
 	/* For recovery, we need to read all sectors including P/Q. */
 	ret = alloc_rbio_pages(rbio);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	index_rbio_pages(rbio);
 
@@ -1960,37 +1960,28 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
 					 sectornr, REQ_OP_READ);
 		if (ret < 0) {
 			bio_list_put(&bio_list);
-			return ret;
+			goto out;
 		}
 	}
 
 	submit_read_wait_bio_list(rbio, &bio_list);
-	return recover_sectors(rbio);
+	ret = recover_sectors(rbio);
+out:
+	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
 }
 
 static void recover_rbio_work(struct work_struct *work)
 {
 	struct btrfs_raid_bio *rbio;
-	int ret;
 
 	rbio = container_of(work, struct btrfs_raid_bio, work);
-
-	ret = lock_stripe_add(rbio);
-	if (ret == 0) {
-		ret = recover_rbio(rbio);
-		rbio_orig_end_io(rbio, errno_to_blk_status(ret));
-	}
+	if (!lock_stripe_add(rbio))
+		recover_rbio(rbio);
 }
 
 static void recover_rbio_work_locked(struct work_struct *work)
 {
-	struct btrfs_raid_bio *rbio;
-	int ret;
-
-	rbio = container_of(work, struct btrfs_raid_bio, work);
-
-	ret = recover_rbio(rbio);
-	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
+	recover_rbio(container_of(work, struct btrfs_raid_bio, work));
 }
 
 static void set_rbio_raid6_extra_error(struct btrfs_raid_bio *rbio, int mirror_num)
-- 
2.35.1

