Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E53164340
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 12:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBSLXE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 06:23:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbgBSLXE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 06:23:04 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 37FF2B07EE7D5F7B7DE1;
        Wed, 19 Feb 2020 19:22:57 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 19 Feb 2020
 19:22:48 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 1/3] btrfs: remove set but not used variable 'root_owner'
Date:   Wed, 19 Feb 2020 19:21:48 +0800
Message-ID: <20200219112148.16914-1-yukuai3@huawei.com>
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
fs/btrfs/tree-log.c:2698:6: warning: variable ‘root_owner’
set but not used [-Wunused-but-set-variable]
fs/btrfs/tree-log.c: In function ‘walk_up_log_tree’:
fs/btrfs/tree-log.c:2793:6: warning: variable ‘root_owner’
set but not used [-Wunused-but-set-variable]

They are never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 fs/btrfs/tree-log.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5e6b18924e00..156beda01b18 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2695,7 +2695,6 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 				   struct walk_control *wc)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	u64 root_owner;
 	u64 bytenr;
 	u64 ptr_gen;
 	struct extent_buffer *next;
@@ -2721,7 +2720,6 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 		blocksize = fs_info->nodesize;
 
 		parent = path->nodes[*level];
-		root_owner = btrfs_header_owner(parent);
 
 		next = btrfs_find_create_tree_block(fs_info, bytenr);
 		if (IS_ERR(next))
@@ -2790,7 +2788,6 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 				 struct walk_control *wc)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	u64 root_owner;
 	int i;
 	int slot;
 	int ret;
@@ -2809,7 +2806,6 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 			else
 				parent = path->nodes[*level + 1];
 
-			root_owner = btrfs_header_owner(parent);
 			ret = wc->process_func(root, path->nodes[*level], wc,
 				 btrfs_header_generation(path->nodes[*level]),
 				 *level);
-- 
2.17.2

