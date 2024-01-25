Return-Path: <linux-btrfs+bounces-1766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495DA83B877
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 04:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99947282DFF
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 03:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6D47468;
	Thu, 25 Jan 2024 03:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KZSpdUbd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KZSpdUbd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318B96FC3;
	Thu, 25 Jan 2024 03:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706154439; cv=none; b=jyDhDurOnvw1nAtSagHjtV5fdQIyRJ7L8dY/PeIv8cAvm7HoZVyBTmrgD72zTejf6D3OpAANWzJ62FkzyS8EUAB4IK0ysdQp7v7wjhiMQnLKx61eRvEVlPmhqmZEPlmXnoob8XGXstdkgnt0T9JSnkLFjh6A+yFUunfpgR/7JfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706154439; c=relaxed/simple;
	bh=ItfcFV4lAjodsLSvWy5md0uBbYfE4D4+Al2/A2nqN4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kEDk0o23pUpnlR/jkO7UKM19pSWCgOQPLz8JwhO3mmkiD3nQ5yvRVfNPm1UVYOyO5+IlkKS3XizhrE6pZO2gEDtstEK5SNQV4+lmdpXmwXYT1cGPhqE4nkVv73r/PNIlQUzD6uhFgVHERqyKzm3kNYdU7ZJlCZXqYJOLj3bPD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KZSpdUbd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KZSpdUbd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 135A722186;
	Thu, 25 Jan 2024 03:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706154434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZYk4foKn3G8gH44lEqEI0zxVrgwJtGTA+PXfCJMbgp4=;
	b=KZSpdUbdhc3XaH5yJCMaskyTZ1Ps7rwTOrcCydqCaTX4qOXtpk+cFj5CAgZRZQy1CZGyOT
	CmTr8Sv99gkTHEOuCDh7ogHbvEeMlOt1h86PIPYpMvn663igEhki29MneX4KThU7hsSFh2
	XVWBT/90gLWF9WoU4D2xEgP1gqjc8fQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706154434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZYk4foKn3G8gH44lEqEI0zxVrgwJtGTA+PXfCJMbgp4=;
	b=KZSpdUbdhc3XaH5yJCMaskyTZ1Ps7rwTOrcCydqCaTX4qOXtpk+cFj5CAgZRZQy1CZGyOT
	CmTr8Sv99gkTHEOuCDh7ogHbvEeMlOt1h86PIPYpMvn663igEhki29MneX4KThU7hsSFh2
	XVWBT/90gLWF9WoU4D2xEgP1gqjc8fQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A74F213786;
	Thu, 25 Jan 2024 03:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GUGAGb/ZsWUJWwAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 25 Jan 2024 03:47:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	erosca@de.adit-jv.com
Cc: Filipe Manana <fdmanana@suse.com>,
	Rob Landley <rob@landley.net>,
	stable@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 5.15] btrfs: fix infinite directory reads
Date: Thu, 25 Jan 2024 14:17:08 +1030
Message-ID: <88ce65d61253e3474635c589a7de9e668108462e.1706153625.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=KZSpdUbd
X-Spamd-Result: default: False [-0.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.81
X-Rspamd-Queue-Id: 135A722186
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit b4c639f699349880b7918b861e1bd360442ec450 ]

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
---
Initially I tried to backport all the needed dependency to v5.15, but it
turns out to be a disaster, at least 3 large rework series are needed,
and the deeper I dig, more dependency series came up.

So this version is a manual backport, the conflicts are caused by two
missing dependency:

- 96d89923fa94 ("btrfs: store index number instead of key in struct btrfs_delayed_item")
  This changes btrfs_delayed_item::key to index, which saves some space.
  Thankfully the new @index member is just the same as @key.offset.

- 3c32c7212f16 ("btrfs: use cached state when looking for delalloc ranges with lseek")
  This belongs to the series "[PATCH 0/9] btrfs: more optimizations for
  lseek and fiemap", thankfully the conflicting member is only utilized
  by the optimizations, we can go without that member.

And if I dig deeper with every conflict, at least the following series
are needed to be backported:

- [PATCH 0/9] btrfs: more optimizations for lseek and fiemap
- [PATCH v2 00/15] btrfs: some updates to delayed items and inode logging
- [PATCH v2 00/16] btrfs: inode creation cleanups and fixes

At this stage, a full backport with all those needed dependency looks
impractical.
Thus a manual backport is created, so far the fstests result looks fine
and generic/736 (the reproducer inspired by the bug report) passes.

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
2.43.0


