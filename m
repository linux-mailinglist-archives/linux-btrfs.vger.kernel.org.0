Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F752142CEA
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 15:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgATOJZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 09:09:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:49046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbgATOJW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 09:09:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16A0FB162;
        Mon, 20 Jan 2020 14:09:21 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 03/11] btrfs: Introduce unaccount_log_buffer
Date:   Mon, 20 Jan 2020 16:09:10 +0200
Message-Id: <20200120140918.15647-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120140918.15647-1-nborisov@suse.com>
References: <20200120140918.15647-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function correctly adjusts the reserved bytes occupied by a
log tree extent buffer. It will be used instead of calling
btrfs_pin_reserved_extent.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/tree-log.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index a2bae5c230e1..30e7d96a69fe 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -18,6 +18,8 @@
 #include "compression.h"
 #include "qgroup.h"
 #include "inode-map.h"
+#include "block-group.h"
+#include "space-info.h"
 
 /* magic values for the inode_only field in btrfs_log_inode:
  *
@@ -2659,6 +2661,27 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 	return ret;
 }
 
+static void unaccount_log_buffer(struct btrfs_fs_info *fs_info, u64 start)
+{
+	struct btrfs_block_group *cache;
+
+	cache = btrfs_lookup_block_group(fs_info, start);
+	if (!cache) {
+		btrfs_err(fs_info, "unable to find block group for %llu", start);
+		return;
+	}
+
+	spin_lock(&cache->space_info->lock);
+	spin_lock(&cache->lock);
+	cache->reserved -= fs_info->nodesize;
+	cache->space_info->bytes_reserved -= fs_info->nodesize;
+	spin_unlock(&cache->lock);
+	spin_unlock(&cache->space_info->lock);
+
+	btrfs_put_block_group(cache);
+	return;
+}
+
 static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 				   struct btrfs_root *root,
 				   struct btrfs_path *path, int *level,
-- 
2.17.1

