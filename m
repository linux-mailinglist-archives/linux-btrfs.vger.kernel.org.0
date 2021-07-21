Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402793D1296
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 17:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbhGUO5H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 10:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbhGUO5G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 10:57:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9D0C061575;
        Wed, 21 Jul 2021 08:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=d9VixLyLBmOaAtol1dnFl7Rez9u9mSdLSZuAkTnkVjE=; b=VbTbMxG0OEJq6PQIo3QERb1el0
        B+GlVRuezgMm7LZCAXTGcFBoBY7v6IbriZxy+b9VyBV/LBjoKlQel8bewW4wxpSd1/7A6mRH+VPV9
        OTF5xzZiHBLOx+fkcjj6NFQdMr+9buXyGgtvCdqvrCN9ByfEsZXJRuU2Yi6am40kB9rCeMaCYJGDP
        8QGH/thJq/w+d2AjgnWFcMuspHuYc1+Lfw+oYvjshzr0/+PxIRkHoIsaa+X7tL75H9/z5KiJsGFKA
        hw1mSD6qP4MtYzgR1uFDfqUnVP6MwHsfMzE9I1U8k0oYUOQ/2JwxwVXamI3TAOnbK9S5gJH7VfqJS
        TDHGoBJQ==;
Received: from [2001:4bb8:193:7660:d6d5:72f4:23f7:1898] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6EHW-009LJf-JG; Wed, 21 Jul 2021 15:37:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: no need to grab a reference to disk->part0
Date:   Wed, 21 Jul 2021 17:35:20 +0200
Message-Id: <20210721153523.103818-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721153523.103818-1-hch@lst.de>
References: <20210721153523.103818-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The struct block_device for the whole disk will not be freed while
the disk in use, so don't bother to grab a reference to it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 297c0b1c0634..21c5654967b0 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1362,20 +1362,16 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	struct extent_map_tree *em_tree;
 	struct extent_map *em;
 	struct btrfs_ordered_sum *sum;
-	struct block_device *bdev;
 	u64 orig_logical = ordered->disk_bytenr;
 	u64 *logical = NULL;
 	int nr, stripe_len;
 
 	/* Zoned devices should not have partitions. So, we can assume it is 0 */
 	ASSERT(ordered->partno == 0);
-	bdev = bdgrab(ordered->disk->part0);
-	if (WARN_ON(!bdev))
-		return;
 
-	if (WARN_ON(btrfs_rmap_block(fs_info, orig_logical, bdev,
-				     ordered->physical, &logical, &nr,
-				     &stripe_len)))
+	if (WARN_ON(btrfs_rmap_block(fs_info, orig_logical,
+			ordered->disk->part0, ordered->physical, &logical,
+			&nr, &stripe_len)))
 		goto out;
 
 	WARN_ON(nr != 1);
@@ -1402,7 +1398,6 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 
 out:
 	kfree(logical);
-	bdput(bdev);
 }
 
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-- 
2.30.2

