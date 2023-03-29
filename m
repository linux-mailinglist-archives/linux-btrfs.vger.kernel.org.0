Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93696CCE9D
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 02:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjC2ANd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 20:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjC2ANc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 20:13:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1E419C
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 17:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+Xfe11xv0g04osh835h6quLYprLeCUAFmPIDjoFALlM=; b=FZahgjlBs4HbxNw0rplZy95bo8
        3OZFFSCNR0gGvGEG8350B9Dnzinu3TsJlpmZCh8QFq2DPGWxPL8vlnwoVX65o4AA24Mj42jhQ0YCX
        +gChygGjMdFvXSit+4lmi4sgwWAZxY6e0fbfe1HZYkc55pB/J1KqCJx5pMD4XlnnC+JIE0sOiT3MQ
        FbChXwT9I3rVCaUmSgyFDIP9oLh/+66Jbr6XG1regt4Ng8GshD64uAAqu7CW7LTb3hicg2yUNsLQw
        cjVYea9amVqT+SBaDZ0bS/33jUlDIefpJr/iAyb9qXWHCYqpBO797xtydGswwlqxVV4jiTv+nZN71
        YCo3b6fg==;
Received: from mo146-160-37-65.air.mopera.net ([146.160.37.65] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phJRR-00GAzl-0T;
        Wed, 29 Mar 2023 00:13:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: never defer I/O submission for fast CRC implementations
Date:   Wed, 29 Mar 2023 09:13:07 +0900
Message-Id: <20230329001308.1275299-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329001308.1275299-1-hch@lst.de>
References: <20230329001308.1275299-1-hch@lst.de>
MIME-Version: 1.0
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

Most modern hardware supports very fast accelerated crc32c calculation.
If that is supported the CPU overhead of the checksum calculation is
very limited, and offloading the calculation to special worker threads
has a lot of overhead for no gain.

E.g. on an Intel Optane device is actually very much slows down even
1M buffered writes with fio:

Unpatched:

write: IOPS=3316, BW=3316MiB/s (3477MB/s)(200GiB/61757msec); 0 zone resets

With synchronous CRCs:

write: IOPS=4882, BW=4882MiB/s (5119MB/s)(200GiB/41948msec); 0 zone resets

With a lot of variation during the unpatch run going down as low as
1100MB/s, while the synchronous CRC version has about the same peak write
speed but much lower dips, and fewer kworkers churning around.
Both tests had fio saturated at 100% CPU.

(thanks to Jens Axboe via Chris Mason for the benchmarking)

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index c851a3526911f6..57c35e920269f4 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -551,26 +551,26 @@ static void run_one_async_free(struct btrfs_work *work)
 
 static bool should_async_write(struct btrfs_bio *bbio)
 {
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
+
+	/*
+	 * Submit synchronously if the checksum implementation is fast.
+	 */
+	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
+		return false;
+
 	/*
 	 * Try to defer the submission to a workqueue to parallelize the
-	 * checksum calculation unless the I/O is issued synchronously.
+	 * checksum calculation only if the I/O is issued asynchronously.
 	 */
 	if (op_is_sync(bbio->bio.bi_opf))
 		return false;
 
 	/*
-	 * Submit metadata writes synchronously if the checksum implementation
-	 * is fast, or we are on a zoned device that wants I/O to be submitted
-	 * in order.
+	 * Zoned devices require I/O to be submitted in order.
 	 */
-	if (bbio->bio.bi_opf & REQ_META) {
-		struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
-
-		if (btrfs_is_zoned(fs_info))
-			return false;
-		if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
-			return false;
-	}
+	if ((bbio->bio.bi_opf & REQ_META) && btrfs_is_zoned(fs_info))
+		return false;
 
 	return true;
 }
-- 
2.39.2

