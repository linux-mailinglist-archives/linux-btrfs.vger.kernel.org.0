Return-Path: <linux-btrfs+bounces-6676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B135193AC1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 06:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F19284581
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 04:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDD73FE4A;
	Wed, 24 Jul 2024 04:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="faGnVtTi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="faGnVtTi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A731DDF5B
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jul 2024 04:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721797170; cv=none; b=UqLKpJsKIWMYPu9cfGeuYm0ttp3hwSL1f2sPZMZ6DQhwyMzTXuxsIoHI2MPPAi+Nf1foayNU0uXAUCLG9vP7o9NJEEbp94i5KpJC5TCpeXiwGFuDUqVLjYLj61xp6NrVm33jz/Ku/Ja7b7zRLeGXVaVFcF3fX/+Fg+bRNlN3iGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721797170; c=relaxed/simple;
	bh=hQrnHspPSJqYFu3JymVrqh/Tj6iSgx2VD8yhNi669/c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=i5+f+1ntFkitUpVLuBNpXMLcRqyzl/n9fise8UMHFJyNEV/LdBspnSA2VnG+jSHSX/57knX/wKl96L1aF2A4Nxnb+WKYbFZPEwQzkm1eHk99875olYty/Fpr2yXL04gLkr7TCSDwE38akBWoue6bvNVMv/czcHf7ZfyKppkfvqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=faGnVtTi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=faGnVtTi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5EF51F74B
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jul 2024 04:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721797165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uOeqMXG4ANcRa/VO+N6BxB1XchT7IE6SmXM9hWQtBtM=;
	b=faGnVtTiweC3tO+yk6b+Q5xk0Z5L/19ymDVi9qLdoiZTtc9KvCXajRWkajAk+H84yGrBBO
	rRCaavnpQPux//NsK7sK8rErJ8DPWO3SKANUWS+wgc0zpzPXufDzbf1zLI3XR2/s+5ji1/
	qaFFrDZ+HqPDxav0tjiA5YreajQSGJU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721797165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uOeqMXG4ANcRa/VO+N6BxB1XchT7IE6SmXM9hWQtBtM=;
	b=faGnVtTiweC3tO+yk6b+Q5xk0Z5L/19ymDVi9qLdoiZTtc9KvCXajRWkajAk+H84yGrBBO
	rRCaavnpQPux//NsK7sK8rErJ8DPWO3SKANUWS+wgc0zpzPXufDzbf1zLI3XR2/s+5ji1/
	qaFFrDZ+HqPDxav0tjiA5YreajQSGJU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E56E41324F
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jul 2024 04:59:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 81ztJiyKoGZdFQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jul 2024 04:59:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: move uuid tree related code to uuid-tree.[ch]
Date: Wed, 24 Jul 2024 14:29:02 +0930
Message-ID: <953cb5cf507f8f25b6e89a0666164ae0315c9e8e.1721797137.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.40 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 0.40

Functions btrfs_uuid_scan_kthread() and btrfs_create_uuid_tree() are for
UUID tree rescan and creation, it's not suitable for volumes.[ch].

Move them to uuid-tree.[ch] instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/uuid-tree.c | 179 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/uuid-tree.h |   2 +
 fs/btrfs/volumes.c   | 177 ------------------------------------------
 fs/btrfs/volumes.h   |   2 -
 4 files changed, 181 insertions(+), 179 deletions(-)

diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index eae75bb572b9..c6399513c66f 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -3,6 +3,7 @@
  * Copyright (C) STRATO AG 2013.  All rights reserved.
  */
 
+#include <linux/kthread.h>
 #include <linux/uuid.h>
 #include <asm/unaligned.h>
 #include "messages.h"
@@ -12,6 +13,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "uuid-tree.h"
+#include "ioctl.h"
 
 static void btrfs_uuid_to_key(const u8 *uuid, u8 type, struct btrfs_key *key)
 {
@@ -390,3 +392,180 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
 	btrfs_free_path(path);
 	return ret;
 }
