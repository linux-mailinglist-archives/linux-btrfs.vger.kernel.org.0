Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156F1602E6B
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 16:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiJRO1p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 10:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiJRO1o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 10:27:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37113C098A
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:27:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E42E522DB0;
        Tue, 18 Oct 2022 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666103261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ma7epJiZavyyokNsoiIyiciFZvhIGzp3Umb5M/Y06+k=;
        b=R/4k57phQjLUEZUOzWtlTt1RBJ2oufautw+MBbi2yZL+NPUk1uol9wzoD9OaS2V0cqe0AZ
        S97X3Lx1/53ze6znWcSMsy61+RjQ3y1UsPRuc5bP49m9a3MclJqE6kzSnOVzBqN2fWIWid
        67cMy1FkHqgq/o1/nvWz67UUJ0cgJO0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DBE902C141;
        Tue, 18 Oct 2022 14:27:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F427DA79B; Tue, 18 Oct 2022 16:27:33 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/4] btrfs: sink gfp_t parameter to btrfs_qgroup_trace_extent
Date:   Tue, 18 Oct 2022 16:27:33 +0200
Message-Id: <851400b247c547bd420dafa4b7ae78345f4a7ae4.1666103172.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666103172.git.dsterba@suse.com>
References: <cover.1666103172.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All callers pass GFP_NOFS, we can drop the parameter and use it
directly.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/qgroup.c     | 17 +++++++----------
 fs/btrfs/qgroup.h     |  2 +-
 fs/btrfs/relocation.c |  2 +-
 fs/btrfs/tree-log.c   |  3 +--
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9334c3157c22..34f0e4dabe25 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1840,7 +1840,7 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
-			      u64 num_bytes, gfp_t gfp_flag)
+			      u64 num_bytes)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_qgroup_extent_record *record;
@@ -1850,7 +1850,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)
 	    || bytenr == 0 || num_bytes == 0)
 		return 0;
-	record = kzalloc(sizeof(*record), gfp_flag);
+	record = kzalloc(sizeof(*record), GFP_NOFS);
 	if (!record)
 		return -ENOMEM;
 
@@ -1902,8 +1902,7 @@ int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
 
 		num_bytes = btrfs_file_extent_disk_num_bytes(eb, fi);
 
-		ret = btrfs_qgroup_trace_extent(trans, bytenr, num_bytes,
-						GFP_NOFS);
+		ret = btrfs_qgroup_trace_extent(trans, bytenr, num_bytes);
 		if (ret)
 			return ret;
 	}
@@ -2102,12 +2101,11 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 	 * blocks for qgroup accounting.
 	 */
 	ret = btrfs_qgroup_trace_extent(trans, src_path->nodes[dst_level]->start,
-			nodesize, GFP_NOFS);
+					nodesize);
 	if (ret < 0)
 		goto out;
-	ret = btrfs_qgroup_trace_extent(trans,
-			dst_path->nodes[dst_level]->start,
-			nodesize, GFP_NOFS);
+	ret = btrfs_qgroup_trace_extent(trans, dst_path->nodes[dst_level]->start,
+					nodesize);
 	if (ret < 0)
 		goto out;
 
@@ -2391,8 +2389,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 			path->locks[level] = BTRFS_READ_LOCK;
 
 			ret = btrfs_qgroup_trace_extent(trans, child_bytenr,
-							fs_info->nodesize,
-							GFP_NOFS);
+							fs_info->nodesize);
 			if (ret)
 				goto out;
 		}
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 3fb5459c9309..7bffa10589d6 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -321,7 +321,7 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
  * (NULL trans)
  */
 int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
-			      u64 num_bytes, gfp_t gfp_flag);
+			      u64 num_bytes);
 
 /*
  * Inform qgroup to trace all leaf items of data
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 216a4485d914..f5564aa313f5 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -471,7 +471,7 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 	int ret;
 	int err = 0;
 
-	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info, GFP_NOFS);
+	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info);
 	if (!iter)
 		return ERR_PTR(-ENOMEM);
 	path = btrfs_alloc_path();
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 813986e38258..3b44b325aba6 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -747,8 +747,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 		 */
 		ret = btrfs_qgroup_trace_extent(trans,
 				btrfs_file_extent_disk_bytenr(eb, item),
-				btrfs_file_extent_disk_num_bytes(eb, item),
-				GFP_NOFS);
+				btrfs_file_extent_disk_num_bytes(eb, item));
 		if (ret < 0)
 			goto out;
 
-- 
2.37.3

