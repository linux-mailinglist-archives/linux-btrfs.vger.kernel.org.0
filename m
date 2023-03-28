Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6752D6CB5E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 07:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjC1FUY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 01:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjC1FUW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 01:20:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D7A1BE8
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 22:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BpUDjBqDGzu3hvqByzedbbc0AznwYOaPHCRcHRAfvUM=; b=39lALCRWwNlACTOYT+GEH1aG40
        e7njt0/0sG2GIhZz5RucAVEtsOIwkpR6+0VjDyrETjwR0jKDzm7SXlBjTqODfdQ7k6jtlQMe3aOYW
        gkyZEg+l26rKxUnwRlJtjau2aAwkfGkmoyhvjopWtL6Hbx500ff/BhrCqs+2Z5WniMHlzFUq8C9/S
        stjWabfocwFGaEuYY/RtBP5SeRtOtm7HO9/0eQhhW5jKDYvXkRdaYwesYHuSMGxammYbKc70EF02D
        HMyCv2ioZVU9wC1krcFd6IZSc0FGSSSSESYriJcFaxMjmmlTLVcl0E5WIRJDEIzu5+gw6ovNWooEG
        ztlhSAtQ==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ph1kl-00DAWs-2K;
        Tue, 28 Mar 2023 05:20:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 06/11] btrfs: simplify btrfs_split_ordered_extent
Date:   Tue, 28 Mar 2023 14:19:52 +0900
Message-Id: <20230328051957.1161316-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328051957.1161316-1-hch@lst.de>
References: <20230328051957.1161316-1-hch@lst.de>
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

btrfs_split_ordered_extent is only ever asked to split out the beginning
of an ordered_extent.  Change it to only take a len to split out, and
switch it to allocate the new extent for the beginning, as that helps
with callers that want to keep a pointer to the ordered_extent that
it is stealing from.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c        |  8 +-------
 fs/btrfs/ordered-data.c | 31 +++++++++++++++----------------
 fs/btrfs/ordered-data.h |  3 +--
 3 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 428fa99711def1..5358187f37fe10 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2646,17 +2646,11 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 		goto out;
 	}
 
-	/* The bio must be entirely covered by the ordered extent */
-	if (WARN_ON_ONCE(len > ordered_len)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	/* No need to split if the ordered extent covers the entire bio */
 	if (ordered->disk_num_bytes == len)
 		goto out;
 
-	ret = btrfs_split_ordered_extent(ordered, len, 0);
+	ret = btrfs_split_ordered_extent(ordered, len);
 	if (ret)
 		goto out;
 	ret = split_zoned_em(inode, bbio->file_offset, ordered_len, len, 0);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 4b46406c0c8af5..561531ca4e9ef2 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1138,17 +1138,22 @@ static int clone_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pos,
 					ordered->compress_type);
 }
 
-int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
-				u64 post)
+/* split out a new ordered extent for this first @len bytes of @ordered */
+int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 len)
 {
 	struct inode *inode = ordered->inode;
 	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
-	struct rb_node *node;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	int ret = 0;
+	struct rb_node *node;
 
 	trace_btrfs_ordered_extent_split(BTRFS_I(inode), ordered);
 
+	/*
+	 * The entire bio must be covered by the ordered extent, but we can't
+	 * reduce the original extent to a zero length either.
+	 */
+	if (WARN_ON_ONCE(len >= ordered->num_bytes))
+		return -EINVAL;
 	/* We cannot split once end_bio'd ordered extent */
 	if (WARN_ON_ONCE(ordered->bytes_left != ordered->disk_num_bytes))
 		return -EINVAL;
@@ -1167,11 +1172,11 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
 	if (tree->last == node)
 		tree->last = NULL;
 
-	ordered->file_offset += pre;
-	ordered->disk_bytenr += pre;
-	ordered->num_bytes -= (pre + post);
-	ordered->disk_num_bytes -= (pre + post);
-	ordered->bytes_left -= (pre + post);
+	ordered->file_offset += len;
+	ordered->disk_bytenr += len;
+	ordered->num_bytes -= len;
+	ordered->disk_num_bytes -= len;
+	ordered->bytes_left -= len;
 
 	/* Re-insert the node */
 	node = tree_insert(&tree->tree, ordered->file_offset, &ordered->rb_node);
@@ -1182,13 +1187,7 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
 
 	spin_unlock_irq(&tree->lock);
 
-	if (pre)
-		ret = clone_ordered_extent(ordered, 0, pre);
-	if (ret == 0 && post)
-		ret = clone_ordered_extent(ordered, pre + ordered->disk_num_bytes,
-					   post);
-
-	return ret;
+	return clone_ordered_extent(ordered, 0, len);
 }
 
 int __init ordered_data_init(void)
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 18007f9c00add8..f0f1138d23c331 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -212,8 +212,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 					struct extent_state **cached_state);
 bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct extent_state **cached_state);
-int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
-			       u64 post);
+int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 len);
 int __init ordered_data_init(void);
 void __cold ordered_data_exit(void);
 
-- 
2.39.2

