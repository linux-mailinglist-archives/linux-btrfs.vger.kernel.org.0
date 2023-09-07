Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51673797F21
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjIGXQH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjIGXQH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:16:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB045CF3
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:16:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6E94F210DB;
        Thu,  7 Sep 2023 23:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694128562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NXbpy9iugN4payWqeccfWyJzhHDfz9JS+vTldTe2Gfk=;
        b=Eqa/9/r5FI2qRG/TImXKtantvQByV+q8EPpknMVBo8/1akFkj9N1fAfs2jrQrUc0R3+7sN
        d74Ooi6XCY0Q5FPDbe6zxDrgFqvNcrTfMu8N6py9E0/F54ct9IzzIfaYhxjNL8kEB1ptcu
        7smh+cH7f4BXSagjSWS2uy/QJGt0p7Y=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 634EB2C142;
        Thu,  7 Sep 2023 23:16:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 952CBDA8C5; Fri,  8 Sep 2023 01:09:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 05/10] btrfs: reduce parameters of btrfs_pin_extent_for_log_replay
Date:   Fri,  8 Sep 2023 01:09:31 +0200
Message-ID: <579a7f7e44703c87aa64a253e6f4c14b4bde8c24.1694126893.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694126893.git.dsterba@suse.com>
References: <cover.1694126893.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Both callers of btrfs_pin_extent_for_log_replay expand the parameters to
extent buffer members. We can simply pass the extent buffer instead.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 8 ++++----
 fs/btrfs/extent-tree.h | 2 +-
 fs/btrfs/tree-log.c    | 7 ++-----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 98d97c97ab8c..3e46bb4cc957 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2567,12 +2567,12 @@ int btrfs_pin_extent(struct btrfs_trans_handle *trans,
  * this function must be called within transaction
  */
 int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
-				    u64 bytenr, u64 num_bytes)
+				    const struct extent_buffer *eb)
 {
 	struct btrfs_block_group *cache;
 	int ret;
 
-	cache = btrfs_lookup_block_group(trans->fs_info, bytenr);
+	cache = btrfs_lookup_block_group(trans->fs_info, eb->start);
 	if (!cache)
 		return -EINVAL;
 
@@ -2584,10 +2584,10 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	pin_down_extent(trans, cache, bytenr, num_bytes, 0);
+	pin_down_extent(trans, cache, eb->start, eb->len, 0);
 
 	/* remove us from the free space cache (if we're there at all) */
-	ret = btrfs_remove_free_space(cache, bytenr, num_bytes);
+	ret = btrfs_remove_free_space(cache, eb->start, eb->len);
 out:
 	btrfs_put_block_group(cache);
 	return ret;
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index c56f616dcd1b..dd31ee85f360 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -103,7 +103,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64 num,
 		     int reserved);
 int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
-				    u64 bytenr, u64 num_bytes);
+				    const struct extent_buffer *eb);
 int btrfs_exclude_logged_extents(struct extent_buffer *eb);
 int btrfs_cross_ref_exist(struct btrfs_root *root,
 			  u64 objectid, u64 offset, u64 bytenr, bool strict,
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4f85c435b793..15c8cb6627fe 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -347,8 +347,7 @@ static int process_one_buffer(struct btrfs_root *log,
 	}
 
 	if (wc->pin) {
-		ret = btrfs_pin_extent_for_log_replay(wc->trans, eb->start,
-						      eb->len);
+		ret = btrfs_pin_extent_for_log_replay(wc->trans, eb);
 		if (ret)
 			return ret;
 
@@ -7203,9 +7202,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			 * each subsequent pass.
 			 */
 			if (ret == -ENOENT)
-				ret = btrfs_pin_extent_for_log_replay(trans,
-							log->node->start,
-							log->node->len);
+				ret = btrfs_pin_extent_for_log_replay(trans, log->node);
 			btrfs_put_root(log);
 
 			if (!ret)
-- 
2.41.0

