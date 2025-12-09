Return-Path: <linux-btrfs+bounces-19610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5973CCB0E6E
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 20:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FF9F3019D0C
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 19:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A353A303C8B;
	Tue,  9 Dec 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MghylOou";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MghylOou"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3351E27C162
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765307214; cv=none; b=tczszUx07TC2JoGABWcZrSes3oNwucd7aMo5L6mNbTHIFrrWPsDSyYA3x4TDlsSAybiRXP/btjJZbM90mddrmRdzR++q1q2iODt+6KPw1ioqHHdsBR/Tf3cPi3BVeLvyQ+FQPQ1RsGsegj9bFGfGmMxWBXLOgoGJjFTiQAnhnQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765307214; c=relaxed/simple;
	bh=9P0+cPMp4zLz4SnnvxlAkK3FBJYBT5XfVqcYwQ94lbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7j8Iz7I7E0RLmVf8l8VxPYAO1qKUZ9h1deHtO83IhnFfW6R53ZOfgYKBgVElh5ldgohTujE6wc1ZbUMdjYLy4JsYfk3bsOLAY4o5K7GsxdINoU7vz99VKBZVh0yf6K04zoRcxQbM/Mq/xHOWLVCdeZN3tXPNw2WmYpyLIrx5Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MghylOou; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MghylOou; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 530525BDA2;
	Tue,  9 Dec 2025 19:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765307210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1qCk6rJlIuvqeRWQ+SzXFSGAMoGDExBfS95M1XDriEQ=;
	b=MghylOouZmsZF8JxaKdK/eRsuTQpvb7TSntBhEXN9UD7ADDUkAjv/dbaGqqtOTSsUHiz9p
	zpd9FORyWMbrtdxLv/9vbJ5TVHokxL7Zbllc5QPXGwPoQinkTd1NPks1O+Id2JlIphHikA
	uuw2fnnKe2NcXzV8njRYDqvathUqNp0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765307210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1qCk6rJlIuvqeRWQ+SzXFSGAMoGDExBfS95M1XDriEQ=;
	b=MghylOouZmsZF8JxaKdK/eRsuTQpvb7TSntBhEXN9UD7ADDUkAjv/dbaGqqtOTSsUHiz9p
	zpd9FORyWMbrtdxLv/9vbJ5TVHokxL7Zbllc5QPXGwPoQinkTd1NPks1O+Id2JlIphHikA
	uuw2fnnKe2NcXzV8njRYDqvathUqNp0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 466A83EA63;
	Tue,  9 Dec 2025 19:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A5aCEEpzOGm8UgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 09 Dec 2025 19:06:50 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: merge setting ret and return ret
Date: Tue,  9 Dec 2025 20:06:49 +0100
Message-ID: <20251209190649.2168799-1-dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.978];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

In many places we have pattern:

	ret = ...;
	return ret;

