Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0CE717505
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 06:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjEaESE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 00:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjEaESA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 00:18:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9673FC9
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 21:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tMRrHd467jmn/dK/JeQ9F00GAk2I/1Rz7t0GTn64Dsc=; b=d0X3t9pRe6ovSRvOwG7jUCs8Iv
        qBh7r9X6ALvtPO9zuoMqYMeb2LJOBDKUsFJx4cQDKQ3efHZma736Qoix5Dm3E3ZDPCh7dSB0HcqcD
        xU2IaaA9CnyChagovyQvdsDYThaA68BiQRV6EwBaOUW6wxOGuHIw//yT0plsD9+DfC9jjIzZDT8KO
        AFs9tkBIRF/deuqJd4zRja3918Ais8rSbZQonJOEBZjAsUpcbpGuKapqn+VHcYXQ3Iox8mSSZCvDP
        Yz+b+pXO8rr/lVdrNkTTX4h4W95HqlngE87u28wRU8QDrhCWKWCKQGcJXOWY1rJrGmXYxP4/leQhS
        D6y15ASA==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4DHY-00G1R2-1h;
        Wed, 31 May 2023 04:17:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs: remove btrfs_map_sblock
Date:   Wed, 31 May 2023 06:17:38 +0200
Message-Id: <20230531041740.375963-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531041740.375963-1-hch@lst.de>
References: <20230531041740.375963-1-hch@lst.de>
MIME-Version: 1.0
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

btrfs_map_sblock just hardcodes three arguments and calls
btrfs_map_sblock.  Remove it as it doesn't provide any real
value, but makes following the btrfs_map_block callchains harder.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/scrub.c   | 9 +++++----
 fs/btrfs/volumes.c | 9 ---------
 fs/btrfs/volumes.h | 3 ---
 fs/btrfs/zoned.c   | 4 ++--
 4 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d7d8faf1978a87..8fce48d9e07a85 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -882,8 +882,9 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 
 		/* For scrub, our mirror_num should always start at 1. */
 		ASSERT(stripe->mirror_num >= 1);
-		ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
-				       stripe->logical, &mapped_len, &bioc);
+		ret = btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
+				      stripe->logical, &mapped_len, &bioc,
+				      NULL, NULL, 1);
 		/*
 		 * If we failed, dev will be NULL, and later detailed reports
 		 * will just be skipped.
@@ -1893,8 +1894,8 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	bio->bi_end_io = raid56_scrub_wait_endio;
 
 	btrfs_bio_counter_inc_blocked(fs_info);
-	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_WRITE, full_stripe_start,
-			       &length, &bioc);
+	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, full_stripe_start,
+			      &length, &bioc, NULL, NULL, 1);
 	if (ret < 0) {
 		btrfs_put_bioc(bioc);
 		btrfs_bio_counter_dec(fs_info);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 53059ee04f9b60..6141a9fe5a28a0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6481,15 +6481,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	return ret;
 }
 
-/* For Scrub/replace */
-int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
-		     u64 logical, u64 *length,
-		     struct btrfs_io_context **bioc_ret)
-{
-	return btrfs_map_block(fs_info, op, logical, length, bioc_ret,
-				 NULL, NULL, 1);
-}
-
 static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
 				      const struct btrfs_fs_devices *fs_devices)
 {
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index c70805c8d89554..3930ee01d6968f 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -582,9 +582,6 @@ static inline unsigned long btrfs_chunk_item_size(int num_stripes)
 
 void btrfs_get_bioc(struct btrfs_io_context *bioc);
 void btrfs_put_bioc(struct btrfs_io_context *bioc);
-int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
-		     u64 logical, u64 *length,
-		     struct btrfs_io_context **bioc_ret);
 int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		    u64 logical, u64 *length,
 		    struct btrfs_io_context **bioc_ret,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e311aae8f1ddca..bbde4ddd475492 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1782,8 +1782,8 @@ static int read_zone_info(struct btrfs_fs_info *fs_info, u64 logical,
 	int nmirrors;
 	int i, ret;
 
-	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
-			       &mapped_length, &bioc);
+	ret = btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
+			      &mapped_length, &bioc, NULL, NULL, 1);
 	if (ret || !bioc || mapped_length < PAGE_SIZE) {
 		ret = -EIO;
 		goto out_put_bioc;
-- 
2.39.2

