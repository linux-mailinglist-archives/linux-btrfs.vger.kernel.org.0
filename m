Return-Path: <linux-btrfs+bounces-6715-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F8293D0C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 12:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3575B21F51
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C830C178CCD;
	Fri, 26 Jul 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WbDfNStj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WbDfNStj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D390F178393
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988027; cv=none; b=Ayuus3YrWGlKdMqwqmSGOntQhiW8VqbHVXF8TQptLLeogdupX8tsbsTHxTpRhGphhvB6BsxmbZR+k3UWJpZrrBXR7yriP5WW/bj6G7AzI/l7JtBif7K9gT9fQoS/TjSNYJLLRyJVBTw0OdPDPU5iJ2srNOMQum8uQiEszxSoODU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988027; c=relaxed/simple;
	bh=HmL6hDvr1NKwnN2dZ3Ph2IiYbsAG4OO47155e7DD3KA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZBMxxpfeFLJiNbzNpjaD5a3iXhiI9x4xXfYyKedZdIPAn3q6WY+kBVtP9eMJeyRr5BlkUZDRg3OPxPydxvzsxnGvH5KjJNjPJ+QKINm5ycw03K3EPnQMSG7BdwQXue+0CbKarjdwxKBnJ0VKNy4EE7uPAT2kp3rCSYgIFWLuv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WbDfNStj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WbDfNStj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1916B1F894
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721988023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QH+h60tIpaWjOALgXTs5FIhcpn6udYaDvRTYHq3TzXA=;
	b=WbDfNStjpbplGfgdokWGr3stHxeFbaRiPm1uGjxlwx47kcGxsasq6Ks5+M3ZWN736x8JKA
	nczd0CF82lhHTRhPEz7IjY6lVIWcrRs2wI5i7oLLqPkZReBtTZzAOW8Gkmn0jQYpeUNkge
	xqFLCh51RNu1L9ss1xklZalQHqQKPeI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WbDfNStj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721988023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QH+h60tIpaWjOALgXTs5FIhcpn6udYaDvRTYHq3TzXA=;
	b=WbDfNStjpbplGfgdokWGr3stHxeFbaRiPm1uGjxlwx47kcGxsasq6Ks5+M3ZWN736x8JKA
	nczd0CF82lhHTRhPEz7IjY6lVIWcrRs2wI5i7oLLqPkZReBtTZzAOW8Gkmn0jQYpeUNkge
	xqFLCh51RNu1L9ss1xklZalQHqQKPeI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D0F61396E
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:00:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OCENOrVzo2YeTwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:00:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: introduce btrfs_rebuild_uuid_tree() for mkfs and btrfs-convert
Date: Fri, 26 Jul 2024 19:29:55 +0930
Message-ID: <8e33931a4d078d1e1aa620aa5fe717f35146ef31.1721987605.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721987605.git.wqu@suse.com>
References: <cover.1721987605.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.81
X-Rspamd-Queue-Id: 1916B1F894

Currently mkfs uses its own create_uuid_tree(), but that function is
only handling FS_TREE.

This means for btrfs-convert, we do not generate the uuid tree, nor
add the UUID of the image subvolume.

This can be a problem if we're going to support multiple subvolumes
during mkfs time.

To address this inconvenience, this patch introduces a new helper,
btrfs_rebuild_uuid_tree(), which will:

- Create a new uuid tree if there is not one

- Empty the existing uuid tree

- Iterate through all subvolumes
  * If the subvolume has no valid UUID, regenerate one
  * Add the uuid entry for the subvolume UUID
  * If the subvolume has received UUID, also add it to UUID tree

By this, this new helper can handle all the uuid tree generation needs for:

- Current mkfs
  Only one uuid entry for FS_TREE

- Current btrfs-convert
  Only FS_TREE and the image subvolume

- Future multi-subvolume mkfs
  As we do the scan for all subvolumes.

- Future "btrfs rescue rebuild-uuid-tree"

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/root-tree-utils.c | 265 +++++++++++++++++++++++++++++++++++++++
 common/root-tree-utils.h |   1 +
 convert/main.c           |   5 +
 mkfs/main.c              |  37 +-----
 4 files changed, 274 insertions(+), 34 deletions(-)

diff --git a/common/root-tree-utils.c b/common/root-tree-utils.c
index 6a57c51a8a74..13f89dbd5293 100644
--- a/common/root-tree-utils.c
+++ b/common/root-tree-utils.c
@@ -15,9 +15,11 @@
  */
 
 #include <time.h>
+#include <uuid/uuid.h>
 #include "common/root-tree-utils.h"
 #include "common/messages.h"
 #include "kernel-shared/disk-io.h"
+#include "kernel-shared/uuid-tree.h"
 
 int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root, u64 objectid)
@@ -212,3 +214,266 @@ abort:
 	btrfs_abort_transaction(trans, ret);
 	return ret;
 }
