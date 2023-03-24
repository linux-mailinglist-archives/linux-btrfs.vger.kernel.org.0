Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282B96C75E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 03:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjCXCcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 22:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjCXCcm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 22:32:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12C15FD9
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 19:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WCEED6Setp/bB6UaJ67W4FWqRdQSSu+MURkyPxvlU9Q=; b=bVq+54WkVDBMBjY+IrhKrwntl0
        m+22bwcnuoRUOp5eK7D7elB56Ty0moxxnEXmS3PLAURNi7Mgh4gToopai38U8PLS/2sWszuLISLGe
        NDNKC6usdBf9PHrJDwUiJgIZzQu1aszD72Iik/w2sZ+9LGc+oAjoYdhIfS/y10oIxmfsTX6CRgRHv
        iZ8DaLuzN6Qlw1muO3cbYe0SWhDTqMz/KHpescxyLr6qFe/STykyCYf7/cLXBi/zxIauU4wndVCGa
        oBxF3aazHxQGOLMBNInli+X1A1PK04Um0C5UjFz4F5sdYMpmkXfPmqnON9TOPmVzP5sOpqBXwxiv0
        v35YSTlQ==;
Received: from [122.147.159.86] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pfXEM-003PIx-2i;
        Fri, 24 Mar 2023 02:32:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 07/11] btrfs: fold btrfs_clone_ordered_extent into btrfs_split_ordered_extent
Date:   Fri, 24 Mar 2023 10:32:03 +0800
Message-Id: <20230324023207.544800-8-hch@lst.de>
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

btrfs_clone_ordered_extent is very specific to the usage in
btrfs_split_ordered_extent.  Now that only a single call to
btrfs_clone_ordered_extent is left, just fold it into
btrfs_split_ordered_extent to make the operation more clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ordered-data.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1d5971b6e68c66..b5a86bb13115db 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1116,38 +1116,21 @@ bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 	return false;
 }
 
-
-static int clone_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pos,
-				u64 len)
-{
-	struct inode *inode = ordered->inode;
-	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
-	u64 file_offset = ordered->file_offset + pos;
-	u64 disk_bytenr = ordered->disk_bytenr + pos;
-	unsigned long flags = ordered->flags & BTRFS_ORDERED_TYPE_FLAGS;
-
-	/*
-	 * The splitting extent is already counted and will be added again in
-	 * btrfs_add_ordered_extent_*(). Subtract len to avoid double counting.
-	 */
-	percpu_counter_add_batch(&fs_info->ordered_bytes, -len,
-				 fs_info->delalloc_batch);
-	WARN_ON_ONCE(flags & (1 << BTRFS_ORDERED_COMPRESSED));
-	return btrfs_add_ordered_extent(BTRFS_I(inode), file_offset, len, len,
-					disk_bytenr, len, 0, flags,
-					ordered->compress_type);
-}
-
 /* split out a new ordered extent for this first @len bytes of @ordered */
 int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 len)
 {
 	struct inode *inode = ordered->inode;
 	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	u64 file_offset = ordered->file_offset;
+	u64 disk_bytenr = ordered->disk_bytenr;
+	unsigned long flags = ordered->flags & BTRFS_ORDERED_TYPE_FLAGS;
 	struct rb_node *node;
 
 	trace_btrfs_ordered_extent_split(BTRFS_I(inode), ordered);
 
+	ASSERT(!(flags & (1 << BTRFS_ORDERED_COMPRESSED)));
+
 	/* The bio must be entirely covered by the ordered extent */
 	if (WARN_ON_ONCE(len > ordered->num_bytes))
 		return -EINVAL;
@@ -1184,7 +1167,15 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 len)
 
 	spin_unlock_irq(&tree->lock);
 
-	return clone_ordered_extent(ordered, 0, len);
+	/*
+	 * The splitting extent is already counted and will be added again in
+	 * btrfs_add_ordered_extent(). Subtract len to avoid double counting.
+	 */
+	percpu_counter_add_batch(&fs_info->ordered_bytes, -len,
+				 fs_info->delalloc_batch);
+	return btrfs_add_ordered_extent(BTRFS_I(inode), file_offset, len, len,
+					disk_bytenr, len, 0, flags,
+					ordered->compress_type);
 }
 
 int __init ordered_data_init(void)
-- 
2.39.2