This can be simplified to a direct return, removing 'ret' if not
otherwise needed. The places in self tests are not converted so we can
add more test cases without changing surrounding code
(extent-map-tests.c:test_case_4()).

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c     |  3 +--
 fs/btrfs/ctree.c           |  3 +--
 fs/btrfs/delayed-inode.c   |  4 ++--
 fs/btrfs/disk-io.c         | 13 +++++--------
 fs/btrfs/extent-io-tree.c  |  7 ++-----
 fs/btrfs/extent-tree.c     | 10 +++-------
 fs/btrfs/file.c            |  3 +--
 fs/btrfs/free-space-tree.c |  4 +---
 fs/btrfs/inode-item.c      |  7 +++----
 fs/btrfs/inode.c           | 13 ++++---------
 fs/btrfs/qgroup.c          | 14 ++++----------
 fs/btrfs/relocation.c      |  5 ++---
 fs/btrfs/volumes.c         |  9 +++------
 13 files changed, 32 insertions(+), 63 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 08b14449fabeba..3864aec520b3f7 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1057,8 +1057,7 @@ static int remove_block_group_item(struct btrfs_trans_handle *trans,
 	if (ret < 0)
 		return ret;
 
-	ret = btrfs_del_item(trans, root, path);
-	return ret;
+	return btrfs_del_item(trans, root, path);
 }
 
 int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e245b8c4c3405e..7267b250266579 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4002,8 +4002,7 @@ int btrfs_split_item(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	ret = split_item(trans, path, new_key, split_offset);
-	return ret;
+	return split_item(trans, path, new_key, split_offset);
 }
 
 /*
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index ce6e9f8812e066..79e374ad536555 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1135,8 +1135,8 @@ __btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
 	ret = btrfs_record_root_in_trans(trans, node->root);
 	if (ret)
 		return ret;
-	ret = btrfs_update_delayed_inode(trans, node->root, path, node);
-	return ret;
+
+	return btrfs_update_delayed_inode(trans, node->root, path, node);
 }
 
 /*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 89149fac804c80..712610c622ba5a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -186,7 +186,6 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
 	const u32 step = min(fs_info->nodesize, PAGE_SIZE);
 	const u32 nr_steps = eb->len / step;
 	phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
-	int ret = 0;
 
 	if (sb_rdonly(fs_info->sb))
 		return -EROFS;
@@ -208,9 +207,8 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
 		paddrs[i] = page_to_phys(&folio->page) + offset_in_page(eb->start);
 	}
 
-	ret = btrfs_repair_io_failure(fs_info, 0, eb->start, eb->len, eb->start,
-				      paddrs, step, mirror_num);
-	return ret;
+	return btrfs_repair_io_failure(fs_info, 0, eb->start, eb->len,
+				       eb->start, paddrs, step, mirror_num);
 }
 
 /*
@@ -2194,11 +2192,10 @@ static int load_global_roots(struct btrfs_root *tree_root)
 		return ret;
 	if (!btrfs_fs_compat_ro(tree_root->fs_info, FREE_SPACE_TREE))
 		return ret;
-	ret = load_global_roots_objectid(tree_root, path,
-					 BTRFS_FREE_SPACE_TREE_OBJECTID,
-					 "free space");
 
-	return ret;
+	return load_global_roots_objectid(tree_root, path,
+					  BTRFS_FREE_SPACE_TREE_OBJECTID,
+					  "free space");
 }
 
 static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index bb2ca1c9c7b026..d0dd50f7d2795f 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -187,8 +187,6 @@ static int add_extent_changeset(struct extent_state *state, u32 bits,
 				 struct extent_changeset *changeset,
 				 int set)
 {
-	int ret;
-
 	if (!changeset)
 		return 0;
 	if (set && (state->state & bits) == bits)
@@ -196,9 +194,8 @@ static int add_extent_changeset(struct extent_state *state, u32 bits,
 	if (!set && (state->state & bits) == 0)
 		return 0;
 	changeset->bytes_changed += state->end - state->start + 1;
-	ret = ulist_add(&changeset->range_changed, state->start, state->end,
-			GFP_ATOMIC);
-	return ret;
+
+	return ulist_add(&changeset->range_changed, state->start, state->end, GFP_ATOMIC);
 }
 
 static inline struct extent_state *next_state(struct extent_state *state)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 04a266bb189b00..3b840a4fdf1c0d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2559,7 +2559,6 @@ static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 flags;
-	u64 ret;
 
 	if (data)
 		flags = BTRFS_BLOCK_GROUP_DATA;
@@ -2568,8 +2567,7 @@ static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
 	else
 		flags = BTRFS_BLOCK_GROUP_METADATA;
 
-	ret = btrfs_get_alloc_profile(fs_info, flags);
-	return ret;
+	return btrfs_get_alloc_profile(fs_info, flags);
 }
 
 static u64 first_logical_byte(struct btrfs_fs_info *fs_info)
@@ -4191,10 +4189,8 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 			else
 				trans = btrfs_join_transaction(root);
 
-			if (IS_ERR(trans)) {
-				ret = PTR_ERR(trans);
-				return ret;
-			}
+			if (IS_ERR(trans))
+				return PTR_ERR(trans);
 
 			ret = btrfs_chunk_alloc(trans, space_info, ffe_ctl->flags,
 						CHUNK_ALLOC_FORCE_FOR_EXTENT);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7a501e73d8802f..3030b6ad189dd0 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1274,8 +1274,7 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *iter,
 		btrfs_delalloc_release_extents(inode, reserved_len);
 		release_space(inode, *data_reserved, reserved_start, reserved_len,
 			      only_release_metadata);
-		ret = extents_locked;
-		return ret;
+		return extents_locked;
 	}
 
 	copied = copy_folio_from_iter_atomic(folio, offset_in_folio(folio, start),
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 1ad2ad384b9e86..a66ce9ef3affb6 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1525,9 +1525,7 @@ int btrfs_remove_block_group_free_space(struct btrfs_trans_handle *trans,
 		btrfs_release_path(path);
 	}
 
-	ret = 0;
-
-	return ret;
+	return 0;
 }
 
 static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index b73e1dd97208a8..a864f8c9972964 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -371,14 +371,13 @@ int btrfs_insert_empty_inode(struct btrfs_trans_handle *trans,
 			     struct btrfs_path *path, u64 objectid)
 {
 	struct btrfs_key key;
-	int ret;
+
 	key.objectid = objectid;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
-	ret = btrfs_insert_empty_item(trans, root, path, &key,
-				      sizeof(struct btrfs_inode_item));
-	return ret;
+	return btrfs_insert_empty_item(trans, root, path, &key,
+				       sizeof(struct btrfs_inode_item));
 }
 
 int btrfs_lookup_inode(struct btrfs_trans_handle *trans, struct btrfs_root
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 619aeab7748628..b71b91cf32b28d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2345,7 +2345,6 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 			     u64 start, u64 end, struct writeback_control *wbc)
 {
 	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
-	int ret;
 
 	/*
 	 * The range must cover part of the @locked_folio, or a return of 1
@@ -2354,10 +2353,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 	ASSERT(!(end <= folio_pos(locked_folio) ||
 		 start >= folio_next_pos(locked_folio)));
 
-	if (should_nocow(inode, start, end)) {
-		ret = run_delalloc_nocow(inode, locked_folio, start, end);
-		return ret;
-	}
+	if (should_nocow(inode, start, end))
+		return run_delalloc_nocow(inode, locked_folio, start, end);
 
 	if (btrfs_inode_can_compress(inode) &&
 	    inode_need_compress(inode, start, end) &&
@@ -2365,11 +2362,9 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 		return 1;
 
 	if (zoned)
-		ret = run_delalloc_cow(inode, locked_folio, start, end, wbc,
-				       true);
+		return run_delalloc_cow(inode, locked_folio, start, end, wbc, true);
 	else
-		ret = cow_file_range(inode, locked_folio, start, end, NULL, 0);
-	return ret;
+		return cow_file_range(inode, locked_folio, start, end, NULL, 0);
 }
 
 void btrfs_split_delalloc_extent(struct btrfs_inode *inode,
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ae4a1b76646c5c..14d393a5853d46 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -694,7 +694,6 @@ void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
 static int add_qgroup_relation_item(struct btrfs_trans_handle *trans, u64 src,
 				    u64 dst)
 {
-	int ret;
 	struct btrfs_root *quota_root = trans->fs_info->quota_root;
 	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
@@ -707,8 +706,7 @@ static int add_qgroup_relation_item(struct btrfs_trans_handle *trans, u64 src,
 	key.type = BTRFS_QGROUP_RELATION_KEY;
 	key.offset = dst;
 
-	ret = btrfs_insert_empty_item(trans, quota_root, path, &key, 0);
-	return ret;
+	return btrfs_insert_empty_item(trans, quota_root, path, &key, 0);
 }
 
 static int del_qgroup_relation_item(struct btrfs_trans_handle *trans, u64 src,
@@ -833,9 +831,7 @@ static int del_qgroup_item(struct btrfs_trans_handle *trans, u64 qgroupid)
 	if (ret > 0)
 		return -ENOENT;
 
-	ret = btrfs_del_item(trans, quota_root, path);
-
-	return ret;
+	return btrfs_del_item(trans, quota_root, path);
 }
 
 static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
@@ -2655,10 +2651,8 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 			return ret;
 	}
 
-	if (root_level == 0) {
-		ret = btrfs_qgroup_trace_leaf_items(trans, root_eb);
-		return ret;
-	}
+	if (root_level == 0)
+		return btrfs_qgroup_trace_leaf_items(trans, root_eb);
 
 	path = btrfs_alloc_path();
 	if (!path)
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5bfefc3e9c0616..310b7d817a277a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3254,7 +3254,6 @@ static int delete_v1_space_cache(struct extent_buffer *leaf,
 	struct btrfs_key key;
 	bool found = false;
 	int i;
-	int ret;
 
 	if (btrfs_header_owner(leaf) != BTRFS_ROOT_TREE_OBJECTID)
 		return 0;
@@ -3278,8 +3277,8 @@ static int delete_v1_space_cache(struct extent_buffer *leaf,
 	}
 	if (!found)
 		return -ENOENT;
-	ret = delete_block_group_cache(block_group, NULL, space_cache_ino);
-	return ret;
+
+	return delete_block_group_cache(block_group, NULL, space_cache_ino);
 }
 
 /*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ae1742a35e76f4..4aa92bae60cbce 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2314,9 +2314,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		free_fs_devices(cur_devices);
 	}
 
-	ret = btrfs_commit_transaction(trans);
-
-	return ret;
+	return btrfs_commit_transaction(trans);
 
 error_undo:
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
@@ -7164,7 +7162,6 @@ static int read_one_dev(struct extent_buffer *leaf,
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
 	u64 devid;
-	int ret;
 	u8 fs_uuid[BTRFS_FSID_SIZE];
 	u8 dev_uuid[BTRFS_UUID_SIZE];
 
@@ -7263,8 +7260,8 @@ static int read_one_dev(struct extent_buffer *leaf,
 		atomic64_add(device->total_bytes - device->bytes_used,
 				&fs_info->free_chunk_space);
 	}
-	ret = 0;
-	return ret;
+
+	return 0;
 }
 
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
-- 
2.51.1


