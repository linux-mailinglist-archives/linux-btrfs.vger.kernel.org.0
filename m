Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C10428A97
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 12:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbhJKKM1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 06:12:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58988 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbhJKKMW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 06:12:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8762622074;
        Mon, 11 Oct 2021 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633947021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSQaf0extcEXWaQbASDfN4w85I2vzx/Fuj3yJpXwksU=;
        b=rB/pGn5cZb/yAHTKwuSH+8oQnr+nuZjfsKL0q60hJ5cEtUKQsou9Pg99cqOHXGH3rPaPw5
        Hx3lrkZG91vzzBdCjFIhiF7QRsHAMobQq56+4d2yU87eZ9yJrnTC4NaIbEwAYdeganYDHK
        akVzw/p8ShUY1UblqiFS6qK0hqLuqzw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5723D13C4C;
        Mon, 11 Oct 2021 10:10:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sHXCEo0NZGGJLwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 11 Oct 2021 10:10:21 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/5] btrfs: Add additional parameters to btrfs_init_tree_ref/btrfs_init_data_ref
Date:   Mon, 11 Oct 2021 13:10:17 +0300
Message-Id: <20211011101019.1409855-4-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011101019.1409855-1-nborisov@suse.com>
References: <20211011101019.1409855-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In order to make 'real_root' used only in ref-verify it's required to
have the necessary context to perform the same checks that this member
is used for. So add 'mod_root' which will contain the root on behalf of
which a delayed ref was created and a 'skip_group' parameter which
will contain callsite-specific override of skip_qgroup.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delayed-ref.h |  5 +++--
 fs/btrfs/extent-tree.c | 17 +++++++++++------
 fs/btrfs/file.c        | 13 ++++++++-----
 fs/btrfs/inode.c       |  3 ++-
 fs/btrfs/relocation.c  | 21 ++++++++++++++-------
 fs/btrfs/tree-log.c    |  2 +-
 6 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 8826f3e2b809..8ab79def8e98 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -271,7 +271,7 @@ static inline void btrfs_init_generic_ref(struct btrfs_ref *generic_ref,
 }
 
 static inline void btrfs_init_tree_ref(struct btrfs_ref *generic_ref,
-				int level, u64 root)
+				int level, u64 root, u64 mod_root, bool skip_qgroup)
 {
 	/* If @real_root not set, use @root as fallback */
 	if (!generic_ref->real_root)
@@ -282,7 +282,8 @@ static inline void btrfs_init_tree_ref(struct btrfs_ref *generic_ref,
 }
 
 static inline void btrfs_init_data_ref(struct btrfs_ref *generic_ref,
-				u64 ref_root, u64 ino, u64 offset)
+				u64 ref_root, u64 ino, u64 offset, u64 mod_root,
+				bool skip_qgroup)
 {
 	/* If @real_root not set, use @root as fallback */
 	if (!generic_ref->real_root)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index de099de3829e..a4fbe4b1df80 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2439,7 +2439,8 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 					       num_bytes, parent);
 			generic_ref.real_root = root->root_key.objectid;
 			btrfs_init_data_ref(&generic_ref, ref_root, key.objectid,
-					    key.offset);
+					    key.offset, root->root_key.objectid,
+					    for_reloc);
 			generic_ref.skip_qgroup = for_reloc;
 			if (inc)
 				ret = btrfs_inc_extent_ref(trans, &generic_ref);
@@ -2453,7 +2454,8 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			btrfs_init_generic_ref(&generic_ref, action, bytenr,
 					       num_bytes, parent);
 			generic_ref.real_root = root->root_key.objectid;
-			btrfs_init_tree_ref(&generic_ref, level - 1, ref_root);
+			btrfs_init_tree_ref(&generic_ref, level - 1, ref_root,
+					    root->root_key.objectid, for_reloc);
 			generic_ref.skip_qgroup = for_reloc;
 			if (inc)
 				ret = btrfs_inc_extent_ref(trans, &generic_ref);
@@ -3288,7 +3290,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
 			       buf->start, buf->len, parent);
 	btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf),
-			    root->root_key.objectid);
+			    root->root_key.objectid, 0, false);
 
 	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
@@ -4741,7 +4743,8 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 
 	btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
 			       ins->objectid, ins->offset, 0);
-	btrfs_init_data_ref(&generic_ref, root->root_key.objectid, owner, offset);
+	btrfs_init_data_ref(&generic_ref, root->root_key.objectid, owner,
+			    offset, 0, false);
 	btrfs_ref_tree_mod(root->fs_info, &generic_ref);
 
 	return btrfs_add_delayed_data_ref(trans, &generic_ref, ram_bytes);
@@ -4934,7 +4937,8 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
 				       ins.objectid, ins.offset, parent);
 		generic_ref.real_root = root->root_key.objectid;
-		btrfs_init_tree_ref(&generic_ref, level, root_objectid);
+		btrfs_init_tree_ref(&generic_ref, level, root_objectid,
+				    root->root_key.objectid, false);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
 		ret = btrfs_add_delayed_tree_ref(trans, &generic_ref, extent_op);
 		if (ret)
