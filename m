Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8FA24027C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 09:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgHJH14 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 03:27:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:39518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgHJH1z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 03:27:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08CE5AC3F
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 07:28:14 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs-progs: check/lowmem: add the ability to repair extent item generation
Date:   Mon, 10 Aug 2020 15:27:44 +0800
Message-Id: <20200810072747.64439-2-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810072747.64439-1-wqu@suse.com>
References: <20200810072747.64439-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is an internal report about bad extent item generation triggering
tree-checker.

This patch will add the repair ability to btrfs check --mode=lowmem
mode, by resetting the generation field of extent item.

Currently the correct generation for tree block is fetched from its
header, while for data extent it uses transid as fallback.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-common.c | 59 ++++++++++++++++++++++++++++++
 check/mode-common.h |  3 ++
 check/mode-lowmem.c | 89 +++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 144 insertions(+), 7 deletions(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index aa45c5c2b8a3..a024f17126d0 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -1195,3 +1195,62 @@ int recow_extent_buffer(struct btrfs_root *root, struct extent_buffer *eb)
 	btrfs_release_path(&path);
 	return ret;
 }
+
+/*
+ * Try to get a correct extent item geneartion.
+ * Return 0 if we get a correct generation.
+ * Return <0 if we failed to get one.
+ */
+int get_extent_item_generation(struct btrfs_fs_info *fs_info,
+				u64 bytenr, u64 *gen_ret)
+{
+	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_extent_item *ei;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	int ret;
+
+	key.objectid = bytenr;
+	key.type = BTRFS_METADATA_ITEM_KEY;
+	key.offset = (u64)-1;
+
+	btrfs_init_path(&path);
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	/* Not possible */
+	if (ret == 0)
+		ret = -EUCLEAN;
+	if (ret < 0)
+		goto out;
+	ret = btrfs_previous_extent_item(root, &path, bytenr);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		goto out;
+
+	ei = btrfs_item_ptr(path.nodes[0], path.slots[0],
+			    struct btrfs_extent_item);
+
+	if (btrfs_extent_flags(path.nodes[0], ei) &
+	    BTRFS_EXTENT_FLAG_TREE_BLOCK) {
+		struct extent_buffer *eb;
+
+		eb = read_tree_block(fs_info, bytenr, 0);
+		if (extent_buffer_uptodate(eb)) {
+			*gen_ret = btrfs_header_generation(eb);
+			ret = 0;
+		} else {
+			ret = -EIO;
+		}
+		free_extent_buffer(eb);
+	} else {
+		/*
+		 * TODO: Grab proper data generation for data extents.
+		 * But this is not an urgent objective, as we can still
+		 * use transaction id as fall back
+		 */
+		ret = -ENOTSUP;
+	}
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
diff --git a/check/mode-common.h b/check/mode-common.h
index edf9257edaf0..3292ec744490 100644
--- a/check/mode-common.h
+++ b/check/mode-common.h
@@ -173,4 +173,7 @@ static inline u32 btrfs_type_to_imode(u8 type)
 
 	return imode_by_btrfs_type[(type)];
 }
+
+int get_extent_item_generation(struct btrfs_fs_info *fs_info,
+				u64 bytenr, u64 *gen_ret);
 #endif
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 747a21b21b85..b0c638b07ffc 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4146,6 +4146,66 @@ out:
 	return ret;
 }
 
