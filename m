Return-Path: <linux-btrfs+bounces-7333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111A4957BFE
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 05:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD72E28542E
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 03:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9EC42A9D;
	Tue, 20 Aug 2024 03:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lek87GYQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="noC+CgoD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009F51798C
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 03:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125574; cv=none; b=mbl99q860I9zXOmDT/0Xy1YNIBqtM6ftMvAy8FiGnGbdPuTKQ1LvnwZ/BrUpefEE2quADA1i6uZ1YZH/MTwmmNIHGBnXqGScjiCLYIhSUqRq9hwDkO8ARB4/+IK+vHarmANb2+mNzxhxreUgIUEJ/7ZBjmrjUuWOTf0UCNHSjGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125574; c=relaxed/simple;
	bh=IyvxPhr9qWBLtTjvuakemo8+TicElcT7vlA75lJfbxo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocQxq65LR5rOO9j4Cu9l9c+8MuJLNjxnrlj9wWxSgSKz6+PEIgf+NJCKhadrt6xJSC3yT7cwHor+dWY0BMac0qhC5/fk4RUpWvNCvZeaPMQGsETEDFpAR6N+Q6WNROnY8HBfBeeGLCwtQTRJ4Mv8SFQCAtp4XNhSjDr6SknJNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lek87GYQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=noC+CgoD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47C73226B6
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 03:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724125564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Gxc1wNZmcOYYnpAtmi9UkfQ6t4tbuOieuIYrhCLpaU=;
	b=lek87GYQ8L5zlIRbEUwKbowKDcoC5g6e2968ZY5oL0uCoX5hgmuH2OzV3LBQX4mQQoLfEy
	isrE4lfn2RXi9NCetAPSUVL6pGWyycYijp3MgJ+FyKBjjx/L0TI83a43wMBKiZMlWquKrD
	vVHyhpz+tuVf3i7Xz1VVzDjBZ9VpwmM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=noC+CgoD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724125563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Gxc1wNZmcOYYnpAtmi9UkfQ6t4tbuOieuIYrhCLpaU=;
	b=noC+CgoD+3MpeKjHZt2ED9WRRorK2Mgp/ol20WTmpccEvZ0THUNiMw0I6PH0eQTrWHXi1u
	H0/v557RcerKm95fiRgSrc77TpkqFepHO8+C6MfyrmC5ifwR+p603Z6s7gR26BeR2If+no
	VkGQ/eSYBm5LBeWJrqJmPwDsijcLCKA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81FE913A3E
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 03:46:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AJZ7EXoRxGYbYAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 03:46:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs-progs: mkfs/rootdir: add hard link support
Date: Tue, 20 Aug 2024 13:15:42 +0930
Message-ID: <6651b9d2f49f8a375121e4b4a5651b7f254c8b6b.1724125282.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724125282.git.wqu@suse.com>
References: <cover.1724125282.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 47C73226B6
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_FAIL(0.00)[2a07:de40:b281:106:10:150:64:167:server fail];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

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

  In that case, `foobar_hardlink3` cannot be created as a hard link,
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
 mkfs/rootdir.c               | 203 +++++++++++++++++++++++++++++------
 2 files changed, 185 insertions(+), 31 deletions(-)

diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index 0e9e84adffc8..18c491da4c94 100644
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
+	In that case we cannot create `hardlink3` as hardlinks of
+	`hardlink1` and `hardlink2` because hardlink3 will be inside a new
+	subvolume.
+
 --shrink
         Shrink the filesystem to its minimal size, only works with *--rootdir* option.
 
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 3cc94316be4d..e1ca00f57e60 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -42,6 +42,7 @@
 #include "common/extent-tree-utils.h"
 #include "common/root-tree-utils.h"
 #include "common/path-utils.h"
+#include "common/rbtree-utils.h"
 #include "mkfs/rootdir.h"
 
 static u32 fs_block_size;
@@ -74,6 +75,52 @@ struct inode_entry {
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
+ * But for the btrfs we are building, only hardlink1 and hardlink2 can be
+ * created as hardlinks. Since we cannot create hardlink across subvolume.
+ * So we need @root as a search index to handle such case.
+ */
+struct hardlink_entry {
+	struct rb_node node;
+	/*
+	 * The following three members are reported from the stat() of the
+	 * host filesystem.
+	 *
+	 * For st_nlink we cannot trust it unconditionally, as
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
+
+	/* How many hard links we have created. */
+	nlink_t found_nlink;
+};
+
+static struct rb_root hardlink_root = RB_ROOT;
+
 /*
  * The path towards the rootdir.
  *
@@ -93,9 +140,6 @@ static struct rootdir_path current_path = {
 	.level = 0,
 };
 
-/* Track if a hardlink was found and a warning was printed. */
-static bool g_hardlink_warning;
-static u64 g_hardlink_count;
 static struct btrfs_trans_handle *g_trans = NULL;
 static struct list_head *g_subvols;
 static u64 next_subvol_id = BTRFS_FIRST_FREE_OBJECTID;
@@ -133,6 +177,82 @@ static int rootdir_path_push(struct rootdir_path *path, struct btrfs_root *root,
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
+	const struct hardlink_entry tmp = {
+		.st_dev = st->st_dev,
+		.st_ino = st->st_ino,
+		.root = root,
+	};
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
@@ -498,29 +618,10 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
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
@@ -620,6 +721,37 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 	parent = rootdir_path_last(&current_path);
 	root = parent->root;
 
+	/* For non-directory inode, check if there is already any hard link. */
+	if (have_hard_links) {
+		struct hardlink_entry *found;
+
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
@@ -635,7 +767,6 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 		error("failed to insert inode item %llu for '%s': %m", ino, full_path);
 		return ret;
 	}
-
 	ret = btrfs_add_link(g_trans, root, ino, parent->ino,
 			     full_path + ftwbuf->base,
 			     strlen(full_path) - ftwbuf->base,
@@ -646,6 +777,22 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
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
@@ -714,8 +861,6 @@ int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *source_dir
 	}
 
 	g_trans = trans;
-	g_hardlink_warning = false;
-	g_hardlink_count = 0;
 	g_subvols = subvols;
 	INIT_LIST_HEAD(&current_path.inode_list);
 
@@ -725,13 +870,9 @@ int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *source_dir
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


