Return-Path: <linux-btrfs+bounces-15602-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C1FB0C969
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 19:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DAC31C201BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102F42E3AE3;
	Mon, 21 Jul 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz3I3s2l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAF72E338F
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118210; cv=none; b=g/yyBV5WZQyRbrrwfh46RSjCvnmSdIZ/RXzVWLJ7ikAvin1LWRsWNXEyuKGrYApI68zHaryDeeEAC7dnZkH5Tk2Ox9DiSJDSX75P7IHEGvlqfx82awPg8Lx0sXFoHGY2ATSW0D7u1FQsUbNvE7X/6EnnLOwOo8WQdshg9zPioHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118210; c=relaxed/simple;
	bh=VK2frLE0GHqQbPj5dl46cPzD0jRV7bT8Kv51XcS4IRA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4Uu0ydok9/eVQRO05Ei/JydWSMEyP5vvRErnmwSeydNdSq4J4M2wrf461C8muVjBsSUrqTCBjaiFJkJL/cTCrPHdpTwQm2gtJhusgyQ33jRUOhUgxoAq7mq2EfTH/WM2/h9Yh+yabAhc+eGYEax70yPggR7fgivYBEhTYiiHy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz3I3s2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445B6C4CEF6
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753118209;
	bh=VK2frLE0GHqQbPj5dl46cPzD0jRV7bT8Kv51XcS4IRA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nz3I3s2lKtWKI7Uiwgcbg9fCUxZJSY6IftSpPC+IKlrUJK+d65oHIWffl5cK2E1Sh
	 6KRYbZfbCxY6R+zr0s/gYthEu5Jl/wfyuRu4SCFnhBhjGowr6Tf68oSNDmoT/3obkN
	 i33K7vBDCczNA2V5NvrQQ1X85W1wf5i9k/wyc5aXzjJ0kQ5yu5lDCobrwtMKJtxy3E
	 /AO+yvstCjY3OSirqTpfrOtFf3JYCmsxCGemP9MKYhftalTFYboJML2zflWW3/yzxK
	 fo9rXbNAqduX5Il3NaEPePzl1cgu0vPZ5WZMYKU/5dNUYlJV+ELf98mhXTAXqed2rL
	 HzvB8Qdusjl0A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/10] btrfs: abort transaction where errors happen during log tree replay
Date: Mon, 21 Jul 2025 18:16:33 +0100
Message-ID: <3e201248581ef3b0f86e3ae39b1ac418a76bddd3.1753117707.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1753117707.git.fdmanana@suse.com>
References: <cover.1753117707.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In the replay_one_buffer() log tree walk callback we return errors to the
log tree walk caller and then the caller aborts the transaction, if we
have one, or turns the fs into error state if we don't have one. While
this reduces code it makes it harder to figure out where exactly an error
came from. So add the transaction aborts after every failure inside the
replay_one_buffer() callback and the functions it calls, making it as
fine grained as possible, so that it helps figuring out why failures
happen.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 237 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 186 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 1c6210786a87..17af4ff51479 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -440,8 +440,10 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 
 	/* Look for the key in the destination tree. */
 	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
-	if (ret < 0)
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
 		return ret;
+	}
 
 	dst_eb = path->nodes[0];
 	dst_slot = path->slots[0];
@@ -460,6 +462,7 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 		src_copy = kmalloc(item_size, GFP_NOFS);
 		if (!src_copy) {
 			btrfs_release_path(path);
+			btrfs_abort_transaction(trans, -ENOMEM);
 			return -ENOMEM;
 		}
 
@@ -544,6 +547,7 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 		else if (found_size < item_size)
 			btrfs_extend_item(trans, path, item_size - found_size);
 	} else if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
 	dst_ptr = btrfs_item_ptr_offset(dst_eb, dst_slot);
@@ -674,6 +678,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 		extent_end = ALIGN(start + size,
 				   fs_info->sectorsize);
 	} else {
+		btrfs_abort_transaction(trans, -EUCLEAN);
 		btrfs_err(fs_info,
 		  "unexpected extent type=%d root=%llu inode=%llu offset=%llu",
 			  found_type, btrfs_root_id(root), key->objectid, key->offset);
@@ -681,8 +686,11 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	}
 
 	inode = btrfs_iget_logging(key->objectid, root);
