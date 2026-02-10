Return-Path: <linux-btrfs+bounces-21602-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKTAII0di2nSPwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21602-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:59:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 127BE11A7E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2493C304AC37
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E792328604;
	Tue, 10 Feb 2026 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CytcMqI0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48932825B
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724675; cv=none; b=T75/dK7Xo5a4ExRcS7YnT1+YafqD1rqryvIJyNkgt+w4bw++iMhFNyFrbOwei1OEpcBTZzCf477OaQ0p9MmF+CQg8PDwPfSw1pagyD81T0Ioe9hWTXmzgDwQxZHMByJLI8BpP7MCLf5iJxZUAFZvUMVu1I0M2lUTRuW56ov+5Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724675; c=relaxed/simple;
	bh=loichOLjHk10XHIPZ6Cyd/q3gYup28sUgY9BoYUa7aw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BALI4/bMgaBnz+HYhNWp8hbUnjpZ6RBlqYwXknFQzsRgoyttSekBivADuF5HAl2pme5B9ek1OJnQ0fYeDJlzpjQSybd5VatG+a5Nn8wL8iF8kGWruC+ZJ3AyY9UMzbFgZFEFSDcT7QbP5o920KFmm037nSEeNg501Muv0sOGAgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CytcMqI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE382C116C6
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 11:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770724675;
	bh=loichOLjHk10XHIPZ6Cyd/q3gYup28sUgY9BoYUa7aw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CytcMqI0neG6PUEQATkjLJGNLXIuunKE/t53LovqilrMx1+Q7f/H3ewMEo1eMFWHW
	 RR4GK8GdXZS2RvDIK4AClwQsdeKbTU1DSPqmqROihCBoHjLBQeEIlHuMNr2h+tf/RF
	 l+xmE8ZPq3VSAK1PuhXrpQBymmPZtC1P455UT49WtwAYdmEDClCa9RSWNWIda/i4wU
	 Ub6YD6FwPznYIa8IAhgrVqWbAgALu1p7Bd+OSDQwANBjrnjajgCC9FRVDTsUgLSOFJ
	 cnyIHc6TW3Lk0F7x3Do/Qb9pXEwSOV8Ur5Yz+TVuFC3dEiCgMw0vALb3fKf5SQ2ta+
	 SEw71OdO/EQ2A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: check for NULL root after calls to btrfs_extent_root()
Date: Tue, 10 Feb 2026 11:57:49 +0000
Message-ID: <1d92d80fd23e64c3f9e5e295cff686c126274658.1770724034.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770724034.git.fdmanana@suse.com>
References: <cover.1770724034.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21602-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 127BE11A7E4
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

btrfs_extent_root() can return a NULL pointer in case the root we are
looking for is not in the rb tree that tracks roots. So add checks to
every caller that is missing such check to log a message and return
an error. The same applies to callers of btrfs_block_group_root(),
since it calls btrfs_extent_root().

Reported-by: Chris Mason <clm@meta.com>
Link: https://lore.kernel.org/linux-btrfs/20260208161657.3972997-1-clm@meta.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c         | 28 ++++++++++++++
 fs/btrfs/block-group.c     | 36 ++++++++++++++++++
 fs/btrfs/disk-io.c         | 13 ++++++-
 fs/btrfs/extent-tree.c     | 78 ++++++++++++++++++++++++++++++++++++--
 fs/btrfs/free-space-tree.c |  9 ++++-
 fs/btrfs/qgroup.c          |  8 ++++
 fs/btrfs/relocation.c      | 22 ++++++++++-
 fs/btrfs/zoned.c           |  7 ++++
 8 files changed, 193 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index cf10e10a40fa..8a119c505e32 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1388,6 +1388,13 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 		.indirect_missing_keys = PREFTREE_INIT
 	};
 
+	if (unlikely(!root)) {
+		btrfs_err(ctx->fs_info,
+			  "missing extent root for extent at bytenr %llu",
+			  ctx->bytenr);
+		return -EUCLEAN;
+	}
+
 	/* Roots ulist is not needed when using a sharedness check context. */
 	if (sc)
 		ASSERT(ctx->roots == NULL);
