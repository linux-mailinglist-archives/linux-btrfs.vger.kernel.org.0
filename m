Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D9E7753A5
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 09:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjHIHIw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 03:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjHIHIh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 03:08:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECF91BCF
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 00:08:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 070251F383
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 07:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691564915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ENuvkMliLYhYxKcCxUMKqHojxC94yVTkmQqkxcP0RN0=;
        b=JLoU8HLnafeMYKV9/v0rvUc+F8h1Sgi+LHAXs/M8x8dwOro6J8LimBd9+Q6bI42eK43Kix
        banCvDVmZqmufaac+EeZ39TK6gj8QHVoffnT/QNgGwqLiW1y5X25+BssNAKfvUNQY6QTix
        7axBwtNf9fJC5Q+StzwEA2kFI+nCpms=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58FEC1377F
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 07:08:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Gq3UCHI702SiSwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Aug 2023 07:08:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: handle errors properly in update_inline_extent_backref()
Date:   Wed,  9 Aug 2023 15:08:21 +0800
Message-ID: <7a56e967d536bbb3d40c90def6e59e9970ef3445.1691564698.git.wqu@suse.com>
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

[PROBLEM]
Inside function update_inline_extent_backref(), we have several
BUG_ON()s along with some ASSERT()s which can be triggered by corrupted
filesystem.

[ANAYLYSE]
Most of those BUG_ON()s and ASSERT()s are just a way of handling
unexpected on-disk data.

Although we have tree-checker to rule out obviously incorrect extent
tree blocks, it's not enough for those ones.

Thus we need proper error handling for them.

[FIX]
Thankfully all the callers of update_inline_extent_backref() would
eventually handle the errror by aborting the current transaction.

So this patch would do the proper error handling by:

- Make update_inline_extent_backref() to return int
  The return value would be either 0 or -EUCLEAN.

- Replace BUG_ON()s and ASSERT()s with proper error handling
  This includes:
  * Dump the bad extent tree leaf
  * Output an error message for the cause
    This would include the extent bytenr, num_bytes (if needed),
    the bad values and expected good values.
  * Return -EUCLEAN

  Note here we remove all the WARN_ON()s, as eventually the transaction
  would be aborted, thus a backtrace would be triggered anyway.

- Better comments on why we expect refs == 1 and refs_to_mode == -1 for
  tree blocks

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c | 80 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3cae798499e2..45e325523e81 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -381,11 +381,11 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 		}
 	}
 
+	WARN_ON(1);
 	btrfs_print_leaf(eb);
 	btrfs_err(eb->fs_info,
 		  "eb %llu iref 0x%lx invalid extent inline ref type %d",
 		  eb->start, (unsigned long)iref, type);
-	WARN_ON(1);
 
 	return BTRFS_REF_TYPE_INVALID;
 }
