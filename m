Return-Path: <linux-btrfs+bounces-9334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6D49BC5F9
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 07:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5701C2157E
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 06:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A791FDF89;
	Tue,  5 Nov 2024 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HrQnNRah";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HrQnNRah"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A71C75FA
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789324; cv=none; b=T1qh0zhvaYt9tbkq3MFhRW4IFMTl193SFdoyqyJHk22HrqEGWsZMTc0XKfEiczkFdW0X72JvVrA/fiSwdkjT1VEcXuiwJWABC+W86GCw5n6Akb90EAFv6CjxmAcLrMxzJ0YabgdQKjWQKIfTJr3lf0o2/Ba9nU2SfQBu6M+23bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789324; c=relaxed/simple;
	bh=Eu8ZhQtIC/jvL2zWHwDXb9BCzIqg7+eLoyhP8OOaD9A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LN2QVmKUAC6VfBX4G1XshAol2fauv4wtaPvMcZ1ufaRcr5n4bOCIo/s6aiq1gpCzmHXTSaHXar9O1fi1t+zUI7cKaC0lxi4UC0/LexpATh7ese8Xj0+DH6fF8GVPDwP21sL1oZkuOxPsZvAjzj2N5kY67/GxSH6O11bBDF1xa8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HrQnNRah; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HrQnNRah; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CEAA21BC6
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 06:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730789314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYH4CbH58cY3XW4XyIgJyfPuQoAHRcc/geCvNqsRGpg=;
	b=HrQnNRahpHXKsZRD+vEcXnpRfZ5qJCi8qtCxVIMuC1NYNvWrgTNUfDNeneTs985+SgOhu6
	+gM05xdCHfZt6wYrN/ANwEJLC34K8Yu3fa1yvZVjqX7bzvb1wAvpcXYXJrOOB/UAT1RIYB
	HygJey9ufsNSuB6eb5qXEQQOVX9p5/U=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=HrQnNRah
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730789314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYH4CbH58cY3XW4XyIgJyfPuQoAHRcc/geCvNqsRGpg=;
	b=HrQnNRahpHXKsZRD+vEcXnpRfZ5qJCi8qtCxVIMuC1NYNvWrgTNUfDNeneTs985+SgOhu6
	+gM05xdCHfZt6wYrN/ANwEJLC34K8Yu3fa1yvZVjqX7bzvb1wAvpcXYXJrOOB/UAT1RIYB
	HygJey9ufsNSuB6eb5qXEQQOVX9p5/U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6607113964
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 06:48:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sPGKCsG/KWeUDgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 05 Nov 2024 06:48:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: do not call btrfs_record_file_extent() out of btrfs-convert
Date: Tue,  5 Nov 2024 17:18:13 +1030
Message-ID: <ad7acbbad20cd3d88cf1482726aefae1506ce926.1730788965.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730788965.git.wqu@suse.com>
References: <cover.1730788965.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6CEAA21BC6
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The function btrfs_record_file_extent() has extra handling that's
specific to convert, like allowing the range to be split by block group
boundary and image file extent boundary.

All of these split can only lead to corruption for non-converted fs.
As the only caller out of btrfs-convert is rootdir, which expects the
file extent item insert to respect the reserved data extent, and never
to be split.

Thankfully this is not going to cause huge problem, as
btrfs_record_file_extent() has extra checks if the data extent overlaps
with any existing one, and if it doesn't the handling will be the same
as the kernel.

But to avoid abuse, change btrfs_record_file_extent() by:

- Rename it to btrfs_convert_file_extent()
  And add extra comments on that it is specific to btrfs-convert.

- Move it to convert/common.[ch]

- Introduce a helper insert_reserved_file_extent() for rootdir.c

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/extent-tree-utils.c | 240 ------------------------------------
 common/extent-tree-utils.h |   5 -
 convert/common.c           | 242 ++++++++++++++++++++++++++++++++++++-
 convert/common.h           |   6 +
 convert/main.c             |  10 +-
 convert/source-fs.c        |   4 +-
 convert/source-reiserfs.c  |   2 +-
 mkfs/rootdir.c             |  95 ++++++++++++++-
 8 files changed, 349 insertions(+), 255 deletions(-)

