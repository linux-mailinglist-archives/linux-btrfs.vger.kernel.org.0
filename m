Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1DC110E7CB
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 10:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfLBJkV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 04:40:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:47432 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfLBJkU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Dec 2019 04:40:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3F952BB47;
        Mon,  2 Dec 2019 09:40:19 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs: Remove redundant WARN_ON in walk_down_log_tree
Date:   Mon,  2 Dec 2019 11:40:14 +0200
Message-Id: <20191202094015.19444-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202094015.19444-1-nborisov@suse.com>
References: <20191202094015.19444-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

level <0 and level >= BTRFS_MAX_LEVEL are already performed upon
extent buffer read by tree checker in btrfs_check_node.
go. As far as 'level <= 0'  we are guaranteed that level is '> 0'
because the value of level _before_ reading 'next' is larger than 1
(otherwise we wouldn't have executed that code at all) this in turn
guarantees that 'level' after btrfs_read_buffer is 'level - 1' since
we verify this invariant in:

    btrfs_read_buffer
     btree_read_extent_buffer_pages
      btrfs_verify_level_key

This guarantees that level can never be '<= 0' so the warn on is
never triggered.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/tree-log.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 33d329f22534..6ccf260b313e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2673,14 +2673,9 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 	u32 blocksize;
 	int ret = 0;
 
-	WARN_ON(*level < 0);
-	WARN_ON(*level >= BTRFS_MAX_LEVEL);
-
 	while (*level > 0) {
 		struct btrfs_key first_key;
 
-		WARN_ON(*level < 0);
-		WARN_ON(*level >= BTRFS_MAX_LEVEL);
 		cur = path->nodes[*level];
 
 		WARN_ON(btrfs_header_level(cur) != *level);
@@ -2747,7 +2742,6 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 			return ret;
 		}
 
-		WARN_ON(*level <= 0);
 		if (path->nodes[*level-1])
 			free_extent_buffer(path->nodes[*level-1]);
 		path->nodes[*level-1] = next;
@@ -2755,9 +2749,6 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 		path->slots[*level] = 0;
 		cond_resched();
 	}
-	WARN_ON(*level < 0);
-	WARN_ON(*level >= BTRFS_MAX_LEVEL);
-
 	path->slots[*level] = btrfs_header_nritems(path->nodes[*level]);
 
 	cond_resched();
-- 
2.17.1

