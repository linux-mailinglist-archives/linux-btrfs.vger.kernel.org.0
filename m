Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35C5778839
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbjHKHbp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 03:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjHKHbd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 03:31:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A22B2D66
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 00:31:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D6F02186E
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 07:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691739088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zrnyGJWdM/Opbld3QwyWdCLfWepmU06YZsKEsxu/p+4=;
        b=qR4HaGIP8CkvV7EP9M2PM1PvtEheeOByRMzu9Rw3SLe1Qc9oopV3Oe48AN7u1koGjmQ0Na
        1n16ev3G0jPs700yxpxElz/pcc28PIiG9s9Wo8U9pa/0X5x1P3dcuCaceASCqaAzXfhJfE
        SypRB2v9kCQFZoyndSJrbh7BZWCFUlw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F450138E2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 07:31:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U3BtCs/j1WSNZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 07:31:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove v0 extent handling
Date:   Fri, 11 Aug 2023 15:31:17 +0800
Message-ID: <b05e683addda2042339ae625751e181576843684.1691737395.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The v0 extent item has been deprecated for a long time, and we don't have
any report from the community either.

So it's time to remove the v0 extent specific error handling, and just
treat them as regular extent tree corruption.

This patch would remove the btrfs_print_v0_err() helper, and enhance the
involved error handling to treat them just as any extent tree
corruption.

This involves:

- btrfs_backref_add_tree_node()
  This change is a little tricky, the new code is changed to only handle
  BTRFS_TREE_BLOCK_REF_KEY and BTRFS_SHARED_BLOCK_REF_KEY.

  But this is safe, as we have rejected any unknown inline refs through
  btrfs_get_extent_inline_ref_type().
  For keyed backrefs, we're safe to skip anything we don't know (that's
  if it can pass tree-checker in the first place).

- btrfs_lookup_extent_info()
- lookup_inline_extent_backref()
- run_delayed_extent_op()
- __btrfs_free_extent()
- add_tree_block()
  Regular error handling of unexpected extent tree item, and abort
  transaction (if we have a trans handle).

- remove_extent_data_ref()
  It's pretty much the same as the regular rejection of unknown backref
  key.
  But for this particular case, we can also remove a BUG_ON().

- extent_data_ref_count()
  We can remove the BTRFS_EXTENT_REF_V0_key BUG_ON(), as it would be
  rejected by the only caller.

- btrfs_print_leaf()
  Remove the handling for BTRFS_EXTENT_REF_V0_key.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c     | 28 ++++++++++++----------------
 fs/btrfs/extent-tree.c | 35 +++++++++++++++++++++--------------
 fs/btrfs/messages.c    |  6 ------
 fs/btrfs/messages.h    |  2 --
 fs/btrfs/print-tree.c  | 10 ++++------
 fs/btrfs/relocation.c  | 11 ++++++-----
 6 files changed, 43 insertions(+), 49 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 79336fa853db..7bad4d8e81e8 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3462,25 +3462,21 @@ int btrfs_backref_add_tree_node(struct btrfs_backref_cache *cache,
 			ret = handle_direct_tree_backref(cache, &key, cur);
 			if (ret < 0)
 				goto out;
-			continue;
-		} else if (unlikely(key.type == BTRFS_EXTENT_REF_V0_KEY)) {
-			ret = -EINVAL;
-			btrfs_print_v0_err(fs_info);
-			btrfs_handle_fs_error(fs_info, ret, NULL);
-			goto out;
-		} else if (key.type != BTRFS_TREE_BLOCK_REF_KEY) {
-			continue;
+		} else if (key.type == BTRFS_TREE_BLOCK_REF_KEY) {
+			/*
+			 * key.type == BTRFS_TREE_BLOCK_REF_KEY, inline ref
+			 * offset means the root objectid. We need to search
+			 * the tree to get its parent bytenr.
+			 */
+			ret = handle_indirect_tree_backref(cache, path, &key, node_key,
+							   cur);
+			if (ret < 0)
+				goto out;
 		}
-
 		/*
-		 * key.type == BTRFS_TREE_BLOCK_REF_KEY, inline ref offset
-		 * means the root objectid. We need to search the tree to get
-		 * its parent bytenr.
+		 * Unrecognized tree backref items (if it can pass tree-checker)
+		 * would be ignored.
 		 */
-		ret = handle_indirect_tree_backref(cache, path, &key, node_key,
-						   cur);
-		if (ret < 0)
-			goto out;
 	}
 	ret = 0;
 	cur->checked = 1;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 112f6684a192..594c8a2e7296 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -166,8 +166,10 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			num_refs = btrfs_extent_refs(leaf, ei);
 			extent_flags = btrfs_extent_flags(leaf, ei);
 		} else {
-			ret = -EINVAL;
-			btrfs_print_v0_err(fs_info);
+			ret = -EUCLEAN;
+			btrfs_err(fs_info,
+			"unexpected extent item size, has %u expect >= %lu",
+				  item_size, sizeof(*ei));
 			if (trans)
 				btrfs_abort_transaction(trans, ret);
 			else
@@ -603,12 +605,12 @@ static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
 		ref2 = btrfs_item_ptr(leaf, path->slots[0],
 				      struct btrfs_shared_data_ref);
 		num_refs = btrfs_shared_data_ref_count(leaf, ref2);
-	} else if (unlikely(key.type == BTRFS_EXTENT_REF_V0_KEY)) {
-		btrfs_print_v0_err(trans->fs_info);
-		btrfs_abort_transaction(trans, -EINVAL);
-		return -EINVAL;
 	} else {
-		BUG();
+		btrfs_err(trans->fs_info,
+			  "unrecognized backref key (%llu %u %llu)",
+			  key.objectid, key.type, key.offset);
+		btrfs_abort_transaction(trans, -EUCLEAN);
+		return -EUCLEAN;
 	}
 
 	BUG_ON(num_refs < refs_to_drop);