-	if (IS_ERR(inode))
-		return PTR_ERR(inode);
+	if (IS_ERR(inode)) {
+		ret = PTR_ERR(inode);
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
 
 	/*
 	 * first check to see if we already have this extent in the
@@ -717,8 +725,10 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	drop_args.end = extent_end;
 	drop_args.drop_cache = true;
 	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		goto out;
+	}
 
 	if (found_type == BTRFS_FILE_EXTENT_REG ||
 	    found_type == BTRFS_FILE_EXTENT_PREALLOC) {
@@ -732,8 +742,10 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 
 		ret = btrfs_insert_empty_item(trans, root, path, key,
 					      sizeof(*item));
-		if (ret)
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
 			goto out;
+		}
 		dest_offset = btrfs_item_ptr_offset(path->nodes[0],
 						    path->slots[0]);
 		copy_extent_buffer(path->nodes[0], eb, dest_offset,
@@ -755,8 +767,10 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 		ret = btrfs_qgroup_trace_extent(trans,
 				btrfs_file_extent_disk_bytenr(eb, item),
 				btrfs_file_extent_disk_num_bytes(eb, item));
-		if (ret < 0)
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
 			goto out;
+		}
 
 		if (ins.objectid > 0) {
 			u64 csum_start;
@@ -770,6 +784,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 			ret = btrfs_lookup_data_extent(fs_info, ins.objectid,
 						ins.offset);
 			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
 				goto out;
 			} else if (ret == 0) {
 				struct btrfs_ref ref = {
@@ -782,8 +797,10 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 				btrfs_init_data_ref(&ref, key->objectid, offset,
 						    0, false);
 				ret = btrfs_inc_extent_ref(trans, &ref);
-				if (ret)
+				if (ret) {
+					btrfs_abort_transaction(trans, ret);
 					goto out;
+				}
 			} else {
 				/*
 				 * insert the extent pointer in the extent
@@ -792,8 +809,10 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 				ret = btrfs_alloc_logged_file_extent(trans,
 						btrfs_root_id(root),
 						key->objectid, offset, &ins);
-				if (ret)
+				if (ret) {
+					btrfs_abort_transaction(trans, ret);
 					goto out;
+				}
 			}
 			btrfs_release_path(path);
 
@@ -810,8 +829,10 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 			ret = btrfs_lookup_csums_list(root->log_root,
 						csum_start, csum_end - 1,
 						&ordered_sums, false);
-			if (ret < 0)
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
 				goto out;
+			}
 			ret = 0;
 			/*
 			 * Now delete all existing cums in the csum root that
@@ -871,14 +892,20 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 							list);
 				csum_root = btrfs_csum_root(fs_info,
 							    sums->logical);
-				if (!ret)
+				if (!ret) {
 					ret = btrfs_del_csums(trans, csum_root,
 							      sums->logical,
 							      sums->len);
-				if (!ret)
+					if (ret)
+						btrfs_abort_transaction(trans, ret);
+				}
+				if (!ret) {
 					ret = btrfs_csum_file_blocks(trans,
 								     csum_root,
 								     sums);
+					if (ret)
+						btrfs_abort_transaction(trans, ret);
+				}
 				list_del(&sums->list);
 				kfree(sums);
 			}
@@ -895,12 +922,16 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	}
 
 	ret = btrfs_inode_set_file_extent_range(inode, start, extent_end - start);
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		goto out;
+	}
 
 update_inode:
 	btrfs_update_inode_bytes(inode, nbytes, drop_args.bytes_found);
 	ret = btrfs_update_inode(trans, inode);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
 out:
 	iput(&inode->vfs_inode);
 	return ret;
@@ -914,15 +945,20 @@ static int unlink_inode_for_log_replay(struct btrfs_trans_handle *trans,
 	int ret;
 
 	ret = btrfs_unlink_inode(trans, dir, inode, name);
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		return ret;
+	}
 	/*
 	 * Whenever we need to check if a name exists or not, we check the
 	 * fs/subvolume tree. So after an unlink we must run delayed items, so
 	 * that future checks for a name during log replay see that the name
 	 * does not exists anymore.
 	 */
-	return btrfs_run_delayed_items(trans);
+	ret = btrfs_run_delayed_items(trans);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
+	return ret;
 }
 
 /*
@@ -949,14 +985,17 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 
 	btrfs_dir_item_key_to_cpu(leaf, di, &location);
 	ret = read_alloc_one_name(leaf, di + 1, btrfs_dir_name_len(leaf, di), &name);
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		return ret;
+	}
 
 	btrfs_release_path(path);
 
 	inode = btrfs_iget_logging(location.objectid, root);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
+		btrfs_abort_transaction(trans, ret);
 		inode = NULL;
 		goto out;
 	}
@@ -1087,14 +1126,18 @@ static int unlink_refs_not_in_log(struct btrfs_trans_handle *trans,
 		ret = read_alloc_one_name(leaf, (victim_ref + 1),
 					  btrfs_inode_ref_name_len(leaf, victim_ref),
 					  &victim_name);
-		if (ret)
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
 			return ret;
+		}
 
 		ret = backref_in_log(log_root, search_key, parent_objectid, &victim_name);
 		if (ret) {
 			kfree(victim_name.name);
-			if (ret < 0)
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
 				return ret;
+			}
 			ptr = (unsigned long)(victim_ref + 1) + victim_name.len;
 			continue;
 		}
@@ -1140,8 +1183,10 @@ static int unlink_extrefs_not_in_log(struct btrfs_trans_handle *trans,
 
 		ret = read_alloc_one_name(leaf, &extref->name, victim_name.len,
 					  &victim_name);
-		if (ret)
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
 			return ret;
+		}
 
 		search_key->objectid = inode_objectid;
 		search_key->type = BTRFS_INODE_EXTREF_KEY;
@@ -1151,8 +1196,10 @@ static int unlink_extrefs_not_in_log(struct btrfs_trans_handle *trans,
 		ret = backref_in_log(log_root, search_key, parent_objectid, &victim_name);
 		if (ret) {
 			kfree(victim_name.name);
-			if (ret < 0)
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
 				return ret;
+			}
 next:
 			cur_offset += victim_name.len + sizeof(*extref);
 			continue;
@@ -1161,7 +1208,9 @@ static int unlink_extrefs_not_in_log(struct btrfs_trans_handle *trans,
 		victim_parent = btrfs_iget_logging(parent_objectid, root);
 		if (IS_ERR(victim_parent)) {
 			kfree(victim_name.name);
-			return PTR_ERR(victim_parent);
+			ret = PTR_ERR(victim_parent);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
 		}
 
 		inc_nlink(&inode->vfs_inode);
@@ -1200,6 +1249,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	search_key.offset = parent_objectid;
 	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
 	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
 		return ret;
 	} else if (ret == 0) {
 		/*
@@ -1237,7 +1287,9 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	di = btrfs_lookup_dir_index_item(trans, root, path, btrfs_ino(dir),
 					 ref_index, name, 0);
 	if (IS_ERR(di)) {
-		return PTR_ERR(di);
+		ret = PTR_ERR(di);
+		btrfs_abort_transaction(trans, ret);
+		return ret;
 	} else if (di) {
 		ret = drop_one_dir_item(trans, path, dir, di);
 		if (ret)
@@ -1327,8 +1379,10 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 		ret = 0;
 		goto out;
 	}
-	if (ret < 0)
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
 		goto out;
+	}
 
 	eb = path->nodes[0];
 	ref_ptr = btrfs_item_ptr_offset(eb, path->slots[0]);
@@ -1340,12 +1394,18 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 		if (key->type == BTRFS_INODE_EXTREF_KEY) {
 			ret = extref_get_fields(eb, ref_ptr, &name,
 						NULL, &parent_id);
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				goto out;
+			}
 		} else {
 			parent_id = key->offset;
 			ret = ref_get_fields(eb, ref_ptr, &name, NULL);
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				goto out;
+			}
 		}
-		if (ret)
-			goto out;
 
 		if (key->type == BTRFS_INODE_EXTREF_KEY)
 			ret = !!btrfs_find_name_in_ext_backref(log_eb, log_slot,
@@ -1361,6 +1421,7 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 			if (IS_ERR(dir)) {
 				ret = PTR_ERR(dir);
 				kfree(name.name);
+				btrfs_abort_transaction(trans, ret);
 				goto out;
 			}
 			ret = unlink_inode_for_log_replay(trans, dir, inode, &name);
@@ -1435,6 +1496,8 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		ret = PTR_ERR(dir);
 		if (ret == -ENOENT)
 			ret = 0;
+		else
+			btrfs_abort_transaction(trans, ret);
 		dir = NULL;
 		goto out;
 	}
@@ -1442,6 +1505,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	inode = btrfs_iget_logging(inode_objectid, root);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
+		btrfs_abort_transaction(trans, ret);
 		inode = NULL;
 		goto out;
 	}
@@ -1450,8 +1514,10 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		if (is_extref_item) {
 			ret = extref_get_fields(eb, ref_ptr, &name,
 						&ref_index, &parent_objectid);
-			if (ret)
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
 				goto out;
+			}
 			/*
 			 * parent object can change from one array
 			 * item to another.
@@ -1476,19 +1542,24 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 						 */
 						ret = 0;
 						goto next;
