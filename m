Return-Path: <linux-btrfs+bounces-15894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE12B1C4A5
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 13:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C683B740D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 11:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704B428B4E7;
	Wed,  6 Aug 2025 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGvoDO+3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0328A72E
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754478699; cv=none; b=A6i41XLt6lD27HljSauPfFDBLZ8MGUBNcbnp69D1wyUn1iy325dTS2UCLeYLqVWeEOwOzfnPFaGWtTzpPfeaf/wbYTIn16nb5yb0TyS9Q6pJNrCAouzttAYDrmWtD612UhKfOZ1s7mBH2OaitSpNjKj09Fv/K6t+Zm+eAuth67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754478699; c=relaxed/simple;
	bh=53O3IbNuhiDd5jMAVuV0pr+TJ0jTVOEBhvXj96lQGQk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7H/swIeR+ZPhDCDR9Ch0vfdrRwirWdIhQ15uVKAfgh7iu7dxD32RBsVfn0Ngunx4hMSxyjRW1mUd0IZEMksOM1OV2hA4tESJBmm5r5oZSqkizSH3JCzuYIe2kstmbJRRUdK+SEwFRZyvf8Tp1eUM9blcqXJ/qmt7gukiBCgXM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGvoDO+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB018C4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 11:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754478699;
	bh=53O3IbNuhiDd5jMAVuV0pr+TJ0jTVOEBhvXj96lQGQk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aGvoDO+3a6+80JORG+WMWqrcCs4qLV6sCPjwIqajO/bMLJkze7AaiXseWTnjjVjJN
	 EUhK2kLJSlEt7QfP6XPldMo9hV9aj/G3wI7z2TzSKW4HnYamcZPFkUhLXhKbAqg82u
	 /dSblgHq2QOG8o7FAG3h0r9uLJ+Q4MadRxI7FzX1PDVbn7IJj6fVrCIOc/vmqREUsv
	 ZHvGO+CRhF6sMYIzRAc3e8IhWOzQEt2nuxK7tVI/hnLHfxin8o5CGAbxileuONCf63
	 IP2nYWL5Lsfk86PzdtAeCkQRGQEpH6xAvqqBnlOjTO0vouOuhzG+toClms9XZ0Ee+Z
	 R6bRCtRkwjswA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: fix race between setting last_dir_index_offset and inode logging
Date: Wed,  6 Aug 2025 12:11:31 +0100
Message-ID: <08078ef730a0423eb6788d4db5a71de66924df77.1754432806.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1754432805.git.fdmanana@suse.com>
References: <cover.1754432805.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At inode_logged() if we find that the inode was not logged before we
update its ->last_dir_index_offset to (u64)-1 with the goal that the
next directory log operation will see the (u64)-1 and then figure out
it must check what was the index of the last logged dir index key and
update ->last_dir_index_offset to that key's offset (this is done in
update_last_dir_index_offset()).

This however has a possibility for a time window where a race can happen
and lead to directory logging skipping dir index keys that should be
logged. The race happens like this:

1) Task A calls inode_logged(), sees ->logged_trans as 0 and then checks
   that the inode item was logged before, but before it sets the inode's
   ->last_dir_index_offset to (u64)-1...

2) Task B is at btrfs_log_inode() which calls inode_logged() early, and
   that has set ->last_dir_index_offset to (u64)-1;

3) Task B then enters log_directory_changes() which calls
   update_last_dir_index_offset(). There it sees ->last_dir_index_offset
   is (u64)-1 and that the inode was logged before (ctx->logged_before is
   true), and so it searches for the last logged dir index key in the log
   tree and it finds that it has an offset (index) value of N, so it sets
   ->last_dir_index_offset to N, so that we can skip index keys that are
   less than or equal to N (later at process_dir_items_leaf());

4) Task A now sets ->last_dir_index_offset to (u64)-1, undoing the update
   that task B just did;

5) Task B will now skip every index key when it enters
   process_dir_items_leaf(), since ->last_dir_index_offset is (u64)-1.

Fix this by making inode_logged() not touch ->last_dir_index_offset and
initializing it to 0 when an inode is loaded (at btrfs_alloc_inode()) and
then having update_last_dir_index_offset() treat a value of 0 as meaning
we must check the log tree and update with the index of the last logged
index key. This is fine since the minimum possible value for
->last_dir_index_offset is 1 (BTRFS_DIR_START_INDEX - 1 = 2 - 1 = 1).
This also simplifies the management of ->last_dir_index_offset and now
all accesses to it are done under the inode's log_mutex.

Fixes: 0f8ce49821de ("btrfs: avoid inode logging during rename and link when possible")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/inode.c       |  1 +
 fs/btrfs/tree-log.c    | 17 ++---------------
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b99fb0273292..0387b9f43a52 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -248,7 +248,7 @@ struct btrfs_inode {
 		u64 new_delalloc_bytes;
 		/*
 		 * The offset of the last dir index key that was logged.
-		 * This is used only for directories.
+		 * This is used only for directories. Protected by 'log_mutex'.
 		 */
 		u64 last_dir_index_offset;
 	};
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 83e242bf42f3..096044eeb0ba 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7832,6 +7832,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->last_sub_trans = 0;
 	ei->logged_trans = 0;
 	ei->delalloc_bytes = 0;
+	/* new_delalloc_bytes and last_dir_index_offset are in a union. */
 	ei->new_delalloc_bytes = 0;
 	ei->defrag_bytes = 0;
 	ei->disk_i_size = 0;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 3d8090bc4b4e..9e12447f3e0e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3615,19 +3615,6 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
 	inode->logged_trans = trans->transid;
 	spin_unlock(&inode->lock);
 
-	/*
-	 * If it's a directory, then we must set last_dir_index_offset to the
-	 * maximum possible value, so that the next attempt to log the inode does
-	 * not skip checking if dir index keys found in modified subvolume tree
-	 * leaves have been logged before, otherwise it would result in attempts
-	 * to insert duplicate dir index keys in the log tree. This must be done
-	 * because last_dir_index_offset is an in-memory only field, not persisted
-	 * in the inode item or any other on-disk structure, so its value is lost
-	 * once the inode is evicted.
-	 */
-	if (S_ISDIR(inode->vfs_inode.i_mode))
-		inode->last_dir_index_offset = (u64)-1;
-
 	return 1;
 }
 
@@ -4218,7 +4205,7 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 
 /*
  * If the inode was logged before and it was evicted, then its
- * last_dir_index_offset is (u64)-1, so we don't the value of the last index
+ * last_dir_index_offset is 0, so we don't know the value of the last index
  * key offset. If that's the case, search for it and update the inode. This
  * is to avoid lookups in the log tree every time we try to insert a dir index
  * key from a leaf changed in the current transaction, and to allow us to always
@@ -4234,7 +4221,7 @@ static int update_last_dir_index_offset(struct btrfs_inode *inode,
 
 	lockdep_assert_held(&inode->log_mutex);
 
-	if (inode->last_dir_index_offset != (u64)-1)
+	if (inode->last_dir_index_offset != 0)
 		return 0;
 
 	if (!ctx->logged_before) {
-- 
2.47.2


