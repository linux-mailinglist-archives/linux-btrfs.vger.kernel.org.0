Return-Path: <linux-btrfs+bounces-1788-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC2483C184
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 13:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DDE282864
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 12:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A004439A;
	Thu, 25 Jan 2024 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of8Lyigf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13A532182;
	Thu, 25 Jan 2024 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184009; cv=none; b=I+bSPUNVbB/5g0rR7dZtZc61qvT2AEKTZHMM9PCmsAucYr+/oTTZZJk4bKZWLFrIycGqaBO2WrHHDO7D+XBc528NYSN6+CWzsobGMMN+fpwUBK2NJdu+YpaSyU+ROwJiCIYOkjCDqZnGUVvrmg+HljjtXE5WZuJCcOOXSI3To6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184009; c=relaxed/simple;
	bh=kRNNqpW5ghYYKDPPbfEW8Kp1YKLwdICsvyoA7/Z0zKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tF18KFJrzav+fxQFH5hBxYaR/9X8dtUximzn1tzTXQP05s66jkIlmExCwm1Tos9mMu6d6mqO+7ntj7tCquuge1RZMJn5HBzbFczd5mHRCXVBFNn+x549Wxld+Ypy/JzoThRJY9wDUU8LCcONM+MM1ib3J69krVo8uK96TaZ8Na4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of8Lyigf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C630EC433C7;
	Thu, 25 Jan 2024 12:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706184009;
	bh=kRNNqpW5ghYYKDPPbfEW8Kp1YKLwdICsvyoA7/Z0zKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Of8LyigfKbNLuJ/RZMMti4fN5hUdyA7H1/2icvtYUqx5kX8pyUv6w5T3luq344+Ky
	 6nKmEnJZI+agOYJhYzvHywOXN3aaI2ykkxYRKE44jM7/eGrPRybckVvHiEeFIYHOZu
	 iH3vrIoPsyiB1bsTEuHocnLKSDHccYa1gU8KzzbHrKzMlYKRx8tQOB6EQzEDGHnpHZ
	 oliCWieqssY4NmClnbhGEK4NsjBqdr8Xh//gviDDD7/ebvIbyflZ6Sp82ynNqWxlcd
	 7UiWmVFUb0y94uN2FyrFr7Hqzn24V73S3TE9Hf91S4w1iAOmksMGT24wKpPi0PgozK
	 vBt669/bNk7GA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: erosca@de.adit-jv.com,
	Maksim.Paimushkin@se.bosch.com,
	Matthias.Thomae@de.bosch.com,
	Sebastian.Unger@bosch.com,
	Dirk.Behme@de.bosch.com,
	Eugeniu.Rosca@bosch.com,
	wqu@suse.com,
	dsterba@suse.com,
	stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Rob Landley <rob@landley.net>
Subject: [PATCH 1/4 for 5.15 stable] btrfs: fix infinite directory reads
Date: Thu, 25 Jan 2024 11:59:35 +0000
Message-Id: <f1e33797054fcea8b61d88878e67b8c007b5d5f5.1706183427.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706183427.git.fdmanana@suse.com>
References: <cover.1706183427.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

commit 9b378f6ad48cfa195ed868db9123c09ee7ec5ea2 upstream.

The readdir implementation currently processes always up to the last index
it finds. This however can result in an infinite loop if the directory has
a large number of entries such that they won't all fit in the given buffer
passed to the readdir callback, that is, dir_emit() returns a non-zero
value. Because in that case readdir() will be called again and if in the
meanwhile new directory entries were added and we still can't put all the
remaining entries in the buffer, we keep repeating this over and over.

The following C program and test script reproduce the problem:

  $ cat /mnt/readdir_prog.c
  #include <sys/types.h>
  #include <dirent.h>
  #include <stdio.h>

  int main(int argc, char *argv[])
  {
    DIR *dir = opendir(".");
    struct dirent *dd;

    while ((dd = readdir(dir))) {
      printf("%s\n", dd->d_name);
      rename(dd->d_name, "TEMPFILE");
      rename("TEMPFILE", dd->d_name);
    }
    closedir(dir);
  }

  $ gcc -o /mnt/readdir_prog /mnt/readdir_prog.c

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/sdi
  MNT=/mnt/sdi

  mkfs.btrfs -f $DEV &> /dev/null
  #mkfs.xfs -f $DEV &> /dev/null
  #mkfs.ext4 -F $DEV &> /dev/null

  mount $DEV $MNT

  mkdir $MNT/testdir
  for ((i = 1; i <= 2000; i++)); do
      echo -n > $MNT/testdir/file_$i
  done

  cd $MNT/testdir
  /mnt/readdir_prog

  cd /mnt

  umount $MNT