+					} else {
+						btrfs_abort_transaction(trans, ret);
 					}
 					goto out;
 				}
 			}
 		} else {
 			ret = ref_get_fields(eb, ref_ptr, &name, &ref_index);
-			if (ret)
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
 				goto out;
+			}
 		}
 
 		ret = inode_in_dir(root, path, btrfs_ino(dir), btrfs_ino(inode),
 				   ref_index, &name);
 		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
 			goto out;
 		} else if (ret == 0) {
 			/*
@@ -1509,12 +1580,16 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 
 			/* insert our name */
 			ret = btrfs_add_link(trans, dir, inode, &name, 0, ref_index);
-			if (ret)
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
 				goto out;
+			}
 
 			ret = btrfs_update_inode(trans, inode);
-			if (ret)
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
 				goto out;
+			}
 		}
 		/* Else, ret == 1, we already have a perfect match, we're done. */
 
@@ -1786,8 +1861,11 @@ static noinline int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 	struct inode *vfs_inode;
 
 	inode = btrfs_iget_logging(objectid, root);
-	if (IS_ERR(inode))
-		return PTR_ERR(inode);
+	if (IS_ERR(inode)) {
+		ret = PTR_ERR(inode);
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
 
 	vfs_inode = &inode->vfs_inode;
 	key.objectid = BTRFS_TREE_LOG_FIXUP_OBJECTID;
@@ -1805,6 +1883,8 @@ static noinline int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 		ret = btrfs_update_inode(trans, inode);
 	} else if (ret == -EEXIST) {
 		ret = 0;
+	} else {
+		btrfs_abort_transaction(trans, ret);
 	}
 	iput(vfs_inode);
 