+/*
+ * Reset generation for extent item specified by @path.
+ * Will try to grab the proper generation number from other sources, but if
+ * failed to grab, then use current transid as fallback.
+ *
+ * Returns < 0 for error.
+ * Return 0 if the generation is reset.
+ */
+static int repair_extent_item_generation(struct btrfs_fs_info *fs_info,
+		struct btrfs_path *path)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_key key;
+	struct btrfs_extent_item *ei;
+	struct btrfs_root *extent_root = fs_info->extent_root;
+	u64 new_gen = 0;;
+	int ret;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	ASSERT(key.type == BTRFS_METADATA_ITEM_KEY ||
+	       key.type == BTRFS_EXTENT_ITEM_KEY);
+
+	get_extent_item_generation(fs_info, key.objectid, &new_gen);
+	ret = avoid_extents_overwrite(fs_info);
+	if (ret)
+		return ret;
+	btrfs_release_path(path);
+	trans = btrfs_start_transaction(extent_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction: %m");
+		return ret;
+	}
+	ret = btrfs_search_slot(trans, extent_root, &key, path, 0, 1);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to locate extent item for %llu: %m", key.objectid);
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+	if (!new_gen)
+		new_gen = trans->transid;
+	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_extent_item);
+	btrfs_set_extent_generation(path->nodes[0], ei, new_gen);
+	ret = btrfs_commit_transaction(trans, extent_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to commit transaction: %m");
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+	printf("Reset extent item (%llu) generation to %llu\n",
+		key.objectid, new_gen);
+	return ret;
+}
+
 /*
  * This function will check a given extent item, including its backref and
  * itself (like crossing stripe boundary and type)
@@ -4178,7 +4238,7 @@ static int check_extent_item(struct btrfs_fs_info *fs_info,
 	struct btrfs_key key;
 	int ret;
 	int err = 0;
-	int tmp_err;
+	int tmp_err = 0;
 	u32 ptr_offset;
 
 	btrfs_item_key_to_cpu(eb, &key, slot);
@@ -4208,7 +4268,7 @@ static int check_extent_item(struct btrfs_fs_info *fs_info,
 		error(
 		"invalid generation for extent %llu, have %llu expect (0, %llu]",
 			key.objectid, gen, super_gen + 1);
-		err |= INVALID_GENERATION;
+		tmp_err |= INVALID_GENERATION;
 	}
 
 	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)
@@ -4261,12 +4321,12 @@ next:
 	case BTRFS_TREE_BLOCK_REF_KEY:
 		root_objectid = offset;
 		owner = level;
-		tmp_err = check_tree_block_backref(fs_info, offset,
+		tmp_err |= check_tree_block_backref(fs_info, offset,
 						   key.objectid, level);
 		break;
 	case BTRFS_SHARED_BLOCK_REF_KEY:
 		parent = offset;
-		tmp_err = check_shared_block_backref(fs_info, offset,
+		tmp_err |= check_shared_block_backref(fs_info, offset,
 						     key.objectid, level);
 		break;
 	case BTRFS_EXTENT_DATA_REF_KEY:
@@ -4274,13 +4334,13 @@ next:
 		root_objectid = btrfs_extent_data_ref_root(eb, dref);
 		owner = btrfs_extent_data_ref_objectid(eb, dref);
 		owner_offset = btrfs_extent_data_ref_offset(eb, dref);
-		tmp_err = check_extent_data_backref(fs_info, root_objectid,
+		tmp_err |= check_extent_data_backref(fs_info, root_objectid,
 			    owner, owner_offset, key.objectid, key.offset,
 			    btrfs_extent_data_ref_count(eb, dref));
 		break;
 	case BTRFS_SHARED_DATA_REF_KEY:
 		parent = offset;
-		tmp_err = check_shared_data_backref(fs_info, offset,
+		tmp_err |= check_shared_data_backref(fs_info, offset,
 						    key.objectid);
 		break;
 	default:
@@ -4318,8 +4378,23 @@ next:
 			item_size = btrfs_item_size_nr(eb, slot);
 			goto next;
 		}
-	} else {
+	}
+	if ((tmp_err & (INVALID_GENERATION) && repair)){
+		ret = repair_extent_item_generation(fs_info, path);
+		if (ret < 0) {
+			err |= tmp_err;
+			err |= FATAL_ERROR;
+			goto out;
+		}
+		/* Error has been repaired */
+		tmp_err &= ~INVALID_GENERATION;
 		err |= tmp_err;
+		eb = path->nodes[0];
+		slot = path->slots[0];
+		ei = btrfs_item_ptr(eb, slot, struct btrfs_extent_item);
+		item_size = btrfs_item_size_nr(eb, slot);
+		ptr_offset += btrfs_extent_inline_ref_size(type);
+		goto next;
 	}
 
 	ptr_offset += btrfs_extent_inline_ref_size(type);
-- 
2.28.0

