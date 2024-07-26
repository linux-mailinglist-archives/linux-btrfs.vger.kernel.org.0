Return-Path: <linux-btrfs+bounces-6714-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7360093D0BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 12:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A47E1F22673
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 10:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280E817839F;
	Fri, 26 Jul 2024 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bofij1bX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bofij1bX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92617799F
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988025; cv=none; b=VOyYGjUV6uueBIl59EDyaZexdG6X8sfAJs0q03gBmInXVDHq7jxs8ZFUbqPcEKv72ZWNegQwoC61KLAIXCGG3wMUT7sX7UsQhPF3qSjMp3f93t4wAEtsXIOntN4hQtZTzrqV/DM7VZY6al25dSusxkxuOaiwvOvs1ImU644Ct6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988025; c=relaxed/simple;
	bh=jiOQGdqTXiJoM9cT0glpfVv0+pKqf8r+1qIonRhUw0g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuBI18yLZz1PM4CEmMVF5wgPScZA8rjStAcz4gNdpEkvppYMy9F61C+XNo1ToJifG7oBptFOubYEgFhetfgSXOnUb9lk0xYaNb1tCGvXUganigkEvQ/CTptRytGpAC6EnlfalRqdXOb9lPMeNb8+oBpLEsPNosPIVYAWa10YG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bofij1bX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bofij1bX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AFCA11F892
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721988021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYdfK/URMOab9c1BPg6H7KlCfiVCHHObG/MvHjtFHUo=;
	b=bofij1bXWcEbNc8p155LA40c20j4TmPq7DlDGL75P3EZXtOG0fxFhK9omeVVAZkkOjf9zV
	Ait+D3yXUeCldX0Nugyo8UyBwG+PuprvGsP+jG4k+ylXhseKAE2wC3H6UZKI+UKePBoDev
	zDngOQWZ1LuX2fzJ2/weStxk0zgvSHU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bofij1bX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721988021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYdfK/URMOab9c1BPg6H7KlCfiVCHHObG/MvHjtFHUo=;
	b=bofij1bXWcEbNc8p155LA40c20j4TmPq7DlDGL75P3EZXtOG0fxFhK9omeVVAZkkOjf9zV
	Ait+D3yXUeCldX0Nugyo8UyBwG+PuprvGsP+jG4k+ylXhseKAE2wC3H6UZKI+UKePBoDev
	zDngOQWZ1LuX2fzJ2/weStxk0zgvSHU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D225D1396E
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:00:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4CvqIrRzo2YeTwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:00:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: cross-port btrfs_uuid_tree_add() from kernel
Date: Fri, 26 Jul 2024 19:29:54 +0930
Message-ID: <7f424e054b690d6a0b49f1d508f41df9d3ab5dc8.1721987605.git.wqu@suse.com>
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AFCA11F892
X-Spam-Score: -2.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]

The modification is minimal:

- Replace WARN_ON() with UASSERT()

- Remove the @trans parameter for btrfs_extend_item() and
  btrfs_mark_buffer_dirty()
  As progs version doesn't need a transaction handler.

- Remove the btrfs_uuid_tree_add() in mkfs/main.c

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/uuid-tree.c | 119 ++++++++++++++++++++++++++++++++++++++
 kernel-shared/uuid-tree.h |   2 +
 mkfs/main.c               |  56 ------------------
 3 files changed, 121 insertions(+), 56 deletions(-)

diff --git a/kernel-shared/uuid-tree.c b/kernel-shared/uuid-tree.c
index 26359520d57c..3b00945d3981 100644
--- a/kernel-shared/uuid-tree.c
+++ b/kernel-shared/uuid-tree.c
@@ -30,6 +30,7 @@
 #include "kernel-shared/messages.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/uuid-tree.h"
+#include "kernel-shared/disk-io.h"
 #include "common/messages.h"
 #include "common/utils.h"
 
@@ -199,3 +200,121 @@ out:
 	btrfs_free_path(path);
 	return ret;
 }
