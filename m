Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EA9428A96
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 12:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhJKKM1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 06:12:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39854 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbhJKKMW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 06:12:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CB0522004C;
        Mon, 11 Oct 2021 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633947021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rti+ajVMtF/nCdTtO/LUngBHNyCxvFPYHUq4D6MBO2E=;
        b=ZreaxBWtv3u00GHgylt/PaGNPsEhA3diTVHg1ynXLyPIUbrl/y/SZ2ZjJJEHMyIkeDKELP
        rGDlYlOw9Cp1SD5Iw+moOqGe6J4zJeqLIKlgnJAnJmWPs6vUj/zy+A0XZ11dJ6p8rqLaaQ
        xxJOSWDdRXvpvMjddyZFp3qabJ5syVE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A3A513C4C;
        Mon, 11 Oct 2021 10:10:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2OMRI40NZGGJLwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 11 Oct 2021 10:10:21 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/5] btrfs: pull up qgroup checks from delayed-ref core to init time
Date:   Mon, 11 Oct 2021 13:10:18 +0300
Message-Id: <20211011101019.1409855-5-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011101019.1409855-1-nborisov@suse.com>
References: <20211011101019.1409855-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of checking whether qgroup processing for a dealyed ref has to
happen in the core of delayed ref, simply pull the check at init time of
respective delayed ref structures. This eliminates the final use of
real_root in delayed-ref core paving the way to making this member
optional.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delayed-ref.c | 4 ----
 fs/btrfs/delayed-ref.h | 4 ++++
 fs/btrfs/extent-tree.c | 5 -----
 fs/btrfs/inode.c       | 1 -
 fs/btrfs/relocation.c  | 7 -------
 5 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 7c725379b8ca..405e93ebddae 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -923,8 +923,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	}
 
 	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) &&
-	    is_fstree(generic_ref->real_root) &&
-	    is_fstree(generic_ref->tree_ref.owning_root) &&
 	    !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
 		if (!record) {
@@ -1029,8 +1027,6 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	}
 
 	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) &&
-	    is_fstree(ref_root) &&
-	    is_fstree(generic_ref->real_root) &&
 	    !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
 		if (!record) {
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 8ab79def8e98..6bb299c66e1e 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -279,6 +279,8 @@ static inline void btrfs_init_tree_ref(struct btrfs_ref *generic_ref,
 	generic_ref->tree_ref.level = level;
 	generic_ref->tree_ref.owning_root = root;
 	generic_ref->type = BTRFS_REF_METADATA;
+	generic_ref->skip_qgroup = skip_qgroup || !(is_fstree(root) &&
+				    (!mod_root || is_fstree(mod_root)));
 }
 
 static inline void btrfs_init_data_ref(struct btrfs_ref *generic_ref,
@@ -292,6 +294,8 @@ static inline void btrfs_init_data_ref(struct btrfs_ref *generic_ref,
 	generic_ref->data_ref.ino = ino;
 	generic_ref->data_ref.offset = offset;
 	generic_ref->type = BTRFS_REF_DATA;
+	generic_ref->skip_qgroup = skip_qgroup || !(is_fstree(ref_root) &&
+				    (!mod_root || is_fstree(mod_root)));
 }
 
 static inline struct btrfs_delayed_extent_op *
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a4fbe4b1df80..5a07386bd6d9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2437,11 +2437,9 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			key.offset -= btrfs_file_extent_offset(buf, fi);
 			btrfs_init_generic_ref(&generic_ref, action, bytenr,
 					       num_bytes, parent);
-			generic_ref.real_root = root->root_key.objectid;
 			btrfs_init_data_ref(&generic_ref, ref_root, key.objectid,
 					    key.offset, root->root_key.objectid,
 					    for_reloc);
-			generic_ref.skip_qgroup = for_reloc;
 			if (inc)
 				ret = btrfs_inc_extent_ref(trans, &generic_ref);
 			else
@@ -2453,10 +2451,8 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			num_bytes = fs_info->nodesize;
 			btrfs_init_generic_ref(&generic_ref, action, bytenr,
 					       num_bytes, parent);
-			generic_ref.real_root = root->root_key.objectid;
 			btrfs_init_tree_ref(&generic_ref, level - 1, ref_root,
 					    root->root_key.objectid, for_reloc);
-			generic_ref.skip_qgroup = for_reloc;
 			if (inc)
 				ret = btrfs_inc_extent_ref(trans, &generic_ref);
 			else
@@ -4936,7 +4932,6 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 
 		btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
 				       ins.objectid, ins.offset, parent);
-		generic_ref.real_root = root->root_key.objectid;
 		btrfs_init_tree_ref(&generic_ref, level, root_objectid,
 				    root->root_key.objectid, false);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4fa0792be22d..a980bf37efdc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4919,7 +4919,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 
 			btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF,
 					extent_start, extent_num_bytes, 0);
-			ref.real_root = root->root_key.objectid;
 			btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
 					ino, extent_offset,
 					root->root_key.objectid, false);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ce3631760ef4..fed823596248 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1146,7 +1146,6 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 		key.offset -= btrfs_file_extent_offset(leaf, fi);
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new_bytenr,
 				       num_bytes, parent);
-		ref.real_root = root->root_key.objectid;
 		btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
 				    key.objectid, key.offset,
 				    root->root_key.objectid, false);
@@ -1158,7 +1157,6 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, bytenr,
 				       num_bytes, parent);
-		ref.real_root = root->root_key.objectid;
 		btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
 				    key.objectid, key.offset,
 				    root->root_key.objectid, false);
@@ -1370,7 +1368,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, old_bytenr,
 				       blocksize, path->nodes[level]->start);
-		ref.skip_qgroup = true;
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid,
 				    0, true);
 		ret = btrfs_inc_extent_ref(trans, &ref);
@@ -1380,7 +1377,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		}
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new_bytenr,
 				       blocksize, 0);
-		ref.skip_qgroup = true;
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid, 0,
 				    true);
 		ret = btrfs_inc_extent_ref(trans, &ref);
@@ -1393,7 +1389,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 				       blocksize, path->nodes[level]->start);
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid,
 				    0, true);
-		ref.skip_qgroup = true;
 		ret = btrfs_free_extent(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -1404,7 +1399,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 				       blocksize, 0);
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid,
 				    0, true);
-		ref.skip_qgroup = true;
 		ret = btrfs_free_extent(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -2480,7 +2474,6 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF,
 					       node->eb->start, blocksize,
 					       upper->eb->start);
-			ref.real_root = root->root_key.objectid;
 			btrfs_init_tree_ref(&ref, node->level,
 					    btrfs_header_owner(upper->eb),
 					    root->root_key.objectid, false);
-- 
2.25.1

