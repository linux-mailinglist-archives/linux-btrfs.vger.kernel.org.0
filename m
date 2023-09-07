Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADD4797F26
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjIGXQH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjIGXQG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:16:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88524BD
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:16:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4C6BC210DB;
        Thu,  7 Sep 2023 23:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694128560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XhYmZ4Sc1I3dj94oqUdNgk/UdnRbTB0N1TAZfIG3dp8=;
        b=o4fg4mEY0p8OxaIknRMB4GlsxQA1iOwXtEMJWzzfUUCrbb/l05cf9ibQfjSleR+zH7hGYl
        TqCPBoBbXTWRtGQB9SAcATJ7DNI4dAheD9cjf4nhxtqmWPZ4a0i16/3P40KJ9d/+6Dus1a
        zGnt6wi6eu7wXkV7we9rLF5EYqPk2J4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 40C7C2C142;
        Thu,  7 Sep 2023 23:16:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 72943DA8C5; Fri,  8 Sep 2023 01:09:29 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 04/10] btrfs: reduce parameters of btrfs_pin_reserved_extent
Date:   Fri,  8 Sep 2023 01:09:29 +0200
Message-ID: <339252a0cd7e42cbd8f527601b3c9e7f0d565231.1694126893.git.dsterba@suse.com>
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

There is only one caller of btrfs_pin_reserved_extent that expands the
parameters to extent buffer members. We can simply pass the extent
buffer instead.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 10 +++++-----
 fs/btrfs/extent-tree.h |  3 ++-
 fs/btrfs/tree-log.c    |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5ef4e852ae2e..98d97c97ab8c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4560,20 +4560,20 @@ int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 start,
-			      u64 len)
+int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans,
+			      const struct extent_buffer *eb)
 {
 	struct btrfs_block_group *cache;
 	int ret = 0;
 
-	cache = btrfs_lookup_block_group(trans->fs_info, start);
+	cache = btrfs_lookup_block_group(trans->fs_info, eb->start);
 	if (!cache) {
 		btrfs_err(trans->fs_info, "unable to find block group for %llu",
-			  start);
+			  eb->start);
 		return -ENOSPC;
 	}
 
-	ret = pin_down_extent(trans, cache, start, len, 1);
+	ret = pin_down_extent(trans, cache, eb->start, eb->len, 1);
 	btrfs_put_block_group(cache);
 	return ret;
 }
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 2109c72aea2a..c56f616dcd1b 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -139,7 +139,8 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref);
 
 int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 			       u64 start, u64 len, int delalloc);
-int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 start, u64 len);
+int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans,
+			      const struct extent_buffer *eb);
 int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
 int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans, struct btrfs_ref *generic_ref);
 int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref,
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 1834a6ec12bd..4f85c435b793 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2574,7 +2574,7 @@ static int clean_log_buffer(struct btrfs_trans_handle *trans,
 	btrfs_tree_unlock(eb);
 
 	if (trans) {
-		ret = btrfs_pin_reserved_extent(trans, eb->start, eb->len);
+		ret = btrfs_pin_reserved_extent(trans, eb);
 		if (ret)
 			return ret;
 		btrfs_redirty_list_add(trans->transaction, eb);
-- 
2.41.0