+
+int btrfs_uuid_scan_kthread(void *data)
+{
+	struct btrfs_fs_info *fs_info = data;
+	struct btrfs_root *root = fs_info->tree_root;
+	struct btrfs_key key;
+	struct btrfs_path *path = NULL;
+	int ret = 0;
+	struct extent_buffer *eb;
+	int slot;
+	struct btrfs_root_item root_item;
+	u32 item_size;
+	struct btrfs_trans_handle *trans = NULL;
+	bool closing = false;
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	key.objectid = 0;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = 0;
+
+	while (1) {
+		if (btrfs_fs_closing(fs_info)) {
+			closing = true;
+			break;
+		}
+		ret = btrfs_search_forward(root, &key, path,
+				BTRFS_OLDEST_GENERATION);
+		if (ret) {
+			if (ret > 0)
+				ret = 0;
+			break;
+		}
+
+		if (key.type != BTRFS_ROOT_ITEM_KEY ||
+		    (key.objectid < BTRFS_FIRST_FREE_OBJECTID &&
+		     key.objectid != BTRFS_FS_TREE_OBJECTID) ||
+		    key.objectid > BTRFS_LAST_FREE_OBJECTID)
+			goto skip;
+
+		eb = path->nodes[0];
+		slot = path->slots[0];
+		item_size = btrfs_item_size(eb, slot);
+		if (item_size < sizeof(root_item))
+			goto skip;
+
+		read_extent_buffer(eb, &root_item,
+				   btrfs_item_ptr_offset(eb, slot),
+				   (int)sizeof(root_item));
+		if (btrfs_root_refs(&root_item) == 0)
+			goto skip;
+
+		if (!btrfs_is_empty_uuid(root_item.uuid) ||
+		    !btrfs_is_empty_uuid(root_item.received_uuid)) {
+			if (trans)
+				goto update_tree;
+
+			btrfs_release_path(path);
+			/*
+			 * 1 - subvol uuid item
+			 * 1 - received_subvol uuid item
+			 */
+			trans = btrfs_start_transaction(fs_info->uuid_root, 2);
+			if (IS_ERR(trans)) {
+				ret = PTR_ERR(trans);
+				break;
+			}
+			continue;
+		} else {
+			goto skip;
+		}
+update_tree:
+		btrfs_release_path(path);
+		if (!btrfs_is_empty_uuid(root_item.uuid)) {
+			ret = btrfs_uuid_tree_add(trans, root_item.uuid,
+						  BTRFS_UUID_KEY_SUBVOL,
+						  key.objectid);
+			if (ret < 0) {
+				btrfs_warn(fs_info, "uuid_tree_add failed %d",
+					ret);
+				break;
+			}
+		}
+
+		if (!btrfs_is_empty_uuid(root_item.received_uuid)) {
+			ret = btrfs_uuid_tree_add(trans,
+						  root_item.received_uuid,
+						 BTRFS_UUID_KEY_RECEIVED_SUBVOL,
+						  key.objectid);
+			if (ret < 0) {
+				btrfs_warn(fs_info, "uuid_tree_add failed %d",
+					ret);
+				break;
+			}
+		}
+
+skip:
+		btrfs_release_path(path);
+		if (trans) {
+			ret = btrfs_end_transaction(trans);
+			trans = NULL;
+			if (ret)
+				break;
+		}
+
+		if (key.offset < (u64)-1) {
+			key.offset++;
+		} else if (key.type < BTRFS_ROOT_ITEM_KEY) {
+			key.offset = 0;
+			key.type = BTRFS_ROOT_ITEM_KEY;
+		} else if (key.objectid < (u64)-1) {
+			key.offset = 0;
+			key.type = BTRFS_ROOT_ITEM_KEY;
+			key.objectid++;
+		} else {
+			break;
+		}
+		cond_resched();
+	}
+
+out:
+	btrfs_free_path(path);
+	if (trans && !IS_ERR(trans))
+		btrfs_end_transaction(trans);
+	if (ret)
+		btrfs_warn(fs_info, "btrfs_uuid_scan_kthread failed %d", ret);
+	else if (!closing)
+		set_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags);
+	up(&fs_info->uuid_tree_rescan_sem);
+	return 0;
+}
+
+int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	struct btrfs_root *uuid_root;
+	struct task_struct *task;
+	int ret;
+
+	/*
+	 * 1 - root node
+	 * 1 - root item
+	 */
+	trans = btrfs_start_transaction(tree_root, 2);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	uuid_root = btrfs_create_tree(trans, BTRFS_UUID_TREE_OBJECTID);
+	if (IS_ERR(uuid_root)) {
+		ret = PTR_ERR(uuid_root);
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		return ret;
+	}
+
+	fs_info->uuid_root = uuid_root;
+
+	ret = btrfs_commit_transaction(trans);
+	if (ret)
+		return ret;
+
+	down(&fs_info->uuid_tree_rescan_sem);
+	task = kthread_run(btrfs_uuid_scan_kthread, fs_info, "btrfs-uuid");
+	if (IS_ERR(task)) {
+		/* fs_info->update_uuid_tree_gen remains 0 in all error case */
+		btrfs_warn(fs_info, "failed to start uuid_scan task");
+		up(&fs_info->uuid_tree_rescan_sem);
+		return PTR_ERR(task);
+	}
+
+	return 0;
+}
diff --git a/fs/btrfs/uuid-tree.h b/fs/btrfs/uuid-tree.h
index a3f5757cc7cf..c60ad20325cc 100644
--- a/fs/btrfs/uuid-tree.h
+++ b/fs/btrfs/uuid-tree.h
@@ -13,5 +13,7 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, const u8 *uuid, u8 typ
 int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8 type,
 			u64 subid);
 int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info);