+
+static int empty_tree(struct btrfs_root *root)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key = { 0 };
+	int ret;
+
+	trans = btrfs_start_transaction(root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error_msg(ERROR_MSG_START_TRANS, "emptry tree: %m");
+		return ret;
+	}
+	while (true) {
+		int nr_items;
+
+		ret = btrfs_search_slot(trans, root, &key, &path, -1, 1);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to locate the first key of root %lld: %m",
+				root->root_key.objectid);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+		UASSERT(ret > 0);
+		nr_items = btrfs_header_nritems(path.nodes[0]);
+		/* The tree is empty. */
+		if (nr_items == 0) {
+			btrfs_release_path(&path);
+			break;
+		}
+		ret = btrfs_del_items(trans, root, &path, 0, nr_items);
+		btrfs_release_path(&path);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to empty the first leaf of root %lld: %m",
+				root->root_key.objectid);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+	}
+	ret = btrfs_commit_transaction(trans, root);
+	if (ret < 0) {
+		errno = -ret;
+		error_msg(ERROR_MSG_COMMIT_TRANS, "empty tree: %m");
+	}
+	return ret;
+}
+
+static int rescan_subvol_uuid(struct btrfs_trans_handle *trans,
+			      struct btrfs_key *subvol_key)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *subvol;
+	int ret;
+
+	UASSERT(is_fstree(subvol_key->objectid));
+
+	/*
+	 * Read out the subvolume root and updates root::root_item.
+	 * This is to avoid de-sync between in-memory and on-disk root_items.
+	 */
+	subvol = btrfs_read_fs_root(fs_info, subvol_key);
+	if (IS_ERR(subvol)) {
+		ret = PTR_ERR(subvol);
+		error("failed to read subvolume %llu: %m",
+			subvol_key->objectid);
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+	/* The uuid is not set, regenerate one. */
+	if (uuid_is_null(subvol->root_item.uuid)) {
+		uuid_generate(subvol->root_item.uuid);
+		ret = btrfs_update_root(trans, fs_info->tree_root, &subvol->root_key,
+					&subvol->root_item);
+		if (ret < 0) {
+			error("failed to update subvolume %llu: %m",
+			      subvol_key->objectid);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+	}
+	ret = btrfs_uuid_tree_add(trans, subvol->root_item.uuid,
+				  BTRFS_UUID_KEY_SUBVOL,
+				  subvol->root_key.objectid);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to add uuid for subvolume %llu: %m",
+		      subvol_key->objectid);
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+	if (!uuid_is_null(subvol->root_item.received_uuid)) {
+		ret = btrfs_uuid_tree_add(trans, subvol->root_item.uuid,
+					  BTRFS_UUID_KEY_RECEIVED_SUBVOL,
+					  subvol->root_key.objectid);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to add received_uuid for subvol %llu: %m",
+			      subvol->root_key.objectid);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static int rescan_uuid_tree(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	struct btrfs_root *uuid_root = fs_info->uuid_root;
+	struct btrfs_trans_handle *trans;
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key = { 0 };
+	int ret;
+
+	UASSERT(uuid_root);
+	trans = btrfs_start_transaction(uuid_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error_msg(ERROR_MSG_START_TRANS, "rescan uuid tree: %m");
+		return ret;
+	}
+	key.objectid = BTRFS_LAST_FREE_OBJECTID;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = (u64)-1;
+	/* Iterate through all subvolumes except fs tree. */
+	while (true) {
+		struct btrfs_key found_key;
+		struct extent_buffer *leaf;
+		int slot;
+
+		/* No more subvolume. */
+		if (key.objectid < BTRFS_FIRST_FREE_OBJECTID) {
+			ret = 0;
+			break;
+		}
+		ret = btrfs_search_slot(NULL, tree_root, &key, &path, 0, 0);
+		if (ret < 0) {
+			errno = -ret;
+			error_msg(ERROR_MSG_READ, "iterate subvolumes: %m");
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+		if (ret > 0) {
+			ret = btrfs_previous_item(tree_root, &path,
+						  BTRFS_FIRST_FREE_OBJECTID,
+						  BTRFS_ROOT_ITEM_KEY);
+			if (ret < 0) {
+				errno = -ret;
+				btrfs_release_path(&path);
+				error_msg(ERROR_MSG_READ, "iterate subvolumes: %m");
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
+			/* No more subvolume. */
+			if (ret > 0) {
+				ret = 0;
+				btrfs_release_path(&path);
+				break;
+			}
+		}
+		leaf = path.nodes[0];
+		slot = path.slots[0];
+		btrfs_item_key_to_cpu(leaf, &found_key, slot);
+		btrfs_release_path(&path);
+		key.objectid = found_key.objectid - 1;
+
+		ret = rescan_subvol_uuid(trans, &found_key);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to rescan the uuid of subvolume %llu: %m",
+			      found_key.objectid);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+	}
+
+	/* Update fs tree uuid. */
+	key.objectid = BTRFS_FS_TREE_OBJECTID;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = 0;
+	ret = rescan_subvol_uuid(trans, &key);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to rescan the uuid of subvolume %llu: %m",
+		      key.objectid);
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+	ret = btrfs_commit_transaction(trans, uuid_root);
+	if (ret < 0) {
+		errno = -ret;
+		error_msg(ERROR_MSG_COMMIT_TRANS, "rescan uuid tree: %m");
+	}
+	return ret;
+}
+
+/*
+ * Rebuild the whole uuid tree.
+ *
+ * If no uuid tree is present, create a new one.
+ * If there is an existing uuid tree, all items would be deleted first.
+ *
+ * For all existing subvolumes (except fs tree), any uninitialized uuid
+ * (all zero) be generated using a random uuid, and inserted into the new tree.
+ * And if a subvolume has its UUID initialized, it would not be touched and
+ * be added to the new uuid tree.
+ */
+int btrfs_rebuild_uuid_tree(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *uuid_root;
+	struct btrfs_key key;
+	int ret;
+
+	if (!fs_info->uuid_root) {
+		struct btrfs_trans_handle *trans;
+
+		trans = btrfs_start_transaction(fs_info->tree_root, 1);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			errno = -ret;
+			error_msg(ERROR_MSG_START_TRANS, "create uuid tree: %m");
+			return ret;
+		}
+		key.objectid = BTRFS_UUID_TREE_OBJECTID;
+		key.type = BTRFS_ROOT_ITEM_KEY;
+		key.offset = 0;
+		uuid_root = btrfs_create_tree(trans, &key);
+		if (IS_ERR(uuid_root)) {
+			ret = PTR_ERR(uuid_root);
+			errno = -ret;
+			error("failed to create uuid root: %m");
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+		add_root_to_dirty_list(uuid_root);
+		fs_info->uuid_root = uuid_root;
+		ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+		if (ret < 0) {
+			errno = -ret;
+			error_msg(ERROR_MSG_COMMIT_TRANS, "create uuid tree: %m");
+			return ret;
+		}
+	}
+	UASSERT(fs_info->uuid_root);
+	ret = empty_tree(fs_info->uuid_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to clear the existing uuid tree: %m");
+		return ret;
+	}
+	ret = rescan_uuid_tree(fs_info);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to rescan the uuid tree: %m");
+		return ret;
+	}
+	return 0;
+}
diff --git a/common/root-tree-utils.h b/common/root-tree-utils.h
index 0c4ece24c7cc..3cb508022e0c 100644
--- a/common/root-tree-utils.h
+++ b/common/root-tree-utils.h
@@ -26,5 +26,6 @@ int btrfs_link_subvolume(struct btrfs_trans_handle *trans,
 			 struct btrfs_root *parent_root,
 			 u64 parent_dir, const char *name,
 			 int namelen, struct btrfs_root *subvol);
