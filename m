Return-Path: <linux-btrfs+bounces-6455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BB4930D88
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 07:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD251C203D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 05:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA19183098;
	Mon, 15 Jul 2024 05:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LoEY2GKT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LoEY2GKT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B32328FA
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721020956; cv=none; b=egfxy1hQ3J7ZqsciEcniAT+dwELxcg8uIbgoBQzOzQZoXTgvwqvkAYQZRuJH7P/L8pzOnJPuGk+Jh/DmFA0w12EKCaa3FmWwD0yLspitzqFgLQnDMwgaeRt2cVgdrsxaS4ikHfdTJwk/a4up8u7wsAbchvKcJFVnkb4TKMQFbQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721020956; c=relaxed/simple;
	bh=mPLQY+V0CVgNaP1oRHMlDHK6+MBOwCU7aQw8xaTmKSk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpJR+FXG6pMh96Z6ZdY1IJLNFlEcPgoJ5IVG64cXYVDpUrqrvfyfc/+yyCempojF7lB5n1tmiAWZyaiUF2844Uwj3IECTec3wUTkE3uMkycXJL6YX9MGrWf7iPt4uxbdXOhj9txKvqGnTsiCpqGNAfKXObZsjlaZV1u8PuVND/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LoEY2GKT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LoEY2GKT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 695A71F7F0
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721020952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B68CtDl4kJyF7GuCxnbtX+7HQrvX82QuHRLEMox2Q4w=;
	b=LoEY2GKTy965a0vSKdnSPQeqEwF+gpqJ1PnA3IB9o8FDtBO4Cp4lp3YI5Uh8nwLBGmnQSR
	5xMP9TXYs4XQTWMidQBSVTfVoa6TulfsSL7PWHiIDWxNDqNg1H8vc9LPQEwpGjAa1kdhkd
	rPJUH5b4SDnvPo3PzUX6NIjoX28z87c=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=LoEY2GKT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721020952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B68CtDl4kJyF7GuCxnbtX+7HQrvX82QuHRLEMox2Q4w=;
	b=LoEY2GKTy965a0vSKdnSPQeqEwF+gpqJ1PnA3IB9o8FDtBO4Cp4lp3YI5Uh8nwLBGmnQSR
	5xMP9TXYs4XQTWMidQBSVTfVoa6TulfsSL7PWHiIDWxNDqNg1H8vc9LPQEwpGjAa1kdhkd
	rPJUH5b4SDnvPo3PzUX6NIjoX28z87c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 810E3134AB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:22:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +FDzDheylGZdRQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:22:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs-progs: introduce btrfs_make_subvolume()
Date: Mon, 15 Jul 2024 14:52:09 +0930
Message-ID: <d99070bab70c77f3b9d7dcb30dfda5e6dc0353bf.1721020730.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721020730.git.wqu@suse.com>
References: <cover.1721020730.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 695A71F7F0
X-Spam-Flag: NO
X-Spam-Score: 0.99
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spamd-Bar: /

There are two different subvolume/data reloc tree creation routines:

- create_subvol() from convert/main.c
  * calls btrfs_copy_root() to create an empty root
    This is not safe, as it relies on the source root to be empty.
  * calls btrfs_read_fs_root() to add it to the cache and trace it
    properly
  * calls btrfs_make_root_dir() to initialize the empty new root

- create_data_reloc_tree() from mkfs/main.c
  * calls btrfs_create_tree() to create an empty rooo
  * Manually add the root to fs_root cache
    This is only safe for data reloc tree as it's never updated
    inside btrfs-progs.
    But not safe for other subvolume trees.
  * manually setup the root dir

Both has its good and bad aspects, so here we introduce a new helper,
btrfs_make_subvolume():

- Calls btrfs_create_tree() to create an empty root
- Calls btrfs_read_fs_root() to setup the cache and tracking properly
- Calls btrfs_make_root_dir() to initialize the root dir
- Calls btrfs_update_root() to reflect the rootdir change

So this new helper can replace both create_subvol() and
create_data_reloc_tree().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Makefile                 |   1 +
 check/main.c             |   1 +
 common/root-tree-utils.c | 108 +++++++++++++++++++++++++++++++++++++++
 common/root-tree-utils.h |  26 ++++++++++
 convert/main.c           |  43 ++--------------
 mkfs/common.c            |  39 --------------
 mkfs/common.h            |   2 -
 mkfs/main.c              |  72 +-------------------------
 8 files changed, 141 insertions(+), 151 deletions(-)
 create mode 100644 common/root-tree-utils.c
 create mode 100644 common/root-tree-utils.h

diff --git a/Makefile b/Makefile
index 82dfb1b40cde..c0428c573933 100644
--- a/Makefile
+++ b/Makefile
@@ -221,6 +221,7 @@ objects = \
 	common/device-utils.o	\
 	common/extent-cache.o	\
 	common/extent-tree-utils.o	\