@@ -2194,6 +2201,13 @@ int extent_from_logical(struct btrfs_fs_info *fs_info, u64 logical,
 	struct btrfs_extent_item *ei;
 	struct btrfs_key key;
 
+	if (unlikely(!extent_root)) {
+		btrfs_err(fs_info,
+			  "missing extent root for extent at bytenr %llu",
+			  logical);
+		return -EUCLEAN;
+	}
+
 	key.objectid = logical;
 	if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
 		key.type = BTRFS_METADATA_ITEM_KEY;
@@ -2841,6 +2855,13 @@ int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
 	struct btrfs_key key;
 	int ret;
 
+	if (unlikely(!extent_root)) {
+		btrfs_err(fs_info,
+			  "missing extent root for extent at bytenr %llu",
+			  bytenr);
+		return -EUCLEAN;
+	}
+
 	key.objectid = bytenr;
 	key.type = BTRFS_METADATA_ITEM_KEY;
 	key.offset = (u64)-1;
@@ -2977,6 +2998,13 @@ int btrfs_backref_iter_next(struct btrfs_backref_iter *iter)
 
 	/* We're at keyed items, there is no inline item, go to the next one */
 	extent_root = btrfs_extent_root(iter->fs_info, iter->bytenr);
+	if (unlikely(!extent_root)) {
+		btrfs_err(iter->fs_info,
+			  "missing extent root for extent at bytenr %llu",
+			  iter->bytenr);
+		return -EUCLEAN;
+	}
+
 	ret = btrfs_next_item(extent_root, iter->path);
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 17a18f17538d..36ff6c5a8f51 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -738,6 +738,12 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 		return -ENOMEM;
 
 	extent_root = btrfs_extent_root(fs_info, last);
+	if (unlikely(!extent_root)) {
+		btrfs_err(fs_info,
+			  "missing extent root for block group at offset %llu",
+			  block_group->start);
+		return -EUCLEAN;
+	}
 
 #ifdef CONFIG_BTRFS_DEBUG
 	/*
@@ -1060,6 +1066,11 @@ static int remove_block_group_item(struct btrfs_trans_handle *trans,
 	int ret;
 
 	root = btrfs_block_group_root(fs_info);
+	if (unlikely(!root)) {
+		btrfs_err(fs_info, "missing block group root");
+		return -EUCLEAN;
+	}
+
 	key.objectid = block_group->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = block_group->length;
@@ -1348,6 +1359,11 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 	struct btrfs_chunk_map *map;
 	unsigned int num_items;
 
+	if (unlikely(!root)) {
+		btrfs_err(fs_info, "missing block group root");
+		return ERR_PTR(-EUCLEAN);
+	}
+
 	map = btrfs_find_chunk_map(fs_info, chunk_offset, 1);
 	ASSERT(map != NULL);
 	ASSERT(map->start == chunk_offset);
@@ -2139,6 +2155,11 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 	int ret;
 	struct btrfs_key found_key;
 
+	if (unlikely(!root)) {
+		btrfs_err(fs_info, "missing block group root");
+		return -EUCLEAN;
+	}
+
 	btrfs_for_each_slot(root, key, &found_key, path, ret) {
 		if (found_key.objectid >= key->objectid &&
 		    found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
@@ -2713,6 +2734,11 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	size_t size;
 	int ret;
 
+	if (unlikely(!root)) {
+		btrfs_err(fs_info, "missing block group root");
+		return -EUCLEAN;
+	}
+
 	spin_lock(&block_group->lock);
 	btrfs_set_stack_block_group_v2_used(&bgi, block_group->used);
 	btrfs_set_stack_block_group_v2_chunk_objectid(&bgi, block_group->global_root_id);
@@ -3048,6 +3074,11 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	int ret;
 	bool dirty_bg_running;
 
+	if (unlikely(!root)) {
+		btrfs_err(fs_info, "missing block group root");
+		return -EUCLEAN;
+	}
+
 	/*
 	 * This can only happen when we are doing read-only scrub on read-only
 	 * mount.
@@ -3192,6 +3223,11 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	u64 used, remap_bytes;
 	u32 identity_remap_count;
 
+	if (unlikely(!root)) {
+		btrfs_err(fs_info, "missing block group root");
+		return -EUCLEAN;
+	}
+
 	/*
 	 * Block group items update can be triggered out of commit transaction
 	 * critical section, thus we need a consistent view of used bytes.
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e2a4d4dbf056..4b1e67f176a3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1590,7 +1590,7 @@ static int find_newest_super_backup(struct btrfs_fs_info *info)
  * this will bump the backup pointer by one when it is
  * done
  */
-static void backup_super_roots(struct btrfs_fs_info *info)
+static int backup_super_roots(struct btrfs_fs_info *info)
 {
 	const int next_backup = info->backup_root_index;
 	struct btrfs_root_backup *root_backup;
@@ -1622,6 +1622,11 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 		struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
 		struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
 
+		if (unlikely(!extent_root)) {
+			btrfs_err(info, "missing extent root for extent at bytenr 0");
+			return -EUCLEAN;
+		}
+
 		btrfs_set_backup_extent_root(root_backup,
 					     extent_root->node->start);
 		btrfs_set_backup_extent_root_gen(root_backup,
@@ -1669,6 +1674,8 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	memcpy(&info->super_copy->super_roots,
 	       &info->super_for_commit->super_roots,
 	       sizeof(*root_backup) * BTRFS_NUM_BACKUP_ROOTS);
+
+	return 0;
 }
 
 /*
@@ -4019,7 +4026,9 @@ int write_all_supers(struct btrfs_trans_handle *trans)
 	} else {
 		/* We are called from transaction commit. */
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
-		backup_super_roots(fs_info);
+		ret = backup_super_roots(fs_info);
+		if (ret < 0)
+			return ret;
 	}
 
 	sb = fs_info->super_for_commit;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 01bbe3cae5c2..331263c206af 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -75,6 +75,12 @@ int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len)
 	struct btrfs_key key;
 	BTRFS_PATH_AUTO_FREE(path);
 