diff --git a/common/extent-tree-utils.c b/common/extent-tree-utils.c
index 9f7e543f3bd1..135798b98511 100644
--- a/common/extent-tree-utils.c
+++ b/common/extent-tree-utils.c
@@ -15,18 +15,13 @@
  */
 
 #include "kerncompat.h"
-#include <errno.h>
 #include <stddef.h>
 #include "kernel-shared/accessors.h"
 #include "kernel-shared/uapi/btrfs_tree.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
-#include "kernel-shared/file-item.h"
 #include "kernel-shared/transaction.h"
-#include "kernel-shared/free-space-tree.h"
-#include "common/internal.h"
 #include "common/extent-tree-utils.h"
-#include "common/messages.h"
 
 /*
  * Search in extent tree to found next meta/data extent. Caller needs to check
@@ -50,238 +45,3 @@ int btrfs_next_extent_item(struct btrfs_root *root, struct btrfs_path *path,
 		return 0;
 	}
 }
-
-static void __get_extent_size(struct btrfs_root *root, struct btrfs_path *path,
-			      u64 *start, u64 *len)
-{
-	struct btrfs_key key;
-
-	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-	BUG_ON(!(key.type == BTRFS_EXTENT_ITEM_KEY ||
-		 key.type == BTRFS_METADATA_ITEM_KEY));
-	*start = key.objectid;
-	if (key.type == BTRFS_EXTENT_ITEM_KEY)
-		*len = key.offset;
-	else
-		*len = root->fs_info->nodesize;
-}
-
-/*
- * Find first overlap extent for range [bytenr, bytenr + len).
- *
- * Return 0 for found and point path to it.
- * Return >0 for not found.
- * Return <0 for err
- */
-static int btrfs_search_overlap_extent(struct btrfs_root *root,
-				       struct btrfs_path *path, u64 bytenr, u64 len)
-{
-	struct btrfs_key key;
-	u64 cur_start;
-	u64 cur_len;
-	int ret;
-
-	key.objectid = bytenr;
-	key.type = BTRFS_EXTENT_DATA_KEY;
-	key.offset = (u64)-1;
-
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		return ret;
-	if (ret == 0) {
-		error_msg(ERROR_MSG_UNEXPECTED, "EXTENT_DATA found at %llu", bytenr);
-		return -EUCLEAN;
-	}
-
-	ret = btrfs_previous_extent_item(root, path, 0);
-	if (ret < 0)
-		return ret;
-	/* No previous, check next extent. */
-	if (ret > 0)
-		goto next;
-	__get_extent_size(root, path, &cur_start, &cur_len);
-	/* Tail overlap. */
-	if (cur_start + cur_len > bytenr)
-		return 1;
-
-next:
-	ret = btrfs_next_extent_item(root, path, bytenr + len);
-	if (ret < 0)
-		return ret;
-	/* No next, prev already checked, no overlap. */
-	if (ret > 0)
-		return 0;
-	__get_extent_size(root, path, &cur_start, &cur_len);
-	/* Head overlap.*/
-	if (cur_start < bytenr + len)
-		return 1;
-	return 0;
-}
-
-static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
-				      struct btrfs_root *root, u64 objectid,
-				      struct btrfs_inode_item *inode,
-				      u64 file_pos, u64 disk_bytenr,
-				      u64 *ret_num_bytes)
-{
-	int ret;
-	struct btrfs_fs_info *info = root->fs_info;
-	struct btrfs_root *extent_root = btrfs_extent_root(info, disk_bytenr);
-	struct extent_buffer *leaf;
-	struct btrfs_file_extent_item *fi;
-	struct btrfs_key ins_key;
-	struct btrfs_path *path;
-	struct btrfs_extent_item *ei;
-	u64 nbytes;
-	u64 extent_num_bytes;
-	u64 extent_bytenr;
-	u64 extent_offset;
-	u64 num_bytes = *ret_num_bytes;
-
-	/*
-	 * @objectid should be an inode number, thus it must not be smaller
-	 * than BTRFS_FIRST_FREE_OBJECTID.
-	 */
-	UASSERT(objectid >= BTRFS_FIRST_FREE_OBJECTID);
-
-	/*
-	 * All supported file system should not use its 0 extent.  As it's for
-	 * hole.  And hole extent has no size limit, no need to loop.
-	 */
-	if (disk_bytenr == 0) {
-		ret = btrfs_insert_file_extent(trans, root, objectid,
-					       file_pos, disk_bytenr,
-					       num_bytes, num_bytes);
-		return ret;
-	}
-	num_bytes = min_t(u64, num_bytes, BTRFS_MAX_EXTENT_SIZE);
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	/* First to check extent overlap. */
-	ret = btrfs_search_overlap_extent(extent_root, path, disk_bytenr, num_bytes);
-	if (ret < 0)
-		goto fail;
-	if (ret > 0) {
-		/* Found overlap. */
-		u64 cur_start;
-		u64 cur_len;
-
-		__get_extent_size(extent_root, path, &cur_start, &cur_len);
-		/* For convert case, this extent should be a subset of existing one. */
-		if (disk_bytenr < cur_start) {
-			error_msg(ERROR_MSG_UNEXPECTED,
-				  "invalid range disk_bytenr < cur_start: %llu < %llu",
-				  disk_bytenr, cur_start);
-			ret = -EUCLEAN;
-			goto fail;
-		}
-
-		extent_bytenr = cur_start;
-		extent_num_bytes = cur_len;
-		extent_offset = disk_bytenr - extent_bytenr;
-	} else {
-		/* No overlap, create new extent. */
-		btrfs_release_path(path);
-		ins_key.objectid = disk_bytenr;
-		ins_key.type = BTRFS_EXTENT_ITEM_KEY;
-		ins_key.offset = num_bytes;
-
-		ret = btrfs_insert_empty_item(trans, extent_root, path,
-					      &ins_key, sizeof(*ei));
-		if (ret == 0) {
-			leaf = path->nodes[0];
-			ei = btrfs_item_ptr(leaf, path->slots[0],
-					    struct btrfs_extent_item);
-
-			btrfs_set_extent_refs(leaf, ei, 0);
-			btrfs_set_extent_generation(leaf, ei, trans->transid);
-			btrfs_set_extent_flags(leaf, ei,
-					       BTRFS_EXTENT_FLAG_DATA);
-			btrfs_mark_buffer_dirty(leaf);
-
-			ret = btrfs_update_block_group(trans, disk_bytenr,
-						       num_bytes, 1, 0);
-			if (ret)
-				goto fail;
-		} else if (ret != -EEXIST) {
-			goto fail;
-		}
-
-		ret = remove_from_free_space_tree(trans, disk_bytenr, num_bytes);
-		if (ret)
-			goto fail;
-
-		btrfs_run_delayed_refs(trans, -1);
-		extent_bytenr = disk_bytenr;
-		extent_num_bytes = num_bytes;
-		extent_offset = 0;
-	}
-	btrfs_release_path(path);
-	ins_key.objectid = objectid;
-	ins_key.type = BTRFS_EXTENT_DATA_KEY;
-	ins_key.offset = file_pos;
-	ret = btrfs_insert_empty_item(trans, root, path, &ins_key, sizeof(*fi));
-	if (ret)
-		goto fail;
-	leaf = path->nodes[0];
-	fi = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
-	btrfs_set_file_extent_generation(leaf, fi, trans->transid);
-	btrfs_set_file_extent_type(leaf, fi, BTRFS_FILE_EXTENT_REG);
-	btrfs_set_file_extent_disk_bytenr(leaf, fi, extent_bytenr);
-	btrfs_set_file_extent_disk_num_bytes(leaf, fi, extent_num_bytes);
-	btrfs_set_file_extent_offset(leaf, fi, extent_offset);
-	btrfs_set_file_extent_num_bytes(leaf, fi, num_bytes);
-	btrfs_set_file_extent_ram_bytes(leaf, fi, extent_num_bytes);
-	btrfs_set_file_extent_compression(leaf, fi, 0);
-	btrfs_set_file_extent_encryption(leaf, fi, 0);
-	btrfs_set_file_extent_other_encoding(leaf, fi, 0);
-	btrfs_mark_buffer_dirty(leaf);
-
-	nbytes = btrfs_stack_inode_nbytes(inode) + num_bytes;
-	btrfs_set_stack_inode_nbytes(inode, nbytes);
-	btrfs_release_path(path);
-
-	ret = btrfs_inc_extent_ref(trans, extent_bytenr, extent_num_bytes,
-				   0, root->root_key.objectid, objectid,
-				   file_pos - extent_offset);
-	if (ret)
-		goto fail;
-	ret = 0;
-	*ret_num_bytes = min(extent_num_bytes - extent_offset, num_bytes);
-fail:
-	btrfs_free_path(path);
-	return ret;
-}
-
-/*
- * Record a file extent. Do all the required works, such as inserting file
- * extent item, inserting extent item and backref item into extent tree and
- * updating block accounting.
- */
-int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *root, u64 objectid,
-			     struct btrfs_inode_item *inode,
-			     u64 file_pos, u64 disk_bytenr,
-			     u64 num_bytes)
-{
-	u64 cur_disk_bytenr = disk_bytenr;
-	u64 cur_file_pos = file_pos;
-	u64 cur_num_bytes = num_bytes;
-	int ret = 0;
-
-	while (num_bytes > 0) {
-		ret = __btrfs_record_file_extent(trans, root, objectid,
-						 inode, cur_file_pos,
-						 cur_disk_bytenr,
-						 &cur_num_bytes);
-		if (ret < 0)
-			break;
-		cur_disk_bytenr += cur_num_bytes;
-		cur_file_pos += cur_num_bytes;
-		num_bytes -= cur_num_bytes;
-	}
-	return ret;
-}
diff --git a/common/extent-tree-utils.h b/common/extent-tree-utils.h
index f03d9c438375..e9d121345276 100644
--- a/common/extent-tree-utils.h
+++ b/common/extent-tree-utils.h
@@ -27,10 +27,5 @@ struct btrfs_trans_handle;
 
 int btrfs_next_extent_item(struct btrfs_root *root, struct btrfs_path *path,
 			   u64 max_objectid);
