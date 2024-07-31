Return-Path: <linux-btrfs+bounces-6908-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8D8942B07
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 11:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9421F21327
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 09:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8361AC45C;
	Wed, 31 Jul 2024 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OM66Gx6u";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OM66Gx6u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB1143169
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418754; cv=none; b=DsJmPwHs3wiynOpHYLyvdGwhMNJF1teWKvhrNA+r88x2Em8z9biFi7k1qgm47Z6IxN0OE1pwZi9ZZvgcw2+dM1CmTbW8F0rzASa+zf7sJhD7jwVJ1kkrybuG68fscQIrtbYU2gk6igiHc6/E8DLbWJPDwD1ZV+n7uv8gO7yxU84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418754; c=relaxed/simple;
	bh=un3zqsxj2ydd9/SLkq7MoZ5jHV2t6FEEmC+mxXczxaY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBzY54hd/nVkS5YmfMxCbhDuZQkpCJNS5RY6cKs+SsuuwxISr6vp09ddZhl9OVPyFpIBYaEKeO8WoRFtsmaXVct06tcGHg2Mi8yxO8R4WN9cEjsfYfHOqISnI6iVvf9caxZKINJGetBlNqPn6rw7I6D4n/ZjVvSHpaqkvCMYaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OM66Gx6u; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OM66Gx6u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5AA621F83A
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 09:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722418750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fs4vVCTNRwTsxyn/5X5HJq7CWqxfkxKdKvCotyj6zsY=;
	b=OM66Gx6uSBvoGwNIWFkgs2wqeN1hOHdCE9LuW25lTrSjamgTaNfLoD/K7MzrH/nkeFVsDO
	lqmJgFN79+aVzEa2+qsqy0mvDwktS8xHje8xDm8c+bDpdb1QKGvqWy/t/M49+CelogR2Vt
	ZHLsY0j4f3cYO9/mEjz4YzdyfDOiBJ0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722418750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fs4vVCTNRwTsxyn/5X5HJq7CWqxfkxKdKvCotyj6zsY=;
	b=OM66Gx6uSBvoGwNIWFkgs2wqeN1hOHdCE9LuW25lTrSjamgTaNfLoD/K7MzrH/nkeFVsDO
	lqmJgFN79+aVzEa2+qsqy0mvDwktS8xHje8xDm8c+bDpdb1QKGvqWy/t/M49+CelogR2Vt
	ZHLsY0j4f3cYO9/mEjz4YzdyfDOiBJ0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A2491368F
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 09:39:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qAcwOTwGqmZgHgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 09:39:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: mkfs: rework how we traverse rootdir
Date: Wed, 31 Jul 2024 19:08:47 +0930
Message-ID: <667ee4f02fdc2cb6f186eb8b06dd089f3ce53141.1722418505.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722418505.git.wqu@suse.com>
References: <cover.1722418505.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

There are several hidden pitfalls of the existing traverse_directory():

- Hand written preorder traversal
  Meanwhile there is already a better written standard library function,
  nftw() doing exactly what we need.

- Over-designed path list
  To properly handle the directory change, we have structure
  directory_name_entry, to record every inode until rootdir.

  But it has two string members, dir_name and path, which is a little
  overkilled.
  As for preorder traversal, we will never need to read the parent's
  filename, just its inode number.

  And it's exported while no one utilizes it out of mkfs/rootdir.c.

- Weird inode numbers
  We use the inode number from st->st_ino, with an extra offset.
  This by itself is not safe, if the rootdir has child directory in
  another filesystem.

  And this results very weird inode numbers, e.g:

	item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
	item 6 key (88347519 INODE_ITEM 0) itemoff 15815 itemsize 160
	item 16 key (88347520 INODE_ITEM 0) itemoff 15363 itemsize 160
	item 20 key (88347521 INODE_ITEM 0) itemoff 15119 itemsize 160
	item 24 key (88347522 INODE_ITEM 0) itemoff 14875 itemsize 160
	item 26 key (88347523 INODE_ITEM 0) itemoff 14700 itemsize 160
	item 28 key (88347524 INODE_ITEM 0) itemoff 14525 itemsize 160
	item 30 key (88347557 INODE_ITEM 0) itemoff 14350 itemsize 160
	item 32 key (88347566 INODE_ITEM 0) itemoff 14175 itemsize 160

  Which is far from a regular fs created by copying the data.

