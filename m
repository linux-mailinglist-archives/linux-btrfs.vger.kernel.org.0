Return-Path: <linux-btrfs+bounces-6456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811D8930D89
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 07:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3787328141F
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 05:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C536E22089;
	Mon, 15 Jul 2024 05:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A34iUUL5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A34iUUL5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B131448EA
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721020958; cv=none; b=HQy6pzi59aR9xuYVci5Sbmoy7IaEmJ4+8imSf7uoeV1d4POADQ0vg8dIyMeg61dXavMTylkrIwTVpsSVQnAQv6D0k7RUBYHoUiiwSNrbe07AFVhaWEVh02afUDyn6woferTYtX6z5hjHTah5+9YMq/BE1Vql55bMq8IzJ4m1vDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721020958; c=relaxed/simple;
	bh=lZNaFS4dMO4TLgiImpyF/iTWEqrw+H7ujA6foVYiU/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtpPGh5GPnW/wDEm65amsLXfTJHl+osl5YKr1+JGo/cqjZCM0I/10pcgeOJ2Op67mNRXIXRpbSJORujbyqlx5AV9Ql9Uhhi/L4B/dwV78jHgn2Txt9GnibVTki22n6aznWo/GfZt65SzpicRDmrj0no/UiZBSXrPY1XQq5hpubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A34iUUL5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A34iUUL5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC9AF1F7F3
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721020953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Tim8gwE8VaMxFmyocNueVmXLjWapojjFRs4umo+UT4=;
	b=A34iUUL5pDcfpbX2HEvIc9znIn3oqdBCz7KeCIzJIfu7gIPs6eyWqvRD+Y3V8D3w6rEZYw
	hnx6ohrZPBCqIrQujT07EN0iT579Z3ow+F5TIq9xvpuZN2IdZ5VBu7i3dcbBapFU0RQ47O
	GdnQQHpgrnSQDbH7rUVs/91iPRuHA/c=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=A34iUUL5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721020953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Tim8gwE8VaMxFmyocNueVmXLjWapojjFRs4umo+UT4=;
	b=A34iUUL5pDcfpbX2HEvIc9znIn3oqdBCz7KeCIzJIfu7gIPs6eyWqvRD+Y3V8D3w6rEZYw
	hnx6ohrZPBCqIrQujT07EN0iT579Z3ow+F5TIq9xvpuZN2IdZ5VBu7i3dcbBapFU0RQ47O
	GdnQQHpgrnSQDbH7rUVs/91iPRuHA/c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1540134AB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:22:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6MiHJhiylGZdRQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:22:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs-progs: use btrfs_link_subvolume() to replace btrfs_mksubvol()
Date: Mon, 15 Jul 2024 14:52:10 +0930
Message-ID: <90b482030cb58f803aa07016c632462f6d76c74e.1721020730.git.wqu@suse.com>
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
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: BC9AF1F7F3

The function btrfs_mksubvol() is very different between btrfs-progs and
kernel, the former version is really just linking a subvolume to another
directory inode, but the kernel version is really to make a completely
new subvolume.

Instead of same-named function, introduce btrfs_link_subvolume() and use
it to replace the old btrfs_mksubvol().

This is done by:

- Introduce btrfs_link_subvolume()
  Which would do extra checks before doing any modification:
  * Make sure the target inode is a directory
  * Make sure no filename conflict

  Then do the linkage:
  * Add the dir_item/dir_index into the parent inode
  * Add the forward and backward root refs into tree root

- Introduce link_image_subvolume() helper
  Currently btrfs_mksubvol() has a dedicated convert filename retry
  behavior, which is unnecessary and should be done by the convert code.

  Now move the filename retry behavior into the helper.

