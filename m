Return-Path: <linux-btrfs+bounces-19100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B7BC6A8AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 17:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8C0E4E9112
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C489C364030;
	Tue, 18 Nov 2025 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K1uacwrv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K1uacwrv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389552FF64A
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482022; cv=none; b=WjtSnUOxGh1b77YIVBsVAmieck2RgKrOLS9Wm5XS2Yrl/5KnmIH0/3S5SuLu9faNT7+GMhG7h0b87PKPlkZkjBxmT6MOqqJAxCY5LHGEsykas0Cm3NAzvL54I6fAgXwigMWmAv9NUPKb+FrqqC06kiASV9Zgpv+Jm/d+IBNpHyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482022; c=relaxed/simple;
	bh=C+QW/u/NAY0UarQWfAxOqmSqThyBJMaFgs6/gPxwtjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oEiOSzzH6pEUywXJ3YhvU31ONxOEPtGnk4PuPuFq7zWBVaA/qb6aEviSggy0/vFkSqqfReC0lSG/g1bNX3kI7opkjkZ+IVe0XJPdxdzG2RkkxJcdE7MELbK4kU51ts0dffaNrZglWqozoRszXmME6peBpluV0dut8DJVrv7jxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K1uacwrv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K1uacwrv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 55A7B21256;
	Tue, 18 Nov 2025 16:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763482015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IiGodotAAbzPDutx6n9YNJx3w715YANeww1YsMKRJ5s=;
	b=K1uacwrvbZ0i/ASJ7jtXOlxVJzePnIKw8vAQswXH//jcesFnttvPKh1Zs4u1mxMFFDzBqG
	1iskKsVNu4X004hvlmCKnq30AWFlsn0wHzw+yqT1MVZ7f2hueYPVKnf4zG5nSRuBPEO8sC
	juRdn76UlAH6r00T2DbIrMJS9Wj+g5E=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763482015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IiGodotAAbzPDutx6n9YNJx3w715YANeww1YsMKRJ5s=;
	b=K1uacwrvbZ0i/ASJ7jtXOlxVJzePnIKw8vAQswXH//jcesFnttvPKh1Zs4u1mxMFFDzBqG
	1iskKsVNu4X004hvlmCKnq30AWFlsn0wHzw+yqT1MVZ7f2hueYPVKnf4zG5nSRuBPEO8sC
	juRdn76UlAH6r00T2DbIrMJS9Wj+g5E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DD693EA61;
	Tue, 18 Nov 2025 16:06:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q3L3Ep+ZHGnMXwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 18 Nov 2025 16:06:55 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: remaining BTRFS_PATH_AUTO_FREE conversions
Date: Tue, 18 Nov 2025 17:06:46 +0100
Message-ID: <20251118160646.575903-1-dsterba@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Do the remaining btrfs_path conversion to the auto cleaning, this seems
to be the last one. Most of the conversions are trivial, only adding the
declaration and removing the freeing, or changing the goto patterns to
return.

There are some functions with many changes, like __btrfs_free_extent(),
btrfs_remove_from_free_space_tree() or btrfs_add_to_free_space_tree()
but it still follows the same pattern.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c     |   3 +-
 fs/btrfs/dir-item.c        |   3 +-
 fs/btrfs/extent-tree.c     |  41 +++++------
 fs/btrfs/free-space-tree.c |  29 ++++----
 fs/btrfs/inode-item.c      |   3 +-
 fs/btrfs/inode.c           |   3 +-
 fs/btrfs/ioctl.c           |  37 ++++------
 fs/btrfs/qgroup.c          | 142 ++++++++++++++-----------------------
 fs/btrfs/super.c           |  10 +--
 fs/btrfs/tree-log.c        |   4 +-
 fs/btrfs/volumes.c         |   3 +-
 fs/btrfs/xattr.c           |   3 +-
 12 files changed, 105 insertions(+), 176 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b964eacc161024..2ee82edfd59f08 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1065,7 +1065,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			     struct btrfs_chunk_map *map)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_block_group *block_group;
 	struct btrfs_free_cluster *cluster;
 	struct inode *inode;
@@ -1305,7 +1305,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	btrfs_put_block_group(block_group);
 	if (remove_rsv)
 		btrfs_dec_delayed_refs_rsv_bg_updates(fs_info);