- Weird directory inode size calculation
  Unlike kernel, which updated the directory inode size every time new
  child inodes are added, we calculate the directory inode size by
  searching all its children first, then later new inodes linked to this
  directory won't touch the inode size.

Enhance all these points by:

- Use nftw() to do the preorder traversal
  It also provides the extra level detection, which is pretty handy.

- Use a simple local inode_entry to record each parent
  The only value is a u64 to record the inode number.
  And one simple rootdir_path structure to record the list of
  inode_entry, alone with the current level.

  This rootdir_path structure along with two helpers,
  rootdir_path_push() and rootdir_path_pop(), along with the
  preorder traversal provided by nftw(), are enough for us to record
  all the parent directories until the rootdir.

- Grab new inode number properly
  Just call btrfs_get_free_objectid() to grab a proper inode number,
  other than using some weird calculated value.

- Use btrfs_insert_inode() and btrfs_add_link() to update directory
  inode automatically

With all the refactor, the code is shorter and easier to read.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/rootdir.c | 664 +++++++++++++++++++------------------------------
 mkfs/rootdir.h |   8 -
 2 files changed, 257 insertions(+), 415 deletions(-)

diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 2b39f6bb21fe..d8bd2ce29d5a 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -38,15 +38,12 @@
 #include "kernel-shared/file-item.h"
 #include "common/internal.h"
 #include "common/messages.h"
-#include "common/path-utils.h"
 #include "common/utils.h"
 #include "common/extent-tree-utils.h"
 #include "mkfs/rootdir.h"
 
 static u32 fs_block_size;
 
-static u64 index_cnt = 2;
-
 /*
  * Size estimate will be done using the following data:
  * 1) Number of inodes
@@ -63,169 +60,91 @@ static u64 index_cnt = 2;
 static u64 ftw_meta_nr_inode;
 static u64 ftw_data_size;
 
-static int add_directory_items(struct btrfs_trans_handle *trans,
-			       struct btrfs_root *root, u64 objectid,
-			       ino_t parent_inum, const char *name,
-			       struct stat *st, int *dir_index_cnt)
+/*
+ * Represent one inode inside the path.
+ *
+ * For now, all those inodes are inside fs tree.
+ */
+struct inode_entry {
+	/* The inode number inside btrfs. */
+	u64 ino;
+	struct list_head list;
+};
+
+/*
+ * The path towards the rootdir.
+ *
+ * Only directory inodes are stored inside the path.
+ */
+struct rootdir_path {
+	/*
+	 * Level 0 means it's the rootdir itself.
+	 * Level -1 means it's uninitlized.
+	 */
+	int level;
+
+	struct list_head inode_list;
+} current_path = {
+	.level = -1,
+};
+
+struct btrfs_trans_handle *g_trans = NULL;
+
+static inline struct inode_entry *rootdir_path_last(struct rootdir_path *path)
 {
-	int ret;
-	int name_len;
-	struct btrfs_key location;
-	u8 filetype = 0;
+	UASSERT(!list_empty(&path->inode_list));
 
-	name_len = strlen(name);
-
-	location.objectid = objectid;
-	location.type = BTRFS_INODE_ITEM_KEY;
-	location.offset = 0;
-
-	if (S_ISDIR(st->st_mode))
-		filetype = BTRFS_FT_DIR;
-	if (S_ISREG(st->st_mode))
-		filetype = BTRFS_FT_REG_FILE;
-	if (S_ISLNK(st->st_mode))
-		filetype = BTRFS_FT_SYMLINK;
-	if (S_ISSOCK(st->st_mode))
-		filetype = BTRFS_FT_SOCK;
-	if (S_ISCHR(st->st_mode))
-		filetype = BTRFS_FT_CHRDEV;
-	if (S_ISBLK(st->st_mode))
-		filetype = BTRFS_FT_BLKDEV;
-	if (S_ISFIFO(st->st_mode))
-		filetype = BTRFS_FT_FIFO;
-
-	ret = btrfs_insert_dir_item(trans, root, name, name_len,
-				    parent_inum, &location,
-				    filetype, index_cnt);
-	if (ret)
-		return ret;
-	ret = btrfs_insert_inode_ref(trans, root, name, name_len,
-				     objectid, parent_inum, index_cnt);
-	*dir_index_cnt = index_cnt;
-	index_cnt++;
-
-	return ret;
+	return list_entry(path->inode_list.prev, struct inode_entry, list);
 }
 