@@ -639,7 +641,6 @@ static noinline u32 extent_data_ref_count(struct btrfs_path *path,
 	leaf = path->nodes[0];
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 
-	BUG_ON(key.type == BTRFS_EXTENT_REF_V0_KEY);
 	if (iref) {
 		/*
 		 * If type is invalid, we should have bailed out earlier than
@@ -860,8 +861,10 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	item_size = btrfs_item_size(leaf, path->slots[0]);
 	if (unlikely(item_size < sizeof(*ei))) {
-		err = -EINVAL;
-		btrfs_print_v0_err(fs_info);
+		err = -EUCLEAN;
+		btrfs_err(fs_info,
+			  "unexpected extent item size, has %llu expect >= %lu",
+			  item_size, sizeof(*ei));
 		btrfs_abort_transaction(trans, err);
 		goto out;
 	}
@@ -1662,8 +1665,10 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 	item_size = btrfs_item_size(leaf, path->slots[0]);
 
 	if (unlikely(item_size < sizeof(*ei))) {
-		err = -EINVAL;
-		btrfs_print_v0_err(fs_info);
+		err = -EUCLEAN;
+		btrfs_err(fs_info,
+			  "unexpected extent item size, has %u expect >= %lu",
+			  item_size, sizeof(*ei));
 		btrfs_abort_transaction(trans, err);
 		goto out;
 	}
@@ -3091,8 +3096,10 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	item_size = btrfs_item_size(leaf, extent_slot);
 	if (unlikely(item_size < sizeof(*ei))) {
-		ret = -EINVAL;
-		btrfs_print_v0_err(info);
+		ret = -EUCLEAN;
+		btrfs_err(trans->fs_info,
+			  "unexpected extent item size, has %u expect >= %lu",
+			  item_size, sizeof(*ei));
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index e3c9d2706341..7695decc7243 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -256,12 +256,6 @@ void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt,
 }
 #endif
 
-void __cold btrfs_print_v0_err(struct btrfs_fs_info *fs_info)
-{
-	btrfs_err(fs_info,
-"Unsupported V0 extent filesystem detected. Aborting. Please re-create your filesystem with a newer kernel");
-}
-
 #if BITS_PER_LONG == 32
 void __cold btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info)
 {
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index deedc1a168e2..1ae6f8e23e07 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -181,8 +181,6 @@ do {								\
 #define ASSERT(expr)	(void)(expr)
 #endif
 
-void __cold btrfs_print_v0_err(struct btrfs_fs_info *fs_info);
-
 __printf(5, 6)
 __cold
 void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index aa06d9ca911d..a97615799ced 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -95,8 +95,10 @@ static void print_extent_item(const struct extent_buffer *eb, int slot, int type
 	int ref_index = 0;
 
 	if (unlikely(item_size < sizeof(*ei))) {
-		btrfs_print_v0_err(eb->fs_info);
-		btrfs_handle_fs_error(eb->fs_info, -EINVAL, NULL);
+		btrfs_err(eb->fs_info,
+			  "unexpected extent item size, has %u expect >= %lu",
+			  item_size, sizeof(*ei));
+		btrfs_handle_fs_error(eb->fs_info, -EUCLEAN, NULL);
 	}
 
 	ei = btrfs_item_ptr(eb, slot, struct btrfs_extent_item);
@@ -291,10 +293,6 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 			       btrfs_file_extent_num_bytes(l, fi),
 			       btrfs_file_extent_ram_bytes(l, fi));
 			break;
-		case BTRFS_EXTENT_REF_V0_KEY:
-			btrfs_print_v0_err(fs_info);
-			btrfs_handle_fs_error(fs_info, -EINVAL, NULL);
-			break;
 		case BTRFS_BLOCK_GROUP_ITEM_KEY:
 			bi = btrfs_item_ptr(l, i,
 					    struct btrfs_block_group_item);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7408e48d45bc..9951a0caf5bb 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3256,12 +3256,13 @@ static int add_tree_block(struct reloc_control *rc,
 			if (type == BTRFS_TREE_BLOCK_REF_KEY)
 				owner = btrfs_extent_inline_ref_offset(eb, iref);
 		}
-	} else if (unlikely(item_size == sizeof(struct btrfs_extent_item_v0))) {
-		btrfs_print_v0_err(eb->fs_info);
-		btrfs_handle_fs_error(eb->fs_info, -EINVAL, NULL);
-		return -EINVAL;
 	} else {
-		BUG();
+		btrfs_print_leaf(eb);
+		btrfs_err(rc->block_group->fs_info,
+			  "unrecognized tree backref at tree block %llu slot %u",
+			  eb->start, path->slots[0]);
+		btrfs_release_path(path);
+		return -EUCLEAN;
 	}
 
 	btrfs_release_path(path);
-- 
2.41.0