+	common/root-tree-utils.o	\
 	common/filesystem-utils.o	\
 	common/format-output.o	\
 	common/fsfeatures.o	\
diff --git a/check/main.c b/check/main.c
index 693f77c3542d..8a572c22036e 100644
--- a/check/main.c
+++ b/check/main.c
@@ -59,6 +59,7 @@
 #include "common/open-utils.h"
 #include "common/string-utils.h"
 #include "common/clear-cache.h"
+#include "common/root-tree-utils.h"
 #include "cmds/commands.h"
 #include "mkfs/common.h"
 #include "check/common.h"
diff --git a/common/root-tree-utils.c b/common/root-tree-utils.c
new file mode 100644
index 000000000000..a937037ea4fd
--- /dev/null
+++ b/common/root-tree-utils.c
@@ -0,0 +1,108 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+#include <time.h>
+#include "common/root-tree-utils.h"
+#include "common/rbtree-utils.h"
+#include "common/messages.h"
+#include "kernel-shared/disk-io.h"
+
+int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
+			struct btrfs_root *root, u64 objectid)
+{
+	int ret;
+	struct btrfs_inode_item inode_item;
+	time_t now = time(NULL);
+
+	memset(&inode_item, 0, sizeof(inode_item));
+	btrfs_set_stack_inode_generation(&inode_item, trans->transid);
+	btrfs_set_stack_inode_size(&inode_item, 0);
+	btrfs_set_stack_inode_nlink(&inode_item, 1);
+	btrfs_set_stack_inode_nbytes(&inode_item, root->fs_info->nodesize);
+	btrfs_set_stack_inode_mode(&inode_item, S_IFDIR | 0755);
+	btrfs_set_stack_timespec_sec(&inode_item.atime, now);
+	btrfs_set_stack_timespec_nsec(&inode_item.atime, 0);
+	btrfs_set_stack_timespec_sec(&inode_item.ctime, now);
+	btrfs_set_stack_timespec_nsec(&inode_item.ctime, 0);
+	btrfs_set_stack_timespec_sec(&inode_item.mtime, now);
+	btrfs_set_stack_timespec_nsec(&inode_item.mtime, 0);
+	btrfs_set_stack_timespec_sec(&inode_item.otime, now);
+	btrfs_set_stack_timespec_nsec(&inode_item.otime, 0);
+
+	if (root->fs_info->tree_root == root)
+		btrfs_set_super_root_dir(root->fs_info->super_copy, objectid);
+
+	ret = btrfs_insert_inode(trans, root, objectid, &inode_item);
+	if (ret)
+		goto error;
+
+	ret = btrfs_insert_inode_ref(trans, root, "..", 2, objectid, objectid, 0);
+	if (ret)
+		goto error;
+
+	btrfs_set_root_dirid(&root->root_item, objectid);
+	ret = 0;
+error:
+	return ret;
+}
+
+/*
+ * Create a subvolume and initialize its content with the top inode.
+ *
+ * The created tree root would have its root_ref as 1.
+ * Thus for subvolumes caller needs to properly add ROOT_BACKREF items.
+ */
+int btrfs_make_subvolume(struct btrfs_trans_handle *trans, u64 objectid)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *root;
+	struct btrfs_key key = {
+		.objectid = objectid,
+		.type = BTRFS_ROOT_ITEM_KEY,
+	};
+	int ret;
+
+	/* FSTREE is different and can not be created by this function. */
+	UASSERT(objectid != BTRFS_FS_TREE_OBJECTID);
+	UASSERT(is_fstree(objectid) || objectid == BTRFS_DATA_RELOC_TREE_OBJECTID);
+
+	root = btrfs_create_tree(trans, &key);
+	if (IS_ERR(root)) {
+		ret = PTR_ERR(root);
+		goto error;
+	}
+	/*
+	 * Free it for now, and re-read it from disk to setup cache and
+	 * tracking.
+	 */
+	btrfs_free_fs_root(root);
+	root = btrfs_read_fs_root(fs_info, &key);
+	if (IS_ERR(root)) {
+		ret = PTR_ERR(root);
+		goto error;
+	}
+	ret = btrfs_make_root_dir(trans, root, BTRFS_FIRST_FREE_OBJECTID);
+	if (ret < 0)
+		goto error;
+	ret = btrfs_update_root(trans, fs_info->tree_root, &root->root_key,
+				&root->root_item);
+	if (ret < 0)
+		goto error;
+	return 0;
+error:
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
diff --git a/common/root-tree-utils.h b/common/root-tree-utils.h
new file mode 100644
index 000000000000..f4e354c0bf3e
--- /dev/null
+++ b/common/root-tree-utils.h
@@ -0,0 +1,26 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+#ifndef _ROOT_TREE_UTILS_H_
+#define _ROOT_TREE_UTILS_H_
+
+#include "kernel-shared/transaction.h"
+
+int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
+			struct btrfs_root *root, u64 objectid);
+int btrfs_make_subvolume(struct btrfs_trans_handle *trans, u64 objectid);
+
+#endif
diff --git a/convert/main.c b/convert/main.c
index 8e73aa25b1da..31fa146c86b1 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -120,6 +120,7 @@
 #include "common/box.h"
 #include "common/open-utils.h"
 #include "common/extent-tree-utils.h"
