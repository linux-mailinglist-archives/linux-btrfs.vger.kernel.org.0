Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C396053939E
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345496AbiEaPGy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 11:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345499AbiEaPGw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 11:06:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397D5F61
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 08:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CABFF6133A
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95F2C385A9
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009610;
        bh=cy5M7U5V1/1fK/NOxSLnbQ0mj7pkO54UG0xu9FM3puw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KuQy3DAKX0uVVrij2bukdHIsGo1k08U9JqE35Mx3MnPyKXzQ4Xdfnb78NACLi2Q+j
         o+BNWe+CT+XnqsvLs1LLnHnGqKQE21oT9Zw8jwrHvzaMEumg8W327AqD4cXgni27q8
         6YOTFUMFuHJORJebfCYoqlug4Kejaw3cGVZMQuI9C/9sKRXA7VOYNEFPivPyrFy1d3
         gvNS95c5UANCHcbtIyCEXpjp/u1EG/QaUETfQzrDtCsbhnkTRSUnEbC/168hdSC7/q
         3CQ0sd0pqNI3BHSieJm0ydnYAkj4ZCoVojc/EJyBnzO0xEgdQ74w21BA525e8ZyzfM
         MM8yQtmF9Qz1Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/12] btrfs: balance btree dirty pages and delayed items after clone and dedupe
Date:   Tue, 31 May 2022 16:06:34 +0100
Message-Id: <85eaa822185641693e99a9291175c0a733694937.1654009356.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1654009356.git.fdmanana@suse.com>
References: <cover.1654009356.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When reflinking extents (clone and deduplication), we need to touch the
the btree of the destination inode's subvolume, as well as potentially
create a delayed inode for the destination inode (if it was not created
before). However we are neither balancing the btree dirty pages nor the
delayed items after such operations, so if we have a task that is doing
a long series of clone or deduplication operations, it can result in
accumulation of too many btree dirty pages and delayed items.

So just call btrfs_btree_balance_dirty() after clone and deduplication,
just like we do for every other system call that results on modifying a
btree and adding delayed items.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reflink.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index c39f8b3a5a4a..c0f1456be998 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -5,6 +5,7 @@
 #include "compression.h"
 #include "ctree.h"
 #include "delalloc-space.h"
+#include "disk-io.h"
 #include "reflink.h"
 #include "transaction.h"
 #include "subpage.h"
@@ -650,7 +651,8 @@ static void btrfs_double_mmap_unlock(struct inode *inode1, struct inode *inode2)
 static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 				   struct inode *dst, u64 dst_loff)
 {
-	const u64 bs = BTRFS_I(src)->root->fs_info->sb->s_blocksize;
+	struct btrfs_fs_info *fs_info = BTRFS_I(src)->root->fs_info;
+	const u64 bs = fs_info->sb->s_blocksize;
 	int ret;
 
 	/*
@@ -661,6 +663,8 @@ static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 	ret = btrfs_clone(src, dst, loff, len, ALIGN(len, bs), dst_loff, 1);
 	btrfs_double_extent_unlock(src, loff, dst, dst_loff, len);
 
+	btrfs_btree_balance_dirty(fs_info);
+
 	return ret;
 }
 
@@ -770,6 +774,8 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 				round_down(destoff, PAGE_SIZE),
 				round_up(destoff + len, PAGE_SIZE) - 1);
 
+	btrfs_btree_balance_dirty(fs_info);
+
 	return ret;
 }
 
-- 
2.35.1