-static int fill_inode_item(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root,
-			   struct btrfs_inode_item *dst, struct stat *src)
+static void rootdir_path_pop(struct rootdir_path *path)
 {
-	u64 blocks = 0;
-	u64 sectorsize = root->fs_info->sectorsize;
+	struct inode_entry *last;
+	UASSERT(path->level >= 0);
 
-	/*
-	 * btrfs_inode_item has some reserved fields
-	 * and represents on-disk inode entry, so
-	 * zero everything to prevent information leak
-	 */
-	memset(dst, 0, sizeof(*dst));
+	last = rootdir_path_last(path);
+	list_del_init(&last->list);
+	path->level--;
+	free(last);
+}
 
-	btrfs_set_stack_inode_generation(dst, trans->transid);
-	btrfs_set_stack_inode_size(dst, src->st_size);
-	btrfs_set_stack_inode_nbytes(dst, 0);
-	btrfs_set_stack_inode_block_group(dst, 0);
-	btrfs_set_stack_inode_nlink(dst, src->st_nlink);
-	btrfs_set_stack_inode_uid(dst, src->st_uid);
-	btrfs_set_stack_inode_gid(dst, src->st_gid);
-	btrfs_set_stack_inode_mode(dst, src->st_mode);
-	btrfs_set_stack_inode_rdev(dst, 0);
-	btrfs_set_stack_inode_flags(dst, 0);
-	btrfs_set_stack_timespec_sec(&dst->atime, src->st_atime);
-	btrfs_set_stack_timespec_nsec(&dst->atime, 0);
-	btrfs_set_stack_timespec_sec(&dst->ctime, src->st_ctime);
-	btrfs_set_stack_timespec_nsec(&dst->ctime, 0);
-	btrfs_set_stack_timespec_sec(&dst->mtime, src->st_mtime);
-	btrfs_set_stack_timespec_nsec(&dst->mtime, 0);
-	btrfs_set_stack_timespec_sec(&dst->otime, 0);
-	btrfs_set_stack_timespec_nsec(&dst->otime, 0);
-
-	if (S_ISDIR(src->st_mode)) {
-		btrfs_set_stack_inode_size(dst, 0);
-		btrfs_set_stack_inode_nlink(dst, 1);
-	}
-	if (S_ISREG(src->st_mode)) {
-		btrfs_set_stack_inode_size(dst, (u64)src->st_size);
-		if (src->st_size <= BTRFS_MAX_INLINE_DATA_SIZE(root->fs_info) &&
-		    src->st_size < sectorsize)
-			btrfs_set_stack_inode_nbytes(dst, src->st_size);
-		else {
-			blocks = src->st_size / sectorsize;
-			if (src->st_size % sectorsize)
-				blocks += 1;
-			blocks *= sectorsize;
-			btrfs_set_stack_inode_nbytes(dst, blocks);
-		}
-	}
-	if (S_ISLNK(src->st_mode))
-		btrfs_set_stack_inode_nbytes(dst, src->st_size + 1);
+static int rootdir_path_push(struct rootdir_path *path, u64 ino)
+{
+	struct inode_entry *new;
 
+	new = malloc(sizeof(*new));
+	if (!new)
+		return -ENOMEM;
+	new->ino = ino;
+	list_add_tail(&new->list, &path->inode_list);
+	path->level++;
 	return 0;
 }
 
