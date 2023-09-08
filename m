Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1995C798B69
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245414AbjIHRU7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245411AbjIHRU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:20:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66756199F
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:20:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80ECFC433C8
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193655;
        bh=Sr76n7opmfLz2+fc8EwIiwSQ3SrcHWpeL4ymY3yoX2U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=b+F2lFZMyPxmvPrbqUXENzfmuOWUNiJE3NZdzJ2HfRFNtBWIbSnV0A8qLW1xHypqi
         yVN6wLkk/t46UviwUJzsur3df+T07KgUvxrJShS8i2HlygYeZVnIOu+6RR265xGOPh
         Y0XWMoe3TVGOdGdpc/Fp1APFX9rnq8AWz/JnLIkupJy/oFG4OSt/3kSFz+FhbH9bS7
         tyFc5ZDLEB7Zz/ONKAuVw+XWzUju48fmd8yCR6TUsqZOzBt+j+oFawTxQWgby+Lmfv
         6jwMDW31+dmCWezND8sZ2+cs7seb3gDGTsfq2Xh8Bqcp1NpD29N/tZGNtZli37I0IX
         POxIiFm7IzGBg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 13/21] btrfs: use a single variable for return value at run_delayed_extent_op()
Date:   Fri,  8 Sep 2023 18:20:30 +0100
Message-Id: <c4baa0c7a5b2dd0fd6a97daa7579a88cb42da325.1694192469.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694192469.git.fdmanana@suse.com>
References: <cover.1694192469.git.fdmanana@suse.com>
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

Instead of using a 'ret' and an 'err' variable at run_delayed_extent_op()
for tracking the return value, use a single one ('ret'). This simplifies
the code, makes it comply with most of the existing code and it's less
prone for logic errors as time has proven over and over in the btrfs code.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 167d0438da6e..e33c4b393922 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1602,7 +1602,6 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	u32 item_size;
 	int ret;
-	int err = 0;
 	int metadata = 1;
 
 	if (TRANS_ABORTED(trans))
@@ -1629,10 +1628,8 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 again:
 	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
 	if (ret < 0) {
-		err = ret;
 		goto out;
-	}
-	if (ret > 0) {
+	} else if (ret > 0) {
 		if (metadata) {
 			if (path->slots[0] > 0) {
 				path->slots[0]--;
@@ -1653,7 +1650,7 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 				goto again;
 			}
 		} else {
-			err = -EUCLEAN;
+			ret = -EUCLEAN;
 			btrfs_err(fs_info,
 		  "missing extent item for extent %llu num_bytes %llu level %d",
 				  head->bytenr, head->num_bytes, extent_op->level);
@@ -1665,11 +1662,11 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 	item_size = btrfs_item_size(leaf, path->slots[0]);
 
 	if (unlikely(item_size < sizeof(*ei))) {
-		err = -EUCLEAN;
+		ret = -EUCLEAN;
 		btrfs_err(fs_info,
 			  "unexpected extent item size, has %u expect >= %zu",
 			  item_size, sizeof(*ei));
-		btrfs_abort_transaction(trans, err);
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
@@ -1679,7 +1676,7 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 out:
 	btrfs_free_path(path);
-	return err;
+	return ret;
 }
 
 static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
-- 
2.40.1