+int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
+int btrfs_uuid_scan_kthread(void *data);
 
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9437e779d020..a004c2f8e114 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4784,183 +4784,6 @@ int btrfs_cancel_balance(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
-int btrfs_uuid_scan_kthread(void *data)
-{
-	struct btrfs_fs_info *fs_info = data;
-	struct btrfs_root *root = fs_info->tree_root;
-	struct btrfs_key key;
-	struct btrfs_path *path = NULL;
-	int ret = 0;
-	struct extent_buffer *eb;
-	int slot;
-	struct btrfs_root_item root_item;
-	u32 item_size;
-	struct btrfs_trans_handle *trans = NULL;
-	bool closing = false;
-
-	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	key.objectid = 0;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = 0;
-
-	while (1) {
-		if (btrfs_fs_closing(fs_info)) {
-			closing = true;
-			break;
-		}
-		ret = btrfs_search_forward(root, &key, path,
-				BTRFS_OLDEST_GENERATION);
-		if (ret) {
-			if (ret > 0)
-				ret = 0;
-			break;
-		}
-
-		if (key.type != BTRFS_ROOT_ITEM_KEY ||
-		    (key.objectid < BTRFS_FIRST_FREE_OBJECTID &&
-		     key.objectid != BTRFS_FS_TREE_OBJECTID) ||
-		    key.objectid > BTRFS_LAST_FREE_OBJECTID)
-			goto skip;
-
-		eb = path->nodes[0];
-		slot = path->slots[0];
-		item_size = btrfs_item_size(eb, slot);
-		if (item_size < sizeof(root_item))
-			goto skip;
-
-		read_extent_buffer(eb, &root_item,
-				   btrfs_item_ptr_offset(eb, slot),
-				   (int)sizeof(root_item));
-		if (btrfs_root_refs(&root_item) == 0)
-			goto skip;
-
-		if (!btrfs_is_empty_uuid(root_item.uuid) ||
-		    !btrfs_is_empty_uuid(root_item.received_uuid)) {
-			if (trans)
-				goto update_tree;
-
-			btrfs_release_path(path);
-			/*
-			 * 1 - subvol uuid item
-			 * 1 - received_subvol uuid item
-			 */
-			trans = btrfs_start_transaction(fs_info->uuid_root, 2);
-			if (IS_ERR(trans)) {
-				ret = PTR_ERR(trans);
-				break;
-			}
-			continue;
-		} else {
-			goto skip;
-		}
-update_tree:
-		btrfs_release_path(path);
-		if (!btrfs_is_empty_uuid(root_item.uuid)) {
-			ret = btrfs_uuid_tree_add(trans, root_item.uuid,
-						  BTRFS_UUID_KEY_SUBVOL,
-						  key.objectid);
-			if (ret < 0) {
-				btrfs_warn(fs_info, "uuid_tree_add failed %d",
-					ret);
-				break;
-			}
-		}
-
-		if (!btrfs_is_empty_uuid(root_item.received_uuid)) {
-			ret = btrfs_uuid_tree_add(trans,
-						  root_item.received_uuid,
-						 BTRFS_UUID_KEY_RECEIVED_SUBVOL,
-						  key.objectid);
-			if (ret < 0) {
-				btrfs_warn(fs_info, "uuid_tree_add failed %d",
-					ret);
-				break;
-			}
-		}
-
-skip:
-		btrfs_release_path(path);
-		if (trans) {
-			ret = btrfs_end_transaction(trans);
-			trans = NULL;
-			if (ret)
-				break;
-		}
-
-		if (key.offset < (u64)-1) {
-			key.offset++;
-		} else if (key.type < BTRFS_ROOT_ITEM_KEY) {
-			key.offset = 0;
-			key.type = BTRFS_ROOT_ITEM_KEY;
-		} else if (key.objectid < (u64)-1) {
-			key.offset = 0;
-			key.type = BTRFS_ROOT_ITEM_KEY;
-			key.objectid++;
-		} else {
-			break;
-		}
-		cond_resched();
-	}
-
-out:
-	btrfs_free_path(path);
-	if (trans && !IS_ERR(trans))
-		btrfs_end_transaction(trans);
-	if (ret)
-		btrfs_warn(fs_info, "btrfs_uuid_scan_kthread failed %d", ret);
-	else if (!closing)
-		set_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags);
-	up(&fs_info->uuid_tree_rescan_sem);
-	return 0;
-}
-
-int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info)
-{
-	struct btrfs_trans_handle *trans;
-	struct btrfs_root *tree_root = fs_info->tree_root;
-	struct btrfs_root *uuid_root;
-	struct task_struct *task;
-	int ret;
-
-	/*
-	 * 1 - root node
-	 * 1 - root item
-	 */
-	trans = btrfs_start_transaction(tree_root, 2);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
-
-	uuid_root = btrfs_create_tree(trans, BTRFS_UUID_TREE_OBJECTID);
-	if (IS_ERR(uuid_root)) {
-		ret = PTR_ERR(uuid_root);
-		btrfs_abort_transaction(trans, ret);
-		btrfs_end_transaction(trans);
-		return ret;
-	}
-
-	fs_info->uuid_root = uuid_root;
-
-	ret = btrfs_commit_transaction(trans);
-	if (ret)
-		return ret;
-
-	down(&fs_info->uuid_tree_rescan_sem);
-	task = kthread_run(btrfs_uuid_scan_kthread, fs_info, "btrfs-uuid");
-	if (IS_ERR(task)) {
-		/* fs_info->update_uuid_tree_gen remains 0 in all error case */
-		btrfs_warn(fs_info, "failed to start uuid_scan task");
-		up(&fs_info->uuid_tree_rescan_sem);
-		return PTR_ERR(task);
-	}
-
-	return 0;
-}
-
 /*
  * shrinking a device means finding all of the device extents past
  * the new size, and then following the back refs to the chunks.
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 37a09ebb34dd..c947187539dd 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -725,8 +725,6 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info);
 int btrfs_pause_balance(struct btrfs_fs_info *fs_info);
 int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset);
 int btrfs_cancel_balance(struct btrfs_fs_info *fs_info);
-int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
-int btrfs_uuid_scan_kthread(void *data);
 bool btrfs_chunk_writeable(struct btrfs_fs_info *fs_info, u64 chunk_offset);
 void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index);
 int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
-- 
2.45.2