-	btrfs_free_path(path);
 	return ret;
 }
 
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 77e1bcb2a74bf1..085a83ae9e62f9 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -112,7 +112,7 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
 	int ret = 0;
 	int ret2 = 0;
 	struct btrfs_root *root = dir->root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_dir_item *dir_item;
 	struct extent_buffer *leaf;
 	unsigned long name_ptr;
@@ -164,7 +164,6 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
 	ret2 = btrfs_insert_delayed_dir_index(trans, name->name, name->len, dir,
 					      &disk_key, type, index);
 out_free:
-	btrfs_free_path(path);
 	if (ret)
 		return ret;
 	if (ret2)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 86004b8daa96e9..0b727ad2bd2f6f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3085,7 +3085,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_key key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root *extent_root;
 	struct extent_buffer *leaf;
 	struct btrfs_extent_item *ei;
@@ -3120,7 +3120,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			   node->bytenr, refs_to_drop);
 		ret = -EINVAL;
 		btrfs_abort_transaction(trans, ret);
-		goto out;
+		return ret;
 	}
 
 	if (is_data)
@@ -3165,15 +3165,14 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 				abort_and_dump(trans, path,
 "invalid iref slot %u, no EXTENT/METADATA_ITEM found but has inline extent ref",
 					   path->slots[0]);
-				ret = -EUCLEAN;
-				goto out;
+				return -EUCLEAN;
 			}
 			/* Must be SHARED_* item, remove the backref first */
 			ret = remove_extent_backref(trans, extent_root, path,
 						    NULL, refs_to_drop, is_data);
 			if (unlikely(ret)) {
 				btrfs_abort_transaction(trans, ret);
-				goto out;
+				return ret;
 			}
 			btrfs_release_path(path);
 
@@ -3222,7 +3221,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			}
 			if (unlikely(ret < 0)) {
 				btrfs_abort_transaction(trans, ret);
-				goto out;
+				return ret;
 			}
 			extent_slot = path->slots[0];
 		}
@@ -3231,10 +3230,10 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 "unable to find ref byte nr %llu parent %llu root %llu owner %llu offset %llu slot %d",
 			       bytenr, node->parent, node->ref_root, owner_objectid,
 			       owner_offset, path->slots[0]);
-		goto out;
+		return ret;
 	} else {
 		btrfs_abort_transaction(trans, ret);
-		goto out;
+		return ret;
 	}
 
 	leaf = path->nodes[0];
@@ -3245,7 +3244,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			  "unexpected extent item size, has %u expect >= %zu",
 			  item_size, sizeof(*ei));
 		btrfs_abort_transaction(trans, ret);
-		goto out;
+		return ret;
 	}
 	ei = btrfs_item_ptr(leaf, extent_slot,
 			    struct btrfs_extent_item);
@@ -3259,8 +3258,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 				       key.objectid, key.type, key.offset,
 				       path->slots[0], owner_objectid, item_size,
 				       sizeof(*ei) + sizeof(*bi));
-			ret = -EUCLEAN;
-			goto out;
+			return -EUCLEAN;
 		}
 		bi = (struct btrfs_tree_block_info *)(ei + 1);
 		WARN_ON(owner_objectid != btrfs_tree_block_level(leaf, bi));
@@ -3271,8 +3269,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		abort_and_dump(trans, path,
 		"trying to drop %d refs but we only have %llu for bytenr %llu slot %u",
 			       refs_to_drop, refs, bytenr, path->slots[0]);
-		ret = -EUCLEAN;
-		goto out;
+		return -EUCLEAN;
 	}
 	refs -= refs_to_drop;
 
@@ -3288,8 +3285,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 				abort_and_dump(trans, path,
 "invalid iref, got inlined extent ref but no EXTENT/METADATA_ITEM found, slot %u",
 					       path->slots[0]);
-				ret = -EUCLEAN;
-				goto out;
+				return -EUCLEAN;
 			}
 		} else {
 			btrfs_set_extent_refs(leaf, ei, refs);
@@ -3299,7 +3295,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 						    iref, refs_to_drop, is_data);
 			if (unlikely(ret)) {
 				btrfs_abort_transaction(trans, ret);
-				goto out;
+				return ret;
 			}
 		}
 	} else {
@@ -3319,8 +3315,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		"invalid refs_to_drop, current refs %u refs_to_drop %u slot %u",
 					       extent_data_ref_count(path, iref),
 					       refs_to_drop, path->slots[0]);
