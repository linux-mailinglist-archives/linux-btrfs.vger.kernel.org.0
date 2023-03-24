Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD06C75E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 03:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjCXCck (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 22:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjCXCcj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 22:32:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB485276
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 19:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5+/P4+faQtfgyzVWuk8aP0wshW7rk5hnrAWg19FQCvc=; b=LRfOpwcMJOcj7eK8jWQrDpGrOz
        VvHITTAcvickmOUqzHWTuY2f48qfQo8RpFFEkaoJpF1BlPUJM+/MSl1ly5zxB7MWHYUNmlTkA86K/
        XCc/LcRVA/k0wMJKSp+CVn2P8YrzS6wyUi/AlBPEVmNT7xtZzGP0D/RTqTL9iJvgZ6m6rIKHfh6Vr
        kW9u3Q3ao774qAoPLg4xtzTneCKFtZLOjKZtv65QDMeSLXT7IJR66s4BSBQEsvKYgL6wYuNI05Er+
        Mgo5gKoCFIS2UU+/K2zUFMo6v0eMHMRzEHG6RK17z6vm65RBOyArmSLcCJ+PLbatx1sBZ40y3kmD9
        BqQ3VQvg==;
Received: from [122.147.159.104] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pfXEJ-003PIa-2o;
        Fri, 24 Mar 2023 02:32:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 06/11] btrfs: simplify btrfs_split_ordered_extent
Date:   Fri, 24 Mar 2023 10:32:02 +0800
Message-Id: <20230324023207.544800-7-hch@lst.de>
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

btrfs_split_ordered_extent is only ever asked to split out the beginning
of an ordered_extent.  Change it to only take a len to split out, and
switch it to allocate the new extent for the beginning, as that helps
with callers that want to keep a pointer to the ordered_extent that
it is stealing from.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c        |  8 +-------
 fs/btrfs/ordered-data.c | 28 ++++++++++++----------------
 fs/btrfs/ordered-data.h |  3 +--
 3 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2cbc6c316effc1..bff23bac85f2ef 100644
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
index 4b46406c0c8af5..1d5971b6e68c66 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1138,17 +1138,19 @@ static int clone_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pos,
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
 
+	/* The bio must be entirely covered by the ordered extent */
+	if (WARN_ON_ONCE(len > ordered->num_bytes))
+		return -EINVAL;
 	/* We cannot split once end_bio'd ordered extent */
 	if (WARN_ON_ONCE(ordered->bytes_left != ordered->disk_num_bytes))
 		return -EINVAL;
@@ -1167,11 +1169,11 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
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
@@ -1182,13 +1184,7 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
 
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