-static int directory_select(const struct dirent *entry)
+
+static void stat_to_inode_item(struct btrfs_inode_item *dst, const struct stat *st)
 {
-	if (entry->d_name[0] == '.' &&
-		(entry->d_name[1] == 0 ||
-		 (entry->d_name[1] == '.' && entry->d_name[2] == 0)))
-		return 0;
-	return 1;
-}
-
-static void free_namelist(struct dirent **files, int count)
-{
-	int i;
-
-	if (count < 0)
-		return;
-
-	for (i = 0; i < count; ++i)
-		free(files[i]);
-	free(files);
-}
-
-static u64 calculate_dir_inode_size(const char *dirname)
-{
-	int count, i;
-	struct dirent **files, *cur_file;
-	u64 dir_inode_size = 0;
-
-	count = scandir(dirname, &files, directory_select, NULL);
-
-	for (i = 0; i < count; i++) {
-		cur_file = files[i];
-		dir_inode_size += strlen(cur_file->d_name);
-	}
-
-	free_namelist(files, count);
-
-	dir_inode_size *= 2;
-	return dir_inode_size;
-}
-
-static int add_inode_items(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root,
-			   struct stat *st, const char *name,
-			   u64 self_objectid,
-			   struct btrfs_inode_item *inode_ret)
-{
-	int ret;
-	struct btrfs_inode_item btrfs_inode;
-	u64 objectid;
-	u64 inode_size = 0;
-
-	fill_inode_item(trans, root, &btrfs_inode, st);
-	objectid = self_objectid;
-
-	if (S_ISDIR(st->st_mode)) {
-		inode_size = calculate_dir_inode_size(name);
-		btrfs_set_stack_inode_size(&btrfs_inode, inode_size);
-	}
-
-	ret = btrfs_insert_inode(trans, root, objectid, &btrfs_inode);
-
-	*inode_ret = btrfs_inode;
-	return ret;
+	/*
+	 * Do not touch size for directory inode, the size would be
+	 * automatically updated during btrfs_link_inode().
+	 */
+	if (!S_ISDIR(st->st_mode))
+		btrfs_set_stack_inode_size(dst, st->st_size);
+	btrfs_set_stack_inode_nbytes(dst, 0);
+	btrfs_set_stack_inode_block_group(dst, 0);
+	btrfs_set_stack_inode_uid(dst, st->st_uid);
+	btrfs_set_stack_inode_gid(dst, st->st_gid);
+	btrfs_set_stack_inode_mode(dst, st->st_mode);
+	btrfs_set_stack_inode_rdev(dst, 0);
+	btrfs_set_stack_inode_flags(dst, 0);
+	btrfs_set_stack_timespec_sec(&dst->atime, st->st_atime);
+	btrfs_set_stack_timespec_nsec(&dst->atime, 0);
+	btrfs_set_stack_timespec_sec(&dst->ctime, st->st_ctime);
+	btrfs_set_stack_timespec_nsec(&dst->ctime, 0);
+	btrfs_set_stack_timespec_sec(&dst->mtime, st->st_mtime);
+	btrfs_set_stack_timespec_nsec(&dst->mtime, 0);
+	btrfs_set_stack_timespec_sec(&dst->otime, 0);
+	btrfs_set_stack_timespec_nsec(&dst->otime, 0);
 }
 
 static int add_xattr_item(struct btrfs_trans_handle *trans,
@@ -280,8 +199,10 @@ static int add_xattr_item(struct btrfs_trans_handle *trans,
 
 static int add_symbolic_link(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
+			     struct btrfs_inode_item *inode_item,
 			     u64 objectid, const char *path_name)
 {
+	u64 nbytes;
 	int ret;
 	char buf[PATH_MAX];
 
@@ -297,8 +218,16 @@ static int add_symbolic_link(struct btrfs_trans_handle *trans,
 	}
 
 	buf[ret] = '\0'; /* readlink does not do it for us */
+	nbytes = ret + 1;
 	ret = btrfs_insert_inline_extent(trans, root, objectid, 0,
-					 buf, ret + 1);
+					 buf, nbytes);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to insert inline extent for %s: %m",
+			path_name);
+		goto fail;
+	}
+	btrfs_set_stack_inode_nbytes(inode_item, nbytes);
 fail:
 	return ret;
 }
@@ -306,7 +235,7 @@ fail:
 static int add_file_items(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root,
 			  struct btrfs_inode_item *btrfs_inode, u64 objectid,
-			  struct stat *st, const char *path_name)
+			  const struct stat *st, const char *path_name)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int ret = -1;
@@ -355,6 +284,8 @@ static int add_file_items(struct btrfs_trans_handle *trans,
 		ret = btrfs_insert_inline_extent(trans, root, objectid, 0,
 						 buffer, st->st_size);
 		free(buffer);
+		/* Update the inode nbytes for inline extents. */
+		btrfs_set_stack_inode_nbytes(btrfs_inode, st->st_size);
 		goto end;
 	}
 
@@ -429,264 +360,199 @@ end:
 	return ret;
 }
 