-				ret = -EUCLEAN;
-				goto out;
+				return -EUCLEAN;
 			}
 			if (iref) {
 				if (unlikely(path->slots[0] != extent_slot)) {
@@ -3328,8 +3323,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 "invalid iref, extent item key " BTRFS_KEY_FMT " slot %u doesn't have wanted iref",
 						       BTRFS_KEY_FMT_VALUE(&key),
 						       path->slots[0]);
-					ret = -EUCLEAN;
-					goto out;
+					return -EUCLEAN;
 				}
 			} else {
 				/*
@@ -3342,8 +3336,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 					abort_and_dump(trans, path,
 	"invalid SHARED_* item slot %u, previous item is not EXTENT/METADATA_ITEM",
 						       path->slots[0]);
-					ret = -EUCLEAN;
-					goto out;
+					return -EUCLEAN;
 				}
 				path->slots[0] = extent_slot;
 				num_to_del = 2;
@@ -3364,7 +3357,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 				      num_to_del);
 		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
-			goto out;
+			return ret;
 		}
 		btrfs_release_path(path);
 
@@ -3372,8 +3365,6 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	}
 	btrfs_release_path(path);
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 26eae347739fba..530c982280aa6f 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -833,7 +833,7 @@ int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 				      u64 start, u64 size)
 {
 	struct btrfs_block_group *block_group;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret;
 
 	if (!btrfs_fs_compat_ro(trans->fs_info, FREE_SPACE_TREE))
@@ -843,7 +843,7 @@ int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 	if (unlikely(!path)) {
 		ret = -ENOMEM;
 		btrfs_abort_transaction(trans, ret);
-		goto out;
+		return ret;
 	}
 
 	block_group = btrfs_lookup_block_group(trans->fs_info, start);
@@ -851,7 +851,7 @@ int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 		DEBUG_WARN("no block group found for start=%llu", start);
 		ret = -ENOENT;
 		btrfs_abort_transaction(trans, ret);
-		goto out;
+		return ret;
 	}
 
 	mutex_lock(&block_group->free_space_lock);
@@ -861,8 +861,7 @@ int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 
 	btrfs_put_block_group(block_group);
-out:
-	btrfs_free_path(path);
+
 	return ret;
 }
 
@@ -1015,7 +1014,7 @@ int btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
 				 u64 start, u64 size)
 {
 	struct btrfs_block_group *block_group;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret;
 
 	if (!btrfs_fs_compat_ro(trans->fs_info, FREE_SPACE_TREE))
@@ -1025,7 +1024,7 @@ int btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
 	if (unlikely(!path)) {
 		ret = -ENOMEM;
 		btrfs_abort_transaction(trans, ret);
-		goto out;
+		return ret;
 	}
 
 	block_group = btrfs_lookup_block_group(trans->fs_info, start);
@@ -1033,7 +1032,7 @@ int btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
 		DEBUG_WARN("no block group found for start=%llu", start);
 		ret = -ENOENT;
 		btrfs_abort_transaction(trans, ret);
-		goto out;
+		return ret;
 	}
 
 	mutex_lock(&block_group->free_space_lock);
@@ -1043,8 +1042,7 @@ int btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 
 	btrfs_put_block_group(block_group);
-out:
-	btrfs_free_path(path);
+
 	return ret;
 }
 
@@ -1458,7 +1456,7 @@ int btrfs_remove_block_group_free_space(struct btrfs_trans_handle *trans,
 					struct btrfs_block_group *block_group)
 {
 	struct btrfs_root *root = btrfs_free_space_root(block_group);
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key, found_key;
 	struct extent_buffer *leaf;
 	u64 start, end;
@@ -1477,7 +1475,7 @@ int btrfs_remove_block_group_free_space(struct btrfs_trans_handle *trans,
 	if (unlikely(!path)) {
 		ret = -ENOMEM;
 		btrfs_abort_transaction(trans, ret);
-		goto out;
+		return ret;
 	}
 
 	start = block_group->start;
@@ -1491,7 +1489,7 @@ int btrfs_remove_block_group_free_space(struct btrfs_trans_handle *trans,
 		ret = btrfs_search_prev_slot(trans, root, &key, path, -1, 1);
 		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
-			goto out;
+			return ret;
 		}
 
 		leaf = path->nodes[0];
@@ -1522,14 +1520,13 @@ int btrfs_remove_block_group_free_space(struct btrfs_trans_handle *trans,
 		ret = btrfs_del_items(trans, root, path, path->slots[0], nr);
 		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
-			goto out;
+			return ret;
 		}
 		btrfs_release_path(path);
 	}
 
 	ret = 0;
-out:
-	btrfs_free_path(path);
+
 	return ret;
 }
 
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 1bd73b80f9fac8..7e14e1bbcf389b 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -444,7 +444,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_truncate_control *control)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_key key;
@@ -730,6 +730,5 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	if (!ret && control->last_size > new_size)
 		control->last_size = new_size;
 
-	btrfs_free_path(path);
 	return ret;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1a0c380ef46426..1a4bf3ff45e243 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4458,7 +4458,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *root = dir->root;
 	struct btrfs_inode *inode = BTRFS_I(d_inode(dentry));
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
@@ -4551,7 +4551,6 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 out:
-	btrfs_free_path(path);
 	fscrypt_free_filename(&fname);
 	return ret;
 }
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 1920caf8d30823..ab239d92bb5cba 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1603,7 +1603,7 @@ static noinline int search_ioctl(struct btrfs_root *root,
 {
 	struct btrfs_fs_info *info = root->fs_info;
 	struct btrfs_key key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret;
 	int num_found = 0;
 	unsigned long sk_offset = 0;
@@ -1623,10 +1623,8 @@ static noinline int search_ioctl(struct btrfs_root *root,
 	} else {
 		/* Look up the root from the arguments. */
 		root = btrfs_get_fs_root(info, sk->tree_id, true);
-		if (IS_ERR(root)) {
-			btrfs_free_path(path);
+		if (IS_ERR(root))
 			return PTR_ERR(root);
-		}
 	}
 
 	key.objectid = sk->min_objectid;
