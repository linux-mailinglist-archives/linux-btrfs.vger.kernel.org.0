Return-Path: <linux-btrfs+bounces-11420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5802AA330AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 21:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCBD3A9251
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 20:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB893201259;
	Wed, 12 Feb 2025 20:22:16 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9888201015
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391736; cv=none; b=DZBOvT1xEu15CZMHU82ptYhl6Cu4YeUGpMJsT8H0ORL+S4L4rUjJqY40K819cla8tHhnoYbejmc93MHIUUfLcpqp8OsNLmQ5SeGfVwoHwuJyG+Mxq5Uk8yg5GwAZ0Wp1t1KT7EyzvQPDe0kTkkSGu57SaV3sbA3DMWqOSDSyzfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391736; c=relaxed/simple;
	bh=cjmQO6bE8elf/lRlc+Ot+65cTYQv87YQwz44rymg5kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAQiWu4Ce8kXrlAC1szXkEtoKdIMldM2VFLrl7t8jU1TixiDCmi3LOQ8mlj83MI14srxV/YFA0/6NvnZOouCydD22vx4T7UJoEBaCwzCt3wXTkJtDh5WLS7Hcuv+k6xLq9maDmlNL6RgGzO7CZecGFumF2ADBPSm7njOmaSxdIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 238181F78D;
	Wed, 12 Feb 2025 20:22:12 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C85713AEF;
	Wed, 12 Feb 2025 20:22:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PGL0BvQCrWeqJgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 12 Feb 2025 20:22:12 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 5/7] btrfs: unify ordering of btrfs_key initializations
Date: Wed, 12 Feb 2025 21:22:07 +0100
Message-ID: <7f43f70921ce0f40ad8d393fa95140661acb9d0a.1739391605.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1739391605.git.dsterba@suse.com>
References: <cover.1739391605.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 238181F78D
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

The btrfs_key is defined as objectid/type/offset and the keys are also
printed like that. For better readability, update all key
initializations to match this order.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c          |  4 ++--
 fs/btrfs/block-group.c      |  6 +++---
 fs/btrfs/export.c           |  2 +-
 fs/btrfs/extent-tree.c      |  8 ++++----
 fs/btrfs/file-item.c        | 13 +++++++------
 fs/btrfs/free-space-cache.c |  8 ++++----
 fs/btrfs/inode-item.c       |  6 +++---
 fs/btrfs/inode.c            |  8 ++++----
 fs/btrfs/ioctl.c            |  4 ++--
 fs/btrfs/qgroup.c           |  2 +-
 fs/btrfs/scrub.c            |  4 ++--
 fs/btrfs/transaction.c      |  2 +-
 fs/btrfs/tree-log.c         |  6 +++---
 fs/btrfs/volumes.c          | 16 ++++++++--------
 14 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 3d3923cfc357..5936cff80ff3 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1399,11 +1399,11 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 		ASSERT(ctx->roots == NULL);
 
 	key.objectid = ctx->bytenr;
-	key.offset = (u64)-1;
 	if (btrfs_fs_incompat(ctx->fs_info, SKINNY_METADATA))
 		key.type = BTRFS_METADATA_ITEM_KEY;
 	else
 		key.type = BTRFS_EXTENT_ITEM_KEY;
+	key.offset = (u64)-1;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -2206,11 +2206,11 @@ int extent_from_logical(struct btrfs_fs_info *fs_info, u64 logical,
 	struct btrfs_extent_item *ei;
 	struct btrfs_key key;
 
+	key.objectid = logical;
 	if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
 		key.type = BTRFS_METADATA_ITEM_KEY;
 	else
 		key.type = BTRFS_EXTENT_ITEM_KEY;
-	key.objectid = logical;
 	key.offset = (u64)-1;
 
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c0a8f7d92acc..18f58674a16c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -738,8 +738,8 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 	path->reada = READA_FORWARD;
 
 	key.objectid = last;
-	key.offset = 0;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
+	key.offset = 0;
 
 next:
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
@@ -785,8 +785,8 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 
 		if (key.objectid < last) {
 			key.objectid = last;
-			key.offset = 0;
 			key.type = BTRFS_EXTENT_ITEM_KEY;
+			key.offset = 0;
 			btrfs_release_path(path);
 			goto next;
 		}
@@ -2509,8 +2509,8 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		return fill_dummy_bgs(info);
 
 	key.objectid = 0;
-	key.offset = 0;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+	key.offset = 0;
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index e2b22bea348a..c087424ac067 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -249,8 +249,8 @@ static int btrfs_get_name(struct dentry *parent, char *name,
 		root = fs_info->tree_root;
 	} else {
 		key.objectid = ino;
-		key.offset = btrfs_ino(BTRFS_I(dir));
 		key.type = BTRFS_INODE_REF_KEY;
+		key.offset = btrfs_ino(BTRFS_I(dir));
 	}
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3014a1a23efd..4a6036e7fa83 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -79,8 +79,8 @@ int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len)
 		return -ENOMEM;
 
 	key.objectid = start;
