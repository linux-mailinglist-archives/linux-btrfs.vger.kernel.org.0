Return-Path: <linux-btrfs+bounces-7208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7134795288F
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 06:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973661C21C8E
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 04:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CED3BBC9;
	Thu, 15 Aug 2024 04:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XR8PGokx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XR8PGokx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF45617C64
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 04:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723696732; cv=none; b=dDfCu6R0/sUDP1/vSjImSliTPKGoxJ+rzwg3cYvFKW2sZRdKQj8d0VM5/OT3V5DHGlLEYElBKN67zgYo7hf+bPi/SlPSsxQZj6FpLpjZiCOFyJY4YNN8Ho4old+/OJpQwqxoAFu38357JktsSEmSsU1Ky+Oa5THapU1JGv8ArIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723696732; c=relaxed/simple;
	bh=GrasIIYSRSS/WO2o6qF3RE2xeoCEugD+1/Dp6xI2bFw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFAoiy4i4uq7CK4omJcwxLFdftuWpHR/lD8H5xF+TV6cPQ/yow1KvgTddQst4BPnEOtK8ZLPCMDIDP7t+7HM0YdDgRL1W/zVDF4fZ8W/m5DlfmOH+JxqkvE0GkI4UhWR0Fl0xl8/PFYuT+cZhy37Ai6NG4CSUJMUpOAqQy69LC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XR8PGokx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XR8PGokx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA7562224B
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 04:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723696726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtIhL2qEGTeJx36wbGO7gz1bN3SnD51fU6575+jMEs8=;
	b=XR8PGokxw7vx3kKqPTnZGuOgQPqzB4SeK+aYZci5nR4IkVe4U7rv2b+vGOyyRUgzRhwUGi
	TKcc4CoOPV67nvTfJk1/6hhgh57XxHW3X6INY8y+A9p6ENeUuWrElLKao/jFjXMrqC9X/j
	c/j2NEtD+bqw6BzgPrts6o2q5nbdWR8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723696726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtIhL2qEGTeJx36wbGO7gz1bN3SnD51fU6575+jMEs8=;
	b=XR8PGokxw7vx3kKqPTnZGuOgQPqzB4SeK+aYZci5nR4IkVe4U7rv2b+vGOyyRUgzRhwUGi
	TKcc4CoOPV67nvTfJk1/6hhgh57XxHW3X6INY8y+A9p6ENeUuWrElLKao/jFjXMrqC9X/j
	c/j2NEtD+bqw6BzgPrts6o2q5nbdWR8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B2D313983
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 04:38:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yD35LVWGvWaoPgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 04:38:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: mkfs/rootdir: add hard link support
Date: Thu, 15 Aug 2024 14:08:17 +0930
Message-ID: <694d6d9d743336910c4f6512d5eb69d2f35e332b.1723696468.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723696468.git.wqu@suse.com>
References: <cover.1723696468.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

The new hard link detection and creation support is done by maintaining
an rb tree with the following members:

- st_ino, st_dev
  This is to record the stat() report from the host fs.
  With this two, we can detect if it's really a hard link (st_dev
  determines one filesystem/subvolume, and st_ino determines the inode
  number inside the fs).

- root
  This is btrfs root pointer. This a special requirement for the recent
  introduced "--subvol" option.

  As we can have the following corner case:

  rootdir/
  |- foobar_hardlink1
  |- foobar_hardlink2
  |- subv/		<- To be a subvolume inside btrfs
     |- foobar_hardlink3

  In above case, on the host fs, `subv/` directory is just a regular
  directory, but in the new btrfs it will be a subvolume.

  In that case, `foobar_hardlink3` can not be created as a hard link,
  but a new inode.

- st_nlink and found_nlink
  Records the original reported number of links, and the nlinks we
  created inside btrfs.
  This is recorded in case we created all hard links and can remove
  the entry early.

- btrfs_ino
  This is the inode number inside btrfs.

And since we can handle hard links safely, remove all the related
warnings, and add a new note for `--subvol` option, warning about the
case where we need to split hard links due to subvolume boundary.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/mkfs.btrfs.rst |  13 +++
 mkfs/rootdir.c               | 200 +++++++++++++++++++++++++++++------
 2 files changed, 182 insertions(+), 31 deletions(-)

diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index 0e9e84adffc8..a7acd6b0019c 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -160,6 +160,19 @@ OPTIONS
         directory.  The option *--rootdir* must also be specified, and *subdir* must be an
         existing subdirectory within it.  This option can be specified multiple times.
 