+int btrfs_rebuild_uuid_tree(struct btrfs_fs_info *fs_info);
 
 #endif
diff --git a/convert/main.c b/convert/main.c
index 078ef64e41ca..aa253781ee99 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1339,6 +1339,11 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 		goto fail;
 	}
 
+	ret = btrfs_rebuild_uuid_tree(image_root->fs_info);
+	if (ret < 0) {
+		errno = -ret;
+		goto fail;
+	}
 	memset(root->fs_info->super_copy->label, 0, BTRFS_LABEL_SIZE);
 	if (convert_flags & CONVERT_FLAG_COPY_LABEL) {
 		strncpy_null(root->fs_info->super_copy->label, cctx.label, BTRFS_LABEL_SIZE);
diff --git a/mkfs/main.c b/mkfs/main.c
index b95f1c3372a3..00ccac14a41a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -736,35 +736,6 @@ static void update_chunk_allocation(struct btrfs_fs_info *fs_info,
 	}
 }
 
-static int create_uuid_tree(struct btrfs_trans_handle *trans)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *root;
-	struct btrfs_key key = {
-		.objectid = BTRFS_UUID_TREE_OBJECTID,
-		.type = BTRFS_ROOT_ITEM_KEY,
-	};
-	int ret = 0;
-
-	UASSERT(fs_info->uuid_root == NULL);
-	root = btrfs_create_tree(trans, &key);
-	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		goto out;
-	}
-
-	add_root_to_dirty_list(root);
-	fs_info->uuid_root = root;
-	ret = btrfs_uuid_tree_add(trans, fs_info->fs_root->root_item.uuid,
-				  BTRFS_UUID_KEY_SUBVOL,
-				  fs_info->fs_root->root_key.objectid);
-	if (ret < 0)
-		btrfs_abort_transaction(trans, ret);
-
-out:
-	return ret;
-}
-
 static int create_global_root(struct btrfs_trans_handle *trans, u64 objectid,
 			      int root_id)
 {
@@ -1822,17 +1793,15 @@ raid_groups:
 		goto out;
 	}
 
-	ret = create_uuid_tree(trans);
-	if (ret)
-		warning(
-	"unable to create uuid tree, will be created after mount: %d", ret);
-
 	ret = btrfs_commit_transaction(trans, root);
 	if (ret) {
 		errno = -ret;
 		error_msg(ERROR_MSG_START_TRANS, "%m");
 		goto out;
 	}
+	ret = btrfs_rebuild_uuid_tree(fs_info);
+	if (ret < 0)
+		goto out;
 
 	ret = cleanup_temp_chunks(fs_info, &allocation, data_profile,
 				  metadata_profile, metadata_profile);
-- 
2.45.2


