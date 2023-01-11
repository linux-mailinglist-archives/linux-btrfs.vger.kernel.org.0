Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B7D66547A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjAKGYP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjAKGYG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:24:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B59101DC
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ur7fhPspL7yd82y+ZMwL7tHRdo7NtUrr5JHyOou6OMw=; b=dpUySYRzrF9s+Ffh2F8gecfF1z
        hgoMvrVPJr16PCZDv5Q7NWlQkkYU3z7PX7ewhr+Y0ltC8ktO1YNQSrje2Cj7uE5shb8+O/NrKyNvp
        3kYPrn4S/YKTw2w/cmY6nhoVLFWNfqjsCArL2cJtcRDWrMrZXgJ9XJFkTUom/cv4kzCqoNe+BpwVA
        Rb3iH9Vs+nbMUs+T8yiYNt4mjVv0EVwPC/y3EgLSKwPIRTSsC8wz8JcQFB6iS0ZnqEQJADFV6XhXd
        QlMfITwmLQUr1TNEF29jp3a//7lY8YebQIjBteMrPJmjWLZH6sXN4NfFUkCI7auyRkcg75JKsLqyu
        SVGfBdqw==;
Received: from [2001:4bb8:181:656b:8732:62ba:c286:a05b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFUWj-009rCN-GF; Wed, 11 Jan 2023 06:23:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 08/10] btrfs: call rbio_orig_end_io from rmw_rbio
Date:   Wed, 11 Jan 2023 07:23:32 +0100
Message-Id: <20230111062335.1023353-9-hch@lst.de>
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

Both callers of rmv_rbio call rbio_orig_end_io right after it, so
move the call into the shared function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 374c3873169b3f..a9947477daf26d 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2229,7 +2229,7 @@ static bool need_read_stripe_sectors(struct btrfs_raid_bio *rbio)
 	return false;
 }
 
-static int rmw_rbio(struct btrfs_raid_bio *rbio)
+static void rmw_rbio(struct btrfs_raid_bio *rbio)
 {
 	struct bio_list bio_list;
 	int sectornr;
@@ -2241,7 +2241,7 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
 	 */
 	ret = alloc_rbio_parity_pages(rbio);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/*
 	 * Either full stripe write, or we have every data sector already
@@ -2254,13 +2254,13 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
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
@@ -2293,7 +2293,7 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
 	bio_list_init(&bio_list);
 	ret = rmw_assemble_write_bios(rbio, &bio_list);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/* We should have at least one bio assembled. */
 	ASSERT(bio_list_size(&bio_list));
@@ -2310,32 +2310,22 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
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