- Remove btrfs_mksubvol()
  Since there is only one caller utilizing btrfs_mksubvol(), and it's
  now gone, we can remove the old btrfs_mksubvol().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c             |   8 +--
 common/root-tree-utils.c | 107 ++++++++++++++++++++++++++++++
 common/root-tree-utils.h |   4 ++
 convert/main.c           |  64 ++++++++++++++++--
 kernel-shared/ctree.h    |   8 +--
 kernel-shared/inode.c    | 140 ++-------------------------------------
 6 files changed, 184 insertions(+), 147 deletions(-)

diff --git a/check/main.c b/check/main.c
index 8a572c22036e..205bbb4a3c73 100644
--- a/check/main.c
+++ b/check/main.c
@@ -2361,10 +2361,10 @@ static int repair_inode_backrefs(struct btrfs_root *root,
 			struct btrfs_trans_handle *trans;
 			struct btrfs_key location;
 
-			ret = check_dir_conflict(root, backref->name,
-						 backref->namelen,
-						 backref->dir,
-						 backref->index);
+			ret = btrfs_check_dir_conflict(root, backref->name,
+						       backref->namelen,
+						       backref->dir,
+						       backref->index);
 			if (ret) {
 				/*
 				 * let nlink fixing routine to handle it,
diff --git a/common/root-tree-utils.c b/common/root-tree-utils.c
index a937037ea4fd..39e4a7be9498 100644
--- a/common/root-tree-utils.c
+++ b/common/root-tree-utils.c
@@ -106,3 +106,110 @@ error:
 	btrfs_abort_transaction(trans, ret);
 	return ret;
 }
+
+/*
+ * Link subvoume @subvol as @name under directory inode @parent_dir of
+ * subvolume @parent_root.
+ */
+int btrfs_link_subvolume(struct btrfs_trans_handle *trans,
+			 struct btrfs_root *parent_root,
+			 u64 parent_dir, const char *name,
+			 int namelen, struct btrfs_root *subvol)
+{
+	struct btrfs_root *tree_root = trans->fs_info->tree_root;
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	struct btrfs_inode_item *ii;
+	u64 index;
+	u64 isize;
+	u32 imode;
+	int ret;
+
+	UASSERT(namelen && namelen <= BTRFS_NAME_LEN);
+
+	/* Make sure @parent_dir is a directory. */
+	key.objectid = parent_dir;
+	key.type = BTRFS_INODE_ITEM_KEY;
+	key.offset = 0;
+	ret = btrfs_search_slot(NULL, parent_root, &key, &path, 0, 0);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0) {
+		btrfs_release_path(&path);
+		return ret;
+	}
+	ii = btrfs_item_ptr(path.nodes[0], path.slots[0], struct btrfs_inode_item);
+	imode = btrfs_inode_mode(path.nodes[0], ii);
+	btrfs_release_path(&path);
+
+	if (!S_ISDIR(imode)) {
+		ret = -EUCLEAN;
+		error("%s: inode %llu of subvolume %llu is not a directory",
+		      __func__, parent_dir, parent_root->root_key.objectid);
+		return ret;
+	}
+
+	ret = btrfs_find_free_dir_index(parent_root, parent_dir, &index);
+	if (ret < 0)
+		return ret;
+
+	/* Filename conflicts check. */
+	ret = btrfs_check_dir_conflict(parent_root, name, namelen, parent_dir,
+				       index);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Now everything is fine, add the link.
+	 * From now on, every error would lead to transaction abort.
+	 *
+	 * Add the dir_item/index first.
+	 */
+	ret = btrfs_insert_dir_item(trans, parent_root, name, namelen,
+				    parent_dir, &subvol->root_key,
+				    BTRFS_FT_DIR, index);
+	if (ret < 0)
+		goto abort;
+
+	/* Update inode size of the parent inode */
+	key.objectid = parent_dir;
+	key.type = BTRFS_INODE_ITEM_KEY;
+	key.offset = 0;
+	ret = btrfs_search_slot(trans, parent_root, &key, &path, 1, 1);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0) {
+		btrfs_release_path(&path);
+		goto abort;
+	}
+	ii = btrfs_item_ptr(path.nodes[0], path.slots[0],
+			    struct btrfs_inode_item);
+	isize = btrfs_inode_size(path.nodes[0], ii);
+	isize += namelen * 2;
+	btrfs_set_inode_size(path.nodes[0], ii, isize);
+	btrfs_mark_buffer_dirty(path.nodes[0]);
+	btrfs_release_path(&path);
+
+	/* Add the root backref. */
+	ret = btrfs_add_root_ref(trans, tree_root, subvol->root_key.objectid,
+				 BTRFS_ROOT_BACKREF_KEY,
+				 parent_root->root_key.objectid, parent_dir,
+				 index, name, namelen);
+	if (ret < 0)
+		goto abort;
+
+	/* Then forward ref*/
+	ret = btrfs_add_root_ref(trans, tree_root,
+				 parent_root->root_key.objectid,
+				 BTRFS_ROOT_REF_KEY, subvol->root_key.objectid,
+				 parent_dir, index, name, namelen);
+	if (ret < 0)
+		goto abort;
+	/* For now, all root should have its refs == 1 already.
+	 * So no need to update the root refs. */
+	UASSERT(btrfs_root_refs(&subvol->root_item) == 1);
+	return 0;
+abort:
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
diff --git a/common/root-tree-utils.h b/common/root-tree-utils.h
index f4e354c0bf3e..c5318bd9b8db 100644
--- a/common/root-tree-utils.h
+++ b/common/root-tree-utils.h
@@ -22,5 +22,9 @@
 int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root, u64 objectid);
 int btrfs_make_subvolume(struct btrfs_trans_handle *trans, u64 objectid);
