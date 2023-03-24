Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C316C75E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 03:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCXCcg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 22:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjCXCcf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 22:32:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9C026B8
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 19:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tuzUJte6/aXoVffLJ/q8t897t11yjN/wMnKUnvchLiI=; b=xrRgB5eoZjn8OpoKB/2ING54JY
        anSbsXsIWhGATefz8KkPVH9+OvJenwWO8dvrqJPUrcs8H57m2oOgijwmp1OJGE6kehIujAgKuNS+T
        06kcq83Z8sCL0X4BA6yi67114mm80IiMe1gR+XVlz+YWlMqSXELOzTD5v3Fpyhi+ISkYvG+MzyRad
        zZHpDLJCsu6n8afl5FJ0GiRH0mTTXCFmqcayOiOjfW75/l+npLkG0Kxjonx4heaJ2bvZS58sTYM12
        DF/gwd9JQSco40Ql70Y6GuOUcuvMGKKDFXXVyOkHW20qF+kCerBSvJTJcS0SQU1rVjZAhBu2nC5ze
        mJvV8tyg==;
Received: from [122.147.159.101] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pfXEE-003PGw-0U;
        Fri, 24 Mar 2023 02:32:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 04/11] btrfs: move ordered_extent internal sanity checks into btrfs_split_ordered_extent
Date:   Fri, 24 Mar 2023 10:32:00 +0800
Message-Id: <20230324023207.544800-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324023207.544800-1-hch@lst.de>
References: <20230324023207.544800-1-hch@lst.de>
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

Move the three checks that are about ordered extent internal sanity checking
into btrfs_split_ordered_extent instead of doing them in the higher level
btrfs_extract_ordered_extent routine.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c        | 18 ------------------
 fs/btrfs/ordered-data.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a92f482e898950..4f2f1aafd1720e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2646,18 +2646,6 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 	if (ordered->disk_num_bytes == len)
 		goto out;
 
-	/* We cannot split once end_bio'd ordered extent */
-	if (WARN_ON_ONCE(ordered->bytes_left != ordered->disk_num_bytes)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/* We cannot split a compressed ordered extent */
-	if (WARN_ON_ONCE(ordered->disk_num_bytes != ordered->num_bytes)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	ordered_end = ordered->disk_bytenr + ordered->disk_num_bytes;
 	/* bio must be in one ordered extent */
 	if (WARN_ON_ONCE(start < ordered->disk_bytenr || end > ordered_end)) {
@@ -2665,12 +2653,6 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 		goto out;
 	}
 
-	/* Checksum list should be empty */
-	if (WARN_ON_ONCE(!list_empty(&ordered->list))) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	file_len = ordered->num_bytes;
 	pre = start - ordered->disk_bytenr;
 	post = ordered_end - end;
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1848d0d1a9c41e..4b46406c0c8af5 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1149,6 +1149,16 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
 
 	trace_btrfs_ordered_extent_split(BTRFS_I(inode), ordered);
 
+	/* We cannot split once end_bio'd ordered extent */
+	if (WARN_ON_ONCE(ordered->bytes_left != ordered->disk_num_bytes))
+		return -EINVAL;
+	/* We cannot split a compressed ordered extent */
+	if (WARN_ON_ONCE(ordered->disk_num_bytes != ordered->num_bytes))
+		return -EINVAL;
+	/* Checksum list should be empty */
+	if (WARN_ON_ONCE(!list_empty(&ordered->list)))
+		return -EINVAL;
+
 	spin_lock_irq(&tree->lock);
 	/* Remove from tree once */
 	node = &ordered->rb_node;
-- 
2.39.2

