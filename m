Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2820E269DE4
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 07:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIOFgR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 01:36:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:43400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgIOFgP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 01:36:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9A37AEA2
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Sep 2020 05:36:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 15/19] btrfs: don't set extent_io_tree bits for btree inode at endio time
Date:   Tue, 15 Sep 2020 13:35:28 +0800
Message-Id: <20200915053532.63279-16-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915053532.63279-1-wqu@suse.com>
References: <20200915053532.63279-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For btree inode, we don't use ordered extent, nor really use it for
locking and uptodate bits.

But we still call lock_extent_bits() during endio call backs.

This is fine and won't cause anything wrong for current code base, but
since we're going to completely rely on extent_io_tree to do all the
sector locking/uptodate/dirty tracking, it's better to decouple btree
inode from endio call backs.

There is only one caller who explicitly lock and unlock btree inode io
tree, that's verify_parent_transid().

But in verify_parent_transid(), call its callers have ensured that they
have the pages read out, either through manual
read_extent_buffer_pages() call, or through extent_buffer_uptodate()
call (checks UPTODATE bit of an extent buffer, which only get set after
page read).

Thus that extra locking makes no sense and can be removed completely.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c        |  5 -----
 fs/btrfs/extent-io-tree.h |  7 +++++++
 fs/btrfs/extent_io.c      | 19 ++++++++++++++-----
 fs/btrfs/ordered-data.c   |  8 ++++++++
 fs/btrfs/qgroup.c         |  4 ++++
 5 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 82a841bd0702..b526adf20f3e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -286,7 +286,6 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 				 struct extent_buffer *eb, u64 parent_transid,
 				 int atomic)
 {
-	struct extent_state *cached_state = NULL;
 	int ret;
 	bool need_lock = (current->journal_info == BTRFS_SEND_TRANS_STUB);
 
@@ -301,8 +300,6 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 		btrfs_set_lock_blocking_read(eb);
 	}
 
-	lock_extent_bits(io_tree, eb->start, eb->start + eb->len - 1,
-			 &cached_state);
 	if (extent_buffer_uptodate(eb) &&
 	    btrfs_header_generation(eb) == parent_transid) {
 		ret = 0;
@@ -325,8 +322,6 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 	if (!extent_buffer_under_io(eb))
 		clear_extent_buffer_uptodate(eb);
 out:
-	unlock_extent_cached(io_tree, eb->start, eb->start + eb->len - 1,
-			     &cached_state);
 	if (need_lock)
 		btrfs_tree_read_unlock_blocking(eb);
 	return ret;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 21d128383bfd..133cae8a88a6 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -56,6 +56,13 @@ struct extent_io_tree {
 	struct btrfs_fs_info *fs_info;
 	void *private_data;
 	u64 dirty_bytes;
+
+	/*
+	 * Does the tree tracks things like locking and uptodate at endio time.
+	 *
+	 * File inodes has it set to true. Other inodes (include btree inode) set it
+	 * to false.
+	 */
 	bool track_uptodate;
 
 	/* Who owns this io tree, should be one of IO_TREE_* */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f4ab59b3ce3c..16fe9f4313a1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2782,9 +2782,15 @@ endio_readpage_release_extent(struct extent_io_tree *tree, u64 start, u64 len,
 	struct extent_state *cached = NULL;
 	u64 end = start + len - 1;
 
-	if (uptodate && tree->track_uptodate)
+	/*
+	 * Only update the UPTODATE and LOCK bits for regular inodes.
+	 * Btree io tree (without the track_uptodate bit) handles its own bits
+	 * manually.
+	 */
+	if (uptodate && tree->track_uptodate) {
 		set_extent_uptodate(tree, start, end, &cached, GFP_ATOMIC);
-	unlock_extent_cached_atomic(tree, start, end, &cached);
+		unlock_extent_cached_atomic(tree, start, end, &cached);
+	}
 }
 
 /*
@@ -4436,10 +4442,13 @@ int extent_invalidatepage(struct extent_io_tree *tree,
 	if (start > end)
 		return 0;
 
-	lock_extent_bits(tree, start, end, &cached_state);
+	if (tree->track_uptodate)
+		lock_extent_bits(tree, start, end, &cached_state);
 	wait_on_page_writeback(page);
-	clear_extent_bit(tree, start, end, EXTENT_LOCKED | EXTENT_DELALLOC |
-			 EXTENT_DO_ACCOUNTING, 1, 1, &cached_state);
+	if (tree->track_uptodate)
+		clear_extent_bit(tree, start, end, EXTENT_LOCKED |
+			EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING, 1, 1,
+			&cached_state);
 	return 0;
 }
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index ebac13389e7e..0bb8ce1ab51f 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -865,6 +865,14 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 	struct extent_state *cache = NULL;
 	struct extent_state **cachedp = &cache;
 
+	/*
+	 * Btree inode, who doesn't have the track_uptodate bit, doesn't use
+	 * ordered extent at all.
+	 * Exit directly.
+	 */
+	if (!inode->io_tree.track_uptodate)
+		return;
+
 	if (cached_state)
 		cachedp = cached_state;
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index c0f350c3a0cf..aeb04ccafaa8 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3924,6 +3924,10 @@ void btrfs_qgroup_check_reserved_leak(struct btrfs_inode *inode)
 	struct ulist_iterator iter;
 	int ret;
 
+	/* This is btree inode, no need to check */
+	if (!inode->io_tree.track_uptodate)
+		return;
+
 	extent_changeset_init(&changeset);
 	ret = clear_record_extent_bits(&inode->io_tree, 0, (u64)-1,
 			EXTENT_QGROUP_RESERVED, &changeset);
-- 
2.28.0

