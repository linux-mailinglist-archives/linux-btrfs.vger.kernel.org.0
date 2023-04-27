Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987556F0596
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 14:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243510AbjD0MRT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 08:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243860AbjD0MRR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 08:17:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86735BAB
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 05:16:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 757B31FE0F
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682597808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y0MhA0q9e4biiL6sBy6t6EyiGD3+1bDwJzwkDsCzgo8=;
        b=oSd1C/UDFhpUYcMXRQGco2pT+cYi+NkMHi8Ojm1mH1Bjnyrx5Ik/iGKfVTd/EMmlZYruOG
        Qb0cCbw+hvhzBc1VnUz7CIgfz9zH0t7hg40BHYKm7++AGKFqKmXaWnNuPgAXeAKomZbWdj
        XptanOIqQ2m6O4lyW1Tf59GwATw86VU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9ECF13910
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 12:16:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CLcCKq9nSmQOUAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 12:16:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: improve leaf dump and error handling
Date:   Thu, 27 Apr 2023 20:16:28 +0800
Message-Id: <d5e7a6c160f50080e6c828964513579785fd0d67.1682597619.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1682597619.git.wqu@suse.com>
References: <cover.1682597619.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Improve the leaf dump behavior by:

- Always dump the leaf first, then the error message

- Output the slot number if possible
  Especially in __btrfs_free_extent() the leaf dump of extent tree can
  be pretty large.
  With an extra slot number it's much easier to locate the problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.c       |   4 +-
 fs/btrfs/extent-tree.c | 123 +++++++++++++++++++----------------------
 2 files changed, 59 insertions(+), 68 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 71b8905ebd01..a5a9c6c41125 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2633,6 +2633,7 @@ void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
 	if (slot > 0) {
 		btrfs_item_key(eb, &disk_key, slot - 1);
 		if (unlikely(comp_keys(&disk_key, new_key) >= 0)) {
+			btrfs_print_leaf(eb);
 			btrfs_crit(fs_info,
 		"slot %u key (%llu %u %llu) new key (%llu %u %llu)",
 				   slot, btrfs_disk_key_objectid(&disk_key),
@@ -2640,13 +2641,13 @@ void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
 				   btrfs_disk_key_offset(&disk_key),
 				   new_key->objectid, new_key->type,
 				   new_key->offset);
-			btrfs_print_leaf(eb);
 			BUG();
 		}
 	}
 	if (slot < btrfs_header_nritems(eb) - 1) {
 		btrfs_item_key(eb, &disk_key, slot + 1);
 		if (unlikely(comp_keys(&disk_key, new_key) <= 0)) {
+			btrfs_print_leaf(eb);
 			btrfs_crit(fs_info,
 		"slot %u key (%llu %u %llu) new key (%llu %u %llu)",
 				   slot, btrfs_disk_key_objectid(&disk_key),
@@ -2654,7 +2655,6 @@ void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
 				   btrfs_disk_key_offset(&disk_key),
 				   new_key->objectid, new_key->type,
 				   new_key->offset);
-			btrfs_print_leaf(eb);
 			BUG();
 		}
 	}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e1d5198d1f5e..c80c181ab34d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1164,15 +1164,10 @@ int insert_inline_extent_backref(struct btrfs_trans_handle *trans,
 		 * should not happen at all.
 		 */
 		if (owner < BTRFS_FIRST_FREE_OBJECTID) {
+			btrfs_print_leaf(path->nodes[0]);
 			btrfs_crit(trans->fs_info,
-"adding refs to an existing tree ref, bytenr %llu num_bytes %llu root_objectid %llu",
-				   bytenr, num_bytes, root_objectid);
-			if (IS_ENABLED(CONFIG_BTRFS_DEBUG)) {
-				WARN_ON(1);
-				btrfs_crit(trans->fs_info,
-			"path->slots[0]=%d path->nodes[0]:", path->slots[0]);
-				btrfs_print_leaf(path->nodes[0]);
-			}
+"adding refs to an existing tree ref, bytenr %llu num_bytes %llu root_objectid %llu slot %u",
+				   bytenr, num_bytes, root_objectid, path->slots[0]);
 			return -EUCLEAN;
 		}
 		update_inline_extent_backref(path, iref, refs_to_add, extent_op);
