Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0697AB9EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 21:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjIVTRP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 15:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjIVTRO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 15:17:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0926A3
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 12:17:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9D0CE1FE33;
        Fri, 22 Sep 2023 19:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695410227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YOXh5K+JZEgsMnRMob8VwviO9Zjo3VWQfo86OSJO4yE=;
        b=UOfopOtsbygOubabvr/IuPR8XnP/kFMYUqmYpMKTzAbtc8j8JbhBtwSKRXnZmLyiBcQGXB
        MTSi5UCHfXt9W+prt/T19JEPGMAS0HfE843NzmV59qwKe/0zUEKjkXPtUeiWaooioUzVcg
        xTSqQaijCSb9p7HKCr4CT4t9YhNZECY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 82CA02C142;
        Fri, 22 Sep 2023 19:17:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 68650DA832; Fri, 22 Sep 2023 21:10:33 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/5] btrfs: remove unused alloc and free helpers for block group reserves
Date:   Fri, 22 Sep 2023 21:10:33 +0200
Message-ID: <d78707a5750fa78939eb6509cabf962d1ab8e6ca.1695408280.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695408280.git.dsterba@suse.com>
References: <cover.1695408280.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are no remaining users of btrfs_alloc_block_rsv() and
btrfs_free_block_rsv() after conversions to on-stack or embedded
variables, so remove them.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-rsv.c | 22 ----------------------
 fs/btrfs/block-rsv.h |  4 ----
 2 files changed, 26 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index ceb5f586a2d5..9cb32301e92a 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -190,28 +190,6 @@ void btrfs_init_metadata_block_rsv(struct btrfs_fs_info *fs_info,
 					    BTRFS_BLOCK_GROUP_METADATA);
 }
 
-struct btrfs_block_rsv *btrfs_alloc_block_rsv(struct btrfs_fs_info *fs_info,
-					      enum btrfs_rsv_type type)
-{
-	struct btrfs_block_rsv *block_rsv;
-
-	block_rsv = kmalloc(sizeof(*block_rsv), GFP_NOFS);
-	if (!block_rsv)
-		return NULL;
-
-	btrfs_init_metadata_block_rsv(fs_info, block_rsv, type);
-	return block_rsv;
-}
-
-void btrfs_free_block_rsv(struct btrfs_fs_info *fs_info,
-			  struct btrfs_block_rsv *rsv)
-{
-	if (!rsv)
-		return;
-	btrfs_block_rsv_release(fs_info, rsv, (u64)-1, NULL);
-	kfree(rsv);
-}
-
 int btrfs_block_rsv_add(struct btrfs_fs_info *fs_info,
 			struct btrfs_block_rsv *block_rsv, u64 num_bytes,
 			enum btrfs_reserve_flush_enum flush)
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index b0bd12b8652f..f1f52a21682a 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -53,13 +53,9 @@ struct btrfs_block_rsv {
 
 void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, enum btrfs_rsv_type type);
 void btrfs_init_root_block_rsv(struct btrfs_root *root);
-struct btrfs_block_rsv *btrfs_alloc_block_rsv(struct btrfs_fs_info *fs_info,
-					      enum btrfs_rsv_type type);
 void btrfs_init_metadata_block_rsv(struct btrfs_fs_info *fs_info,
 				   struct btrfs_block_rsv *rsv,
 				   enum btrfs_rsv_type type);
-void btrfs_free_block_rsv(struct btrfs_fs_info *fs_info,
-			  struct btrfs_block_rsv *rsv);
 int btrfs_block_rsv_add(struct btrfs_fs_info *fs_info,
 			struct btrfs_block_rsv *block_rsv, u64 num_bytes,
 			enum btrfs_reserve_flush_enum flush);
-- 
2.41.0