+	If there are hard links inside *rootdir* and *subdir* will split the
+	subvolumes, like the following case::
+
+		rootdir/
+		|- hardlink1
+		|- hardlink2
+		|- subdir/  <- will be a subvolume
+		   |- hardlink3
+
+	In that case we can not create `hardlink3` as a hardlinks of
+	`hardlink1` and `hardlink2`.
+	Because hardlink3 will be inside a new subvolume.
+
 --shrink
         Shrink the filesystem to its minimal size, only works with *--rootdir* option.
 
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 7976d93ea560..3da3c8247d08 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -42,6 +42,7 @@
 #include "common/extent-tree-utils.h"
 #include "common/root-tree-utils.h"
 #include "common/path-utils.h"
+#include "common/rbtree-utils.h"
 #include "mkfs/rootdir.h"
 
 static u32 fs_block_size;
@@ -74,6 +75,50 @@ struct inode_entry {
 	struct list_head list;
 };
 
+/*
+ * Record all the hard links we found for a specific file inside
+ * rootdir.
+ *
+ * The search is based on (root, st_dev, st_ino).
+ * The reason for @root as a search index is, for hard links separated by
+ * subvolume boundaries:
+ *
+ * rootdir/
+ * |- foobar_hardlink1
+ * |- foobar_hardlink2
+ * |- subv/	<- Will be created as a subvolume
+ *    |- foobar_hardlink3.
+ *
+ * Since all the 3 hard links are inside the same rootdir and the same
+ * filesystem, on the host fs they are all hard links to the same inode.
+ *
+ * But for created btrfs, only hardlink1 and hardlink2 can be created as
+ * hardlinks. Since we can not create hardlink across subvolume.
+ */
+struct hardlink_entry {
+	struct rb_node node;
+	/*
+	 * The following two are reported from the stat() of the
+	 * host filesystem.
+	 *
+	 * For st_nlink we can not trust it unconditionally, as
+	 * some hard links may be out of rootdir.
+	 * If @found_nlink reached @st_nlink, we know we have created all
+	 * the hard links and can remove the entry.
+	 */
+	dev_t st_dev;
+	ino_t st_ino;
+	nlink_t st_nlink;
+
+	/* The following two are inside the new btrfs. */
+	struct btrfs_root *root;
+	u64 btrfs_ino;
+	/* How many hard links we have created. */
+	nlink_t found_nlink;
+};
+
+static struct rb_root hardlink_root = RB_ROOT;
+
 /*
  * The path towards the rootdir.
  *
@@ -93,9 +138,6 @@ static struct rootdir_path current_path = {
 	.level = 0,
 };
 
-/* Track if a hardlink was found and a warning was printed. */
-static bool g_hardlink_warning;
-static u64 g_hardlink_count;
 static struct btrfs_trans_handle *g_trans = NULL;
 static struct list_head *g_subvols;
 static u64 next_subvol_id = BTRFS_FIRST_FREE_OBJECTID;
@@ -133,6 +175,82 @@ static int rootdir_path_push(struct rootdir_path *path, struct btrfs_root *root,
 	return 0;
 }
 