This behaviour is surprising to applications and it's unlike ext4, xfs,
tmpfs, vfat and other filesystems, which always finish. In this case where
new entries were added due to renames, some file names may be reported
more than once, but this varies according to each filesystem - for example
ext4 never reported the same file more than once while xfs reports the
first 13 file names twice.

So change our readdir implementation to track the last index number when
opendir() is called and then make readdir() never process beyond that
index number. This gives the same behaviour as ext4.

Reported-by: Rob Landley <rob@landley.net>
Link: https://lore.kernel.org/linux-btrfs/2c8c55ec-04c6-e0dc-9c5c-8c7924778c35@landley.net/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217681
CC: stable@vger.kernel.org # 5.15
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ Resolve a conflict due to member changes in 96d89923fa94 ]
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h         |   1 +
 fs/btrfs/delayed-inode.c |   5 +-
 fs/btrfs/delayed-inode.h |   1 +
 fs/btrfs/inode.c         | 131 +++++++++++++++++++++++----------------
 4 files changed, 84 insertions(+), 54 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1467bf439cb4..7905f178efa3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1361,6 +1361,7 @@ struct btrfs_drop_extents_args {
 
 struct btrfs_file_private {
 	void *filldir_buf;
+	u64 last_index;
 };
 
 
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index fd951aeaeac5..5a98c5da1225 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1513,6 +1513,7 @@ int btrfs_inode_delayed_dir_index_count(struct btrfs_inode *inode)
 }
 
 bool btrfs_readdir_get_delayed_items(struct inode *inode,
+				     u64 last_index,
 				     struct list_head *ins_list,
 				     struct list_head *del_list)
 {
@@ -1532,14 +1533,14 @@ bool btrfs_readdir_get_delayed_items(struct inode *inode,
 
 	mutex_lock(&delayed_node->mutex);
 	item = __btrfs_first_delayed_insertion_item(delayed_node);
-	while (item) {
+	while (item && item->key.offset <= last_index) {
 		refcount_inc(&item->refs);
 		list_add_tail(&item->readdir_list, ins_list);
 		item = __btrfs_next_delayed_item(item);
 	}
 
 	item = __btrfs_first_delayed_deletion_item(delayed_node);
-	while (item) {
+	while (item && item->key.offset <= last_index) {
 		refcount_inc(&item->refs);
 		list_add_tail(&item->readdir_list, del_list);
 		item = __btrfs_next_delayed_item(item);
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index b2412160c5bc..a9cfce856d2e 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -123,6 +123,7 @@ void btrfs_destroy_delayed_inodes(struct btrfs_fs_info *fs_info);
 
 /* Used for readdir() */
 bool btrfs_readdir_get_delayed_items(struct inode *inode,
+				     u64 last_index,
 				     struct list_head *ins_list,
 				     struct list_head *del_list);
 void btrfs_readdir_put_delayed_items(struct inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 95af29634e55..1df374ce829b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6121,6 +6121,74 @@ static struct dentry *btrfs_lookup(struct inode *dir, struct dentry *dentry,
 	return d_splice_alias(inode, dentry);
 }
 
+/*
+ * Find the highest existing sequence number in a directory and then set the
+ * in-memory index_cnt variable to the first free sequence number.
+ */
+static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
+{
+	struct btrfs_root *root = inode->root;
+	struct btrfs_key key, found_key;
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	int ret;
+
+	key.objectid = btrfs_ino(inode);
+	key.type = BTRFS_DIR_INDEX_KEY;
+	key.offset = (u64)-1;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret < 0)
+		goto out;
+	/* FIXME: we should be able to handle this */
+	if (ret == 0)
+		goto out;
+	ret = 0;
+
+	if (path->slots[0] == 0) {
+		inode->index_cnt = BTRFS_DIR_START_INDEX;
+		goto out;
+	}
+
+	path->slots[0]--;
+
+	leaf = path->nodes[0];
+	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+
+	if (found_key.objectid != btrfs_ino(inode) ||
+	    found_key.type != BTRFS_DIR_INDEX_KEY) {
+		inode->index_cnt = BTRFS_DIR_START_INDEX;
+		goto out;
+	}
+
+	inode->index_cnt = found_key.offset + 1;
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
+static int btrfs_get_dir_last_index(struct btrfs_inode *dir, u64 *index)
+{
+	if (dir->index_cnt == (u64)-1) {
+		int ret;
+
+		ret = btrfs_inode_delayed_dir_index_count(dir);
+		if (ret) {
+			ret = btrfs_set_inode_index_count(dir);
+			if (ret)
+				return ret;
+		}
+	}
+
+	*index = dir->index_cnt;
+
+	return 0;
+}
+
 /*
  * All this infrastructure exists because dir_emit can fault, and we are holding
  * the tree lock when doing readdir.  For now just allocate a buffer and copy
@@ -6133,10 +6201,17 @@ static struct dentry *btrfs_lookup(struct inode *dir, struct dentry *dentry,
 static int btrfs_opendir(struct inode *inode, struct file *file)
 {
 	struct btrfs_file_private *private;
+	u64 last_index;
+	int ret;
+
+	ret = btrfs_get_dir_last_index(BTRFS_I(inode), &last_index);
+	if (ret)
+		return ret;
 
 	private = kzalloc(sizeof(struct btrfs_file_private), GFP_KERNEL);
 	if (!private)
 		return -ENOMEM;
+	private->last_index = last_index;
 	private->filldir_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!private->filldir_buf) {
 		kfree(private);
@@ -6205,7 +6280,8 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 
 	INIT_LIST_HEAD(&ins_list);
 	INIT_LIST_HEAD(&del_list);
-	put = btrfs_readdir_get_delayed_items(inode, &ins_list, &del_list);
+	put = btrfs_readdir_get_delayed_items(inode, private->last_index,
+					      &ins_list, &del_list);
 
 again:
 	key.type = BTRFS_DIR_INDEX_KEY;
@@ -6238,6 +6314,8 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 			break;
 		if (found_key.offset < ctx->pos)
 			goto next;
+		if (found_key.offset > private->last_index)
+			break;
 		if (btrfs_should_delete_dir_index(&del_list, found_key.offset))
 			goto next;
 		di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
@@ -6371,57 +6449,6 @@ static int btrfs_update_time(struct inode *inode, struct timespec64 *now,
 	return dirty ? btrfs_dirty_inode(inode) : 0;
 }
 
-/*
- * find the highest existing sequence number in a directory
- * and then set the in-memory index_cnt variable to reflect
- * free sequence numbers
- */
-static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
-{
-	struct btrfs_root *root = inode->root;
-	struct btrfs_key key, found_key;
-	struct btrfs_path *path;
-	struct extent_buffer *leaf;
-	int ret;
-
-	key.objectid = btrfs_ino(inode);
-	key.type = BTRFS_DIR_INDEX_KEY;
-	key.offset = (u64)-1;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-	/* FIXME: we should be able to handle this */
-	if (ret == 0)
-		goto out;
-	ret = 0;
-
-	if (path->slots[0] == 0) {
-		inode->index_cnt = BTRFS_DIR_START_INDEX;
-		goto out;
-	}
-
-	path->slots[0]--;
-
-	leaf = path->nodes[0];
-	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
-
-	if (found_key.objectid != btrfs_ino(inode) ||
-	    found_key.type != BTRFS_DIR_INDEX_KEY) {
-		inode->index_cnt = BTRFS_DIR_START_INDEX;
-		goto out;
-	}
-
-	inode->index_cnt = found_key.offset + 1;
-out:
-	btrfs_free_path(path);
-	return ret;
-}
-
 /*
  * helper to find a free sequence number in a given directory.  This current
  * code is very simple, later versions will do smarter things in the btree
-- 
2.40.1