@@ -2838,6 +2833,13 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+#define abort_and_dump(trans, path, fmt, args...)	\
+({							\
+	btrfs_abort_transaction(trans, -EUCLEAN);	\
+	btrfs_print_leaf(path->nodes[0]);		\
+	btrfs_crit(trans->fs_info, fmt, ##args);	\
+})
+
 /*
  * Drop one or more refs of @node.
  *
@@ -2978,10 +2980,11 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 
 		if (!found_extent) {
 			if (iref) {
-				btrfs_crit(info,
-"invalid iref, no EXTENT/METADATA_ITEM found but has inline extent ref");
-				btrfs_abort_transaction(trans, -EUCLEAN);
-				goto err_dump;
+				abort_and_dump(trans, path,
+"invalid iref slot %u, no EXTENT/METADATA_ITEM found but has inline extent ref",
+					   path->slots[0]);
+				ret = -EUCLEAN;
+				goto out;
 			}
 			/* Must be SHARED_* item, remove the backref first */
 			ret = remove_extent_backref(trans, extent_root, path,
@@ -3029,11 +3032,11 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			}
 
 			if (ret) {
-				btrfs_err(info,
-					  "umm, got %d back from search, was looking for %llu",
-					  ret, bytenr);
 				if (ret > 0)
 					btrfs_print_leaf(path->nodes[0]);
+				btrfs_err(info,
+					  "umm, got %d back from search, was looking for %llu, slot %d",
+					  ret, bytenr, path->slots[0]);
 			}
 			if (ret < 0) {
 				btrfs_abort_transaction(trans, ret);
@@ -3042,12 +3045,10 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			extent_slot = path->slots[0];
 		}
 	} else if (WARN_ON(ret == -ENOENT)) {
-		btrfs_print_leaf(path->nodes[0]);
-		btrfs_err(info,
-			"unable to find ref byte nr %llu parent %llu root %llu  owner %llu offset %llu",
-			bytenr, parent, root_objectid, owner_objectid,
-			owner_offset);
-		btrfs_abort_transaction(trans, ret);
+		abort_and_dump(trans, path,
+"unable to find ref byte nr %llu parent %llu root %llu owner %llu offset %llu slot %d",
+			       bytenr, parent, root_objectid, owner_objectid,
+			       owner_offset, path->slots[0]);
 		goto out;
 	} else {
 		btrfs_abort_transaction(trans, ret);
@@ -3067,14 +3068,15 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	if (owner_objectid < BTRFS_FIRST_FREE_OBJECTID &&
 	    key.type == BTRFS_EXTENT_ITEM_KEY) {
 		struct btrfs_tree_block_info *bi;
+
 		if (item_size < sizeof(*ei) + sizeof(*bi)) {
-			btrfs_crit(info,
-"invalid extent item size for key (%llu, %u, %llu) owner %llu, has %u expect >= %zu",
-				   key.objectid, key.type, key.offset,
-				   owner_objectid, item_size,
-				   sizeof(*ei) + sizeof(*bi));
-			btrfs_abort_transaction(trans, -EUCLEAN);
-			goto err_dump;
+			abort_and_dump(trans, path,
+"invalid extent item size for key (%llu, %u, %llu) slot %u owner %llu, has %u expect >= %zu",
+				       key.objectid, key.type, key.offset,
+				       path->slots[0], owner_objectid, item_size,
+				       sizeof(*ei) + sizeof(*bi));
+			ret = -EUCLEAN;
+			goto out;
 		}
 		bi = (struct btrfs_tree_block_info *)(ei + 1);
 		WARN_ON(owner_objectid != btrfs_tree_block_level(leaf, bi));
@@ -3082,11 +3084,11 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 
 	refs = btrfs_extent_refs(leaf, ei);
 	if (refs < refs_to_drop) {
-		btrfs_crit(info,
-		"trying to drop %d refs but we only have %llu for bytenr %llu",
-			  refs_to_drop, refs, bytenr);
-		btrfs_abort_transaction(trans, -EUCLEAN);
-		goto err_dump;
+		abort_and_dump(trans, path,
+		"trying to drop %d refs but we only have %llu for bytenr %llu slot %u",
+			       refs_to_drop, refs, bytenr, path->slots[0]);
+		ret = -EUCLEAN;
+		goto out;
 	}
 	refs -= refs_to_drop;
 
@@ -3099,10 +3101,11 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		 */
 		if (iref) {
 			if (!found_extent) {
-				btrfs_crit(info,
-"invalid iref, got inlined extent ref but no EXTENT/METADATA_ITEM found");
-				btrfs_abort_transaction(trans, -EUCLEAN);
-				goto err_dump;
+				abort_and_dump(trans, path,
+"invalid iref, got inlined extent ref but no EXTENT/METADATA_ITEM found, slot %u",
+					       path->slots[0]);
+				ret = -EUCLEAN;
+				goto out;
 			}
 		} else {
 			btrfs_set_extent_refs(leaf, ei, refs);
@@ -3121,21 +3124,21 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		if (found_extent) {
 			if (is_data && refs_to_drop !=
 			    extent_data_ref_count(path, iref)) {
-				btrfs_crit(info,
-		"invalid refs_to_drop, current refs %u refs_to_drop %u",
-					   extent_data_ref_count(path, iref),
-					   refs_to_drop);
-				btrfs_abort_transaction(trans, -EUCLEAN);
-				goto err_dump;
+				abort_and_dump(trans, path,
+		"invalid refs_to_drop, current refs %u refs_to_drop %u slot %u",
+					       extent_data_ref_count(path, iref),
+					       refs_to_drop, path->slots[0]);
+				ret = -EUCLEAN;
+				goto out;
 			}
 			if (iref) {
 				if (path->slots[0] != extent_slot) {
-					btrfs_crit(info,
-"invalid iref, extent item key (%llu %u %llu) doesn't have wanted iref",
-						   key.objectid, key.type,
-						   key.offset);
-					btrfs_abort_transaction(trans, -EUCLEAN);
-					goto err_dump;
+					abort_and_dump(trans, path,
+"invalid iref, extent item key (%llu %u %llu) slot %u doesn't have wanted iref",
+						       key.objectid, key.type,
+						       key.offset, path->slots[0]);
+					ret = -EUCLEAN;
+					goto out;
 				}
 			} else {
 				/*
@@ -3145,10 +3148,11 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 				 * [ EXTENT/METADATA_ITEM ][ SHARED_* ITEM ]
 				 */
 				if (path->slots[0] != extent_slot + 1) {
-					btrfs_crit(info,
-	"invalid SHARED_* item, previous item is not EXTENT/METADATA_ITEM");
-					btrfs_abort_transaction(trans, -EUCLEAN);
-					goto err_dump;
+					abort_and_dump(trans, path,
+	"invalid SHARED_* item slot %u, previous item is not EXTENT/METADATA_ITEM",
+						       path->slots[0]);
+					ret = -EUCLEAN;
+					goto out;
 				}
 				path->slots[0] = extent_slot;
 				num_to_del = 2;
@@ -3170,19 +3174,6 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 out:
 	btrfs_free_path(path);
 	return ret;
-err_dump:
-	/*
-	 * Leaf dump can take up a lot of log buffer, so we only do full leaf
-	 * dump for debug build.
-	 */
-	if (IS_ENABLED(CONFIG_BTRFS_DEBUG)) {
-		btrfs_crit(info, "path->slots[0]=%d extent_slot=%d",
-			   path->slots[0], extent_slot);
-		btrfs_print_leaf(path->nodes[0]);
-	}
-
-	btrfs_free_path(path);
-	return -EUCLEAN;
 }
 
 /*
-- 
2.39.2