+#include "common/root-tree-utils.h"
 #include "common/clear-cache.h"
 #include "cmds/commands.h"
 #include "check/repair.h"
@@ -916,44 +917,6 @@ out:
 	return ret;
 }
 
-static int create_subvol(struct btrfs_trans_handle *trans,
-			 struct btrfs_root *root, u64 root_objectid)
-{
-	struct extent_buffer *tmp;
-	struct btrfs_root *new_root;
-	struct btrfs_key key;
-	struct btrfs_root_item root_item;
-	int ret;
-
-	ret = btrfs_copy_root(trans, root, root->node, &tmp,
-			      root_objectid);
-	if (ret)
-		return ret;
-
-	memcpy(&root_item, &root->root_item, sizeof(root_item));
-	btrfs_set_root_bytenr(&root_item, tmp->start);
-	btrfs_set_root_level(&root_item, btrfs_header_level(tmp));
-	btrfs_set_root_generation(&root_item, trans->transid);
-	free_extent_buffer(tmp);
-
-	key.objectid = root_objectid;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = trans->transid;
-	ret = btrfs_insert_root(trans, root->fs_info->tree_root,
-				&key, &root_item);
-
-	key.offset = (u64)-1;
-	new_root = btrfs_read_fs_root(root->fs_info, &key);
-	if (!new_root || IS_ERR(new_root)) {
-		error("unable to fs read root: %lu", PTR_ERR(new_root));
-		return PTR_ERR(new_root);
-	}
-
-	ret = btrfs_make_root_dir(trans, new_root, BTRFS_FIRST_FREE_OBJECTID);
-
-	return ret;
-}
-
 /*
  * New make_btrfs() has handle system and meta chunks quite well.
  * So only need to add remaining data chunks.
@@ -1059,13 +1022,13 @@ static int init_btrfs(struct btrfs_mkfs_config *cfg, struct btrfs_root *root,
 			     BTRFS_FIRST_FREE_OBJECTID);
 
 	/* subvol for fs image file */
-	ret = create_subvol(trans, root, CONV_IMAGE_SUBVOL_OBJECTID);
+	ret = btrfs_make_subvolume(trans, CONV_IMAGE_SUBVOL_OBJECTID);
 	if (ret < 0) {
 		error("failed to create subvolume image root: %d", ret);
 		goto err;
 	}
 	/* subvol for data relocation tree */
-	ret = create_subvol(trans, root, BTRFS_DATA_RELOC_TREE_OBJECTID);
+	ret = btrfs_make_subvolume(trans, BTRFS_DATA_RELOC_TREE_OBJECTID);
 	if (ret < 0) {
 		error("failed to create DATA_RELOC root: %d", ret);
 		goto err;
diff --git a/mkfs/common.c b/mkfs/common.c
index 5de3e0b6d59c..e28b1e827ee7 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -758,45 +758,6 @@ out:
 	return ret;
 }
 
