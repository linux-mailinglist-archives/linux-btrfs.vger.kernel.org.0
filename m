Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977F76C2FF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCULOo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCULOj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436CD28D33
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2206DB815B3
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E1BC4339B
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397252;
        bh=CW/m5oNvzysXc3pZlTivNIAzB60URx4rTf9tGLKvHBI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CJ+MG5P9KzFQV9HZfcPF7CWviMHYpddS/sJhYhx6KPdIHGA+gTkrq+EDkY2ehfUMs
         IOi2vOuLp5z1WRGPHMCnYY1O0Cv63ImUd4E8zjuCEC5GGgF0yCf6bEJi7FLhtoN24Z
         Vn2XSIFiMaL/3Bat3NDwPOLtPqBJg/j1DNuOVg2fTlx7e1YekFxi8efTUH54mBoYRA
         kYni8H4r9/K91ZSH836PyaJhrNqOzUgdhKZQSWaQEF5ULd1RInJLkDb7yU6Uvzrv7T
         keKwbpiUjHLfuL+q6FHt32Dpn4SJ8Imb3u8us0ZcXqBsrOFIpPtKjsmLZgWTCaWOHG
         AMJeP3Gby4/pg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/24] btrfs: remove bytes_used argument from btrfs_make_block_group()
Date:   Tue, 21 Mar 2023 11:13:45 +0000
Message-Id: <84070b134bcaab995abb46437568fdb1a5282171.1679326432.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The only caller of btrfs_make_block_group() always passes 0 as the value
for the bytes_used argument, so remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 7 ++-----
 fs/btrfs/block-group.h | 2 +-
 fs/btrfs/volumes.c     | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 46a8ca24afaa..bb6024c17db4 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2672,7 +2672,7 @@ static u64 calculate_global_root_id(struct btrfs_fs_info *fs_info, u64 offset)
 }
 
 struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *trans,
-						 u64 bytes_used, u64 type,
+						 u64 type,
 						 u64 chunk_offset, u64 size)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -2687,7 +2687,6 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 
 	cache->length = size;
 	set_free_space_tree_thresholds(cache);
-	cache->used = bytes_used;
 	cache->flags = type;
 	cache->cached = BTRFS_CACHE_FINISHED;
 	cache->global_root_id = calculate_global_root_id(fs_info, cache->start);
@@ -2738,9 +2737,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 
 #ifdef CONFIG_BTRFS_DEBUG
 	if (btrfs_should_fragment_free_space(cache)) {
-		u64 new_bytes_used = size - bytes_used;
-
-		cache->space_info->bytes_used += new_bytes_used >> 1;
+		cache->space_info->bytes_used += size >> 1;
 		fragment_free_space(cache);
 	}
 #endif
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 6e4a0b429ac3..db729ad7315b 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -302,7 +302,7 @@ void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info);
 void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg);
 int btrfs_read_block_groups(struct btrfs_fs_info *info);
 struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *trans,
-						 u64 bytes_used, u64 type,
+						 u64 type,
 						 u64 chunk_offset, u64 size);
 void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans);
 int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 93bc45001e68..5da6f5167046 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5421,7 +5421,7 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 	}
 	write_unlock(&em_tree->lock);
 
-	block_group = btrfs_make_block_group(trans, 0, type, start, ctl->chunk_size);
+	block_group = btrfs_make_block_group(trans, type, start, ctl->chunk_size);
 	if (IS_ERR(block_group))
 		goto error_del_extent;
 
-- 
2.34.1