@@ -1059,12 +1059,13 @@ static int lookup_extent_backref(struct btrfs_trans_handle *trans,
  * helper to update/remove inline back ref
  */
 static noinline_for_stack
-void update_inline_extent_backref(struct btrfs_path *path,
-				  struct btrfs_extent_inline_ref *iref,
-				  int refs_to_mod,
-				  struct btrfs_delayed_extent_op *extent_op)
+int update_inline_extent_backref(struct btrfs_path *path,
+				 struct btrfs_extent_inline_ref *iref,
+				 int refs_to_mod,
+				 struct btrfs_delayed_extent_op *extent_op)
 {
 	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_extent_item *ei;
 	struct btrfs_extent_data_ref *dref = NULL;
 	struct btrfs_shared_data_ref *sref = NULL;
@@ -1077,18 +1078,33 @@ void update_inline_extent_backref(struct btrfs_path *path,
 
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
 	refs = btrfs_extent_refs(leaf, ei);
-	WARN_ON(refs_to_mod < 0 && refs + refs_to_mod <= 0);
+	if (unlikely(refs_to_mod < 0 && refs + refs_to_mod <= 0)) {
+		struct btrfs_key key;
+		u32 extent_size;
+
+		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+		if (key.type == BTRFS_METADATA_ITEM_KEY)
+			extent_size = fs_info->nodesize;
+		else
+			extent_size = key.offset;
+		btrfs_print_leaf(leaf);
+		btrfs_err(fs_info,
+"invalid refs_to_mod for extent %llu num_bytes %u, has %d expect >= -%llu",
+			  key.objectid, extent_size, refs_to_mod, refs);
+		return -EUCLEAN;
+	}
 	refs += refs_to_mod;
 	btrfs_set_extent_refs(leaf, ei, refs);
 	if (extent_op)
 		__run_delayed_extent_op(extent_op, leaf, ei);
 
-	/*
-	 * If type is invalid, we should have bailed out after
-	 * lookup_inline_extent_backref().
-	 */
 	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_ANY);
-	ASSERT(type != BTRFS_REF_TYPE_INVALID);
+	/*
+	 * Function btrfs_get_extent_inline_ref_type() has already output
+	 * error messages.
+	 */
+	if (unlikely(type == BTRFS_REF_TYPE_INVALID))
+		return -EUCLEAN;
 
 	if (type == BTRFS_EXTENT_DATA_REF_KEY) {
 		dref = (struct btrfs_extent_data_ref *)(&iref->offset);
@@ -1098,10 +1114,43 @@ void update_inline_extent_backref(struct btrfs_path *path,
 		refs = btrfs_shared_data_ref_count(leaf, sref);
 	} else {
 		refs = 1;
-		BUG_ON(refs_to_mod != -1);
+		/*
+		 * For tree blocks we can only drop one ref for it, and
+		 * tree blocks should not have refs > 1.
+		 *
+		 * Furthermore if we're inserting a new inline backref,
+		 * we won't reach this path either.
+		 * (that would be setup_inline_extent_backref())
+		 */
+		if (unlikely(refs_to_mod != -1)) {
+			struct btrfs_key key;
+
+			btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+
+			btrfs_print_leaf(leaf);
+			btrfs_err(fs_info,
+		"invalid refs_to_mod for tree block %llu, has %d expect -1",
+				  key.objectid, refs_to_mod);
+			return -EUCLEAN;
+		}
 	}
 
-	BUG_ON(refs_to_mod < 0 && refs < -refs_to_mod);
+	if (unlikely(refs_to_mod < 0 && refs < -refs_to_mod)) {
+		struct btrfs_key key;
+		u32 extent_size;
+
+		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+		if (key.type == BTRFS_METADATA_ITEM_KEY)
+			extent_size = fs_info->nodesize;
+		else
+			extent_size = key.offset;
+		btrfs_print_leaf(leaf);
+		btrfs_err(fs_info,
+"invalid refs_to_mod for backref entry, iref %lu extent %llu num_bytes %u, has %d expect >= -%llu",
+			  (unsigned long)iref, key.objectid, extent_size,
+			  refs_to_mod, refs);
+		return -EUCLEAN;
+	}
 	refs += refs_to_mod;
 
 	if (refs > 0) {
@@ -1121,6 +1170,7 @@ void update_inline_extent_backref(struct btrfs_path *path,
 		btrfs_truncate_item(path, item_size, 1);
 	}
 	btrfs_mark_buffer_dirty(leaf);
+	return 0;
 }
 
 static noinline_for_stack
@@ -1149,7 +1199,7 @@ int insert_inline_extent_backref(struct btrfs_trans_handle *trans,
 				   bytenr, num_bytes, root_objectid, path->slots[0]);
 			return -EUCLEAN;
 		}
-		update_inline_extent_backref(path, iref, refs_to_add, extent_op);
+		ret = update_inline_extent_backref(path, iref, refs_to_add, extent_op);
 	} else if (ret == -ENOENT) {
 		setup_inline_extent_backref(trans->fs_info, path, iref, parent,
 					    root_objectid, owner, offset,
@@ -1169,7 +1219,7 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
 
 	BUG_ON(!is_data && refs_to_drop != 1);
 	if (iref)
-		update_inline_extent_backref(path, iref, -refs_to_drop, NULL);
+		ret = update_inline_extent_backref(path, iref, -refs_to_drop, NULL);
 	else if (is_data)
 		ret = remove_extent_data_ref(trans, root, path, refs_to_drop);
 	else
-- 
2.41.0

