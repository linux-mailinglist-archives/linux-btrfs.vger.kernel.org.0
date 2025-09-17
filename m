Return-Path: <linux-btrfs+bounces-16893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 820CFB813EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 19:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 435254E2E0A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 17:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12722FF64B;
	Wed, 17 Sep 2025 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="arKKuEFl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ulfDYRB7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1302773CE
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131659; cv=none; b=nNR/43+QUeT04t7q/0yBMJ8ke7Tt5r1AgusHdUtSDV7DpQ4o7BztkI3LZqzN05znmaYONwCsvJBw7xQfc+IiwLgjy8uvozz13uVZStbItVqHcN76WXdCI13G18ENgsphoT+HAufeN/xqdnid7ilwhnXN5kaFwoHNv+sLJItEyOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131659; c=relaxed/simple;
	bh=Ah00FyUf1zO5znY7jY/tZZUm94R0NffWtDs0ON4NeGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsZf6KTZp+G+cnEQeDhGFi+OnlckfgcrloTMYEdk/qkn1FTzw5CSDp5Mc1OU9podiHn/gbrJ0un9h8RgqRGeuBrVl2fhG2P2cuKBo/fbayNW0IxWqu+mcKZIRSq0aTJDJCjduzsOP/CSZp3IEo0gK1hbPwd9dCJ1UoEIhk9T8YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=arKKuEFl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ulfDYRB7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB9135BF85;
	Wed, 17 Sep 2025 17:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758131653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTD3IlsgrybWJg9pL28UhLtMmh40uu/HFE0ceI2jeYk=;
	b=arKKuEFlAchaJgrS9a7EuWKQ24X5Z/P8b6i698BqW+A5YL2NeetRjQd+0T2RTwnl/JwOr0
	o/5LyqPDlr9AAYBmuGiVJ4RbgR5XCGHUdBAzUqaJPDnleDGfPmLpQqqyYkmvo+z7VEq/KE
	Ej21cSX373dyRu9ljZhbpCsgvWM4ipQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758131652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTD3IlsgrybWJg9pL28UhLtMmh40uu/HFE0ceI2jeYk=;
	b=ulfDYRB7Uf8xNhMIGzwiszxaaUzIE41ADnSwdqigwHcNvxVipAFNN8wlHRHrQ3pZCXDRtK
	RcOknOX3DB2s9lm30j/Sxdk2lRa50CaktxghNe5jvgGZtyLlfc7X8wEQn5CnIEB3Q8W1/q
	pW6Y2wbAfkC58X8dLn5C8rFgcxidSUI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4AEE137C3;
	Wed, 17 Sep 2025 17:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oFTSN8T1ymiQSgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 17 Sep 2025 17:54:12 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/3] btrfs: add unlikely annotations to branches leading to transaction abort
Date: Wed, 17 Sep 2025 19:53:56 +0200
Message-ID: <481d9c17e019b41cb00c25846102c032028c61de.1758130856.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758130856.git.dsterba@suse.com>
References: <cover.1758130856.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c      | 10 ++++----
 fs/btrfs/ctree.c            | 48 ++++++++++++++++++-------------------
 fs/btrfs/delayed-inode.c    |  2 +-
 fs/btrfs/extent-tree.c      | 38 ++++++++++++++---------------
 fs/btrfs/file-item.c        |  2 +-
 fs/btrfs/file.c             | 43 ++++++++++++++++-----------------
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/free-space-tree.c  | 12 +++++-----
 fs/btrfs/inode.c            | 36 ++++++++++++++--------------
 9 files changed, 96 insertions(+), 97 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6f7974060a1ab5..4330f5ba02dd7b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3248,7 +3248,7 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 	 */
 	BTRFS_I(inode)->generation = 0;
 	ret = btrfs_update_inode(trans, BTRFS_I(inode));
