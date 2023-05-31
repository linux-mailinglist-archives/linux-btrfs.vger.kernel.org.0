Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA25717932
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjEaH4a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 03:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjEaH4J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 03:56:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C440E68
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=L6duVNsoNdkPA0dTSlgh7bg6wBXFu4ggU2NxEpYbS4U=; b=w5hpkPAd6crxLR+5VhDnLabXQU
        Bu6wYxzOmcVTbGvnODT+PEM9KF6bnhk26ZbhRIrF2rJQqmjQk5JKe8JDnUU+Kauq3ZbYvD4A1wwRs
        i81EmDeGJNHu/mqb7uN15N6/5fWmbBWcOdYbrkqnDzp4WJ7xeuOeyDwyBrVAiUhYewNAKKnG5HaKp
        NXn8NmlUP7GrUiie6gTwWRzsF4BC3e4LPFrBSpyD+WbWDM1IDSjJkpXfgnLG5SW9w5dTP44Q+fBPx
        BVob2sHf74X42EYq2U9HriyypfIrrDikvMW2XLpFo4H8V88OXIrbWHAQ1Tr7/cVx9tylsYblK2nZo
        hxIil8fA==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4GfP-00GWwG-2x;
        Wed, 31 May 2023 07:54:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 12/17] btrfs: factor out a btrfs_queue_ordered_fn helper
Date:   Wed, 31 May 2023 09:54:05 +0200
Message-Id: <20230531075410.480499-13-hch@lst.de>
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

Factor out a helper to queue up an ordered_extent completion in a work
queue.  This new helper will later be used complete an ordered_extent
without first doing a lookup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ordered-data.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index c8cd8a0fde0e11..70f411412ca158 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -360,6 +360,17 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 	return true;
 }
 
+static void btrfs_queue_ordered_fn(struct btrfs_ordered_extent *ordered)
+{
+	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_workqueue *wq = btrfs_is_free_space_inode(inode) ?
+		fs_info->endio_freespace_worker : fs_info->endio_write_workers;
+
+	btrfs_init_work(&ordered->work, finish_ordered_fn, NULL, NULL);
+	btrfs_queue_work(wq, &ordered->work);
+}
+
 /*
  * Mark all ordered extents io inside the specified range finished.
  *
@@ -378,18 +389,11 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 				    u64 num_bytes, bool uptodate)
 {
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_workqueue *wq;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 	unsigned long flags;
 	u64 cur = file_offset;
 
-	if (btrfs_is_free_space_inode(inode))
-		wq = fs_info->endio_freespace_worker;
-	else
-		wq = fs_info->endio_write_workers;
-
 	spin_lock_irqsave(&tree->lock, flags);
 	while (cur < file_offset + num_bytes) {
 		u64 entry_end;
@@ -444,8 +448,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 
 		if (can_finish_ordered_extent(entry, page, cur, len, uptodate)) {
 			spin_unlock_irqrestore(&tree->lock, flags);
-			btrfs_init_work(&entry->work, finish_ordered_fn, NULL, NULL);
-			btrfs_queue_work(wq, &entry->work);
+			btrfs_queue_ordered_fn(entry);
 			spin_lock_irqsave(&tree->lock, flags);
 		}
 		cur += len;
-- 
2.39.2