-static int copy_rootdir_inode(struct btrfs_trans_handle *trans,
-			      struct btrfs_root *root, const char *dir_name)
+static int update_inode_item(struct btrfs_trans_handle *trans,
+			     struct btrfs_root *root,
+			     const struct btrfs_inode_item *inode_item,
+			     u64 ino)
 {
-	u64 root_dir_inode_size;
-	struct btrfs_inode_item *inode_item;
 	struct btrfs_path path = { 0 };
-	struct btrfs_key key;
-	struct extent_buffer *leaf;
-	struct stat st;
+	struct btrfs_key key = {
+		.objectid = ino,
+		.type = BTRFS_INODE_ITEM_KEY,
+		.offset = 0,
+	};
+	u32 item_ptr_off;
 	int ret;
 
-	ret = stat(dir_name, &st);
-	if (ret < 0) {
-		ret = -errno;
-		error("stat failed for directory %s: %m", dir_name);
-		return ret;
-	}
-
-	ret = add_xattr_item(trans, root, btrfs_root_dirid(&root->root_item), dir_name);
-	if (ret < 0) {
-		errno = -ret;
-		error("failed to add xattr item for the top level inode: %m");
-		return ret;
-	}
-
-	key.objectid = btrfs_root_dirid(&root->root_item);
-	key.type = BTRFS_INODE_ITEM_KEY;
-	key.offset = 0;
 	ret = btrfs_lookup_inode(trans, root, &path, &key, 1);
 	if (ret > 0)
 		ret = -ENOENT;
-	if (ret) {
-		error("failed to lookup root dir: %d", ret);
-		goto error;
+	if (ret < 0) {
+		btrfs_release_path(&path);
+		return ret;
 	}
-
-	leaf = path.nodes[0];
-	inode_item = btrfs_item_ptr(leaf, path.slots[0], struct btrfs_inode_item);
-
-	root_dir_inode_size = calculate_dir_inode_size(dir_name);
-	btrfs_set_inode_size(leaf, inode_item, root_dir_inode_size);
-
-	/* Unlike fill_inode_item, we only need to copy part of the attributes. */
-	btrfs_set_inode_uid(leaf, inode_item, st.st_uid);
-	btrfs_set_inode_gid(leaf, inode_item, st.st_gid);
-	btrfs_set_inode_mode(leaf, inode_item, st.st_mode);
-	btrfs_set_timespec_sec(leaf, &inode_item->atime, st.st_atime);
-	btrfs_set_timespec_nsec(leaf, &inode_item->atime, 0);
-	btrfs_set_timespec_sec(leaf, &inode_item->ctime, st.st_ctime);
-	btrfs_set_timespec_nsec(leaf, &inode_item->ctime, 0);
-	btrfs_set_timespec_sec(leaf, &inode_item->mtime, st.st_mtime);
-	btrfs_set_timespec_nsec(leaf, &inode_item->mtime, 0);
-	/* FIXME */
-	btrfs_set_timespec_sec(leaf, &inode_item->otime, 0);
-	btrfs_set_timespec_nsec(leaf, &inode_item->otime, 0);
-	btrfs_mark_buffer_dirty(leaf);
-
-error:
+	item_ptr_off = btrfs_item_ptr_offset(path.nodes[0], path.slots[0]);
+	write_extent_buffer(path.nodes[0], inode_item, item_ptr_off, sizeof(*inode_item));
+	btrfs_mark_buffer_dirty(path.nodes[0]);
 	btrfs_release_path(&path);
-	return ret;
+	return 0;
 }
 
-static int traverse_directory(struct btrfs_trans_handle *trans,
-			      struct btrfs_root *root, const char *dir_name,
-			      struct directory_name_entry *dir_head)
+static u8 ftype_to_btrfs_type(mode_t ftype)
 {
-	int ret = 0;
+	if (S_ISREG(ftype))
+		return BTRFS_FT_REG_FILE;
+	if (S_ISDIR(ftype))
+		return BTRFS_FT_DIR;
+	if (S_ISLNK(ftype))
+		return BTRFS_FT_SYMLINK;
+	if (S_ISCHR(ftype))
+		return BTRFS_FT_CHRDEV;
+	if (S_ISBLK(ftype))
+		return BTRFS_FT_BLKDEV;
+	if (S_ISFIFO(ftype))
+		return BTRFS_FT_FIFO;
+	if (S_ISSOCK(ftype))
+		return BTRFS_FT_SOCK;
+	return BTRFS_FT_UNKNOWN;
 
-	struct btrfs_inode_item cur_inode;
-	int count, i, dir_index_cnt;
-	struct dirent **files;
-	struct stat st;
-	struct directory_name_entry *dir_entry, *parent_dir_entry;
-	struct dirent *cur_file;
-	ino_t parent_inum, cur_inum;
-	ino_t highest_inum = 0;
-	const char *parent_dir_name;
+}
 
-	/* Add list for source directory */
-	dir_entry = malloc(sizeof(struct directory_name_entry));
-	if (!dir_entry)
-		return -ENOMEM;
-	dir_entry->dir_name = dir_name;
-	dir_entry->path = realpath(dir_name, NULL);
-	if (!dir_entry->path) {
-		error("realpath failed for %s: %m", dir_name);
-		ret = -1;
-		goto fail_no_dir;
+static int ftw_add_inode(const char *full_path, const struct stat *st,
+			 int typeflag, struct FTW *ftwbuf)
+{
+	struct btrfs_fs_info *fs_info = g_trans->fs_info;
+	struct btrfs_root *root = fs_info->fs_root;
+	struct btrfs_inode_item inode_item = { 0 };
+	struct inode_entry *parent;
+	u64 ino;
+	int ret;
+
+	/* The rootdir itself. */
+	if (unlikely(ftwbuf->level == 0)) {
+		u64 root_ino = btrfs_root_dirid(&root->root_item);
+
+		UASSERT(S_ISDIR(st->st_mode));
+
+		ret = add_xattr_item(g_trans, root, root_ino, full_path);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to add xattr item for the top level inode: %m");
+			return ret;
+		}
+		stat_to_inode_item(&inode_item, st);
+		/*
+		 * Rootdir inode exists without any parent.
+		 * Thus needs to set its nlink to 1 manually.
+		 */
+		btrfs_set_stack_inode_nlink(&inode_item, 1);
+		ret = update_inode_item(g_trans, root, &inode_item, root_ino);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to update root dir for root %llu: %m",
+			      root->root_key.objectid);
+			return ret;
+		}
+
+		ret = rootdir_path_push(&current_path,
+					btrfs_root_dirid(&root->root_item));
+		if (ret < 0) {
+			errno = -ret;
+			error_msg(ERROR_MSG_MEMORY, "push path for rootdir: %m");
+			return ret;
+		}
+		return ret;
 	}
 
