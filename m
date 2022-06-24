Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2194559AF8
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiFXOGw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 10:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiFXOGh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 10:06:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBCA4F1E3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 07:06:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 60C8A21A8F;
        Fri, 24 Jun 2022 14:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656079578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37Zi2HMq0UYlxwNZ4+aL5bUyIa1yJEaH4hskYHOkAsA=;
        b=bEfRmy1+miVCEJzvd63c0ItAz7mRVsiITBQng7YOx6FFTE15ZDvNvrNMESo9F4nCPdPPCs
        uDASBs6u2ub5ftLwTloC0dIMsJCq5BN/dsCZ9IO3H+Wlg1vKDVNQwGJovq7d03XQLP/iYh
        2ozq9D/vzaty29LzvL4mQ/UrQ/bPaq0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 592B62C24A;
        Fri, 24 Jun 2022 14:06:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BD6CBDA82F; Fri, 24 Jun 2022 16:01:40 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/3] btrfs: use u8 type for btrfs_block_rsv::type
Date:   Fri, 24 Jun 2022 16:01:40 +0200
Message-Id: <2ff62613189d8f58f8da90a1558ad5726172057b.1656079178.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656079178.git.dsterba@suse.com>
References: <cover.1656079178.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The number of block group reserve types BTRFS_BLOCK_RSV_* is small and
fits to u8 and there's enough left in case we want to add more.

The structure size is now 48 on release build, making a slight
improvement in structures where it's embedded, like btrfs_fs_info or
btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-rsv.c |  7 +++----
 fs/btrfs/block-rsv.h | 10 +++++-----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 26c43a6ef5d2..5384c6ae8fe8 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -171,7 +171,7 @@ int btrfs_block_rsv_migrate(struct btrfs_block_rsv *src,
 	return 0;
 }
 
-void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, unsigned short type)
+void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, u8 type)
 {
 	memset(rsv, 0, sizeof(*rsv));
 	spin_lock_init(&rsv->lock);
@@ -179,8 +179,7 @@ void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, unsigned short type)
 }
 
 void btrfs_init_metadata_block_rsv(struct btrfs_fs_info *fs_info,
-				   struct btrfs_block_rsv *rsv,
-				   unsigned short type)
+				   struct btrfs_block_rsv *rsv, u8 type)
 {
 	btrfs_init_block_rsv(rsv, type);
 	rsv->space_info = btrfs_find_space_info(fs_info,
@@ -188,7 +187,7 @@ void btrfs_init_metadata_block_rsv(struct btrfs_fs_info *fs_info,
 }
 
 struct btrfs_block_rsv *btrfs_alloc_block_rsv(struct btrfs_fs_info *fs_info,
-					      unsigned short type)
+					      u8 type)
 {
 	struct btrfs_block_rsv *block_rsv;
 
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 0702d4087ff6..bb449c75ee4c 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -27,7 +27,8 @@ struct btrfs_block_rsv {
 	spinlock_t lock;
 	bool full;
 	bool failfast;
-	unsigned short type;
+	/* Block reserve type, one of BTRFS_BLOCK_RSV_* */
+	u8 type;
 
 	/*
 	 * Qgroup equivalent for @size @reserved
@@ -49,13 +50,12 @@ struct btrfs_block_rsv {
 	u64 qgroup_rsv_reserved;
 };
 
-void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, unsigned short type);
+void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, u8 type);
 void btrfs_init_root_block_rsv(struct btrfs_root *root);
 struct btrfs_block_rsv *btrfs_alloc_block_rsv(struct btrfs_fs_info *fs_info,
-					      unsigned short type);
+					      u8 type);
 void btrfs_init_metadata_block_rsv(struct btrfs_fs_info *fs_info,
-				   struct btrfs_block_rsv *rsv,
-				   unsigned short type);
+				   struct btrfs_block_rsv *rsv, u8 type);
 void btrfs_free_block_rsv(struct btrfs_fs_info *fs_info,
 			  struct btrfs_block_rsv *rsv);
 int btrfs_block_rsv_add(struct btrfs_fs_info *fs_info,
-- 
2.36.1

