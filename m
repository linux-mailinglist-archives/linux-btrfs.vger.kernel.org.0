Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E654B9FD5
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 13:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240301AbiBQMMd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 07:12:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240296AbiBQMMb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 07:12:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367CD11C29
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 04:12:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C712D6102C
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 12:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3768C340EC
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645099936;
        bh=56hiJVFQSczjoUJ8awzQ6wvcPFtCIGcbRtj6U794/i4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bou+9ic7U7XczFsbqxb8jo91Gp9cqIvrBW67xh/zuXhPCL17icfZAgxnl5QwA3pHp
         cRWmgTsOrr+DtUzasTp++A5K5QrV5HtNSpMPp8O5R3Y7OKdfC5sYIDeehrz/9FxNIW
         6VDZendFmGP/deorIdb4Xd/RMCRC9O23/4czG5KuRMJcdtxd30NpRwxW9dRh5vTH4Y
         2Vx9cW5gbdgidypZb1XQ6XWLMaZGOaVT+ZmFtCyKNXXom+J41zaC+G9pwUL/3T2z5/
         AHNWB8kmfJ14jt3nzZ+oM4nUtUIBk72qHZp2KkXiaunPTBK8NdfLCvQoH5vVoFZp/P
         PFnEXHANcODyg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs: reset last_reflink_trans after fsyncing inode
Date:   Thu, 17 Feb 2022 12:12:06 +0000
Message-Id: <6a870bbde848ae3aeaa399134f478d544ad7a80f.1645098951.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1645098951.git.fdmanana@suse.com>
References: <cover.1645098951.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When an inode has a last_reflink_trans matching the current transaction,
we have to take special care when logging its checksums in order to
avoid getting checksum items with overlapping ranges in a log tree,
which could result in missing checksums after log replay (more on that
in the changelogs of commit 40e046acbd2f36 ("Btrfs: fix missing data
checksums after replaying a log tree") and commit e289f03ea79bbc ("btrfs:
fix corrupt log due to concurrent fsync of inodes with shared extents")).
We also need to make sure a full fsync will copy all old file extent
items it finds in modified leaves, because they might have been copied
from some other inode.

However once we fsync an inode, we don't need to keep paying the price of
that extra special care in future fsyncs done in the same transaction,
unless the inode is used for another reflink operation or the full sync
flag is set on it (truncate, failure to allocate extent maps for holes,
and other exceptional and infrequent cases).

So after we fsync an inode reset its last_unlink_trans to zero. In case
another reflink happens, we continue to update the last_reflink_trans of
the inode, just as before. Also set last_reflink_trans to the generation
of the last transaction that modified the inode whenever we need to set
the full sync flag on the inode, just like when we need to load an inode
from disk after eviction.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h | 30 ++++++++++++++++++++++++++++++
 fs/btrfs/file.c        |  7 +++----
 fs/btrfs/inode.c       | 12 +++++-------
 fs/btrfs/reflink.c     |  5 ++---
 fs/btrfs/tree-log.c    |  8 ++++++++
 5 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 6d4f42b0fdce..47e72d72f7d0 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -341,6 +341,36 @@ static inline void btrfs_set_inode_last_sub_trans(struct btrfs_inode *inode)
 	spin_unlock(&inode->lock);
 }
 
+/*
+ * Should be called while holding the inode's VFS lock in exclusive mode or in a
+ * context where no one else can access the inode concurrently (during inode
+ * creation or when loading an inode from disk).
+ */
+static inline void btrfs_set_inode_full_sync(struct btrfs_inode *inode)
+{
+	set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
+	/*
+	 * The inode may have been part of a reflink operation in the last
+	 * transaction that modified it, and then a fsync has reset the
+	 * last_reflink_trans to avoid subsequent fsyncs in the same
+	 * transaction to do unnecessary work. So update last_reflink_trans
+	 * to the last_trans value (we have to be pessimistic and assume a
+	 * reflink happened).
+	 *
+	 * The ->last_trans is protected by the inode's spinlock and we can
+	 * have a concurrent ordered extent completion update it. Also set
+	 * last_reflink_trans to ->last_trans only if the former is less than
+	 * the later, because we can be called in a context where
+	 * last_reflink_trans was set to the current transaction generation
+	 * while ->last_trans was not yet updated in the current transaction,
+	 * and therefore has a lower value.
+	 */
+	spin_lock(&inode->lock);
+	if (inode->last_reflink_trans < inode->last_trans)
+		inode->last_reflink_trans = inode->last_trans;
+	spin_unlock(&inode->lock);
+}
+
 static inline bool btrfs_inode_in_log(struct btrfs_inode *inode, u64 generation)
 {
 	bool ret = false;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 625c25bff126..119f8a28fbe6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2499,7 +2499,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 	hole_em = alloc_extent_map();
 	if (!hole_em) {
 		btrfs_drop_extent_cache(inode, offset, end - 1, 0);
-		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
+		btrfs_set_inode_full_sync(inode);
 	} else {
 		hole_em->start = offset;
 		hole_em->len = end - offset;
@@ -2520,8 +2520,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		} while (ret == -EEXIST);
 		free_extent_map(hole_em);
 		if (ret)
-			set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-					&inode->runtime_flags);
+			btrfs_set_inode_full_sync(inode);
 	}
 
 	return 0;