-int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
-			struct btrfs_root *root, u64 objectid)
-{
-	int ret;
-	struct btrfs_inode_item inode_item;
-	time_t now = time(NULL);
-
-	memset(&inode_item, 0, sizeof(inode_item));
-	btrfs_set_stack_inode_generation(&inode_item, trans->transid);
-	btrfs_set_stack_inode_size(&inode_item, 0);
-	btrfs_set_stack_inode_nlink(&inode_item, 1);
-	btrfs_set_stack_inode_nbytes(&inode_item, root->fs_info->nodesize);
-	btrfs_set_stack_inode_mode(&inode_item, S_IFDIR | 0755);
-	btrfs_set_stack_timespec_sec(&inode_item.atime, now);
-	btrfs_set_stack_timespec_nsec(&inode_item.atime, 0);
-	btrfs_set_stack_timespec_sec(&inode_item.ctime, now);
-	btrfs_set_stack_timespec_nsec(&inode_item.ctime, 0);
-	btrfs_set_stack_timespec_sec(&inode_item.mtime, now);
-	btrfs_set_stack_timespec_nsec(&inode_item.mtime, 0);
-	btrfs_set_stack_timespec_sec(&inode_item.otime, now);
-	btrfs_set_stack_timespec_nsec(&inode_item.otime, 0);
-
-	if (root->fs_info->tree_root == root)
-		btrfs_set_super_root_dir(root->fs_info->super_copy, objectid);
-
-	ret = btrfs_insert_inode(trans, root, objectid, &inode_item);
-	if (ret)
-		goto error;
-
-	ret = btrfs_insert_inode_ref(trans, root, "..", 2, objectid, objectid, 0);
-	if (ret)
-		goto error;
-
-	btrfs_set_root_dirid(&root->root_item, objectid);
-	ret = 0;
-error:
-	return ret;
-}
-
 /*
  * Btrfs minimum size calculation is complicated, it should include at least:
  * 1. system group size
diff --git a/mkfs/common.h b/mkfs/common.h
index de0ff57beee8..c600c16622fa 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -103,8 +103,6 @@ struct btrfs_mkfs_config {
 };
 
 int make_btrfs(int fd, struct btrfs_mkfs_config *cfg);
-int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
-			struct btrfs_root *root, u64 objectid);
 u64 btrfs_min_dev_size(u32 nodesize, bool mixed, u64 zone_size, u64 meta_profile,
 		       u64 data_profile);
 int test_minimum_size(const char *file, u64 min_dev_size);
diff --git a/mkfs/main.c b/mkfs/main.c
index 077da1e33fc6..cf5cae45d02a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -58,6 +58,7 @@
 #include "common/units.h"
 #include "common/string-utils.h"
 #include "common/string-table.h"
+#include "common/root-tree-utils.h"
 #include "cmds/commands.h"
 #include "check/qgroup-verify.h"
 #include "mkfs/common.h"
@@ -734,75 +735,6 @@ static void update_chunk_allocation(struct btrfs_fs_info *fs_info,
 	}
 }
 
-static int create_data_reloc_tree(struct btrfs_trans_handle *trans)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_inode_item *inode;
-	struct btrfs_root *root;
-	struct btrfs_path path = { 0 };
-	struct btrfs_key key = {
-		.objectid = BTRFS_DATA_RELOC_TREE_OBJECTID,
-		.type = BTRFS_ROOT_ITEM_KEY,
-	};
-	u64 ino = BTRFS_FIRST_FREE_OBJECTID;
-	char *name = "..";
-	int ret;
-
-	root = btrfs_create_tree(trans, &key);
-	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		goto out;
-	}
-	/* Update dirid as created tree has default dirid 0 */
-	btrfs_set_root_dirid(&root->root_item, ino);
-	ret = btrfs_update_root(trans, fs_info->tree_root, &root->root_key,
-				&root->root_item);
-	if (ret < 0)
-		goto out;
-
-	/* Cache this tree so it can be cleaned up at close_ctree() */
-	ret = rb_insert(&fs_info->fs_root_tree, &root->rb_node,
-			btrfs_fs_roots_compare_roots);
-	if (ret < 0)
-		goto out;
-
-	/* Insert INODE_ITEM */
-	ret = btrfs_new_inode(trans, root, ino, 0755 | S_IFDIR);
-	if (ret < 0)
-		goto out;
-
-	/* then INODE_REF */
-	ret = btrfs_insert_inode_ref(trans, root, name, strlen(name), ino, ino,
-				     0);
-	if (ret < 0)
-		goto out;
-
-	/* Update nlink of that inode item */
-	key.objectid = ino;
-	key.type = BTRFS_INODE_ITEM_KEY;
-	key.offset = 0;
-
-	ret = btrfs_search_slot(trans, root, &key, &path, 0, 1);
-	if (ret > 0) {
-		ret = -ENOENT;
-		btrfs_release_path(&path);
-		goto out;
-	}
-	if (ret < 0) {
-		btrfs_release_path(&path);
-		goto out;
-	}
-	inode = btrfs_item_ptr(path.nodes[0], path.slots[0],
-			       struct btrfs_inode_item);
-	btrfs_set_inode_nlink(path.nodes[0], inode, 1);
-	btrfs_mark_buffer_dirty(path.nodes[0]);
-	btrfs_release_path(&path);
-	return 0;
-out:
-	btrfs_abort_transaction(trans, ret);
-	return ret;
-}
-
 static int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid,
 			       u8 type, u64 subvol_id_cpu)
 {
@@ -1939,7 +1871,7 @@ raid_groups:
 		goto out;
 	}
 
-	ret = create_data_reloc_tree(trans);
+	ret = btrfs_make_subvolume(trans, BTRFS_DATA_RELOC_TREE_OBJECTID);
 	if (ret) {
 		error("unable to create data reloc tree: %d", ret);
 		goto out;
-- 
2.45.2