-int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *root, u64 objectid,
-			     struct btrfs_inode_item *inode,
-			     u64 file_pos, u64 disk_bytenr,
-			     u64 num_bytes);
 
 #endif
diff --git a/convert/common.c b/convert/common.c
index b093fdb5f14f..0ec9f2ec193f 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -27,10 +27,13 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/accessors.h"
-#include "kernel-shared/uapi/btrfs_tree.h"
+#include "kernel-shared/file-item.h"
+#include "kernel-shared/transaction.h"
+#include "kernel-shared/free-space-tree.h"
 #include "common/path-utils.h"
 #include "common/messages.h"
 #include "common/string-utils.h"
+#include "common/extent-tree-utils.h"
 #include "common/fsfeatures.h"
 #include "mkfs/common.h"
 #include "convert/common.h"
@@ -908,3 +911,240 @@ out:
 	return ret;
 }
 
+static void __get_extent_size(struct btrfs_root *root, struct btrfs_path *path,
+			      u64 *start, u64 *len)
+{
+	struct btrfs_key key;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	BUG_ON(!(key.type == BTRFS_EXTENT_ITEM_KEY ||
+		 key.type == BTRFS_METADATA_ITEM_KEY));
+	*start = key.objectid;
+	if (key.type == BTRFS_EXTENT_ITEM_KEY)
+		*len = key.offset;
+	else
+		*len = root->fs_info->nodesize;
+}
+
+/*
+ * Find first overlap extent for range [bytenr, bytenr + len).
+ *
+ * Return 0 for found and point path to it.
+ * Return >0 for not found.
+ * Return <0 for err
+ */
+static int btrfs_search_overlap_extent(struct btrfs_root *root,
+				       struct btrfs_path *path, u64 bytenr, u64 len)
+{
+	struct btrfs_key key;
+	u64 cur_start;
+	u64 cur_len;
+	int ret;
+
+	key.objectid = bytenr;
+	key.type = BTRFS_EXTENT_DATA_KEY;
+	key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret < 0)
+		return ret;
+	if (ret == 0) {
+		error_msg(ERROR_MSG_UNEXPECTED, "EXTENT_DATA found at %llu", bytenr);
+		return -EUCLEAN;
+	}
+
+	ret = btrfs_previous_extent_item(root, path, 0);
+	if (ret < 0)
+		return ret;
+	/* No previous, check next extent. */
+	if (ret > 0)
+		goto next;
+	__get_extent_size(root, path, &cur_start, &cur_len);
+	/* Tail overlap. */
+	if (cur_start + cur_len > bytenr)
+		return 1;
+
+next:
+	ret = btrfs_next_extent_item(root, path, bytenr + len);
+	if (ret < 0)
+		return ret;
+	/* No next, prev already checked, no overlap. */
+	if (ret > 0)
+		return 0;
+	__get_extent_size(root, path, &cur_start, &cur_len);
+	/* Head overlap.*/
+	if (cur_start < bytenr + len)
+		return 1;
+	return 0;
+}
+
+static int __btrfs_convert_file_extent(struct btrfs_trans_handle *trans,
+				       struct btrfs_root *root, u64 objectid,
+				       struct btrfs_inode_item *inode,
+				       u64 file_pos, u64 disk_bytenr,
+				       u64 *ret_num_bytes)
+{
+	int ret;
+	struct btrfs_fs_info *info = root->fs_info;
+	struct btrfs_root *extent_root = btrfs_extent_root(info, disk_bytenr);
+	struct extent_buffer *leaf;
+	struct btrfs_file_extent_item *fi;
+	struct btrfs_key ins_key;
+	struct btrfs_path *path;
+	struct btrfs_extent_item *ei;
+	u64 nbytes;
+	u64 extent_num_bytes;
+	u64 extent_bytenr;
+	u64 extent_offset;
+	u64 num_bytes = *ret_num_bytes;
+
+	/*
+	 * @objectid should be an inode number, thus it must not be smaller
+	 * than BTRFS_FIRST_FREE_OBJECTID.
+	 */
+	UASSERT(objectid >= BTRFS_FIRST_FREE_OBJECTID);
+
+	/*
+	 * All supported file system should not use its 0 extent.  As it's for
+	 * hole.  And hole extent has no size limit, no need to loop.
+	 */
+	if (disk_bytenr == 0) {
+		ret = btrfs_insert_file_extent(trans, root, objectid,
+					       file_pos, disk_bytenr,
+					       num_bytes, num_bytes);
+		return ret;
+	}
+	num_bytes = min_t(u64, num_bytes, BTRFS_MAX_EXTENT_SIZE);
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	/* First to check extent overlap. */
+	ret = btrfs_search_overlap_extent(extent_root, path, disk_bytenr, num_bytes);
+	if (ret < 0)
+		goto fail;
+	if (ret > 0) {
+		/* Found overlap. */
+		u64 cur_start;
+		u64 cur_len;
+
+		__get_extent_size(extent_root, path, &cur_start, &cur_len);
+		/* For convert case, this extent should be a subset of existing one. */
+		if (disk_bytenr < cur_start) {
+			error_msg(ERROR_MSG_UNEXPECTED,
+				  "invalid range disk_bytenr < cur_start: %llu < %llu",
+				  disk_bytenr, cur_start);
+			ret = -EUCLEAN;
+			goto fail;
+		}
+
+		extent_bytenr = cur_start;
+		extent_num_bytes = cur_len;
+		extent_offset = disk_bytenr - extent_bytenr;
+	} else {
+		/* No overlap, create new extent. */
+		btrfs_release_path(path);
+		ins_key.objectid = disk_bytenr;
+		ins_key.type = BTRFS_EXTENT_ITEM_KEY;
+		ins_key.offset = num_bytes;
+
+		ret = btrfs_insert_empty_item(trans, extent_root, path,
+					      &ins_key, sizeof(*ei));
+		if (ret == 0) {
+			leaf = path->nodes[0];
+			ei = btrfs_item_ptr(leaf, path->slots[0],
+					    struct btrfs_extent_item);
+
+			btrfs_set_extent_refs(leaf, ei, 0);
+			btrfs_set_extent_generation(leaf, ei, trans->transid);
+			btrfs_set_extent_flags(leaf, ei,
+					       BTRFS_EXTENT_FLAG_DATA);
+			btrfs_mark_buffer_dirty(leaf);
+
+			ret = btrfs_update_block_group(trans, disk_bytenr,
+						       num_bytes, 1, 0);
+			if (ret)
+				goto fail;
+		} else if (ret != -EEXIST) {
+			goto fail;
+		}
+
+		ret = remove_from_free_space_tree(trans, disk_bytenr, num_bytes);
+		if (ret)
+			goto fail;
+
+		btrfs_run_delayed_refs(trans, -1);
+		extent_bytenr = disk_bytenr;
+		extent_num_bytes = num_bytes;
+		extent_offset = 0;
+	}
+	btrfs_release_path(path);
+	ins_key.objectid = objectid;
+	ins_key.type = BTRFS_EXTENT_DATA_KEY;
+	ins_key.offset = file_pos;
+	ret = btrfs_insert_empty_item(trans, root, path, &ins_key, sizeof(*fi));
+	if (ret)
+		goto fail;
+	leaf = path->nodes[0];
+	fi = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
+	btrfs_set_file_extent_generation(leaf, fi, trans->transid);
+	btrfs_set_file_extent_type(leaf, fi, BTRFS_FILE_EXTENT_REG);
+	btrfs_set_file_extent_disk_bytenr(leaf, fi, extent_bytenr);
+	btrfs_set_file_extent_disk_num_bytes(leaf, fi, extent_num_bytes);
+	btrfs_set_file_extent_offset(leaf, fi, extent_offset);
+	btrfs_set_file_extent_num_bytes(leaf, fi, num_bytes);
+	btrfs_set_file_extent_ram_bytes(leaf, fi, extent_num_bytes);
+	btrfs_set_file_extent_compression(leaf, fi, 0);
+	btrfs_set_file_extent_encryption(leaf, fi, 0);
+	btrfs_set_file_extent_other_encoding(leaf, fi, 0);
+	btrfs_mark_buffer_dirty(leaf);
+
+	nbytes = btrfs_stack_inode_nbytes(inode) + num_bytes;
+	btrfs_set_stack_inode_nbytes(inode, nbytes);
+	btrfs_release_path(path);
+
+	ret = btrfs_inc_extent_ref(trans, extent_bytenr, extent_num_bytes,
+				   0, root->root_key.objectid, objectid,
+				   file_pos - extent_offset);
+	if (ret)
+		goto fail;
+	ret = 0;
+	*ret_num_bytes = min(extent_num_bytes - extent_offset, num_bytes);
+fail:
+	btrfs_free_path(path);
+	return ret;
+}
+
+/*
+ * Insert file extent using converted image. Do all the required works,
+ * such as inserting file extent item, inserting extent item and backref item
+ * into extent tree and updating block accounting.
+ *
+ * This is for btrfs-convert only, thus it won't support compressed regular
+ * file extents.
+ */
+int btrfs_convert_file_extent(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root, u64 objectid,
+			      struct btrfs_inode_item *inode,
+			      u64 file_pos, u64 disk_bytenr,
+			      u64 num_bytes)
+{
+	u64 cur_disk_bytenr = disk_bytenr;
+	u64 cur_file_pos = file_pos;
+	u64 cur_num_bytes = num_bytes;
+	int ret = 0;
+
+	while (num_bytes > 0) {
+		ret = __btrfs_convert_file_extent(trans, root, objectid,
+						  inode, cur_file_pos,
+						  cur_disk_bytenr,
+						  &cur_num_bytes);
+		if (ret < 0)
+			break;
+		cur_disk_bytenr += cur_num_bytes;
+		cur_file_pos += cur_num_bytes;
+		num_bytes -= cur_num_bytes;
+	}
+	return ret;
+}
diff --git a/convert/common.h b/convert/common.h
index 581ef3298304..7678c1656507 100644
--- a/convert/common.h
+++ b/convert/common.h
@@ -23,6 +23,7 @@
 #define __BTRFS_CONVERT_COMMON_H__
 
 #include "kerncompat.h"