@@ -2875,7 +2874,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 	 * maps for the replacement extents (or holes).
 	 */
 	if (extent_info && !extent_info->is_new_extent)
-		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
+		btrfs_set_inode_full_sync(inode);
 
 	if (ret)
 		goto out_trans;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 24099fe9e120..fe1597e74791 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -428,7 +428,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 		goto out;
 	}
 
-	set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
+	btrfs_set_inode_full_sync(inode);
 out:
 	/*
 	 * Don't forget to free the reserved space, as for inlined extent
@@ -4900,8 +4900,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 						cur_offset + hole_size - 1, 0);
 			hole_em = alloc_extent_map();
 			if (!hole_em) {
-				set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-					&inode->runtime_flags);
+				btrfs_set_inode_full_sync(inode);
 				goto next;
 			}
 			hole_em->start = cur_offset;
@@ -6154,7 +6153,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	 * sync since it will be a full sync anyway and this will blow away the
 	 * old info in the log.
 	 */
-	set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &BTRFS_I(inode)->runtime_flags);
+	btrfs_set_inode_full_sync(BTRFS_I(inode));
 
 	key[0].objectid = objectid;
 	key[0].type = BTRFS_INODE_ITEM_KEY;
@@ -8725,7 +8724,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 	 * extents beyond i_size to drop.
 	 */
 	if (control.extents_found > 0)
-		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &BTRFS_I(inode)->runtime_flags);
+		btrfs_set_inode_full_sync(BTRFS_I(inode));
 
 	return ret;
 }
@@ -9933,8 +9932,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 
 		em = alloc_extent_map();
 		if (!em) {
-			set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-				&BTRFS_I(inode)->runtime_flags);
+			btrfs_set_inode_full_sync(BTRFS_I(inode));
 			goto next;
 		}
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index c083ded71ef7..cdcfeab82e12 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -277,7 +277,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 						  path->slots[0]),
 			    size);
 	btrfs_update_inode_bytes(BTRFS_I(dst), datal, drop_args.bytes_found);
-	set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &BTRFS_I(dst)->runtime_flags);
+	btrfs_set_inode_full_sync(BTRFS_I(dst));
 	ret = btrfs_inode_set_file_extent_range(BTRFS_I(dst), 0, aligned_end);
 out:
 	if (!ret && !trans) {
@@ -580,8 +580,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		 * replaced file extent items.
 		 */
 		if (last_dest_end >= i_size_read(inode))
-			set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-				&BTRFS_I(inode)->runtime_flags);
+			btrfs_set_inode_full_sync(BTRFS_I(inode));
 
 		ret = btrfs_replace_file_extents(BTRFS_I(inode), path,
 				last_dest_end, destoff + len - 1, NULL, &trans);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e5b681854117..73ecc4f67a23 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5995,6 +5995,14 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	if (inode_only != LOG_INODE_EXISTS)
 		inode->last_log_commit = inode->last_sub_trans;
 	spin_unlock(&inode->lock);
+
+	/*
+	 * Reset the last_reflink_trans so that the next fsync does not need to
+	 * go through the slower path when logging extents and their checksums.
+	 */
+	if (inode_only == LOG_INODE_ALL)
+		inode->last_reflink_trans = 0;
+
 out_unlock:
 	mutex_unlock(&inode->log_mutex);
 out:
-- 
2.33.0

