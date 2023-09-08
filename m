Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2167986C9
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242826AbjIHMJp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243030AbjIHMJo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:09:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9931BC5
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:09:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6121EC433C8
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174980;
        bh=5jALY8Tyarr/TIo+Gi/M/dyGvLBjNfwlSVD+PfqjjqU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OzVRYUJHv0FpQcaud5j2Ugpo08X/4SBdE7cqw6vJJvP8Ava6ebmxZnW9P/cJLO3dK
         DmJaKyxLvPfpYBrqpcD35kcGJp6HXN/YQwwwzHGXRxuoYaXg90f/xdbC85KjObYSRx
         kGCq06KpLRi2bG6ddZrTNBAJKluAAOoTIn3uv4jsnwAls5g7DQtjI/YsbEsEJWopR+
         l8+CJ2AjDhxHRfUGQzzoCSJkbCcvCxfIv/kCy67XBvGzsYg4NmDnDoYzCeUIsPxMVG
         tdsXNJLJhWKCNTvrRg8L254xst4ntZtFuFRZOag0CKWoqclg7uOdqt8UaR1PoabcP7
         ZcRUxyxrbZTlg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/21] btrfs: use a single variable for return value at lookup_inline_extent_backref()
Date:   Fri,  8 Sep 2023 13:09:16 +0100
Message-Id: <6a03f43747c9126f6162886e3bb7934fd480ae48.1694174371.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694174371.git.fdmanana@suse.com>
References: <cover.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At lookup_inline_extent_backref(), instead of using a 'ret' and an 'err'
variable for tracking the return value, use a single one ('ret'). This
simplifies the code, makes it comply with most of the existing code and
it's less prone for logic errors as time has proven over and over in the
btrfs code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e33c4b393922..e57061106860 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -789,7 +789,6 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	int type;
 	int want;
 	int ret;
-	int err = 0;
 	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
 	int needed;
 
@@ -816,10 +815,8 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 
 again:
 	ret = btrfs_search_slot(trans, root, &key, path, extra_size, 1);
-	if (ret < 0) {
-		err = ret;
+	if (ret < 0)
 		goto out;
-	}
 
 	/*
 	 * We may be a newly converted file system which still has the old fat
@@ -846,7 +843,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	}
 
 	if (ret && !insert) {
-		err = -ENOENT;
+		ret = -ENOENT;
 		goto out;
 	} else if (WARN_ON(ret)) {
 		btrfs_print_leaf(path->nodes[0]);
@@ -854,18 +851,18 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 "extent item not found for insert, bytenr %llu num_bytes %llu parent %llu root_objectid %llu owner %llu offset %llu",
 			  bytenr, num_bytes, parent, root_objectid, owner,
 			  offset);
-		err = -EIO;
+		ret = -EIO;
 		goto out;
 	}
 
 	leaf = path->nodes[0];
 	item_size = btrfs_item_size(leaf, path->slots[0]);
 	if (unlikely(item_size < sizeof(*ei))) {
-		err = -EUCLEAN;
+		ret = -EUCLEAN;
 		btrfs_err(fs_info,
 			  "unexpected extent item size, has %llu expect >= %zu",
 			  item_size, sizeof(*ei));
-		btrfs_abort_transaction(trans, err);
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
@@ -885,11 +882,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	else
 		needed = BTRFS_REF_TYPE_BLOCK;
 
-	err = -ENOENT;
+	ret = -ENOENT;
 	while (1) {
 		if (ptr >= end) {
 			if (ptr > end) {
-				err = -EUCLEAN;
+				ret = -EUCLEAN;
 				btrfs_print_leaf(path->nodes[0]);
 				btrfs_crit(fs_info,
 "overrun extent record at slot %d while looking for inline extent for root %llu owner %llu offset %llu parent %llu",
@@ -900,7 +897,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 		iref = (struct btrfs_extent_inline_ref *)ptr;
 		type = btrfs_get_extent_inline_ref_type(leaf, iref, needed);
 		if (type == BTRFS_REF_TYPE_INVALID) {
-			err = -EUCLEAN;
+			ret = -EUCLEAN;
 			goto out;
 		}
 
@@ -916,7 +913,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
 			if (match_extent_data_ref(leaf, dref, root_objectid,
 						  owner, offset)) {
-				err = 0;
+				ret = 0;
 				break;
 			}
 			if (hash_extent_data_ref_item(leaf, dref) <
@@ -927,14 +924,14 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 			ref_offset = btrfs_extent_inline_ref_offset(leaf, iref);
 			if (parent > 0) {
 				if (parent == ref_offset) {
-					err = 0;
+					ret = 0;
 					break;
 				}
 				if (ref_offset < parent)
 					break;
 			} else {
 				if (root_objectid == ref_offset) {
-					err = 0;
+					ret = 0;
 					break;
 				}
 				if (ref_offset < root_objectid)
@@ -943,10 +940,10 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 		}
 		ptr += btrfs_extent_inline_ref_size(type);
 	}
-	if (err == -ENOENT && insert) {
+	if (ret == -ENOENT && insert) {
 		if (item_size + extra_size >=
 		    BTRFS_MAX_EXTENT_ITEM_SIZE(root)) {
-			err = -EAGAIN;
+			ret = -EAGAIN;
 			goto out;
 		}
 		/*
@@ -958,7 +955,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 		if (find_next_key(path, 0, &key) == 0 &&
 		    key.objectid == bytenr &&
 		    key.type < BTRFS_BLOCK_GROUP_ITEM_KEY) {
-			err = -EAGAIN;
+			ret = -EAGAIN;
 			goto out;
 		}
 	}
@@ -969,7 +966,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 		path->search_for_extension = 0;
 		btrfs_unlock_up_safe(path, 1);
 	}
-	return err;
+	return ret;
 }
 
 /*
-- 
2.40.1

