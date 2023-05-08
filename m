Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46926FB4D4
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjEHQJN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjEHQI5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B8C658E
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OqqypU+aKqc926oUL6ED0h5SbV6n+oqGaeXw5yBTkos=; b=bZA2V5n+ouPlg1EqRYhg+xKky2
        8c+nFK9w37ZzZVMlI4w1jLh4sARN91RoXoSLsVuPy2Tp4I8mGfr8qUPKOS/f7ykf/rrE9UCzQk1Mw
        h2/Kng+Cc0BZbr66eiBE/oe1z3ZtK5mZcwn4KR66Kr1vwB+U2UjinN9N1RhW4o36AIjS1CRASwQcQ
        fn1eJ7LEV2ud6aBz/U0lEo2gQcmDlRwd2biNowfMf13VDndmvSHgbAJg9YGYjBkAb5h2NRajjwkdT
        JEoiLGACpxupSL8qAzpIC8oCEH1gsSIhvHtWcRd9VEaNxIOq7JltVvBqQx42unq+fl/o+Te2yO4kH
        XvNaW8Yw==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Py-000w3n-0u;
        Mon, 08 May 2023 16:08:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/21] btrfs: factor out a btrfs_queue_ordered_fn helper
Date:   Mon,  8 May 2023 09:08:38 -0700
Message-Id: <20230508160843.133013-17-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160843.133013-1-hch@lst.de>
References: <20230508160843.133013-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out a helper to queue up an ordered_extent completion in a work
queue.  This new helper will later be used complete an ordered_extent
without first doing a lookup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ordered-data.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 36e4d2517b28fd..f474585e6234fe 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -345,6 +345,17 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
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
@@ -363,18 +374,11 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
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
@@ -429,8 +433,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 
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