@@ -1911,19 +1991,26 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	bool name_added = false;
 
 	dir = btrfs_iget_logging(key->objectid, root);
-	if (IS_ERR(dir))
-		return PTR_ERR(dir);
+	if (IS_ERR(dir)) {
+		ret = PTR_ERR(dir);
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
 
 	ret = read_alloc_one_name(eb, di + 1, btrfs_dir_name_len(eb, di), &name);
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		goto out;
+	}
 
 	log_flags = btrfs_dir_flags(eb, di);
 	btrfs_dir_item_key_to_cpu(eb, di, &log_key);
 	ret = btrfs_lookup_inode(trans, root, path, &log_key, 0);
 	btrfs_release_path(path);
-	if (ret < 0)
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
 		goto out;
+	}
 	exists = (ret == 0);
 	ret = 0;
 
@@ -1931,12 +2018,15 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 					   &name, 1);
 	if (IS_ERR(dir_dst_di)) {
 		ret = PTR_ERR(dir_dst_di);
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	} else if (dir_dst_di) {
 		ret = delete_conflicting_dir_entry(trans, dir, path, dir_dst_di,
 						   &log_key, log_flags, exists);
-		if (ret < 0)
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
 			goto out;
+		}
 		dir_dst_matches = (ret == 1);
 	}
 
