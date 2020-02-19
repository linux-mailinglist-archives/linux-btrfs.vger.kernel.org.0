Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7717164345
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 12:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgBSLXN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 06:23:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10219 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727046AbgBSLXN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 06:23:13 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D2C95F7484DAC9A56793;
        Wed, 19 Feb 2020 19:23:11 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 19 Feb 2020
 19:23:03 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 2/3] btrfs: remove set but not used variable 'parent'
Date:   Wed, 19 Feb 2020 19:22:03 +0800
Message-ID: <20200219112203.17075-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

fs/btrfs/tree-log.c: In function ‘walk_down_log_tree’:
fs/btrfs/tree-log.c:2702:24: warning: variable ‘parent’
set but not used [-Wunused-but-set-variable]
fs/btrfs/tree-log.c: In function ‘walk_up_log_tree’:
fs/btrfs/tree-log.c:2803:26: warning: variable ‘parent’
set but not used [-Wunused-but-set-variable]

They are never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 fs/btrfs/tree-log.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 156beda01b18..19c107be9ef6 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2699,7 +2699,6 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 	u64 ptr_gen;
 	struct extent_buffer *next;
 	struct extent_buffer *cur;
-	struct extent_buffer *parent;
 	u32 blocksize;
 	int ret = 0;
 
@@ -2719,8 +2718,6 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 		btrfs_node_key_to_cpu(cur, &first_key, path->slots[*level]);
 		blocksize = fs_info->nodesize;
 
-		parent = path->nodes[*level];
-
 		next = btrfs_find_create_tree_block(fs_info, bytenr);
 		if (IS_ERR(next))
 			return PTR_ERR(next);
@@ -2800,12 +2797,6 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 			WARN_ON(*level == 0);
 			return 0;
 		} else {
-			struct extent_buffer *parent;
-			if (path->nodes[*level] == root->node)
-				parent = path->nodes[*level];
-			else
-				parent = path->nodes[*level + 1];
-
 			ret = wc->process_func(root, path->nodes[*level], wc,
 				 btrfs_header_generation(path->nodes[*level]),
 				 *level);
-- 
2.17.2