-	parent_inum = highest_inum + BTRFS_FIRST_FREE_OBJECTID;
-	dir_entry->inum = parent_inum;
-	list_add_tail(&dir_entry->list, &dir_head->list);
+	/*
+	 * If our path level is higher than this level - 1, this means
+	 * we have changed directory.
+	 * Poping out the unrelated inodes.
+	 */
+	while (current_path.level > ftwbuf->level - 1)
+		rootdir_path_pop(&current_path);
 
-	ret = copy_rootdir_inode(trans, root, dir_name);
+	ret = btrfs_find_free_objectid(g_trans, root,
+				       BTRFS_FIRST_FREE_OBJECTID, &ino);
 	if (ret < 0) {
 		errno = -ret;
-		error("failed to copy rootdir inode: %m");
-		goto fail_no_dir;
+		error("failed to find free objectid for file %s: %m",
+			full_path);
+		return ret;
+	}
+	stat_to_inode_item(&inode_item, st);
+
+	ret = btrfs_insert_inode(g_trans, root, ino, &inode_item);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to insert inode item %llu for '%s': %m",
+			ino, full_path);
+		return ret;
 	}
 
-	do {
-		parent_dir_entry = list_entry(dir_head->list.next,
-					      struct directory_name_entry,
-					      list);
-		list_del(&parent_dir_entry->list);
+	parent = rootdir_path_last(&current_path);
+	ret = btrfs_add_link(g_trans, root, ino, parent->ino,
+			     full_path + ftwbuf->base,
+			     strlen(full_path) - ftwbuf->base,
+			     ftype_to_btrfs_type(st->st_mode),
+			     NULL, 1, 0);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to add link for inode %llu ('%s'): %m",
+			ino, full_path);
+		return ret;
+	}
+	/*
+	 * btrfs_add_link() has increased the nlink to 1 in the metadata.
+	 * Also update the value in case we need to update the inode item
+	 * later.
+	 */
+	btrfs_set_stack_inode_nlink(&inode_item, 1);
 
