Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE72856AB86
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 21:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbiGGTHn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 15:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbiGGTHn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 15:07:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC3359241
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 12:07:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 33ADF21FFC;
        Thu,  7 Jul 2022 19:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657220861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V7pdIyV28QhIMSgs5FYRGb4ibBS2zg4bQBHAQW/L6uI=;
        b=o2Zl80+PpO4mnC/OD5gVoEBFSww0Kf2AV6donM/62rlxAaBkOjJL1S7mcXeFZxusEMc5rE
        /KW9OEnhXakFYJF5LCgP5mjE7U1HPtqAgJ7Mbijo4MpzkzEDTIWkxAiFSPH1kKlnwI/Pf2
        MBFYV5ms4X1wrAaJ9Y+pVrRRItOeS/w=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2C2252C141;
        Thu,  7 Jul 2022 19:07:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D30B3DA83C; Thu,  7 Jul 2022 21:02:55 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 3/3] btrfs: use enum for btrfs_block_rsv::type
Date:   Thu,  7 Jul 2022 21:02:55 +0200
Message-Id: <7851f095eba6e66d1d3d46741f00ba895836c72d.1657220460.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657220460.git.dsterba@suse.com>
References: <cover.1657220460.git.dsterba@suse.com>
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
For type safety use the enum but make it 8 bits in the structure to save
space.

The structure size is now 48 on release build, making a slight
improvement in structures where it's embedded, like btrfs_fs_info or
btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-rsv.c |  6 +++---
 fs/btrfs/block-rsv.h | 11 ++++++-----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 26c43a6ef5d2..06be0644dd37 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -171,7 +171,7 @@ int btrfs_block_rsv_migrate(struct btrfs_block_rsv *src,
 	return 0;
 }
 
-void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, unsigned short type)
+void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, enum btrfs_rsv_type type)
 {
 	memset(rsv, 0, sizeof(*rsv));
 	spin_lock_init(&rsv->lock);
@@ -180,7 +180,7 @@ void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, unsigned short type)
 
 void btrfs_init_metadata_block_rsv(struct btrfs_fs_info *fs_info,
 				   struct btrfs_block_rsv *rsv,
-				   unsigned short type)
+				   enum btrfs_rsv_type type)
 {
 	btrfs_init_block_rsv(rsv, type);
 	rsv->space_info = btrfs_find_space_info(fs_info,
@@ -188,7 +188,7 @@ void btrfs_init_metadata_block_rsv(struct btrfs_fs_info *fs_info,
 }
 
 struct btrfs_block_rsv *btrfs_alloc_block_rsv(struct btrfs_fs_info *fs_info,
-					      unsigned short type)
+					      enum btrfs_rsv_type type)
 {
 	struct btrfs_block_rsv *block_rsv;
 
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 0702d4087ff6..0c183709be00 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -9,7 +9,7 @@ enum btrfs_reserve_flush_enum;
 /*
  * Types of block reserves
  */
-enum {
+enum btrfs_rsv_type {
 	BTRFS_BLOCK_RSV_GLOBAL,
 	BTRFS_BLOCK_RSV_DELALLOC,
 	BTRFS_BLOCK_RSV_TRANS,
@@ -27,7 +27,8 @@ struct btrfs_block_rsv {
 	spinlock_t lock;
 	bool full;
 	bool failfast;
-	unsigned short type;
+	/* Block reserve type, one of BTRFS_BLOCK_RSV_* */
+	enum btrfs_rsv_type type:8;
 
 	/*
 	 * Qgroup equivalent for @size @reserved
@@ -49,13 +50,13 @@ struct btrfs_block_rsv {
 	u64 qgroup_rsv_reserved;
 };
 
-void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, unsigned short type);
+void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, enum btrfs_rsv_type type);
 void btrfs_init_root_block_rsv(struct btrfs_root *root);
 struct btrfs_block_rsv *btrfs_alloc_block_rsv(struct btrfs_fs_info *fs_info,
-					      unsigned short type);
+					      enum btrfs_rsv_type type);
 void btrfs_init_metadata_block_rsv(struct btrfs_fs_info *fs_info,
 				   struct btrfs_block_rsv *rsv,
-				   unsigned short type);
+				   enum btrfs_rsv_type type);
 void btrfs_free_block_rsv(struct btrfs_fs_info *fs_info,
 			  struct btrfs_block_rsv *rsv);
 int btrfs_block_rsv_add(struct btrfs_fs_info *fs_info,
-- 
2.36.1