@@ -1947,12 +2037,15 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 						   &name, 1);
 	if (IS_ERR(index_dst_di)) {
 		ret = PTR_ERR(index_dst_di);
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	} else if (index_dst_di) {
 		ret = delete_conflicting_dir_entry(trans, dir, path, index_dst_di,
 						   &log_key, log_flags, exists);
-		if (ret < 0)
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
 			goto out;
+		}
 		index_dst_matches = (ret == 1);
 	}
 
@@ -1973,6 +2066,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	search_key.offset = key->objectid;
 	ret = backref_in_log(root->log_root, &search_key, 0, &name);
 	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
 	        goto out;
 	} else if (ret) {
 	        /* The dentry will be added later. */
@@ -1986,6 +2080,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	search_key.offset = key->objectid;
 	ret = backref_in_log(root->log_root, &search_key, key->objectid, &name);
 	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	} else if (ret) {
 		/* The dentry will be added later. */
@@ -1996,8 +2091,10 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 	ret = insert_one_name(trans, root, key->objectid, key->offset,
 			      &name, &log_key);
-	if (ret && ret != -ENOENT && ret != -EEXIST)
+	if (ret && ret != -ENOENT && ret != -EEXIST) {
+		btrfs_abort_transaction(trans, ret);
 		goto out;
+	}
 	if (!ret)
 		name_added = true;
 	update_size = false;
@@ -2007,6 +2104,8 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	if (!ret && update_size) {
 		btrfs_i_size_write(dir, dir->vfs_inode.i_size + name.len * 2);
 		ret = btrfs_update_inode(trans, dir);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
 	}
 	kfree(name.name);
 	iput(&dir->vfs_inode);
@@ -2064,8 +2163,10 @@ static noinline int replay_one_dir_item(struct btrfs_trans_handle *trans,
 		struct btrfs_key di_key;
 
 		fixup_path = btrfs_alloc_path();
-		if (!fixup_path)
+		if (!fixup_path) {
+			btrfs_abort_transaction(trans, -ENOMEM);
 			return -ENOMEM;
+		}
 
 		btrfs_dir_item_key_to_cpu(eb, di, &di_key);
 		ret = link_to_fixup_dir(trans, root, fixup_path, di_key.objectid);
@@ -2190,8 +2291,10 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 	slot = path->slots[0];
 	di = btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
 	ret = read_alloc_one_name(eb, di + 1, btrfs_dir_name_len(eb, di), &name);
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		goto out;
+	}
 
 	if (log) {
 		struct btrfs_dir_item *log_di;
@@ -2201,6 +2304,7 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 						     dir_key->offset, &name, 0);
 		if (IS_ERR(log_di)) {
 			ret = PTR_ERR(log_di);
+			btrfs_abort_transaction(trans, ret);
 			goto out;
 		} else if (log_di) {
 			/* The dentry exists in the log, we have nothing to do. */
@@ -2216,6 +2320,7 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		inode = NULL;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
@@ -2252,16 +2357,20 @@ static int replay_xattr_deletes(struct btrfs_trans_handle *trans,
 	int ret;
 
 	log_path = btrfs_alloc_path();
-	if (!log_path)
+	if (!log_path) {
+		btrfs_abort_transaction(trans, -ENOMEM);
 		return -ENOMEM;
+	}
 
 	search_key.objectid = ino;
 	search_key.type = BTRFS_XATTR_ITEM_KEY;
 	search_key.offset = 0;
 again:
 	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
-	if (ret < 0)
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
 		goto out;
+	}
 process_leaf:
 	nritems = btrfs_header_nritems(path->nodes[0]);
 	for (i = path->slots[0]; i < nritems; i++) {
@@ -2289,6 +2398,7 @@ static int replay_xattr_deletes(struct btrfs_trans_handle *trans,
 			name = kmalloc(name_len, GFP_NOFS);
 			if (!name) {
 				ret = -ENOMEM;
+				btrfs_abort_transaction(trans, ret);
 				goto out;
 			}
 			read_extent_buffer(path->nodes[0], name,
@@ -2305,13 +2415,16 @@ static int replay_xattr_deletes(struct btrfs_trans_handle *trans,
 				kfree(name);
 				if (IS_ERR(di)) {
 					ret = PTR_ERR(di);
+					btrfs_abort_transaction(trans, ret);
 					goto out;
 				}
 				ASSERT(di);
 				ret = btrfs_delete_one_dir_name(trans, root,
 								path, di);
-				if (ret)
+				if (ret) {
+					btrfs_abort_transaction(trans, ret);
 					goto out;
+				}
 				btrfs_release_path(path);
 				search_key = key;
 				goto again;
@@ -2319,6 +2432,7 @@ static int replay_xattr_deletes(struct btrfs_trans_handle *trans,
 			kfree(name);
 			if (IS_ERR(log_di)) {
 				ret = PTR_ERR(log_di);
+				btrfs_abort_transaction(trans, ret);
 				goto out;
 			}
 			cur += this_len;
@@ -2330,6 +2444,8 @@ static int replay_xattr_deletes(struct btrfs_trans_handle *trans,
 		ret = 0;
 	else if (ret == 0)
 		goto process_leaf;
+	else
+		btrfs_abort_transaction(trans, ret);
 out:
 	btrfs_free_path(log_path);
 	btrfs_release_path(path);
@@ -2364,8 +2480,10 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 	dir_key.objectid = dirid;
 	dir_key.type = BTRFS_DIR_INDEX_KEY;
 	log_path = btrfs_alloc_path();
-	if (!log_path)
+	if (!log_path) {
+		btrfs_abort_transaction(trans, -ENOMEM);
 		return -ENOMEM;
+	}
 
 	dir = btrfs_iget_logging(dirid, root);
 	/*
@@ -2377,6 +2495,8 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 		ret = PTR_ERR(dir);
 		if (ret == -ENOENT)
 			ret = 0;
+		else
+			btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
 
@@ -2388,10 +2508,12 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 		else {
 			ret = find_dir_range(log, path, dirid,
 					     &range_start, &range_end);
-			if (ret < 0)
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
 				goto out;
-			else if (ret > 0)
+			} else if (ret > 0) {
 				break;
+			}
 		}
 
 		dir_key.offset = range_start;
@@ -2399,16 +2521,20 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 			int nritems;
 			ret = btrfs_search_slot(NULL, root, &dir_key, path,
 						0, 0);
-			if (ret < 0)
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
 				goto out;
+			}
 
 			nritems = btrfs_header_nritems(path->nodes[0]);
 			if (path->slots[0] >= nritems) {
 				ret = btrfs_next_leaf(root, path);
-				if (ret == 1)
+				if (ret == 1) {
 					break;
-				else if (ret < 0)
+				} else if (ret < 0) {
+					btrfs_abort_transaction(trans, ret);
 					goto out;
+				}
 			}
 			btrfs_item_key_to_cpu(path->nodes[0], &found_key,
 					      path->slots[0]);
@@ -2470,8 +2596,10 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 	int ret;
 
 	ret = btrfs_read_extent_buffer(eb, &check);
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		return ret;
+	}
 
 	level = btrfs_header_level(eb);
 
@@ -2479,8 +2607,10 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 		return 0;
 
 	path = btrfs_alloc_path();
-	if (!path)
+	if (!path) {
+		btrfs_abort_transaction(trans, -ENOMEM);
 		return -ENOMEM;
+	}
 
 	nritems = btrfs_header_nritems(eb);
 	for (i = 0; i < nritems; i++) {
@@ -2538,6 +2668,7 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 				inode = btrfs_iget_logging(key.objectid, root);
 				if (IS_ERR(inode)) {
 					ret = PTR_ERR(inode);
+					btrfs_abort_transaction(trans, ret);
 					break;
 				}
 				from = ALIGN(i_size_read(&inode->vfs_inode),
@@ -2546,11 +2677,15 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 				drop_args.end = (u64)-1;
 				drop_args.drop_cache = true;
 				ret = btrfs_drop_extents(trans, root, inode,  &drop_args);
-				if (!ret) {
+				if (ret) {
+					btrfs_abort_transaction(trans, ret);
+				} else {
 					inode_sub_bytes(&inode->vfs_inode,
 							drop_args.bytes_found);
 					/* Update the inode's nbytes. */
 					ret = btrfs_update_inode(trans, inode);
+					if (ret)
+						btrfs_abort_transaction(trans, ret);
 				}
 				iput(&inode->vfs_inode);
 				if (ret)
-- 
2.47.2


