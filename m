Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024A210E7CA
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 10:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfLBJkV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 04:40:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:47436 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbfLBJkU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Dec 2019 04:40:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ECA31BB46;
        Mon,  2 Dec 2019 09:40:18 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs: Remove WARN_ON in walk_log_tree
Date:   Mon,  2 Dec 2019 11:40:13 +0200
Message-Id: <20191202094015.19444-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202094015.19444-1-nborisov@suse.com>
References: <20191202094015.19444-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The log_root passed to walk_log_tree is guaranteed to have its
root_key.objectid always be BTRFS_TREE_LOG_OBJECTID. This is by
merit that all log roots of an ordinary root are allocated in
alloc_log_tree which hard-codes objectid to be BTRFS_TREE_LOG_OBJECTID.

In case walk_log_tree is called for a log tree found by btrfs_read_fs_root
in btrfs_recover_log_trees, that function already ensures
found_key.objectid is BTRFS_TREE_LOG_OBJECTID.

No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/tree-log.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index a30057feff2a..33d329f22534 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2893,8 +2893,6 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 					clear_extent_buffer_dirty(next);
 			}
 
-			WARN_ON(log->root_key.objectid !=
-				BTRFS_TREE_LOG_OBJECTID);
 			ret = btrfs_pin_reserved_extent(fs_info, next->start,
 							next->len);
 			if (ret)
-- 
2.17.1