+
+/* return -ENOENT for !found, < 0 for errors, or 0 if an item was found */
+static int btrfs_uuid_tree_lookup(struct btrfs_root *uuid_root, const u8 *uuid,
+				  u8 type, u64 subid)
+{
+	int ret;
+	struct btrfs_path *path = NULL;
+	struct extent_buffer *eb;
+	int slot;
+	u32 item_size;
+	unsigned long offset;
+	struct btrfs_key key;
+
+	UASSERT(uuid_root);
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	btrfs_uuid_to_key(uuid, type, &key);
+	ret = btrfs_search_slot(NULL, uuid_root, &key, path, 0, 0);
+	if (ret < 0) {
+		goto out;
+	} else if (ret > 0) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	eb = path->nodes[0];
+	slot = path->slots[0];
+	item_size = btrfs_item_size(eb, slot);
+	offset = btrfs_item_ptr_offset(eb, slot);
+	ret = -ENOENT;
+
+	if (!IS_ALIGNED(item_size, sizeof(u64))) {
+		btrfs_warn(uuid_root->fs_info,
+			   "uuid item with illegal size %lu!",
+			   (unsigned long)item_size);
+		goto out;
+	}
+	while (item_size) {
+		__le64 data;
+
+		read_extent_buffer(eb, &data, offset, sizeof(data));
+		if (le64_to_cpu(data) == subid) {
+			ret = 0;
+			break;
+		}
+		offset += sizeof(data);
+		item_size -= sizeof(data);
+	}
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
+int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, const u8 *uuid, u8 type,
+			u64 subid_cpu)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *uuid_root = fs_info->uuid_root;
+	int ret;
+	struct btrfs_path *path = NULL;
+	struct btrfs_key key;
+	struct extent_buffer *eb;
+	int slot;
+	unsigned long offset;
+	__le64 subid_le;
+
+	ret = btrfs_uuid_tree_lookup(uuid_root, uuid, type, subid_cpu);
+	if (ret != -ENOENT)
+		return ret;
+
+	UASSERT(uuid_root);
+	btrfs_uuid_to_key(uuid, type, &key);
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = btrfs_insert_empty_item(trans, uuid_root, path, &key,
+				      sizeof(subid_le));
+	if (ret == 0) {
+		/* Add an item for the type for the first time */
+		eb = path->nodes[0];
+		slot = path->slots[0];
+		offset = btrfs_item_ptr_offset(eb, slot);
+	} else if (ret == -EEXIST) {
+		/*
+		 * An item with that type already exists.
+		 * Extend the item and store the new subid at the end.
+		 */
+		btrfs_extend_item(path, sizeof(subid_le));
+		eb = path->nodes[0];
+		slot = path->slots[0];
+		offset = btrfs_item_ptr_offset(eb, slot);
+		offset += btrfs_item_size(eb, slot) - sizeof(subid_le);
+	} else {
+		btrfs_warn(fs_info,
+			   "insert uuid item failed %d (0x%016llx, 0x%016llx) type %u!",
+			   ret, key.objectid, key.offset, type);
+		goto out;
+	}
+
+	ret = 0;
+	subid_le = cpu_to_le64(subid_cpu);
+	write_extent_buffer(eb, &subid_le, offset, sizeof(subid_le));
+	btrfs_mark_buffer_dirty(eb);
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
diff --git a/kernel-shared/uuid-tree.h b/kernel-shared/uuid-tree.h
index 0cdc2228c44f..904cabe7ea94 100644
--- a/kernel-shared/uuid-tree.h
+++ b/kernel-shared/uuid-tree.h
@@ -29,5 +29,7 @@ int btrfs_lookup_uuid_received_subvol_item(int fd, const u8 *uuid,
 int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 			   u64 subid);
 void btrfs_uuid_to_key(const u8 *uuid, u8 type, struct btrfs_key *key);
+int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, const u8 *uuid, u8 type,
+			u64 subid_cpu);
 
 #endif
diff --git a/mkfs/main.c b/mkfs/main.c
index 9a6047f7296b..b95f1c3372a3 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -736,62 +736,6 @@ static void update_chunk_allocation(struct btrfs_fs_info *fs_info,
 	}
 }
 
-static int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid,
-			       u8 type, u64 subvol_id_cpu)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *uuid_root = fs_info->uuid_root;
-	int ret;
-	struct btrfs_path *path = NULL;
-	struct btrfs_key key;
-	struct extent_buffer *eb;
-	int slot;
-	unsigned long offset;
-	__le64 subvol_id_le;
-
-	btrfs_uuid_to_key(uuid, type, &key);
-
-	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	ret = btrfs_insert_empty_item(trans, uuid_root, path, &key, sizeof(subvol_id_le));
-	if (ret < 0 && ret != -EEXIST) {
-		warning(
-		"inserting uuid item failed (0x%016llx, 0x%016llx) type %u: %d",
-			key.objectid, key.offset, type, ret);
-		goto out;
-	}
-
-	if (ret >= 0) {
-		/* Add an item for the type for the first time. */
-		eb = path->nodes[0];
-		slot = path->slots[0];
-		offset = btrfs_item_ptr_offset(eb, slot);
-	} else {
-		/*
-		 * ret == -EEXIST case, an item with that type already exists.
-		 * Extend the item and store the new subvol_id at the end.
-		 */
-		btrfs_extend_item(path, sizeof(subvol_id_le));
-		eb = path->nodes[0];
-		slot = path->slots[0];
-		offset = btrfs_item_ptr_offset(eb, slot);
-		offset += btrfs_item_size(eb, slot) - sizeof(subvol_id_le);
-	}
-
-	ret = 0;
-	subvol_id_le = cpu_to_le64(subvol_id_cpu);
-	write_extent_buffer(eb, &subvol_id_le, offset, sizeof(subvol_id_le));
-	btrfs_mark_buffer_dirty(eb);
-
-out:
-	btrfs_free_path(path);
-	return ret;
-}
-
 static int create_uuid_tree(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-- 
2.45.2


