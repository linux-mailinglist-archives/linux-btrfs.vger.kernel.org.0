Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB7B6CB5E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 07:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjC1FUN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 01:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjC1FUK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 01:20:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31851BE8
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 22:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZOXIf1zqB3w5elnjWJQrLgeGUSS8aYRV+ngK6an9JJQ=; b=eiRsgzT6/xZLxNyTRyGkfYCu2C
        Eo8kjIToJSqJwdzlA4i9bfsughS0Qqh/pIYnJNtrVXM/JL4KMPh7OPDwyLUv5NeSwjJFSs3f0th43
        pp3AimW5CaVmeC1dyWzuzb7ao4zxFtgwAC2z5qwmfzYYqc20uZBXmEgB7lvtLODKurZmPXRd/0GF1
        t51HssfHeyi9ka8fERVw3WMG8bkMDuZxGUmA3X9ssr79ECYadmLHnpSjJHYmtWechNQlVvB7jwvne
        iKeVJzGwMKWf8YnCZbs1hneYUCcVUvTSB4Nw78hZGWSYWN7uVUrPZXiH7owiUKo6jFEZhuJ9H0E5i
        d55tDcvg==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ph1kZ-00DATi-1P;
        Tue, 28 Mar 2023 05:20:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 01/11] btrfs: add function to create and return an ordered extent
Date:   Tue, 28 Mar 2023 14:19:47 +0900
Message-Id: <20230328051957.1161316-2-hch@lst.de>
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

From: Boris Burkov <boris@bur.io>

Currently, btrfs_add_ordered_extent allocates a new ordered extent, adds
it to the rb_tree, but doesn't return a referenced pointer to the
caller. There are cases where it is useful for the creator of a new
ordered_extent to hang on to such a pointer, so add a new function
btrfs_alloc_ordered_extent which is the same as
btrfs_add_ordered_extent, except it takes an additional reference count
and returns a pointer to the ordered_extent. Implement
btrfs_add_ordered_extent as btrfs_alloc_ordered_extent followed by
dropping the new reference and handling the IS_ERR case.

The type of flags in btrfs_alloc_ordered_extent and
btrfs_add_ordered_extent is changed from unsigned int to unsigned long
so it's unified with the other ordered extent functions.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ordered-data.c | 46 +++++++++++++++++++++++++++++++++--------
 fs/btrfs/ordered-data.h |  5 +++++
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 6c24b69e2d0a37..83a51c692406ab 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -160,14 +160,16 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
  * @compress_type:   Compression algorithm used for data.
  *
  * Most of these parameters correspond to &struct btrfs_file_extent_item. The
- * tree is given a single reference on the ordered extent that was inserted.
+ * tree is given a single reference on the ordered extent that was inserted, and
+ * the returned pointer is given a second reference.
  *
- * Return: 0 or -ENOMEM.
+ * Return: the new ordered extent or ERR_PTR(-ENOMEM).
  */
-int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
-			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			     u64 disk_num_bytes, u64 offset, unsigned flags,
-			     int compress_type)
+struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
+			struct btrfs_inode *inode, u64 file_offset,
+			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
+			u64 disk_num_bytes, u64 offset, unsigned long flags,
+			int compress_type)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -181,7 +183,7 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 		/* For nocow write, we can release the qgroup rsv right now */
 		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes);
 		if (ret < 0)
-			return ret;
+			return ERR_PTR(ret);
 		ret = 0;
 	} else {
 		/*
@@ -190,11 +192,11 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 		 */
 		ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes);
 		if (ret < 0)
-			return ret;
+			return ERR_PTR(ret);
 	}
 	entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
 	if (!entry)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	entry->file_offset = file_offset;
 	entry->num_bytes = num_bytes;
@@ -256,6 +258,32 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 	btrfs_mod_outstanding_extents(inode, 1);
 	spin_unlock(&inode->lock);
 
+	/* One ref for the returned entry to match semantics of lookup. */
+	refcount_inc(&entry->refs);
+
+	return entry;
+}
+
+/*
+ * Add a new btrfs_ordered_extent for the range, but drop the reference instead
+ * of returning it to the caller.
+ */
+int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
+			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
+			     u64 disk_num_bytes, u64 offset, unsigned flags,
+			     int compress_type)
+{
+	struct btrfs_ordered_extent *ordered;
+
+	ordered = btrfs_alloc_ordered_extent(inode, file_offset, num_bytes,
+					     ram_bytes, disk_bytenr,
+					     disk_num_bytes, offset, flags,
+					     compress_type);
+
+	if (IS_ERR(ordered))
+		return PTR_ERR(ordered);
+	btrfs_put_ordered_extent(ordered);
+
 	return 0;
 }
 
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index eb40cb39f842e6..c00a5a3f060fa2 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -178,6 +178,11 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
 				    u64 file_offset, u64 io_size);
+struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
+			struct btrfs_inode *inode, u64 file_offset,
+			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
+			u64 disk_num_bytes, u64 offset, unsigned long flags,
+			int compress_type);
 int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
 			     u64 disk_num_bytes, u64 offset, unsigned flags,
-- 
2.39.2

