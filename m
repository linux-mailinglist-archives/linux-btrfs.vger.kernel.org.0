Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE5971792E
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 09:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjEaH4d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 03:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjEaH4Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 03:56:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFA710C7
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DUapqdO3INJ+Iso5BPrNxk2npm3XI0n1VP1TcLTom8Q=; b=t5zyGkqYbYWQXW6DhJiC8rEg78
        82wbhDxCe8mWujBM4ogfZe57pVw7PdPV+82XUdcUQmcDUrfbXaDki/Ba4K2aBaIAQwiFziuhKMSAW
        EPDujPeFcv3euAhn7rCAaeoN1HuSPSCeHFoo9sOEQdIbvRk3vDJsSDpLQ/3+vWJv5C6R4h7Zlzr4j
        znHUSHKBJkt5e4eJTXiz5M3z3OCf7xR3LRnH4B3Xja+lsUMod8FMTVaZVqCpccTzgwvv7muyMWH92
        rne+2hBOBq3AsbG4JO0k1PFdaVau4mHqazSs5H9QBxYzJ38c2ao5pCegLHe8L3nxCMeKNcMkC4Svi
        ULJ0f5dA==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4GfY-00GWxq-1h;
        Wed, 31 May 2023 07:54:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 15/17] btrfs: use btrfs_finish_ordered_extent to complete compressed writes
Date:   Wed, 31 May 2023 09:54:08 +0200
Message-Id: <20230531075410.480499-16-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531075410.480499-1-hch@lst.de>
References: <20230531075410.480499-1-hch@lst.de>
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

Use the btrfs_finish_ordered_extent helper to complete compressed writes
using the bbio->ordered pointer instead of requiring an rbtree lookup
in the otherwise equivalent btrfs_mark_ordered_io_finished called from
btrfs_writepage_endio_finish_ordered.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/compression.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e27f30417cefc8..47da3809d25ff5 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -226,13 +226,8 @@ static void btrfs_finish_compressed_write_work(struct work_struct *work)
 	struct compressed_bio *cb =
 		container_of(work, struct compressed_bio, write_end_work);
 
-	/*
-	 * Ok, we're the last bio for this extent, step one is to call back
-	 * into the FS and do all the end_io operations.
-	 */
-	btrfs_writepage_endio_finish_ordered(cb->bbio.inode, NULL,
-			cb->start, cb->start + cb->len - 1,
-			cb->bbio.bio.bi_status == BLK_STS_OK);
+	btrfs_finish_ordered_extent(cb->bbio.ordered, NULL, cb->start, cb->len,
+				    cb->bbio.bio.bi_status == BLK_STS_OK);
 
 	if (cb->writeback)
 		end_compressed_writeback(cb);
-- 
2.39.2