+int btrfs_link_subvolume(struct btrfs_trans_handle *trans,
+			 struct btrfs_root *parent_root,
+			 u64 parent_dir, const char *name,
+			 int namelen, struct btrfs_root *subvol);
 
 #endif
diff --git a/convert/main.c b/convert/main.c
index 31fa146c86b1..b2d0d5666737 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1110,6 +1110,62 @@ static int convert_open_fs(const char *devname,
 	return -1;
 }
 
+static int link_image_subvolume(struct btrfs_root *image_root, char *name)
+{
+	struct btrfs_fs_info *fs_info = image_root->fs_info;
+	struct btrfs_root *fs_root = fs_info->fs_root;
+	struct btrfs_trans_handle *trans;
+	char buf[BTRFS_NAME_LEN + 1]; /* for snprintf, null terminated. */
+	int ret;
+
+	/*
+	 * 1 root backref 1 root forward ref, 1 dir item 1 dir index,
+	 * and finally one root item.
+	 */
+	trans = btrfs_start_transaction(fs_root, 5);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction to link subvolume: %m");
+		return PTR_ERR(trans);
+	}
+	ret = btrfs_link_subvolume(trans, fs_root, btrfs_root_dirid(&fs_root->root_item),
+			name, strlen(name), image_root);
+	/* No filename conflicts, all done. */
+	if (!ret)
+		goto commit;
+	/* Other unexpected errors. */
+	if (ret != -EEXIST) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
+	/* Filename conflicts detected, try different names. */
+	for (int i = 0; i < 1024; i++) {
+		int len;
+
+		len = snprintf(buf, ARRAY_SIZE(buf), "%s%d", name, i);
+		if (len == 0 || len > BTRFS_NAME_LEN) {
+			error("failed to find an alternative name for image_root");
+			ret = -EINVAL;
+			goto abort;
+		}
+		ret = btrfs_link_subvolume(trans, fs_root,
+					   btrfs_root_dirid(&fs_root->root_item),
+					   buf, len, image_root);
+		if (!ret)
+			break;
+		if (ret != -EEXIST)
+			goto abort;
+	}
+commit:
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	return ret;
+abort:
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
+
 static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 		const char *fslabel, int progress,
 		struct btrfs_mkfs_features *features, u16 csum_type,