-		parent_inum = parent_dir_entry->inum;
-		parent_dir_name = parent_dir_entry->dir_name;
-		if (chdir(parent_dir_entry->path)) {
-			error("chdir failed for %s: %m",
-				parent_dir_name);
-			ret = -1;
-			goto fail_no_files;
+	ret = add_xattr_item(g_trans, root, ino, full_path);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to add xattrs for inode %llu ('%s'): %m",
+			ino, full_path);
+		return ret;
+	}
+	if (S_ISDIR(st->st_mode)) {
+		ret = rootdir_path_push(&current_path, ino);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to allocate new entry for inode %llu ('%s'): %m",
+				ino, full_path);
+			return ret;
 		}
-
-		count = scandir(parent_dir_entry->path, &files,
-				directory_select, NULL);
-		if (count == -1) {
-			error("scandir failed for %s: %m",
-				parent_dir_name);
-			ret = -1;
-			goto fail;
+	} else if (S_ISREG(st->st_mode)) {
+		ret = add_file_items(g_trans, root, &inode_item, ino, st, full_path);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to add file extents for inode %llu ('%s'): %m",
+				ino, full_path);
+			return ret;
 		}
-
-		for (i = 0; i < count; i++) {
-			char tmp[PATH_MAX];
-
-			cur_file = files[i];
-
-			if (lstat(cur_file->d_name, &st) == -1) {
-				error("lstat failed for %s: %m",
-					cur_file->d_name);
-				ret = -1;
-				goto fail;
-			}
-			if (bconf.verbose >= LOG_INFO) {
-				path_cat_out(tmp, parent_dir_entry->path, cur_file->d_name);
-				pr_verbose(LOG_INFO, "ADD: %s\n", tmp);
-			}
-
-			/*
-			 * We can not directly use the source ino number,
-			 * as there is a chance that the ino is smaller than
-			 * BTRFS_FIRST_FREE_OBJECTID, which will screw up
-			 * backref code.
-			 */
-			cur_inum = st.st_ino + BTRFS_FIRST_FREE_OBJECTID;
-			ret = add_directory_items(trans, root,
-						  cur_inum, parent_inum,
-						  cur_file->d_name,
-						  &st, &dir_index_cnt);
-			if (ret) {
-				error("unable to add directory items for %s: %d",
-					cur_file->d_name, ret);
-				goto fail;
-			}
-
-			ret = add_inode_items(trans, root, &st,
-					      cur_file->d_name, cur_inum,
-					      &cur_inode);
-			if (ret == -EEXIST) {
-				if (st.st_nlink <= 1) {
-					error(
-			"item %s already exists but has wrong st_nlink %lu <= 1",
-						cur_file->d_name,
-						(unsigned long)st.st_nlink);
-					goto fail;
-				}
-				ret = 0;
-				continue;
-			}
-			if (ret) {
-				error("unable to add inode items for %s: %d",
-					cur_file->d_name, ret);
-				goto fail;
-			}
-
-			ret = add_xattr_item(trans, root,
-					     cur_inum, cur_file->d_name);
-			if (ret) {
-				error("unable to add xattr items for %s: %d",
-					cur_file->d_name, ret);
-				if (ret != -ENOTSUP)
-					goto fail;
-			}
-
-			if (S_ISDIR(st.st_mode)) {
-				dir_entry = malloc(sizeof(*dir_entry));
-				if (!dir_entry) {
-					ret = -ENOMEM;
-					goto fail;
-				}
-				dir_entry->dir_name = cur_file->d_name;
-				if (path_cat_out(tmp, parent_dir_entry->path,
-							cur_file->d_name)) {
-					error("invalid path: %s/%s",
-							parent_dir_entry->path,
-							cur_file->d_name);
-					ret = -EINVAL;
-					goto fail;
-				}
-				dir_entry->path = strdup(tmp);
-				if (!dir_entry->path) {
-					error_msg(ERROR_MSG_MEMORY, NULL);
-					ret = -ENOMEM;
-					goto fail;
-				}
-				dir_entry->inum = cur_inum;
-				list_add_tail(&dir_entry->list,
-					      &dir_head->list);
-			} else if (S_ISREG(st.st_mode)) {
-				ret = add_file_items(trans, root, &cur_inode,
-						     cur_inum, &st,
-						     cur_file->d_name);
-				if (ret) {
-					error("unable to add file items for %s: %d",
-						cur_file->d_name, ret);
-					goto fail;
-				}
-			} else if (S_ISLNK(st.st_mode)) {
-				ret = add_symbolic_link(trans, root,
-						cur_inum, cur_file->d_name);
-				if (ret) {
-					error("unable to add symlink for %s: %d",
-						cur_file->d_name, ret);
-					goto fail;
-				}
-			}
+		ret = update_inode_item(g_trans, root, &inode_item, ino);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to update inode item for inode %llu ('%s'): %m",
+				ino, full_path);
+			return ret;
 		}
