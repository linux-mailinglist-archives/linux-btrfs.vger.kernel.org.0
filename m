Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F97606683
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 18:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiJTQ7j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 12:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJTQ7i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 12:59:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3030B65B2
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 09:59:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1B7351FD99;
        Thu, 20 Oct 2022 16:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666285171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EsSoisrj4KYeLpzeoKdv5B0NFeSAsj9M9iUs2iUuJMQ=;
        b=brLu7dSzytWrZZQw+HdVCgr+O/NK277ObbI4G8yCQD3cq/f0fNMuRr8e7fkVXVKNZSc1VT
        1PE1jXjPhsD0sAUeNAwhr91n4SUwfbF6oIgqoyI15Jz36MBgBebiRNKHCsqDzFn1jYsXO7
        c0nmPg1mk2P1N+QMxIbr5KUHesp2VnU=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1261E2C141;
        Thu, 20 Oct 2022 16:59:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6E354DA79B; Thu, 20 Oct 2022 18:59:21 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 2/4] btrfs: sink gfp_t parameter to btrfs_qgroup_trace_extent
Date:   Thu, 20 Oct 2022 18:59:21 +0200
Message-Id: <fd15ab8442691d19b624ad50fd5a07a0a7baa7c0.1666285085.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666285085.git.dsterba@suse.com>
References: <cover.1666285085.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All callers pass GFP_NOFS, we can drop the parameter and use it
directly.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/qgroup.c   | 17 +++++++----------
 fs/btrfs/qgroup.h   |  2 +-
 fs/btrfs/tree-log.c |  3 +--
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1e42404afc8d..9aa6c19f0cde 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1842,7 +1842,7 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
-			      u64 num_bytes, gfp_t gfp_flag)
+			      u64 num_bytes)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_qgroup_extent_record *record;
@@ -1852,7 +1852,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)
 	    || bytenr == 0 || num_bytes == 0)
 		return 0;
-	record = kzalloc(sizeof(*record), gfp_flag);
+	record = kzalloc(sizeof(*record), GFP_NOFS);
 	if (!record)
 		return -ENOMEM;
 
@@ -1904,8 +1904,7 @@ int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
 
 		num_bytes = btrfs_file_extent_disk_num_bytes(eb, fi);
 
-		ret = btrfs_qgroup_trace_extent(trans, bytenr, num_bytes,
-						GFP_NOFS);
+		ret = btrfs_qgroup_trace_extent(trans, bytenr, num_bytes);
 		if (ret)
 			return ret;
 	}
@@ -2104,12 +2103,11 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
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
 
@@ -2393,8 +2391,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
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
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 823fbd826944..e1a47e0561aa 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -749,8 +749,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
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