-	key.offset = len;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
+	key.offset = len;
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	btrfs_free_path(path);
 	return ret;
@@ -125,11 +125,11 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 
 search_again:
 	key.objectid = bytenr;
-	key.offset = offset;
 	if (metadata)
 		key.type = BTRFS_METADATA_ITEM_KEY;
 	else
 		key.type = BTRFS_EXTENT_ITEM_KEY;
+	key.offset = offset;
 
 	extent_root = btrfs_extent_root(fs_info, bytenr);
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
@@ -1679,8 +1679,8 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 				metadata = 0;
 
 				key.objectid = head->bytenr;
-				key.offset = head->num_bytes;
 				key.type = BTRFS_EXTENT_ITEM_KEY;
+				key.offset = head->num_bytes;
 				goto again;
 			}
 		} else {
@@ -2348,8 +2348,8 @@ static noinline int check_committed_ref(struct btrfs_inode *inode,
 	int ret;
 
 	key.objectid = bytenr;
-	key.offset = (u64)-1;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
+	key.offset = (u64)-1;
 
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index d04a3b47b1fb..5083025d28b2 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -169,9 +169,10 @@ int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
+
 	file_key.objectid = objectid;
-	file_key.offset = pos;
 	file_key.type = BTRFS_EXTENT_DATA_KEY;
+	file_key.offset = pos;
 
 	ret = btrfs_insert_empty_item(trans, root, path, &file_key,
 				      sizeof(*item));
@@ -212,8 +213,8 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,
 	int csums_in_item;
 
 	file_key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
-	file_key.offset = bytenr;
 	file_key.type = BTRFS_EXTENT_CSUM_KEY;
+	file_key.offset = bytenr;
 	ret = btrfs_search_slot(trans, root, &file_key, path, 0, cow);
 	if (ret < 0)
 		goto fail;
@@ -259,8 +260,8 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 	int cow = mod != 0;
 
 	file_key.objectid = objectid;
-	file_key.offset = offset;
 	file_key.type = BTRFS_EXTENT_DATA_KEY;
+	file_key.offset = offset;
 
 	return btrfs_search_slot(trans, root, &file_key, path, ins_len, cow);
 }
@@ -484,8 +485,8 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 	path->nowait = nowait;
 
 	key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
-	key.offset = start;
 	key.type = BTRFS_EXTENT_CSUM_KEY;
+	key.offset = start;
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
@@ -892,8 +893,8 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 
 	while (1) {
 		key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
-		key.offset = end_byte - 1;
 		key.type = BTRFS_EXTENT_CSUM_KEY;
+		key.offset = end_byte - 1;
 
 		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 		if (ret > 0) {
@@ -1074,8 +1075,8 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	found_next = 0;
 	bytenr = sums->logical + total_bytes;
 	file_key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
-	file_key.offset = bytenr;
 	file_key.type = BTRFS_EXTENT_CSUM_KEY;
+	file_key.offset = bytenr;
 
 	item = btrfs_lookup_csum(trans, root, path, bytenr, 1);
 	if (!IS_ERR(item)) {
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 7054b4c88f99..056546bf9abd 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -93,8 +93,8 @@ static struct inode *__lookup_free_space_inode(struct btrfs_root *root,
 	int ret;
 
 	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
-	key.offset = offset;
 	key.type = 0;
+	key.offset = offset;
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
@@ -201,8 +201,8 @@ static int __create_free_space_inode(struct btrfs_root *root,
 	btrfs_release_path(path);
 
 	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
-	key.offset = offset;
 	key.type = 0;
+	key.offset = offset;
 	ret = btrfs_insert_empty_item(trans, root, path, &key,
 				      sizeof(struct btrfs_free_space_header));
 	if (ret < 0) {
@@ -755,8 +755,8 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 		return 0;
 
 	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
-	key.offset = offset;
 	key.type = 0;
+	key.offset = offset;
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
@@ -1158,8 +1158,8 @@ update_cache_item(struct btrfs_trans_handle *trans,
 	int ret;
 
 	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
-	key.offset = offset;
 	key.type = 0;
+	key.offset = offset;
 
 	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
 	if (ret < 0) {
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 448aa1a682d6..3530de0618c8 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -191,8 +191,8 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 	int del_len = name->len + sizeof(*ref);
 
 	key.objectid = inode_objectid;
-	key.offset = ref_objectid;
 	key.type = BTRFS_INODE_REF_KEY;
+	key.offset = ref_objectid;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -317,8 +317,8 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 	int ins_len = name->len + sizeof(*ref);
 
 	key.objectid = inode_objectid;
-	key.offset = ref_objectid;
 	key.type = BTRFS_INODE_REF_KEY;
+	key.offset = ref_objectid;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -493,8 +493,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	path->reada = READA_BACK;
 
 	key.objectid = control->ino;
-	key.offset = (u64)-1;
 	key.type = (u8)-1;
+	key.offset = (u64)-1;
 
 search_again:
 	/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1512eb94b6e5..ace9a3ecdefa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -489,8 +489,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		size_t datasize;
 
 		key.objectid = btrfs_ino(inode);
-		key.offset = 0;
 		key.type = BTRFS_EXTENT_DATA_KEY;
+		key.offset = 0;
 
 		datasize = btrfs_file_extent_calc_inline_size(cur_size);
 		ret = btrfs_insert_empty_item(trans, root, path, &key,
@@ -2966,8 +2966,8 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 
 	if (!drop_args.extent_inserted) {
 		ins.objectid = btrfs_ino(inode);
-		ins.offset = file_pos;
 		ins.type = BTRFS_EXTENT_DATA_KEY;
+		ins.offset = file_pos;
 
 		ret = btrfs_insert_empty_item(trans, root, path, &ins,
 					      sizeof(*stack_fi));
@@ -3002,8 +3002,8 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 		btrfs_update_inode_bytes(inode, num_bytes, drop_args.bytes_found);
 
 	ins.objectid = disk_bytenr;
-	ins.offset = disk_num_bytes;
 	ins.type = BTRFS_EXTENT_ITEM_KEY;
+	ins.offset = disk_num_bytes;
 
 	ret = btrfs_inode_set_file_extent_range(inode, file_pos, ram_bytes);
 	if (ret)
@@ -8715,8 +8715,8 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		goto out;
 	}
 	key.objectid = btrfs_ino(BTRFS_I(inode));
-	key.offset = 0;
 	key.type = BTRFS_EXTENT_DATA_KEY;
+	key.offset = 0;
 	datasize = btrfs_file_extent_calc_inline_size(name_len);
 	err = btrfs_insert_empty_item(trans, root, path, &key,
 				      datasize);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8fff7ddf6409..45b087011324 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -618,8 +618,8 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 	btrfs_set_root_dirid(root_item, BTRFS_FIRST_FREE_OBJECTID);
 
 	key.objectid = objectid;
-	key.offset = 0;
 	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = 0;
 	ret = btrfs_insert_root(trans, fs_info->tree_root, &key,
 				root_item);
 	if (ret) {
@@ -1531,8 +1531,8 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 		}
 
 		sh.objectid = key->objectid;
-		sh.offset = key->offset;
 		sh.type = key->type;
+		sh.offset = key->offset;
 		sh.len = item_len;
 		sh.transid = found_transid;
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index f9d3766c809b..d6fa36674270 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -956,8 +956,8 @@ static int btrfs_clean_quota_tree(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 
 	key.objectid = 0;
-	key.offset = 0;
 	key.type = 0;
+	key.offset = 0;
 
 	while (1) {
 		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 531312efee8d..2c5edcee9450 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1380,11 +1380,11 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
 	if (path->nodes[0])
 		goto search_forward;
 
+	key.objectid = search_start;
 	if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
 		key.type = BTRFS_METADATA_ITEM_KEY;
 	else
 		key.type = BTRFS_EXTENT_ITEM_KEY;
-	key.objectid = search_start;
 	key.offset = (u64)-1;
 
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
@@ -2497,8 +2497,8 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	path->skip_locking = 1;
 
 	key.objectid = scrub_dev->devid;
-	key.offset = 0ull;
 	key.type = BTRFS_DEV_EXTENT_KEY;
+	key.offset = 0ull;
 
 	while (1) {
 		u64 dev_extent_len;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index aca83a98b75a..47b2f7172374 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1690,8 +1690,8 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	}
 
 	key.objectid = objectid;
-	key.offset = (u64)-1;
 	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = (u64)-1;
 
 	rsv = trans->block_rsv;
 	trans->block_rsv = &pending->block_rsv;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 955d1677e865..fc5c761181eb 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -747,8 +747,8 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 				(unsigned long)item,  sizeof(*item));
 
 		ins.objectid = btrfs_file_extent_disk_bytenr(eb, item);
-		ins.offset = btrfs_file_extent_disk_num_bytes(eb, item);
 		ins.type = BTRFS_EXTENT_ITEM_KEY;
+		ins.offset = btrfs_file_extent_disk_num_bytes(eb, item);
 		offset = key->offset - btrfs_file_extent_offset(eb, item);
 
 		/*
@@ -3560,8 +3560,8 @@ static noinline int insert_dir_log_key(struct btrfs_trans_handle *trans,
 	struct btrfs_dir_log_item *item;
 
 	key.objectid = dirid;
-	key.offset = first_offset;
 	key.type = BTRFS_DIR_LOG_INDEX_KEY;
+	key.offset = first_offset;
 	ret = btrfs_insert_empty_item(trans, log, path, &key, sizeof(*item));
 	/*
 	 * -EEXIST is fine and can happen sporadically when we are logging a
@@ -7247,8 +7247,8 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 
 again:
 	key.objectid = BTRFS_TREE_LOG_OBJECTID;
-	key.offset = (u64)-1;
 	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = (u64)-1;
 
 	while (1) {
 		ret = btrfs_search_slot(NULL, log_root_tree, &key, path, 0, 0);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0a0776489055..9258b2023f30 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1798,8 +1798,8 @@ static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 	path->skip_locking = 1;
 
 	key.objectid = device->devid;
-	key.offset = search_start;
 	key.type = BTRFS_DEV_EXTENT_KEY;
+	key.offset = search_start;
 
 	ret = btrfs_search_backwards(root, &key, path);
 	if (ret < 0)
@@ -1918,8 +1918,8 @@ static int btrfs_free_dev_extent(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 
 	key.objectid = device->devid;
-	key.offset = start;
 	key.type = BTRFS_DEV_EXTENT_KEY;
+	key.offset = start;
 again:
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 	if (ret > 0) {
@@ -2721,8 +2721,8 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 		return -ENOMEM;
 
 	key.objectid = BTRFS_DEV_ITEMS_OBJECTID;
-	key.offset = 0;
 	key.type = BTRFS_DEV_ITEM_KEY;
+	key.offset = 0;
 
 	while (1) {
 		btrfs_reserve_chunk_metadata(trans, false);
@@ -3119,8 +3119,8 @@ static int btrfs_free_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 		return -ENOMEM;
 
 	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
-	key.offset = chunk_offset;
 	key.type = BTRFS_CHUNK_ITEM_KEY;
+	key.offset = chunk_offset;
 
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 	if (ret < 0)
@@ -3577,8 +3577,8 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 
 again:
 	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
-	key.offset = (u64)-1;
 	key.type = BTRFS_CHUNK_ITEM_KEY;
+	key.offset = (u64)-1;
 
 	while (1) {
 		mutex_lock(&fs_info->reclaim_bgs_lock);
@@ -4184,8 +4184,8 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 		bctl->sys.limit = limit_sys;
 	}
 	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
-	key.offset = (u64)-1;
 	key.type = BTRFS_CHUNK_ITEM_KEY;
+	key.offset = (u64)-1;
 
 	while (1) {
 		if ((!counting && atomic_read(&fs_info->balance_pause_req)) ||
@@ -5001,8 +5001,8 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 
 again:
 	key.objectid = device->devid;
-	key.offset = (u64)-1;
 	key.type = BTRFS_DEV_EXTENT_KEY;
+	key.offset = (u64)-1;
 
 	do {
 		mutex_lock(&fs_info->reclaim_bgs_lock);
@@ -7534,8 +7534,8 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	 * item - BTRFS_FIRST_CHUNK_TREE_OBJECTID).
 	 */
 	key.objectid = BTRFS_DEV_ITEMS_OBJECTID;
-	key.offset = 0;
 	key.type = 0;
+	key.offset = 0;
 	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
 		struct extent_buffer *node = path->nodes[1];
 
-- 
2.47.1