@@ -1660,7 +1658,6 @@ static noinline int search_ioctl(struct btrfs_root *root,
 
 	sk->nr_items = num_found;
 	btrfs_put_root(root);
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -1743,7 +1740,7 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 	int total_len = 0;
 	struct btrfs_inode_ref *iref;
 	struct extent_buffer *l;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 
 	if (dirid == BTRFS_FIRST_FREE_OBJECTID) {
 		name[0]='\0';
@@ -1804,7 +1801,6 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 	ret = 0;
 out:
 	btrfs_put_root(root);
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -1821,7 +1817,7 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 	struct btrfs_inode_ref *iref;
 	struct btrfs_root_ref *rref;
 	struct btrfs_root *root = NULL;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key, key2;
 	struct extent_buffer *leaf;
 	char *ptr;
@@ -1842,10 +1838,8 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 		ptr = &args->path[BTRFS_INO_LOOKUP_USER_PATH_MAX - 1];
 
 		root = btrfs_get_fs_root(fs_info, treeid, true);
-		if (IS_ERR(root)) {
-			ret = PTR_ERR(root);
-			goto out;
-		}
+		if (IS_ERR(root))
+			return PTR_ERR(root);
 
 		key.objectid = dirid;
 		key.type = BTRFS_INODE_REF_KEY;
@@ -1939,12 +1933,10 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 	key.type = BTRFS_ROOT_REF_KEY;
 	key.offset = args->treeid;
 	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
-	if (ret < 0) {
-		goto out;
-	} else if (ret > 0) {
-		ret = -ENOENT;
-		goto out;
-	}
+	if (ret < 0)
+		return ret;
+	else if (ret > 0)
+		return -ENOENT;
 
 	leaf = path->nodes[0];
 	slot = path->slots[0];
@@ -1954,10 +1946,8 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 	item_len = btrfs_item_size(leaf, slot);
 	/* Check if dirid in ROOT_REF corresponds to passed dirid */
 	rref = btrfs_item_ptr(leaf, slot, struct btrfs_root_ref);
-	if (args->dirid != btrfs_root_ref_dirid(leaf, rref)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (args->dirid != btrfs_root_ref_dirid(leaf, rref))
+		return -EINVAL;
 
 	/* Copy subvolume's name */
 	item_off += sizeof(struct btrfs_root_ref);
@@ -1967,8 +1957,7 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 
 out_put:
 	btrfs_put_root(root);
-out:
-	btrfs_free_path(path);
+
 	return ret;
 }
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1956e4bf230220..3c82389109a1be 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -660,7 +660,7 @@ static int add_qgroup_relation_item(struct btrfs_trans_handle *trans, u64 src,
 {
 	int ret;
 	struct btrfs_root *quota_root = trans->fs_info->quota_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 
 	path = btrfs_alloc_path();
@@ -672,7 +672,6 @@ static int add_qgroup_relation_item(struct btrfs_trans_handle *trans, u64 src,
 	key.offset = dst;
 
 	ret = btrfs_insert_empty_item(trans, quota_root, path, &key, 0);
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -681,7 +680,7 @@ static int del_qgroup_relation_item(struct btrfs_trans_handle *trans, u64 src,
 {
 	int ret;
 	struct btrfs_root *quota_root = trans->fs_info->quota_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 
 	path = btrfs_alloc_path();
@@ -694,24 +693,19 @@ static int del_qgroup_relation_item(struct btrfs_trans_handle *trans, u64 src,
 
 	ret = btrfs_search_slot(trans, quota_root, &key, path, -1, 1);
 	if (ret < 0)
-		goto out;
+		return ret;
 
-	if (ret > 0) {
-		ret = -ENOENT;
-		goto out;
-	}
+	if (ret > 0)
+		return -ENOENT;
 
-	ret = btrfs_del_item(trans, quota_root, path);
-out:
-	btrfs_free_path(path);
-	return ret;
+	return btrfs_del_item(trans, quota_root, path);
 }
 
 static int add_qgroup_item(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *quota_root, u64 qgroupid)
 {
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_qgroup_info_item *qgroup_info;
 	struct btrfs_qgroup_limit_item *qgroup_limit;
 	struct extent_buffer *leaf;
@@ -737,7 +731,7 @@ static int add_qgroup_item(struct btrfs_trans_handle *trans,
 	ret = btrfs_insert_empty_item(trans, quota_root, path, &key,
 				      sizeof(*qgroup_info));
 	if (ret && ret != -EEXIST)
-		goto out;
+		return ret;
 
 	leaf = path->nodes[0];
 	qgroup_info = btrfs_item_ptr(leaf, path->slots[0],
@@ -754,7 +748,7 @@ static int add_qgroup_item(struct btrfs_trans_handle *trans,
 	ret = btrfs_insert_empty_item(trans, quota_root, path, &key,
 				      sizeof(*qgroup_limit));
 	if (ret && ret != -EEXIST)
-		goto out;
+		return ret;
 
 	leaf = path->nodes[0];
 	qgroup_limit = btrfs_item_ptr(leaf, path->slots[0],
@@ -765,17 +759,14 @@ static int add_qgroup_item(struct btrfs_trans_handle *trans,
 	btrfs_set_qgroup_limit_rsv_rfer(leaf, qgroup_limit, 0);
 	btrfs_set_qgroup_limit_rsv_excl(leaf, qgroup_limit, 0);
 
-	ret = 0;
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 static int del_qgroup_item(struct btrfs_trans_handle *trans, u64 qgroupid)
 {
 	int ret;
 	struct btrfs_root *quota_root = trans->fs_info->quota_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 
 	path = btrfs_alloc_path();
@@ -787,33 +778,27 @@ static int del_qgroup_item(struct btrfs_trans_handle *trans, u64 qgroupid)
 	key.offset = qgroupid;
 	ret = btrfs_search_slot(trans, quota_root, &key, path, -1, 1);
 	if (ret < 0)
-		goto out;
+		return ret;
 
-	if (ret > 0) {
-		ret = -ENOENT;
-		goto out;
-	}
+	if (ret > 0)
+		return -ENOENT;
 
 	ret = btrfs_del_item(trans, quota_root, path);
 	if (ret)
-		goto out;
+		return ret;
 
 	btrfs_release_path(path);
 
 	key.type = BTRFS_QGROUP_LIMIT_KEY;
 	ret = btrfs_search_slot(trans, quota_root, &key, path, -1, 1);
 	if (ret < 0)
-		goto out;
+		return ret;
 
-	if (ret > 0) {
-		ret = -ENOENT;
-		goto out;
-	}
+	if (ret > 0)
+		return -ENOENT;
 
 	ret = btrfs_del_item(trans, quota_root, path);
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -821,7 +806,7 @@ static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
 				    struct btrfs_qgroup *qgroup)
 {
 	struct btrfs_root *quota_root = trans->fs_info->quota_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct extent_buffer *l;
 	struct btrfs_qgroup_limit_item *qgroup_limit;
@@ -841,7 +826,7 @@ static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
 		ret = -ENOENT;
 
 	if (ret)
-		goto out;
+		return ret;
 
 	l = path->nodes[0];
 	slot = path->slots[0];
@@ -851,8 +836,7 @@ static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
 	btrfs_set_qgroup_limit_max_excl(l, qgroup_limit, qgroup->max_excl);
 	btrfs_set_qgroup_limit_rsv_rfer(l, qgroup_limit, qgroup->rsv_rfer);
 	btrfs_set_qgroup_limit_rsv_excl(l, qgroup_limit, qgroup->rsv_excl);
-out:
-	btrfs_free_path(path);
+
 	return ret;
 }
 
@@ -861,7 +845,7 @@ static int update_qgroup_info_item(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *quota_root = fs_info->quota_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct extent_buffer *l;
 	struct btrfs_qgroup_info_item *qgroup_info;
@@ -884,7 +868,7 @@ static int update_qgroup_info_item(struct btrfs_trans_handle *trans,
 		ret = -ENOENT;
 
 	if (ret)
-		goto out;
+		return ret;
 
 	l = path->nodes[0];
 	slot = path->slots[0];
@@ -894,8 +878,7 @@ static int update_qgroup_info_item(struct btrfs_trans_handle *trans,
 	btrfs_set_qgroup_info_rfer_cmpr(l, qgroup_info, qgroup->rfer_cmpr);
 	btrfs_set_qgroup_info_excl(l, qgroup_info, qgroup->excl);
 	btrfs_set_qgroup_info_excl_cmpr(l, qgroup_info, qgroup->excl_cmpr);
-out:
-	btrfs_free_path(path);
+
 	return ret;
 }
 
@@ -903,7 +886,7 @@ static int update_qgroup_status_item(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *quota_root = fs_info->quota_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct extent_buffer *l;
 	struct btrfs_qgroup_status_item *ptr;
@@ -923,7 +906,7 @@ static int update_qgroup_status_item(struct btrfs_trans_handle *trans)
 		ret = -ENOENT;
 
 	if (ret)
-		goto out;
+		return ret;
 
 	l = path->nodes[0];
 	slot = path->slots[0];
@@ -933,8 +916,7 @@ static int update_qgroup_status_item(struct btrfs_trans_handle *trans)
 	btrfs_set_qgroup_status_generation(l, ptr, trans->transid);
 	btrfs_set_qgroup_status_rescan(l, ptr,
 				fs_info->qgroup_rescan_progress.objectid);
-out:
-	btrfs_free_path(path);
+
 	return ret;
 }
 
@@ -944,7 +926,7 @@ static int update_qgroup_status_item(struct btrfs_trans_handle *trans)
 static int btrfs_clean_quota_tree(struct btrfs_trans_handle *trans,
 				  struct btrfs_root *root)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct extent_buffer *leaf = NULL;
 	int ret;
@@ -961,7 +943,7 @@ static int btrfs_clean_quota_tree(struct btrfs_trans_handle *trans,
 	while (1) {
 		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 		if (ret < 0)
-			goto out;
+			return ret;
 		leaf = path->nodes[0];
 		nr = btrfs_header_nritems(leaf);
 		if (!nr)
@@ -974,14 +956,12 @@ static int btrfs_clean_quota_tree(struct btrfs_trans_handle *trans,
 		path->slots[0] = 0;
 		ret = btrfs_del_items(trans, root, path, 0, nr);
 		if (ret)
-			goto out;
+			return ret;
 
 		btrfs_release_path(path);
 	}
-	ret = 0;
-out:
-	btrfs_free_path(path);
-	return ret;
+
+	return 0;
 }
 
 int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
@@ -1719,8 +1699,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 static int can_delete_qgroup(struct btrfs_fs_info *fs_info, struct btrfs_qgroup *qgroup)
 {
 	struct btrfs_key key;
-	struct btrfs_path *path;
-	int ret;
+	BTRFS_PATH_AUTO_FREE(path);
 
 	/*
 	 * Squota would never be inconsistent, but there can still be case
@@ -1753,13 +1732,11 @@ static int can_delete_qgroup(struct btrfs_fs_info *fs_info, struct btrfs_qgroup
 	if (!path)
 		return -ENOMEM;
 
-	ret = btrfs_find_root(fs_info->tree_root, &key, path, NULL, NULL);
-	btrfs_free_path(path);
 	/*
 	 * The @ret from btrfs_find_root() exactly matches our definition for
 	 * the return value, thus can be returned directly.
 	 */
-	return ret;
+	return btrfs_find_root(fs_info->tree_root, &key, path, NULL, NULL);
 }
 
 int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
@@ -2308,7 +2285,7 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 				    bool trace_leaf)
 {
 	struct btrfs_key key;
-	struct btrfs_path *src_path;
+	BTRFS_PATH_AUTO_FREE(src_path);
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	u32 nodesize = fs_info->nodesize;
 	int cur_level = root_level;
@@ -2320,10 +2297,8 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 		return -EINVAL;
 
 	src_path = btrfs_alloc_path();
-	if (!src_path) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!src_path)
+		return -ENOMEM;
 
 	if (dst_level)
 		btrfs_node_key_to_cpu(dst_path->nodes[dst_level], &key, 0);
@@ -2349,10 +2324,8 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 			parent_slot = src_path->slots[cur_level + 1];
 
 			eb = btrfs_read_node_slot(eb, parent_slot);
-			if (IS_ERR(eb)) {
-				ret = PTR_ERR(eb);
-				goto out;
-			}
+			if (IS_ERR(eb))
+				return PTR_ERR(eb);
 
 			src_path->nodes[cur_level] = eb;
 
@@ -2373,10 +2346,8 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 					&src_key, src_path->slots[cur_level]);
 		}
 		/* Content mismatch, something went wrong */
-		if (btrfs_comp_cpu_keys(&dst_key, &src_key)) {
-			ret = -ENOENT;
-			goto out;
-		}
+		if (btrfs_comp_cpu_keys(&dst_key, &src_key))
+			return -ENOENT;
 		cur_level--;
 	}
 
@@ -2387,21 +2358,20 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 	ret = btrfs_qgroup_trace_extent(trans, src_path->nodes[dst_level]->start,
 					nodesize);
 	if (ret < 0)
-		goto out;
+		return ret;
 	ret = btrfs_qgroup_trace_extent(trans, dst_path->nodes[dst_level]->start,
 					nodesize);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	/* Record leaf file extents */
 	if (dst_level == 0 && trace_leaf) {
 		ret = btrfs_qgroup_trace_leaf_items(trans, src_path->nodes[0]);
 		if (ret < 0)
-			goto out;
+			return ret;
 		ret = btrfs_qgroup_trace_leaf_items(trans, dst_path->nodes[0]);
 	}
-out:
-	btrfs_free_path(src_path);
+
 	return ret;
 }
 
@@ -2602,7 +2572,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	int level;
 	u8 drop_subptree_thres;
 	struct extent_buffer *eb = root_eb;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 
 	ASSERT(0 <= root_level && root_level < BTRFS_MAX_LEVEL);
 	ASSERT(root_eb != NULL);
@@ -2635,12 +2605,12 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 
 		ret = btrfs_read_extent_buffer(root_eb, &check);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	if (root_level == 0) {
 		ret = btrfs_qgroup_trace_leaf_items(trans, root_eb);
-		goto out;
+		return ret;
 	}
 
 	path = btrfs_alloc_path();
@@ -2676,10 +2646,8 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 			child_bytenr = btrfs_node_blockptr(eb, parent_slot);
 
 			eb = btrfs_read_node_slot(eb, parent_slot);
-			if (IS_ERR(eb)) {
-				ret = PTR_ERR(eb);
-				goto out;
-			}
+			if (IS_ERR(eb))
+				return PTR_ERR(eb);
 
 			path->nodes[level] = eb;
 			path->slots[level] = 0;
@@ -2690,14 +2658,14 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 			ret = btrfs_qgroup_trace_extent(trans, child_bytenr,
 							fs_info->nodesize);
 			if (ret)
-				goto out;
+				return ret;
 		}
 
 		if (level == 0) {
 			ret = btrfs_qgroup_trace_leaf_items(trans,
 							    path->nodes[level]);
 			if (ret)
-				goto out;
+				return ret;
 
 			/* Nonzero return here means we completed our search */
 			ret = adjust_slots_upwards(path, root_level);
@@ -2711,11 +2679,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 		level--;
 	}
 
-	ret = 0;
-out:
-	btrfs_free_path(path);
-
-	return ret;
+	return 0;
 }
 
 static void qgroup_iterator_nested_add(struct list_head *head, struct btrfs_qgroup *qgroup)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4ffd7059e27a65..4c1ace12233123 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -807,17 +807,15 @@ char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 	struct btrfs_root_ref *root_ref;
 	struct btrfs_inode_ref *inode_ref;
 	struct btrfs_key key;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	char *name = NULL, *ptr;
 	u64 dirid;
 	int len;
 	int ret;
 
 	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!path)
+		return ERR_PTR(-ENOMEM);
 
 	name = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!name) {
@@ -905,7 +903,6 @@ char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 		fs_root = NULL;
 	}
 
-	btrfs_free_path(path);
 	if (ptr == name + PATH_MAX - 1) {
 		name[0] = '/';
 		name[1] = '\0';
@@ -916,7 +913,6 @@ char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 
 err:
 	btrfs_put_root(fs_root);
-	btrfs_free_path(path);
 	kfree(name);
 	return ERR_PTR(ret);
 }
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e40e1d746381df..2c085d9005da5a 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2648,7 +2648,7 @@ static noinline int replay_dir_deletes(struct walk_control *wc,
 	int ret = 0;
 	struct btrfs_key dir_key;
 	struct btrfs_key found_key;
-	struct btrfs_path *log_path;
+	BTRFS_PATH_AUTO_FREE(log_path);
 	struct btrfs_inode *dir;
 
 	dir_key.objectid = dirid;
@@ -2665,7 +2665,6 @@ static noinline int replay_dir_deletes(struct walk_control *wc,
 	 * we replay the deletes before we copy in the inode item from the log.
 	 */
 	if (IS_ERR(dir)) {
-		btrfs_free_path(log_path);
 		ret = PTR_ERR(dir);
 		if (ret == -ENOENT)
 			ret = 0;
@@ -2745,7 +2744,6 @@ static noinline int replay_dir_deletes(struct walk_control *wc,
 	ret = 0;
 out:
 	btrfs_release_path(wc->subvol_path);
-	btrfs_free_path(log_path);
 	iput(&dir->vfs_inode);
 	return ret;
 }
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 75a34ed95c74cd..a9b2333891cc95 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4054,7 +4054,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 	struct btrfs_root *chunk_root = fs_info->chunk_root;
 	u64 chunk_type;
 	struct btrfs_chunk *chunk;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct extent_buffer *leaf;
@@ -4225,7 +4225,6 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 		goto again;
 	}
 error:
-	btrfs_free_path(path);
 	if (enospc_errors) {
 		btrfs_info(fs_info, "%d enospc errors during balance",
 			   enospc_errors);
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 3d27eb1e2f749b..b71c1ce3d3cb5c 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -73,7 +73,7 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 {
 	struct btrfs_dir_item *di = NULL;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	size_t name_len = strlen(name);
 	int ret = 0;
 
@@ -200,7 +200,6 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 		 */
 	}
 out:
-	btrfs_free_path(path);
 	if (!ret) {
 		set_bit(BTRFS_INODE_COPY_EVERYTHING,
 			&BTRFS_I(inode)->runtime_flags);
-- 
2.51.1