+static int hardlink_compare_nodes(const struct rb_node *node1,
+				  const struct rb_node *node2)
+{
+	const struct hardlink_entry *entry1;
+	const struct hardlink_entry *entry2;
+
+	entry1 = rb_entry(node1, struct hardlink_entry, node);
+	entry2 = rb_entry(node2, struct hardlink_entry, node);
+	UASSERT(entry1->root);
+	UASSERT(entry2->root);
+
+	if (entry1->st_dev < entry2->st_dev)
+		return -1;
+	if (entry1->st_dev > entry2->st_dev)
+		return 1;
+	if (entry1->st_ino < entry2->st_ino)
+		return -1;
+	if (entry1->st_ino > entry2->st_ino)
+		return 1;
+	if (entry1->root < entry2->root)
+		return -1;
+	if (entry1->root > entry2->root)
+		return 1;
+	return 0;
+}
+
+static struct hardlink_entry *find_hard_link(struct btrfs_root *root,
+					     const struct stat *st)
+{
+	struct rb_node *node;
+	struct hardlink_entry tmp;
+
+	tmp.st_dev = st->st_dev;
+	tmp.st_ino = st->st_ino;
+	tmp.root = root;
+
+	node = rb_search(&hardlink_root, &tmp,
+			(rb_compare_keys)hardlink_compare_nodes, NULL);
+	if (node)
+		return rb_entry(node, struct hardlink_entry, node);
+	return NULL;
+}
+
+static int add_hard_link(struct btrfs_root *root, u64 btrfs_ino,
+			 const struct stat *st)
+{
+	struct hardlink_entry *new;
+	int ret;
+
+	UASSERT(st->st_nlink > 1);
+
+	new = calloc(1, sizeof(*new));
+	if (!new)
+		return -ENOMEM;
+
+	new->root = root;
+	new->btrfs_ino = btrfs_ino;
+	new->found_nlink = 1;
+	new->st_dev = st->st_dev;
+	new->st_ino = st->st_ino;
+	new->st_nlink = st->st_nlink;
+	ret = rb_insert(&hardlink_root, &new->node, hardlink_compare_nodes);
+	if (ret) {
+		free(new);
+		return -EEXIST;
+	}
+	return 0;
+}
+
+static void free_one_hardlink(struct rb_node *node)
+{
+	struct hardlink_entry *entry = rb_entry(node, struct hardlink_entry, node);
+
+	free(entry);
+}
+
 static void stat_to_inode_item(struct btrfs_inode_item *dst, const struct stat *st)
 {
 	/*
@@ -498,29 +616,10 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 	struct btrfs_inode_item inode_item = { 0 };
 	struct inode_entry *parent;
 	struct rootdir_subvol *rds;
+	const bool have_hard_links = (!S_ISDIR(st->st_mode) && st->st_nlink > 1);
 	u64 ino;
 	int ret;
 
-	/*
-	 * Hard link needs extra detection code, not supported for now, but
-	 * it's not to break anything but splitting the hard links into new
-	 * inodes.  And we do not even know if the hard links are inside the
-	 * rootdir.
-	 *
-	 * So here we only need to do extra warning.
-	 *
-	 * On most filesystems st_nlink of a directory is the number of
-	 * subdirs, including "." and "..", so skip directory inodes.
-	 */
-	if (unlikely(!S_ISDIR(st->st_mode) && st->st_nlink > 1)) {
-		if (!g_hardlink_warning) {
-			warning("'%s' has extra hardlinks, they will be converted into new inodes",
-				full_path);
-			g_hardlink_warning = true;
-		}
-		g_hardlink_count++;
-	}
-
 	/* The rootdir itself. */
 	if (unlikely(ftwbuf->level == 0)) {
 		u64 root_ino;
@@ -620,6 +719,36 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 	parent = rootdir_path_last(&current_path);
 	root = parent->root;
 
+	/* For non-directory inode, check if there is already any hard link. */
+	if (have_hard_links) {
+		struct hardlink_entry *found;
+		found = find_hard_link(root, st);
+		/*
+		 * Can only add the hard link if it doesn't cross subvolume
+		 * boundary.
+		 */
+		if (found && found->root == root) {
+			ret = btrfs_add_link(g_trans, root, found->btrfs_ino,
+					     parent->ino, full_path + ftwbuf->base,
+					     strlen(full_path) - ftwbuf->base,
+					     ftype_to_btrfs_type(st->st_mode),
+					     NULL, 1, 0);
+			if (ret < 0) {
+				errno = -ret;
+				error(
+			"failed to add link for hard link ('%s'): %m", full_path);
+				return ret;
+			}
+			found->found_nlink++;
+			/* We found all hard links for it. Can remove the entry. */
+			if (found->found_nlink >= found->st_nlink) {
+				rb_erase(&found->node, &hardlink_root);
+				free(found);
+			}
+			return 0;
+		}
+	}
+
 	ret = btrfs_find_free_objectid(g_trans, root,
 				       BTRFS_FIRST_FREE_OBJECTID, &ino);
 	if (ret < 0) {
@@ -635,7 +764,6 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 		error("failed to insert inode item %llu for '%s': %m", ino, full_path);
 		return ret;
 	}
-
 	ret = btrfs_add_link(g_trans, root, ino, parent->ino,
 			     full_path + ftwbuf->base,
 			     strlen(full_path) - ftwbuf->base,
@@ -646,6 +774,22 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 		error("failed to add link for inode %llu ('%s'): %m", ino, full_path);
 		return ret;
 	}
+
+	/*
+	 * Found a possible hard link, add it into the hard link rb tree for
+	 * future detection.
+	 */
+	if (have_hard_links) {
+		ret = add_hard_link(root, ino, st);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to add hard link record for '%s': %m",
+			       full_path);
+			return ret;
+		}
+		ret = 0;
+	}
+
 	/*
 	 * btrfs_add_link() has increased the nlink to 1 in the metadata.
 	 * Also update the value in case we need to update the inode item
@@ -715,8 +859,6 @@ int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *source_dir
 
 	g_trans = trans;
 	g_subvols = subvols;
-	g_hardlink_warning = false;
-	g_hardlink_count = 0;
 	INIT_LIST_HEAD(&current_path.inode_list);
 
 	ret = nftw(source_dir, ftw_add_inode, 32, FTW_PHYS);
@@ -725,13 +867,9 @@ int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *source_dir
 		return ret;
 	}
 
-	if (g_hardlink_warning)
-		warning("%llu hardlinks were detected in %s, all converted to new inodes",
-			g_hardlink_count, source_dir);
-
 	while (current_path.level > 0)
 		rootdir_path_pop(&current_path);
-
+	rb_free_nodes(&hardlink_root, free_one_hardlink);
 	return 0;
 }
 
-- 
2.46.0