+	if (unlikely(!root)) {
+		btrfs_err(fs_info,
+			  "missing extent root for extent at bytenr %llu", start);
+		return -EUCLEAN;
+	}
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -131,6 +137,12 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 	key.offset = offset;
 
 	extent_root = btrfs_extent_root(fs_info, bytenr);
+	if (unlikely(!extent_root)) {
+		btrfs_err(fs_info,
+			  "missing extent root for extent at bytenr %llu", bytenr);
+		return -EUCLEAN;
+	}
+
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
@@ -436,6 +448,12 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
 	int recow;
 	int ret;
 
+	if (unlikely(!root)) {
+		btrfs_err(trans->fs_info,
+			  "missing extent root for extent at bytenr %llu", bytenr);
+		return -EUCLEAN;
+	}
+
 	key.objectid = bytenr;
 	if (parent) {
 		key.type = BTRFS_SHARED_DATA_REF_KEY;
@@ -510,6 +528,12 @@ static noinline int insert_extent_data_ref(struct btrfs_trans_handle *trans,
 	u32 num_refs;
 	int ret;
 
+	if (unlikely(!root)) {
+		btrfs_err(trans->fs_info,
+			  "missing extent root for extent at bytenr %llu", bytenr);
+		return -EUCLEAN;
+	}
+
 	key.objectid = bytenr;
 	if (node->parent) {
 		key.type = BTRFS_SHARED_DATA_REF_KEY;
@@ -668,6 +692,12 @@ static noinline int lookup_tree_block_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	int ret;
 
+	if (unlikely(!root)) {
+		btrfs_err(trans->fs_info,
+			  "missing extent root for extent at bytenr %llu", bytenr);
+		return -EUCLEAN;
+	}
+
 	key.objectid = bytenr;
 	if (parent) {
 		key.type = BTRFS_SHARED_BLOCK_REF_KEY;
@@ -692,6 +722,12 @@ static noinline int insert_tree_block_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	int ret;
 
+	if (unlikely(!root)) {
+		btrfs_err(trans->fs_info,
+			  "missing extent root for extent at bytenr %llu", bytenr);
+		return -EUCLEAN;
+	}
+
 	key.objectid = bytenr;
 	if (node->parent) {
 		key.type = BTRFS_SHARED_BLOCK_REF_KEY;
@@ -782,6 +818,12 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
 	int needed;
 
+	if (unlikely(!root)) {
+		btrfs_err(fs_info,
+			  "missing extent root for extent at bytenr %llu", bytenr);
+		return -EUCLEAN;
+	}
+
 	key.objectid = bytenr;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
 	key.offset = num_bytes;
@@ -1680,6 +1722,12 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 	}
 
 	root = btrfs_extent_root(fs_info, key.objectid);
+	if (unlikely(!root)) {
+		btrfs_err(fs_info,
+			  "missing extent root for extent at bytenr %llu",
+			  key.objectid);
+		return -EUCLEAN;
+	}
 again:
 	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
 	if (ret < 0) {
@@ -2379,6 +2427,12 @@ static noinline int check_committed_ref(struct btrfs_inode *inode,
 	int type;
 	int ret;
 
+	if (unlikely(!extent_root)) {
+		btrfs_err(fs_info,
+			  "missing extent root for extent at bytenr %llu", bytenr);
+		return -EUCLEAN;
+	}
+
 	key.objectid = bytenr;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
 	key.offset = (u64)-1;
@@ -3222,7 +3276,11 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	u64 delayed_ref_root = href->owning_root;
 
 	extent_root = btrfs_extent_root(info, bytenr);
-	ASSERT(extent_root);
+	if (unlikely(!extent_root)) {
+		btrfs_err(info,
+			  "missing extent root for extent at bytenr %llu", bytenr);
+		return -EUCLEAN;
+	}
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -4935,11 +4993,18 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 		size += btrfs_extent_inline_ref_size(BTRFS_EXTENT_OWNER_REF_KEY);
 	size += btrfs_extent_inline_ref_size(type);
 
+	extent_root = btrfs_extent_root(fs_info, ins->objectid);
+	if (unlikely(!extent_root)) {
+		btrfs_err(fs_info,
+			  "missing extent root for extent at bytenr %llu",
+			  ins->objectid);
+		return -EUCLEAN;
+	}
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
-	extent_root = btrfs_extent_root(fs_info, ins->objectid);
 	ret = btrfs_insert_empty_item(trans, extent_root, path, ins, size);
 	if (ret) {
 		btrfs_free_path(path);
@@ -5015,11 +5080,18 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 		size += sizeof(*block_info);
 	}
 
+	extent_root = btrfs_extent_root(fs_info, extent_key.objectid);
+	if (unlikely(!extent_root)) {
+		btrfs_err(fs_info,
+			  "missing extent root for extent at bytenr %llu",
+			  extent_key.objectid);
+		return -EUCLEAN;
+	}
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
-	extent_root = btrfs_extent_root(fs_info, extent_key.objectid);
 	ret = btrfs_insert_empty_item(trans, extent_root, path, &extent_key,
 				      size);
 	if (ret) {
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index ecddfca92b2b..9efd1ec90f03 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1073,6 +1073,14 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
+	extent_root = btrfs_extent_root(trans->fs_info, block_group->start);
+	if (unlikely(!extent_root)) {
+		btrfs_err(trans->fs_info,
+			  "missing extent root for block group at offset %llu",
+			  block_group->start);
+		return -EUCLEAN;
+	}
+
 	mutex_lock(&block_group->free_space_lock);
 
 	/*
@@ -1086,7 +1094,6 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_EXTENT_ITEM_KEY;
 	key.offset = 0;
 
-	extent_root = btrfs_extent_root(trans->fs_info, key.objectid);
 	ret = btrfs_search_slot_for_read(extent_root, &key, path, 1, 0);
 	if (ret < 0)
 		goto out_locked;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9dfd6632c8cc..aaa47b63ffb1 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3740,6 +3740,14 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 	mutex_lock(&fs_info->qgroup_rescan_lock);
 	extent_root = btrfs_extent_root(fs_info,
 				fs_info->qgroup_rescan_progress.objectid);
+	if (unlikely(!extent_root)) {
+		btrfs_err(fs_info,
+			  "missing extent root for extent at bytenr %llu",
+			  fs_info->qgroup_rescan_progress.objectid);
+		mutex_unlock(&fs_info->qgroup_rescan_lock);
+		return -EUCLEAN;
+	}
+
 	ret = btrfs_search_slot_for_read(extent_root,
 					 &fs_info->qgroup_rescan_progress,
 					 path, 1, 0);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 95f7c3a20691..3906e457d2ef 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4941,6 +4941,12 @@ static int do_remap_reloc_trans(struct btrfs_fs_info *fs_info,
 	struct btrfs_space_info *sinfo = src_bg->space_info;
 
 	extent_root = btrfs_extent_root(fs_info, src_bg->start);
+	if (unlikely(!extent_root)) {
+		btrfs_err(fs_info,
+			  "missing extent root for block group at offset %llu",
+			  src_bg->start);
+		return -EUCLEAN;
+	}
 
 	trans = btrfs_start_transaction(extent_root, 0);
 	if (IS_ERR(trans))
@@ -5293,6 +5299,13 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 	int ret;
 	bool bg_is_ro = false;
 
+	if (unlikely(!extent_root)) {
+		btrfs_err(fs_info,
+			  "missing extent root for block group at offset %llu",
+			  group_start);
+		return -EUCLEAN;
+	}
+
 	/*
 	 * This only gets set if we had a half-deleted snapshot on mount.  We
 	 * cannot allow relocation to start while we're still trying to clean up
@@ -5523,12 +5536,17 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	rc->extent_root = btrfs_extent_root(fs_info, 0);
+	if (unlikely(!rc->extent_root)) {
+		btrfs_err(fs_info, "missing extent root for extent at bytenr 0");
+		ret = -EUCLEAN;
+		goto out;
+	}
+
 	ret = reloc_chunk_start(fs_info);
 	if (ret < 0)
 		goto out_end;
 
-	rc->extent_root = btrfs_extent_root(fs_info, 0);
-
 	set_reloc_control(rc);
 
 	trans = btrfs_join_transaction(rc->extent_root);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index ae6f61bcefca..4a1dabeea531 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1259,6 +1259,13 @@ static int calculate_alloc_pointer(struct btrfs_block_group *cache,
 	key.offset = 0;
 
 	root = btrfs_extent_root(fs_info, key.objectid);
+	if (unlikely(!root)) {
+		btrfs_err(fs_info,
+			  "missing extent root for extent at bytenr %llu",
+			  key.objectid);
+		return -EUCLEAN;
+	}
+
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	/* We should not find the exact match */
 	if (unlikely(!ret))
-- 
2.47.2