@@ -1276,10 +1332,10 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 		task_deinit(ctx.info);
 	}
 
-	image_root = btrfs_mksubvol(root, subvol_name,
-				    CONV_IMAGE_SUBVOL_OBJECTID, true);
-	if (!image_root) {
-		error("unable to link subvolume %s", subvol_name);
+	ret = link_image_subvolume(image_root, subvol_name);
+	if (ret < 0) {
+		errno = -ret;
+		error("unable to link subvolume %s: %m", subvol_name);
 		goto fail;
 	}
 
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 1341a418726b..2388879d1db3 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1212,8 +1212,10 @@ static inline int is_fstree(u64 rootid)
 void btrfs_uuid_to_key(const u8 *uuid, u8 type, struct btrfs_key *key);
 
 /* inode.c */
-int check_dir_conflict(struct btrfs_root *root, char *name, int namelen,
-		u64 dir, u64 index);
+int btrfs_find_free_dir_index(struct btrfs_root *root, u64 dir_ino,
+			      u64 *ret_ino);
+int btrfs_check_dir_conflict(struct btrfs_root *root, const char *name,
+			     int namelen, u64 dir, u64 index);
 int btrfs_new_inode(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		u64 ino, u32 mode);
 int btrfs_change_inode_flags(struct btrfs_trans_handle *trans,
@@ -1229,8 +1231,6 @@ int btrfs_add_orphan_item(struct btrfs_trans_handle *trans,
 			  u64 ino);
 int btrfs_mkdir(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		char *name, int namelen, u64 parent_ino, u64 *ino, int mode);
-struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root, const char *base,
-				  u64 root_objectid, bool convert);
 int btrfs_find_free_objectid(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *fs_root,
 			     u64 dirid, u64 *objectid);
diff --git a/kernel-shared/inode.c b/kernel-shared/inode.c
index 91b4f629f3ac..5927af041dbf 100644
--- a/kernel-shared/inode.c
+++ b/kernel-shared/inode.c
@@ -40,8 +40,8 @@
  * Find a free inode index for later btrfs_add_link().
  * Currently just search from the largest dir_index and +1.
  */
-static int btrfs_find_free_dir_index(struct btrfs_root *root, u64 dir_ino,
-				     u64 *ret_ino)
+int btrfs_find_free_dir_index(struct btrfs_root *root, u64 dir_ino,
+			      u64 *ret_ino)
 {
 	struct btrfs_path *path;
 	struct btrfs_key key;
@@ -93,8 +93,8 @@ out:
 }
 
 /* Check the dir_item/index conflicts before insert */
-int check_dir_conflict(struct btrfs_root *root, char *name, int namelen,
-		       u64 dir, u64 index)
+int btrfs_check_dir_conflict(struct btrfs_root *root, const char *name,
+			     int namelen, u64 dir, u64 index)
 {
 	struct btrfs_path *path;
 	struct btrfs_key key;
@@ -190,7 +190,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			goto out;
 	}
 
-	ret = check_dir_conflict(root, name, namelen, parent_ino, ret_index);
+	ret = btrfs_check_dir_conflict(root, name, namelen, parent_ino, ret_index);
 	if (ret < 0 && !(ignore_existed && ret == -EEXIST))
 		goto out;
 
@@ -582,136 +582,6 @@ out:
 	return ret;
 }
 
-struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
-				  const char *base, u64 root_objectid,
-				  bool convert)
-{
-	struct btrfs_trans_handle *trans;
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_root *tree_root = fs_info->tree_root;
-	struct btrfs_root *new_root = NULL;
-	struct btrfs_path path = { 0 };
-	struct btrfs_inode_item *inode_item;
-	struct extent_buffer *leaf;
-	struct btrfs_key key;
-	u64 dirid = btrfs_root_dirid(&root->root_item);
-	u64 index = 2;
-	char buf[BTRFS_NAME_LEN + 1]; /* for snprintf null */
-	int len;
-	int i;
-	int ret;
-
-	len = strlen(base);
-	if (len == 0 || len > BTRFS_NAME_LEN)
-		return NULL;
-
-	key.objectid = dirid;
-	key.type = BTRFS_DIR_INDEX_KEY;
-	key.offset = (u64)-1;
-
-	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
-	if (ret <= 0) {
-		error("search for DIR_INDEX dirid %llu failed: %d",
-				(unsigned long long)dirid, ret);
-		goto fail;
-	}
-
-	if (path.slots[0] > 0) {
-		path.slots[0]--;
-		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
-		if (key.objectid == dirid && key.type == BTRFS_DIR_INDEX_KEY)
-			index = key.offset + 1;
-	}
-	btrfs_release_path(&path);
-
-	trans = btrfs_start_transaction(root, 1);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		errno = -ret;
-		error_msg(ERROR_MSG_START_TRANS, "%m");
-		goto fail;
-	}
-
-	key.objectid = dirid;
-	key.type =  BTRFS_INODE_ITEM_KEY;
-	key.offset = 0;
-
-	ret = btrfs_lookup_inode(trans, root, &path, &key, 1);
-	if (ret) {
-		error("search for INODE_ITEM %llu failed: %d",
-				(unsigned long long)dirid, ret);
-		goto fail;
-	}
-	leaf = path.nodes[0];
-	inode_item = btrfs_item_ptr(leaf, path.slots[0],
-				    struct btrfs_inode_item);
-
-	key.objectid = root_objectid;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = (u64)-1;
-
-	memcpy(buf, base, len);
-	if (convert) {
-		for (i = 0; i < 1024; i++) {
-			ret = btrfs_insert_dir_item(trans, root, buf, len,
-					dirid, &key, BTRFS_FT_DIR, index);
-			if (ret != -EEXIST)
-				break;
-			len = snprintf(buf, ARRAY_SIZE(buf), "%s%d", base, i);
-			if (len < 1 || len > BTRFS_NAME_LEN) {
-				ret = -EINVAL;
-				break;
-			}
-		}
-	} else {
-		ret = btrfs_insert_dir_item(trans, root, buf, len, dirid, &key,
-					    BTRFS_FT_DIR, index);
-	}
-	if (ret)
-		goto fail;
-
-	btrfs_set_inode_size(leaf, inode_item, len * 2 +
-			     btrfs_inode_size(leaf, inode_item));
-	btrfs_mark_buffer_dirty(leaf);
-	btrfs_release_path(&path);
-
-	/* add the backref first */
-	ret = btrfs_add_root_ref(trans, tree_root, root_objectid,
-				 BTRFS_ROOT_BACKREF_KEY,
-				 root->root_key.objectid,
-				 dirid, index, buf, len);
-	if (ret) {
-		error("unable to add root backref for %llu: %d",
-				root->root_key.objectid, ret);
-		goto fail;
-	}
-
-	/* now add the forward ref */
-	ret = btrfs_add_root_ref(trans, tree_root, root->root_key.objectid,
-				 BTRFS_ROOT_REF_KEY, root_objectid,
-				 dirid, index, buf, len);
-	if (ret) {
-		error("unable to add root ref for %llu: %d",
-				root->root_key.objectid, ret);
-		goto fail;
-	}
-
-	ret = btrfs_commit_transaction(trans, root);
-	if (ret) {
-		errno = -ret;
-		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
-		goto fail;
-	}
-
-	new_root = btrfs_read_fs_root(fs_info, &key);
-	if (IS_ERR(new_root)) {
-		error("unable to fs read root: %lu", PTR_ERR(new_root));
-		new_root = NULL;
-	}
-fail:
-	return new_root;
-}
-
 /*
  * Walk the tree of allocated inodes and find a hole.
  */
-- 
2.45.2


