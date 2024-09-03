Return-Path: <linux-btrfs+bounces-7786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4F2969994
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 11:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D795E288AB9
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7F41A3ABA;
	Tue,  3 Sep 2024 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEzeiqCO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1274C1A0BC4
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357340; cv=none; b=f6CDIv1DqvNT5/fsc6vrb6fjEDe6CRRjCYhAB2UJSUxt2szXQK7wPsVEYG+3Xs8fHRf7UYehBYGIFqDs9BTqHOrZSMFjoqbm+COR7+LtUC+R+MdpZ6pL3DWXTyigvigsyZyKqtW1nU0WDak4LYLxP4XdGDQUoH8lXUFHnmRrXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357340; c=relaxed/simple;
	bh=gv5j5Iv6IzXO0/cpUZNYYZUqCTcviWcKkTBtfIwOVUQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=jxque7g9nBQUx91yoUcMHEkGPmNFitFJY+3WByWKphUwFkq1wyGHHoCzn5ukkGaGgCYtna5kB1HXobedSNOusxGiMqKVt6QsVcv8JycJCxaGJBFIj8HxW6dFEiMx5S3mctq83VqJMK7faJI/mmuDvlar0IT/xTkGQMgVXX1i8Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEzeiqCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10215C4CECA
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 09:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725357339;
	bh=gv5j5Iv6IzXO0/cpUZNYYZUqCTcviWcKkTBtfIwOVUQ=;
	h=From:To:Subject:Date:From;
	b=nEzeiqCOtiuUazvLKW1P6kwL2VLGf9l1zXIZJ7YX6s624dOcpJ3Q6bJSDoFks3YsP
	 irp0+WBSDhUl1A540N69pV2yCvhuVrGTypJ3iGFmOe0zOAucBMR02SeU2NjhozkpgP
	 73TKsC8+03n/OrPHHbIn7UV1QirsXmR3a5swHCHiv9bI4xkH4zRBeRF6pd8wr7Mqh8
	 8TQFCqinSl1/51zBsOFQBjNSTMcDHUBJyFD1Fq6uMIcJOD677Bqm2qPEkjptGR8ttV
	 iF/HnQeNAAgdd8KRxhQAcjTn9MDmlrmXzcJv7EE93Ii4DDffWMlj4MpB6rCTgm9TcU
	 GyW5Qjs7KucAA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix race setting file private on concurrent lseek using same fd
Date: Tue,  3 Sep 2024 10:55:36 +0100
Message-Id: <a351fd3b0397b6fe8d94f11a6744e1655349d687.1725356877.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When doing concurrent lseek(2) system calls against the same file
descriptor, using multiple threads belonging to the same process, we have
a short time window where a race happens and can result in a memory leak.

The race happens like this:

1) A program opens a file descriptor for a file and then spawns two
   threads (with the pthreads library for example), lets call them
   task A and task B;

2) Task A calls lseek with SEEK_DATA or SEEK_HOLE and ends up at
   file.c:find_desired_extent() while holding a read lock on the inode;

3) At the start of find_desired_extent(), it extracts the file's
   private_data pointer into a local variable named 'private', which has
   a value of NULL;

4) Task B also calls lseek with SEEK_DATA or SEEK_HOLE, locks the inode
   in shared mode and enters file.c:find_desired_extent(), where it also
   extracts file->private_data into its local variable 'private', which
   has a NULL value;

5) Because it saw a NULL file private, task A allocates a private
   structure and assigns to the file structure;

6) Task B also saw a NULL file private so it also allocates its own file
   private and then assigns it to the same file structure, since both
   tasks are using the same file descriptor.

   At this point we leak the private structure allocated by task A.

Besides the memory leak, there's also the detail that both tasks end up
using the same cached state record in the private structure (struct
btrfs_file_private::llseek_cached_state), which can result in a
use-after-free problem since one task can free it while the other is
still using it (only one task took a reference count on it). Also, sharing
the cached state is not a good idea since it could result in incorrect
results in the future - right now it should not be a problem because it
end ups being used only in extent-io-tree.c:count_range_bits() where we do
range validation before using the cached state.

Fix this by protecting the private assignment and check of a file while
holding the inode's spinlock and keep track of the task that allocated
the private, so that it's used only by that task in order to prevent
user-after-free issues with the cached state record as well as potentially
using it incorrectly in the future.

Fixes: 3c32c7212f16 ("btrfs: use cached state when looking for delalloc ranges with lseek")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h |  1 +
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/file.c        | 34 +++++++++++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 90e72031c724..5dbcc2ebf399 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -152,6 +152,7 @@ struct btrfs_inode {
 	 * logged_trans), to access/update delalloc_bytes, new_delalloc_bytes,
 	 * defrag_bytes, disk_i_size, outstanding_extents, csum_bytes and to
 	 * update the VFS' inode number of bytes used.
+	 * Also protects setting struct file::private_data.
 	 */
 	spinlock_t lock;
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c8568b1a61c4..18554f34f2d3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -459,6 +459,8 @@ struct btrfs_file_private {
 	void *filldir_buf;
 	u64 last_index;
 	struct extent_state *llseek_cached_state;
+	/* Task that allocated this structure. */
+	struct task_struct *owner_task;
 };
 
 static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c5e36f58eb07..4fb521d91b06 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3485,7 +3485,7 @@ static bool find_desired_extent_in_hole(struct btrfs_inode *inode, int whence,
 static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 {
 	struct btrfs_inode *inode = BTRFS_I(file->f_mapping->host);
-	struct btrfs_file_private *private = file->private_data;
+	struct btrfs_file_private *private;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_state *cached_state = NULL;
 	struct extent_state **delalloc_cached_state;
@@ -3513,7 +3513,19 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 	    inode_get_bytes(&inode->vfs_inode) == i_size)
 		return i_size;
 
-	if (!private) {
+	spin_lock(&inode->lock);
+	private = file->private_data;
+	spin_unlock(&inode->lock);
+
+	if (private && private->owner_task != current) {
+		/*
+		 * Not allocated by us, don't use it as its cached state is used
+		 * by the task that allocated it and we don't want neither to
+		 * mess with it nor get incorrect results because it reflects an
+		 * invalid state for the current task.
+		 */
+		private = NULL;
+	} else if (!private) {
 		private = kzalloc(sizeof(*private), GFP_KERNEL);
 		/*
 		 * No worries if memory allocation failed.
@@ -3521,7 +3533,23 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 		 * lseek SEEK_HOLE/DATA calls to a file when there's delalloc,
 		 * so everything will still be correct.
 		 */
-		file->private_data = private;
+		if (private) {
+			bool free = false;
+
+			private->owner_task = current;
+
+			spin_lock(&inode->lock);
+			if (file->private_data)
+				free = true;
+			else
+				file->private_data = private;
+			spin_unlock(&inode->lock);
+
+			if (free) {
+				kfree(private);
+				private = NULL;
+			}
+		}
 	}
 
 	if (private)
-- 
2.43.0