-	if (ret) {
+	if (unlikely(ret)) {
 		/*
 		 * So theoretically we could recover from this, simply set the
 		 * super cache generation to 0 so we know to invalidate the
@@ -3995,7 +3995,7 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
 		struct btrfs_space_info *sys_space_info;
 
 		sys_space_info = btrfs_find_space_info(trans->fs_info, sys_flags);
-		if (!sys_space_info) {
+		if (unlikely(!sys_space_info)) {
 			ret = -EINVAL;
 			btrfs_abort_transaction(trans, ret);
 			goto out;
@@ -4009,17 +4009,17 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
 		}
 
 		ret = btrfs_chunk_alloc_add_chunk_item(trans, sys_bg);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
 
 		ret = btrfs_chunk_alloc_add_chunk_item(trans, bg);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
-	} else if (ret) {
+	} else if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 4257a4707e29cb..368e12409a50d7 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -297,7 +297,7 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 			btrfs_abort_transaction(trans, ret);
 	} else {
 		ret = btrfs_inc_ref(trans, root, cow, 0);
-		if (ret)
+		if (unlikely(ret))
 			btrfs_abort_transaction(trans, ret);
 	}
 	if (ret) {
@@ -536,14 +536,14 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 	write_extent_buffer_fsid(cow, fs_info->fs_devices->metadata_uuid);
 
 	ret = update_ref_for_cow(trans, root, buf, cow, &last_ref);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		goto error_unlock_cow;
 	}
 
 	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
 		ret = btrfs_reloc_cow_block(trans, root, buf, cow);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			goto error_unlock_cow;
 		}
@@ -556,7 +556,7 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 			parent_start = buf->start;
 
 		ret = btrfs_tree_mod_log_insert_root(root->node, cow, true);
-		if (ret < 0) {
+		if (unlikely(ret < 0)) {
 			btrfs_abort_transaction(trans, ret);
 			goto error_unlock_cow;
 		}
@@ -567,7 +567,7 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 					    parent_start, last_ref);
 		free_extent_buffer(buf);
 		add_root_to_dirty_list(root);
-		if (ret < 0) {
+		if (unlikely(ret < 0)) {
 			btrfs_abort_transaction(trans, ret);
 			goto error_unlock_cow;
 		}
@@ -575,7 +575,7 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 		WARN_ON(trans->transid != btrfs_header_generation(parent));
 		ret = btrfs_tree_mod_log_insert_key(parent, parent_slot,
 						    BTRFS_MOD_LOG_KEY_REPLACE);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			goto error_unlock_cow;
 		}
@@ -586,14 +586,14 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 		btrfs_mark_buffer_dirty(trans, parent);
 		if (last_ref) {
 			ret = btrfs_tree_mod_log_free_eb(buf);
-			if (ret) {
+			if (unlikely(ret)) {
 				btrfs_abort_transaction(trans, ret);
 				goto error_unlock_cow;
 			}
 		}
 		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
 					    parent_start, last_ref);
-		if (ret < 0) {
+		if (unlikely(ret < 0)) {
 			btrfs_abort_transaction(trans, ret);
 			goto error_unlock_cow;
 		}
@@ -913,7 +913,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		}
 
 		ret = btrfs_tree_mod_log_insert_root(root->node, child, true);
-		if (ret < 0) {
+		if (unlikely(ret < 0)) {
 			btrfs_tree_unlock(child);
 			free_extent_buffer(child);
 			btrfs_abort_transaction(trans, ret);
@@ -935,7 +935,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
 		/* once for the root ptr */
 		free_extent_buffer_stale(mid);
-		if (ret < 0) {
+		if (unlikely(ret < 0)) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
@@ -1010,7 +1010,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 						    right, 0, 1);
 			free_extent_buffer_stale(right);
 			right = NULL;
-			if (ret < 0) {
+			if (unlikely(ret < 0)) {
 				btrfs_abort_transaction(trans, ret);
 				goto out;
 			}
@@ -1019,7 +1019,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			btrfs_node_key(right, &right_key, 0);
 			ret = btrfs_tree_mod_log_insert_key(parent, pslot + 1,
 					BTRFS_MOD_LOG_KEY_REPLACE);
-			if (ret < 0) {
+			if (unlikely(ret < 0)) {
 				btrfs_abort_transaction(trans, ret);
 				goto out;
 			}
@@ -1071,7 +1071,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
 		free_extent_buffer_stale(mid);
 		mid = NULL;
-		if (ret < 0) {
+		if (unlikely(ret < 0)) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
@@ -1081,7 +1081,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		btrfs_node_key(mid, &mid_key, 0);
 		ret = btrfs_tree_mod_log_insert_key(parent, pslot,
 						    BTRFS_MOD_LOG_KEY_REPLACE);
-		if (ret < 0) {
+		if (unlikely(ret < 0)) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
@@ -1186,7 +1186,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 			btrfs_node_key(mid, &disk_key, 0);
 			ret = btrfs_tree_mod_log_insert_key(parent, pslot,
 					BTRFS_MOD_LOG_KEY_REPLACE);
-			if (ret < 0) {
+			if (unlikely(ret < 0)) {
 				btrfs_tree_unlock(left);
 				free_extent_buffer(left);
 				btrfs_abort_transaction(trans, ret);
@@ -1246,7 +1246,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 			btrfs_node_key(right, &disk_key, 0);
 			ret = btrfs_tree_mod_log_insert_key(parent, pslot + 1,
 					BTRFS_MOD_LOG_KEY_REPLACE);
-			if (ret < 0) {
+			if (unlikely(ret < 0)) {
 				btrfs_tree_unlock(right);
 				free_extent_buffer(right);
 				btrfs_abort_transaction(trans, ret);
@@ -2728,7 +2728,7 @@ static int push_node_left(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 	ret = btrfs_tree_mod_log_eb_copy(dst, src, dst_nritems, 0, push_items);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
@@ -2813,7 +2813,7 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_tree_mod_log_eb_copy(dst, src, 0, src_nritems - push_items,
 					 push_items);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
@@ -2883,7 +2883,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 
 		btrfs_clear_buffer_dirty(trans, c);
 		ret2 = btrfs_free_tree_block(trans, btrfs_root_id(root), c, 0, 1);
-		if (ret2 < 0)
+		if (unlikely(ret2 < 0))
 			btrfs_abort_transaction(trans, ret2);
 		btrfs_tree_unlock(c);
 		free_extent_buffer(c);
@@ -2928,7 +2928,7 @@ static int insert_ptr(struct btrfs_trans_handle *trans,
 		if (level) {
 			ret = btrfs_tree_mod_log_insert_move(lower, slot + 1,
 					slot, nritems - slot);
-			if (ret < 0) {
+			if (unlikely(ret < 0)) {
 				btrfs_abort_transaction(trans, ret);
 				return ret;
 			}
@@ -2941,7 +2941,7 @@ static int insert_ptr(struct btrfs_trans_handle *trans,
 	if (level) {
 		ret = btrfs_tree_mod_log_insert_key(lower, slot,
 						    BTRFS_MOD_LOG_KEY_ADD);
-		if (ret < 0) {
+		if (unlikely(ret < 0)) {
 			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
@@ -3017,7 +3017,7 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 	ASSERT(btrfs_header_level(c) == level);
 
 	ret = btrfs_tree_mod_log_eb_copy(split, c, 0, mid, c_nritems - mid);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_tree_unlock(split);
 		free_extent_buffer(split);
 		btrfs_abort_transaction(trans, ret);
@@ -4374,7 +4374,7 @@ int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (level) {
 			ret = btrfs_tree_mod_log_insert_move(parent, slot,
 					slot + 1, nritems - slot - 1);
-			if (ret < 0) {
+			if (unlikely(ret < 0)) {
 				btrfs_abort_transaction(trans, ret);
 				return ret;
 			}
@@ -4387,7 +4387,7 @@ int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	} else if (level) {
 		ret = btrfs_tree_mod_log_insert_key(parent, slot,
 						    BTRFS_MOD_LOG_KEY_REMOVE);
-		if (ret < 0) {
+		if (unlikely(ret < 0)) {
 			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 6adfe62cd0c4dd..4284597f55009b 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1175,7 +1175,7 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 	while (curr_node && (!count || nr--)) {
 		ret = __btrfs_commit_inode_delayed_items(trans, path,
 							 curr_node);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			break;
 		}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f189a0bfeda5b7..040bf4df6096f9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2157,7 +2157,7 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans, u64 min_bytes)
 	delayed_refs->run_delayed_start = find_middle(&delayed_refs->root);
 #endif
 	ret = __btrfs_run_delayed_refs(trans, min_bytes);
-	if (ret < 0) {
+	if (unlikely(ret < 0)) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
@@ -2982,26 +2982,26 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
 
 		csum_root = btrfs_csum_root(trans->fs_info, bytenr);
 		ret = btrfs_del_csums(trans, csum_root, bytenr, num_bytes);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
 
 		ret = btrfs_delete_raid_extent(trans, bytenr, num_bytes);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
 	}
 
 	ret = btrfs_record_squota_delta(trans->fs_info, delta);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
 
 	ret = btrfs_add_to_free_space_tree(trans, bytenr, num_bytes);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
@@ -3115,7 +3115,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 
 	is_data = owner_objectid >= BTRFS_FIRST_FREE_OBJECTID;
 
-	if (!is_data && refs_to_drop != 1) {
+	if (unlikely(!is_data && refs_to_drop != 1)) {
 		btrfs_crit(info,
 "invalid refs_to_drop, dropping more than 1 refs for tree block %llu refs_to_drop %u",
 			   node->bytenr, refs_to_drop);
@@ -3172,7 +3172,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			/* Must be SHARED_* item, remove the backref first */
 			ret = remove_extent_backref(trans, extent_root, path,
 						    NULL, refs_to_drop, is_data);
-			if (ret) {
+			if (unlikely(ret)) {
 				btrfs_abort_transaction(trans, ret);
 				goto out;
 			}
@@ -3221,7 +3221,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			"umm, got %d back from search, was looking for %llu, slot %d",
 					  ret, bytenr, path->slots[0]);
 			}
-			if (ret < 0) {
+			if (unlikely(ret < 0)) {
 				btrfs_abort_transaction(trans, ret);
 				goto out;
 			}
@@ -3298,7 +3298,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		if (found_extent) {
 			ret = remove_extent_backref(trans, extent_root, path,
 						    iref, refs_to_drop, is_data);
-			if (ret) {
+			if (unlikely(ret)) {
 				btrfs_abort_transaction(trans, ret);
 				goto out;
 			}
@@ -3363,7 +3363,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 
 		ret = btrfs_del_items(trans, extent_root, path, path->slots[0],
 				      num_to_del);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
@@ -5472,17 +5472,17 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	if (!(wc->flags[level] & flag)) {
 		ASSERT(path->locks[level]);
 		ret = btrfs_inc_ref(trans, root, eb, 1);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
 		ret = btrfs_dec_ref(trans, root, eb, 0);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
 		ret = btrfs_set_disk_extent_flags(trans, eb, flag);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
@@ -5885,7 +5885,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				}
 			} else {
 				ret = btrfs_dec_ref(trans, root, eb, 0);
-				if (ret) {
+				if (unlikely(ret)) {
 					btrfs_abort_transaction(trans, ret);
 					return ret;
 				}
@@ -6180,13 +6180,13 @@ int btrfs_drop_snapshot(struct btrfs_root *root, bool update_ref, bool for_reloc
 	while (1) {
 
 		ret = walk_down_tree(trans, root, path, wc);
-		if (ret < 0) {
+		if (unlikely(ret < 0)) {
 			btrfs_abort_transaction(trans, ret);
 			break;
 		}
 
 		ret = walk_up_tree(trans, root, path, wc, BTRFS_MAX_LEVEL);
-		if (ret < 0) {
+		if (unlikely(ret < 0)) {
 			btrfs_abort_transaction(trans, ret);
 			break;
 		}
@@ -6213,7 +6213,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, bool update_ref, bool for_reloc
 			ret = btrfs_update_root(trans, tree_root,
 						&root->root_key,
 						root_item);
-			if (ret) {
+			if (unlikely(ret)) {
 				btrfs_abort_transaction(trans, ret);
 				goto out_end_trans;
 			}
@@ -6249,7 +6249,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, bool update_ref, bool for_reloc
 		goto out_end_trans;
 
 	ret = btrfs_del_root(trans, &root->root_key);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_end_trans;
 	}
@@ -6257,7 +6257,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, bool update_ref, bool for_reloc
 	if (!is_reloc_root) {
 		ret = btrfs_find_root(tree_root, &root->root_key, path,
 				      NULL, NULL);
-		if (ret < 0) {
+		if (unlikely(ret < 0)) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_end_trans;
 		} else if (ret > 0) {
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 7906aea75ee46e..a42e6d54e7cd74 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1011,7 +1011,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 			 * item changed size or key
 			 */
 			ret = btrfs_split_item(trans, root, path, &key, offset);
-			if (ret && ret != -EAGAIN) {
+			if (unlikely(ret && ret != -EAGAIN)) {
 				btrfs_abort_transaction(trans, ret);
 				break;
 			}
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e7765578349b6d..7efd1f8a19121f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -327,7 +327,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 						    args->start - extent_offset,
 						    0, false);
 				ret = btrfs_inc_extent_ref(trans, &ref);
-				if (ret) {
+				if (unlikely(ret)) {
 					btrfs_abort_transaction(trans, ret);
 					break;
 				}
@@ -426,7 +426,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 						    key.offset - extent_offset,
 						    0, false);
 				ret = btrfs_free_extent(trans, &ref);
-				if (ret) {
+				if (unlikely(ret)) {
 					btrfs_abort_transaction(trans, ret);
 					break;
 				}
@@ -443,7 +443,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 
 			ret = btrfs_del_items(trans, root, path, del_slot,
 					      del_nr);
-			if (ret) {
+			if (unlikely(ret)) {
 				btrfs_abort_transaction(trans, ret);
 				break;
 			}
@@ -587,21 +587,20 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 
 	leaf = path->nodes[0];
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
-	if (key.objectid != ino ||
-	    key.type != BTRFS_EXTENT_DATA_KEY) {
+	if (unlikely(key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)) {
 		ret = -EINVAL;
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 	fi = btrfs_item_ptr(leaf, path->slots[0],
 			    struct btrfs_file_extent_item);
-	if (btrfs_file_extent_type(leaf, fi) != BTRFS_FILE_EXTENT_PREALLOC) {
+	if (unlikely(btrfs_file_extent_type(leaf, fi) != BTRFS_FILE_EXTENT_PREALLOC)) {
 		ret = -EINVAL;
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 	extent_end = key.offset + btrfs_file_extent_num_bytes(leaf, fi);
-	if (key.offset > start || extent_end < end) {
+	if (unlikely(key.offset > start || extent_end < end)) {
 		ret = -EINVAL;
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -676,7 +675,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 			btrfs_release_path(path);
 			goto again;
 		}
-		if (ret < 0) {
+		if (unlikely(ret < 0)) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
@@ -704,7 +703,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		ref.ref_root = btrfs_root_id(root);
 		btrfs_init_data_ref(&ref, ino, orig_offset, 0, false);
 		ret = btrfs_inc_extent_ref(trans, &ref);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
@@ -712,7 +711,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		if (split == start) {
 			key.offset = start;
 		} else {
-			if (start != key.offset) {
+			if (unlikely(start != key.offset)) {
 				ret = -EINVAL;
 				btrfs_abort_transaction(trans, ret);
 				goto out;
@@ -744,7 +743,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		del_slot = path->slots[0] + 1;
 		del_nr++;
 		ret = btrfs_free_extent(trans, &ref);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
@@ -762,7 +761,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		del_slot = path->slots[0];
 		del_nr++;
 		ret = btrfs_free_extent(trans, &ref);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
@@ -783,7 +782,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 						extent_end - key.offset);
 
 		ret = btrfs_del_items(trans, root, path, del_slot, del_nr);
-		if (ret < 0) {
+		if (unlikely(ret < 0)) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
@@ -2460,9 +2459,9 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 			 * got EOPNOTSUPP via prealloc then we messed up and
 			 * need to abort.
 			 */
-			if (ret &&
-			    (ret != -EOPNOTSUPP ||
-			     (extent_info && extent_info->is_new_extent)))
+			if (unlikely(ret &&
+				     (ret != -EOPNOTSUPP ||
+				      (extent_info && extent_info->is_new_extent))))
 				btrfs_abort_transaction(trans, ret);
 			break;
 		}
@@ -2473,7 +2472,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 		    cur_offset < ino_size) {
 			ret = fill_holes(trans, inode, path, cur_offset,
 					 drop_args.drop_end);
-			if (ret) {
+			if (unlikely(ret)) {
 				/*
 				 * If we failed then we didn't insert our hole
 				 * entries for the area we dropped, so now the
@@ -2493,7 +2492,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 			ret = btrfs_inode_clear_file_extent_range(inode,
 					cur_offset,
 					drop_args.drop_end - cur_offset);
-			if (ret) {
+			if (unlikely(ret)) {
 				/*
 				 * We couldn't clear our area, so we could
 				 * presumably adjust up and corrupt the fs, so
@@ -2512,7 +2511,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 			ret = btrfs_insert_replace_extent(trans, inode,	path,
 					extent_info, replace_len,
 					drop_args.bytes_found);
-			if (ret) {
+			if (unlikely(ret)) {
 				btrfs_abort_transaction(trans, ret);
 				break;
 			}
@@ -2607,7 +2606,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 	    cur_offset < drop_args.drop_end) {
 		ret = fill_holes(trans, inode, path, cur_offset,
 				 drop_args.drop_end);
-		if (ret) {
+		if (unlikely(ret)) {
 			/* Same comment as above. */
 			btrfs_abort_transaction(trans, ret);
 			goto out_trans;
@@ -2616,7 +2615,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 		/* See the comment in the loop above for the reasoning here. */
 		ret = btrfs_inode_clear_file_extent_range(inode, cur_offset,
 					drop_args.drop_end - cur_offset);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_trans;
 		}
@@ -2626,7 +2625,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 		ret = btrfs_insert_replace_extent(trans, inode, path,
 				extent_info, extent_info->data_len,
 				drop_args.bytes_found);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_trans;
 		}
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index c2730740d92821..ab873bd6719209 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -4142,7 +4142,7 @@ int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info, bool act
 	if (!active) {
 		set_bit(BTRFS_FS_CLEANUP_SPACE_CACHE_V1, &fs_info->flags);
 		ret = cleanup_free_space_cache_v1(fs_info, trans);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			btrfs_end_transaction(trans);
 			goto out;
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 2fee9f3b60d439..edda7f1eda50fe 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1185,7 +1185,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 		goto out_clear;
 	}
 	ret = btrfs_global_root_insert(free_space_root);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_put_root(free_space_root);
 		btrfs_abort_transaction(trans, ret);
 		btrfs_end_transaction(trans);
@@ -1197,7 +1197,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 		block_group = rb_entry(node, struct btrfs_block_group,
 				       cache_node);
 		ret = populate_free_space_tree(trans, block_group);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			btrfs_end_transaction(trans);
 			goto out_clear;
@@ -1290,14 +1290,14 @@ int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info)
 	btrfs_clear_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID);
 
 	ret = clear_free_space_tree(trans, free_space_root);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		btrfs_end_transaction(trans);
 		return ret;
 	}
 
 	ret = btrfs_del_root(trans, &free_space_root->root_key);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		btrfs_end_transaction(trans);
 		return ret;
@@ -1315,7 +1315,7 @@ int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info)
 	ret = btrfs_free_tree_block(trans, btrfs_root_id(free_space_root),
 				    free_space_root->node, 0, 1);
 	btrfs_put_root(free_space_root);
-	if (ret < 0) {
+	if (unlikely(ret < 0)) {
 		btrfs_abort_transaction(trans, ret);
 		btrfs_end_transaction(trans);
 		return ret;
@@ -1344,7 +1344,7 @@ int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
 	set_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
 
 	ret = clear_free_space_tree(trans, free_space_root);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		btrfs_end_transaction(trans);
 		return ret;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 27226e7761aead..4e5a1812fc82f8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -634,7 +634,7 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 	drop_args.replace_extent = true;
 	drop_args.extent_item_size = btrfs_file_extent_calc_inline_size(data_len);
 	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
@@ -642,7 +642,7 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 	ret = insert_inline_extent(trans, path, inode, drop_args.extent_inserted,
 				   size, compressed_size, compress_type,
 				   compressed_folio, update_i_size);
-	if (ret && ret != -ENOSPC) {
+	if (unlikely(ret && ret != -ENOSPC)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	} else if (ret == -ENOSPC) {
@@ -652,7 +652,7 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 
 	btrfs_update_inode_bytes(inode, size, drop_args.bytes_found);
 	ret = btrfs_update_inode(trans, inode);
-	if (ret && ret != -ENOSPC) {
+	if (unlikely(ret && ret != -ENOSPC)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	} else if (ret == -ENOSPC) {
@@ -3148,7 +3148,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 	trans->block_rsv = &inode->block_rsv;
 
 	ret = btrfs_insert_raid_extent(trans, ordered_extent);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
@@ -3156,7 +3156,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 	if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
 		/* Logic error */
 		ASSERT(list_empty(&ordered_extent->list));
-		if (!list_empty(&ordered_extent->list)) {
+		if (unlikely(!list_empty(&ordered_extent->list))) {
 			ret = -EINVAL;
 			btrfs_abort_transaction(trans, ret);
 			goto out;
@@ -3164,7 +3164,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 
 		btrfs_inode_safe_disk_i_size_write(inode, 0);
 		ret = btrfs_update_inode_fallback(trans, inode);
-		if (ret) {
+		if (unlikely(ret)) {
 			/* -ENOMEM or corruption */
 			btrfs_abort_transaction(trans, ret);
 		}
@@ -3191,20 +3191,20 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 						ordered_extent->disk_num_bytes);
 		}
 	}
-	if (ret < 0) {
+	if (unlikely(ret < 0)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
 	ret = btrfs_unpin_extent_cache(inode, ordered_extent->file_offset,
 				       ordered_extent->num_bytes, trans->transid);
-	if (ret < 0) {
+	if (unlikely(ret < 0)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
 	ret = add_pending_csums(trans, &ordered_extent->list);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
@@ -3222,7 +3222,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 
 	btrfs_inode_safe_disk_i_size_write(inode, 0);
 	ret = btrfs_update_inode_fallback(trans, inode);
-	if (ret) { /* -ENOMEM or corruption */
+	if (unlikely(ret)) { /* -ENOMEM or corruption */
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
@@ -3537,7 +3537,7 @@ int btrfs_orphan_add(struct btrfs_trans_handle *trans,
 	int ret;
 
 	ret = btrfs_insert_orphan_item(trans, inode->root, btrfs_ino(inode));
-	if (ret && ret != -EEXIST) {
+	if (unlikely(ret && ret != -EEXIST)) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
@@ -4286,7 +4286,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	}
 
 	ret = btrfs_del_inode_ref(trans, root, name, ino, dir_ino, &index);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_crit(fs_info,
 	   "failed to delete reference to %.*s, root %llu inode %llu parent %llu",
 			   name->len, name->name, btrfs_root_id(root), ino, dir_ino);
@@ -4298,7 +4298,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		rename_ctx->index = index;
 
 	ret = btrfs_delete_delayed_dir_index(trans, dir, index);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
@@ -4453,7 +4453,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	btrfs_dir_item_key_to_cpu(leaf, di, &key);
 	WARN_ON(key.type != BTRFS_ROOT_ITEM_KEY || key.objectid != objectid);
 	ret = btrfs_delete_one_dir_name(trans, root, path, di);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
@@ -4484,14 +4484,14 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 		ret = btrfs_del_root_ref(trans, objectid,
 					 btrfs_root_id(root), dir_ino,
 					 &index, &fname.disk_name);
-		if (ret) {
+		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
 	}
 
 	ret = btrfs_delete_delayed_dir_index(trans, dir, index);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
@@ -4663,13 +4663,13 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 	btrfs_record_snapshot_destroy(trans, dir);
 
 	ret = btrfs_unlink_subvol(trans, dir, dentry);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_end_trans;
 	}
 
 	ret = btrfs_record_root_in_trans(trans, dest);
-	if (ret) {
+	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_end_trans;
 	}
-- 
2.51.0