+#include "kernel-shared/uapi/btrfs_tree.h"
 #include "common/extent-cache.h"
 
 struct btrfs_mkfs_config;
@@ -84,4 +85,9 @@ static inline u64 range_end(const struct simple_range *range)
 	return (range->start + range->len);
 }
 
+int btrfs_convert_file_extent(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root, u64 objectid,
+			      struct btrfs_inode_item *inode,
+			      u64 file_pos, u64 disk_bytenr,
+			      u64 num_bytes);
 #endif
diff --git a/convert/main.c b/convert/main.c
index a227cc6fef84..805682705dff 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -337,7 +337,7 @@ static int create_image_file_range(struct btrfs_trans_handle *trans,
 		error("remaining length not sectorsize aligned: %llu", len);
 		return -EINVAL;
 	}
-	ret = btrfs_record_file_extent(trans, root, ino, inode, bytenr,
+	ret = btrfs_convert_file_extent(trans, root, ino, inode, bytenr,
 				       disk_bytenr, len);
 	if (ret < 0)
 		return ret;
@@ -426,8 +426,8 @@ static int migrate_one_reserved_range(struct btrfs_trans_handle *trans,
 			break;
 
 		/* Now handle extent item and file extent things */
-		ret = btrfs_record_file_extent(trans, root, ino, inode, cur_off,
-					       key.objectid, key.offset);
+		ret = btrfs_convert_file_extent(trans, root, ino, inode, cur_off,
+					        key.objectid, key.offset);
 		if (ret < 0)
 			break;
 		/* Finally, insert csum items */
@@ -438,7 +438,7 @@ static int migrate_one_reserved_range(struct btrfs_trans_handle *trans,
 		/* Don't forget to insert hole */
 		hole_len = cur_off - hole_start;
 		if (hole_len) {
-			ret = btrfs_record_file_extent(trans, root, ino, inode,
+			ret = btrfs_convert_file_extent(trans, root, ino, inode,
 					hole_start, 0, hole_len);
 			if (ret < 0)
 				break;
@@ -455,7 +455,7 @@ static int migrate_one_reserved_range(struct btrfs_trans_handle *trans,
 	 *                   | Hole |
 	 */
 	if (range_end(range) - hole_start > 0)
-		ret = btrfs_record_file_extent(trans, root, ino, inode,
+		ret = btrfs_convert_file_extent(trans, root, ino, inode,
 				hole_start, 0, range_end(range) - hole_start);
 	return ret;
 }
diff --git a/convert/source-fs.c b/convert/source-fs.c
index 97c989d9ab13..8a296bd9c7f4 100644
--- a/convert/source-fs.c
+++ b/convert/source-fs.c
@@ -260,7 +260,7 @@ int record_file_blocks(struct blk_iterate_data *data,
 
 	/* Hole, pass it to record_file_extent directly */
 	if (old_disk_bytenr == 0)
-		return btrfs_record_file_extent(data->trans, root,
+		return btrfs_convert_file_extent(data->trans, root,
 				data->objectid, data->inode, file_pos, 0,
 				num_bytes);
 
@@ -314,7 +314,7 @@ int record_file_blocks(struct blk_iterate_data *data,
 			real_disk_bytenr = 0;
 		cur_len = min(key.offset + extent_num_bytes,
 			      old_disk_bytenr + num_bytes) - cur_off;
-		ret = btrfs_record_file_extent(data->trans, data->root,
+		ret = btrfs_convert_file_extent(data->trans, data->root,
 					data->objectid, data->inode, file_pos,
 					real_disk_bytenr, cur_len);
 		if (ret < 0)
diff --git a/convert/source-reiserfs.c b/convert/source-reiserfs.c
index 3475b15277dc..32d60c09fb0c 100644
--- a/convert/source-reiserfs.c
+++ b/convert/source-reiserfs.c
@@ -364,7 +364,7 @@ static int convert_direct(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	return btrfs_record_file_extent(trans, root, objectid, inode, offset,
+	return btrfs_convert_file_extent(trans, root, objectid, inode, offset,
 					key.objectid, sectorsize);
 }
 
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index ffe9aa1f9af1..526fa255306f 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -36,6 +36,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/file-item.h"
+#include "kernel-shared/free-space-tree.h"
 #include "common/internal.h"
 #include "common/messages.h"
 #include "common/utils.h"
@@ -362,6 +363,98 @@ fail:
 	return ret;
 }
 
+static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
+				       struct btrfs_root *root, u64 ino,
+				       struct btrfs_inode_item *inode,
+				       u64 file_pos, u64 disk_bytenr,
+				       u64 num_bytes)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, disk_bytenr);
+	struct extent_buffer *leaf;
+	struct btrfs_key ins_key;
+	struct btrfs_path *path;
+	struct btrfs_extent_item *ei;
+	int ret;
+
+	/*
+	 * @ino should be an inode number, thus it must not be smaller
+	 * than BTRFS_FIRST_FREE_OBJECTID.
+	 */
+	UASSERT(ino >= BTRFS_FIRST_FREE_OBJECTID);
+
+	/* The reserved data extent should never exceed the upper limit. */
+	UASSERT(num_bytes <= BTRFS_MAX_EXTENT_SIZE);
+
+	/*
+	 * All supported file system should not use its 0 extent.  As it's for
+	 * hole.  And hole extent has no size limit, no need to loop.
+	 */
+	if (disk_bytenr == 0) {
+		ret = btrfs_insert_file_extent(trans, root, ino,
+					       file_pos, disk_bytenr,
+					       num_bytes, num_bytes);
+		return ret;
+	}
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ins_key.objectid = disk_bytenr;
+	ins_key.type = BTRFS_EXTENT_ITEM_KEY;
+	ins_key.offset = num_bytes;
+
+	/* Update extent tree. */
+	ret = btrfs_insert_empty_item(trans, extent_root, path,
+				      &ins_key, sizeof(*ei));
+	if (ret == 0) {
+		leaf = path->nodes[0];
+		ei = btrfs_item_ptr(leaf, path->slots[0],
+				    struct btrfs_extent_item);
+
+		btrfs_set_extent_refs(leaf, ei, 0);
+		btrfs_set_extent_generation(leaf, ei, trans->transid);
+		btrfs_set_extent_flags(leaf, ei,
+				       BTRFS_EXTENT_FLAG_DATA);
+		btrfs_mark_buffer_dirty(leaf);
+
+		ret = btrfs_update_block_group(trans, disk_bytenr,
+					       num_bytes, 1, 0);
+		if (ret)
+			goto fail;
+	} else if (ret != -EEXIST) {
+		goto fail;
+	}
+	btrfs_release_path(path);
+
+	ret = remove_from_free_space_tree(trans, disk_bytenr, num_bytes);
+	if (ret)
+		goto fail;
+
+	btrfs_run_delayed_refs(trans, -1);
+
+	ins_key.objectid = ino;
+	ins_key.type = BTRFS_EXTENT_DATA_KEY;
+	ins_key.offset = file_pos;
+	ret = btrfs_insert_file_extent(trans, root, ino, file_pos, disk_bytenr,
+				       num_bytes, num_bytes);
+	if (ret)
+		goto fail;
+	btrfs_set_stack_inode_nbytes(inode,
+			btrfs_stack_inode_nbytes(inode) + num_bytes);
+
+	ret = btrfs_inc_extent_ref(trans, disk_bytenr, num_bytes,
+				   0, root->root_key.objectid, ino,
+				   file_pos);
+	if (ret)
+		goto fail;
+	ret = 0;
+fail:
+	btrfs_free_path(path);
+	return ret;
+}
+
 static int add_file_items(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root,
 			  struct btrfs_inode_item *btrfs_inode, u64 objectid,
@@ -471,7 +564,7 @@ again:
 	}
 
 	if (bytes_read) {
-		ret = btrfs_record_file_extent(trans, root, objectid,
+		ret = insert_reserved_file_extent(trans, root, objectid,
 				btrfs_inode, file_pos, first_block, cur_bytes);
 		if (ret)
 			goto end;
-- 
2.47.0


