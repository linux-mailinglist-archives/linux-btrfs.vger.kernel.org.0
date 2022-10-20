Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97483606681
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 18:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJTQ7j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 12:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiJTQ7h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 12:59:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6862529B
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 09:59:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 00C131FD5A;
        Thu, 20 Oct 2022 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666285169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztr6gn6YOSbEfYJNImi0pSX//isCJUu0pRmut6Xacu4=;
        b=Ec/3fOZc9avyj58N9FB2aAZ3Oa2KV4kvxfxXt2dkFGNhvBXM5trEMU1HDHqIVLsj7v5N6a
        E9ZqGwjdUIU+LVWNlfh8V7E5HkY4O207JpduQOOTBXCvQgXzA1KzQ2fpXX6s7xKcFLHDDL
        xfzZpxNQyIMg4w5fN3kseUOXfO/8dL4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EA5BE2C141;
        Thu, 20 Oct 2022 16:59:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 53F34DA79B; Thu, 20 Oct 2022 18:59:19 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 1/4] btrfs: sink gfp_t parameter to btrfs_backref_iter_alloc
Date:   Thu, 20 Oct 2022 18:59:19 +0200
Message-Id: <0c27f1de9f5179ea393d34ec1cbac60931492ab4.1666285085.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666285085.git.dsterba@suse.com>
References: <cover.1666285085.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's only one caller that passes GFP_NOFS, we can drop the parameter
an use the flags directly.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c    | 5 ++---
 fs/btrfs/backref.h    | 3 +--
 fs/btrfs/relocation.c | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 719077ac9d03..c55abd8574ee 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2636,12 +2636,11 @@ void free_ipath(struct inode_fs_paths *ipath)
 	kfree(ipath);
 }
 
-struct btrfs_backref_iter *btrfs_backref_iter_alloc(
-		struct btrfs_fs_info *fs_info, gfp_t gfp_flag)
+struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_backref_iter *ret;
 
-	ret = kzalloc(sizeof(*ret), gfp_flag);
+	ret = kzalloc(sizeof(*ret), GFP_NOFS);
 	if (!ret)
 		return NULL;
 
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index fa3c9cbf9ae7..2dd68f87dca5 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -156,8 +156,7 @@ struct btrfs_backref_iter {
 	u32 end_ptr;
 };
 
-struct btrfs_backref_iter *btrfs_backref_iter_alloc(
-		struct btrfs_fs_info *fs_info, gfp_t gfp_flag);
+struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info);
 
 static inline void btrfs_backref_iter_free(struct btrfs_backref_iter *iter)
 {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3d0a63465a74..77d03dce2521 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -473,7 +473,7 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 	int ret;
 	int err = 0;
 
-	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info, GFP_NOFS);
+	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info);
 	if (!iter)
 		return ERR_PTR(-ENOMEM);
 	path = btrfs_alloc_path();
-- 
2.37.3