-
-		free_namelist(files, count);
-		free(parent_dir_entry->path);
-		free(parent_dir_entry);
-
-		index_cnt = 2;
-
-	} while (!list_empty(&dir_head->list));
-
-out:
-	return !!ret;
-fail:
-	free_namelist(files, count);
-fail_no_files:
-	free(parent_dir_entry);
-	goto out;
-fail_no_dir:
-	free(dir_entry);
-	goto out;
-}
+	} else if (S_ISLNK(st->st_mode)) {
+		ret = add_symbolic_link(g_trans, root, &inode_item, ino, full_path);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to insert link for inode %llu ('%s'): %m",
+				ino, full_path);
+			return ret;
+		}
+		ret = update_inode_item(g_trans, root, &inode_item, ino);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to update inode item for inode %llu ('%s'): %m",
+				ino, full_path);
+			return ret;
+		}
+	}
+	return 0;
+};
 
 int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root)
 {
 	int ret;
 	struct btrfs_trans_handle *trans;
 	struct stat root_st;
-	struct directory_name_entry dir_head;
-	struct directory_name_entry *dir_entry = NULL;
 
 	ret = lstat(source_dir, &root_st);
 	if (ret) {
@@ -695,17 +561,18 @@ int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root)
 		goto out;
 	}
 
-	INIT_LIST_HEAD(&dir_head.list);
-
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		errno = -ret;
 		error_msg(ERROR_MSG_START_TRANS, "%m");
 		goto fail;
-}
+	}
 
-	ret = traverse_directory(trans, root, source_dir, &dir_head);
+	g_trans = trans;
+	INIT_LIST_HEAD(&current_path.inode_list);
+
+	ret = nftw(source_dir, ftw_add_inode, 32, FTW_PHYS);
 	if (ret) {
 		error("unable to traverse directory %s: %d", source_dir, ret);
 		goto fail;
@@ -716,29 +583,12 @@ int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root)
 		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
 		goto out;
 	}
+	while (current_path.level >= 0)
+		rootdir_path_pop(&current_path);
 
 	return 0;
 fail:
-	/*
-	 * Since we don't have btrfs_abort_transaction() yet, uncommitted trans
-	 * will trigger a BUG_ON().
-	 *
-	 * However before mkfs is fully finished, the magic number is invalid,
-	 * so even we commit transaction here, the fs still can't be mounted.
-	 *
-	 * To do a graceful error out, here we commit transaction as a
-	 * workaround.
-	 * Since we have already hit some problem, the return value doesn't
-	 * matter now.
-	 */
-	btrfs_commit_transaction(trans, root);
-	while (!list_empty(&dir_head.list)) {
-		dir_entry = list_entry(dir_head.list.next,
-				       struct directory_name_entry, list);
-		list_del(&dir_entry->list);
-		free(dir_entry->path);
-		free(dir_entry);
-	}
+	btrfs_abort_transaction(trans, ret);
 out:
 	return ret;
 }
diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
index 8d5f6896c3d9..4233431a9a42 100644
--- a/mkfs/rootdir.h
+++ b/mkfs/rootdir.h
@@ -24,18 +24,10 @@
 #include "kerncompat.h"
 #include <sys/types.h>
 #include <stdbool.h>
-#include "kernel-lib/list.h"
 
 struct btrfs_fs_info;
 struct btrfs_root;
 
-struct directory_name_entry {
-	const char *dir_name;
-	char *path;
-	ino_t inum;
-	struct list_head list;
-};
-
 int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root);
 u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_dev_size,
 			u64 meta_profile, u64 data_profile);
-- 
2.45.2