@@ -5351,7 +5355,8 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, bytenr,
 				       fs_info->nodesize, parent);
-		btrfs_init_tree_ref(&ref, level - 1, root->root_key.objectid);
+		btrfs_init_tree_ref(&ref, level - 1, root->root_key.objectid,
+				    0, false);
 		ret = btrfs_free_extent(trans, &ref);
 		if (ret)
 			goto out_unlock;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9785ea32d39c..9a3db1365ae8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -876,7 +876,8 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 				btrfs_init_data_ref(&ref,
 						root->root_key.objectid,
 						new_key.objectid,
-						args->start - extent_offset);
+						args->start - extent_offset,
+						0, false);
 				ret = btrfs_inc_extent_ref(trans, &ref);
 				BUG_ON(ret); /* -ENOMEM */
 			}
@@ -962,7 +963,8 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 				btrfs_init_data_ref(&ref,
 						root->root_key.objectid,
 						key.objectid,
-						key.offset - extent_offset);
+						key.offset - extent_offset, 0,
+						false);
 				ret = btrfs_free_extent(trans, &ref);
 				BUG_ON(ret); /* -ENOMEM */
 				args->bytes_found += extent_end - key.offset;
@@ -1238,7 +1240,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, bytenr,
 				       num_bytes, 0);
 		btrfs_init_data_ref(&ref, root->root_key.objectid, ino,
-				    orig_offset);
+				    orig_offset, 0, false);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -1263,7 +1265,8 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 	other_end = 0;
 	btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, bytenr,
 			       num_bytes, 0);
-	btrfs_init_data_ref(&ref, root->root_key.objectid, ino, orig_offset);
+	btrfs_init_data_ref(&ref, root->root_key.objectid, ino, orig_offset,
+			    0, false);
 	if (extent_mergeable(leaf, path->slots[0] + 1,
 			     ino, bytenr, orig_offset,
 			     &other_start, &other_end)) {
@@ -2626,7 +2629,7 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 				       extent_info->disk_len, 0);
 		ref_offset = extent_info->file_offset - extent_info->data_offset;
 		btrfs_init_data_ref(&ref, root->root_key.objectid,
-				    btrfs_ino(inode), ref_offset);
+				    btrfs_ino(inode), ref_offset, 0, false);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 	}
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f5faa6bedbd4..4fa0792be22d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4921,7 +4921,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 					extent_start, extent_num_bytes, 0);
 			ref.real_root = root->root_key.objectid;
 			btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
-					ino, extent_offset);
+					ino, extent_offset,
+					root->root_key.objectid, false);
 			ret = btrfs_free_extent(trans, &ref);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5e5066ee03e6..ce3631760ef4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1148,7 +1148,8 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 				       num_bytes, parent);
 		ref.real_root = root->root_key.objectid;
 		btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
-				    key.objectid, key.offset);
+				    key.objectid, key.offset,
+				    root->root_key.objectid, false);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -1159,7 +1160,8 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 				       num_bytes, parent);
 		ref.real_root = root->root_key.objectid;
 		btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
-				    key.objectid, key.offset);
+				    key.objectid, key.offset,
+				    root->root_key.objectid, false);
 		ret = btrfs_free_extent(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -1369,7 +1371,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, old_bytenr,
 				       blocksize, path->nodes[level]->start);
 		ref.skip_qgroup = true;
-		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid);
+		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid,
+				    0, true);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -1378,7 +1381,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new_bytenr,
 				       blocksize, 0);
 		ref.skip_qgroup = true;
-		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid);
+		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid, 0,
+				    true);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -1387,7 +1391,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, new_bytenr,
 				       blocksize, path->nodes[level]->start);
-		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid);
+		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid,
+				    0, true);
 		ref.skip_qgroup = true;
 		ret = btrfs_free_extent(trans, &ref);
 		if (ret) {
@@ -1397,7 +1402,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, old_bytenr,
 				       blocksize, 0);
-		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid);
+		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid,
+				    0, true);
 		ref.skip_qgroup = true;
 		ret = btrfs_free_extent(trans, &ref);
 		if (ret) {
@@ -2476,7 +2482,8 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 					       upper->eb->start);
 			ref.real_root = root->root_key.objectid;
 			btrfs_init_tree_ref(&ref, node->level,
-					    btrfs_header_owner(upper->eb));
+					    btrfs_header_owner(upper->eb),
+					    root->root_key.objectid, false);
 			ret = btrfs_inc_extent_ref(trans, &ref);
 			if (!ret)
 				ret = btrfs_drop_subtree(trans, root, eb,
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 71b3ddb0333d..cda7bb2e9a1e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -789,7 +789,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 						ins.objectid, ins.offset, 0);
 				btrfs_init_data_ref(&ref,
 						root->root_key.objectid,
-						key->objectid, offset);
+						key->objectid, offset, 0, false);
 				ret = btrfs_inc_extent_ref(trans, &ref);
 				if (ret)
 					goto out;
-- 
2.25.1

