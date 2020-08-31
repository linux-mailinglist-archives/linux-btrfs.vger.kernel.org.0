Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C922578CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 13:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHaLyR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 07:54:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:37898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgHaLxt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 07:53:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54CFFB814;
        Mon, 31 Aug 2020 11:53:46 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 03/12] btrfs: Make ordered extent tracepoint take btrfs_inode
Date:   Mon, 31 Aug 2020 14:42:40 +0300
Message-Id: <20200831114249.8360-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831114249.8360-1-nborisov@suse.com>
References: <20200831114249.8360-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ordered-data.c      |  8 ++++----
 include/trace/events/btrfs.h | 17 ++++++++---------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 5a7e9c5872d3..369ddad30d9c 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -217,7 +217,7 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	INIT_LIST_HEAD(&entry->work_list);
 	init_completion(&entry->completion);
 
-	trace_btrfs_ordered_extent_add(&inode->vfs_inode, entry);
+	trace_btrfs_ordered_extent_add(inode, entry);
 
 	spin_lock_irq(&tree->lock);
 	node = tree_insert(&tree->tree, file_offset,
@@ -442,7 +442,7 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 	struct list_head *cur;
 	struct btrfs_ordered_sum *sum;
 
-	trace_btrfs_ordered_extent_put(entry->inode, entry);
+	trace_btrfs_ordered_extent_put(BTRFS_I(entry->inode), entry);
 
 	if (refcount_dec_and_test(&entry->refs)) {
 		ASSERT(list_empty(&entry->root_extent_list));
@@ -528,7 +528,7 @@ void btrfs_remove_ordered_extent(struct inode *inode,
 	list_del_init(&entry->root_extent_list);
 	root->nr_ordered_extents--;
 
-	trace_btrfs_ordered_extent_remove(inode, entry);
+	trace_btrfs_ordered_extent_remove(BTRFS_I(inode), entry);
 
 	if (!root->nr_ordered_extents) {
 		spin_lock(&fs_info->ordered_root_lock);
@@ -658,7 +658,7 @@ void btrfs_start_ordered_extent(struct inode *inode,
 	u64 start = entry->file_offset;
 	u64 end = start + entry->num_bytes - 1;
 
-	trace_btrfs_ordered_extent_start(inode, entry);
+	trace_btrfs_ordered_extent_start(BTRFS_I(inode), entry);
 
 	/*
 	 * pages in the range can be dirty, clean or writeback.  We
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 34baf3290b89..fec0a5bcf481 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -510,7 +510,7 @@ DEFINE_EVENT(
 
 DECLARE_EVENT_CLASS(btrfs__ordered_extent,
 
-	TP_PROTO(const struct inode *inode,
+	TP_PROTO(const struct btrfs_inode *inode,
 		 const struct btrfs_ordered_extent *ordered),
 
 	TP_ARGS(inode, ordered),
@@ -529,8 +529,8 @@ DECLARE_EVENT_CLASS(btrfs__ordered_extent,
 		__field(	u64,  truncated_len	)
 	),
 
-	TP_fast_assign_btrfs(btrfs_sb(inode->i_sb),
-		__entry->ino 		= btrfs_ino(BTRFS_I(inode));
+	TP_fast_assign_btrfs(inode->root->fs_info,
+		__entry->ino 		= btrfs_ino(inode);
 		__entry->file_offset	= ordered->file_offset;
 		__entry->start		= ordered->disk_bytenr;
 		__entry->len		= ordered->num_bytes;
@@ -539,8 +539,7 @@ DECLARE_EVENT_CLASS(btrfs__ordered_extent,
 		__entry->flags		= ordered->flags;
 		__entry->compress_type	= ordered->compress_type;
 		__entry->refs		= refcount_read(&ordered->refs);
-		__entry->root_objectid	=
-				BTRFS_I(inode)->root->root_key.objectid;
+		__entry->root_objectid	= inode->root->root_key.objectid;
 		__entry->truncated_len	= ordered->truncated_len;
 	),
 
@@ -563,7 +562,7 @@ DECLARE_EVENT_CLASS(btrfs__ordered_extent,
 
 DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_add,
 
-	TP_PROTO(const struct inode *inode,
+	TP_PROTO(const struct btrfs_inode *inode,
 		 const struct btrfs_ordered_extent *ordered),
 
 	TP_ARGS(inode, ordered)
@@ -571,7 +570,7 @@ DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_add,
 
 DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_remove,
 
-	TP_PROTO(const struct inode *inode,
+	TP_PROTO(const struct btrfs_inode *inode,
 		 const struct btrfs_ordered_extent *ordered),
 
 	TP_ARGS(inode, ordered)
@@ -579,7 +578,7 @@ DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_remove,
 
 DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_start,
 
-	TP_PROTO(const struct inode *inode,
+	TP_PROTO(const struct btrfs_inode *inode,
 		 const struct btrfs_ordered_extent *ordered),
 
 	TP_ARGS(inode, ordered)
@@ -587,7 +586,7 @@ DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_start,
 
 DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_put,
 
-	TP_PROTO(const struct inode *inode,
+	TP_PROTO(const struct btrfs_inode *inode,
 		 const struct btrfs_ordered_extent *ordered),
 
 	TP_ARGS(inode, ordered)
-- 
2.17.1

