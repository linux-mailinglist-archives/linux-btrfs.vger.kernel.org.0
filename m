Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 118D8142CE4
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 15:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgATOJ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 09:09:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:49106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbgATOJY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 09:09:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 01036B1B3;
        Mon, 20 Jan 2020 14:09:22 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 07/11] btrfs: Make pin_down_extent take btrfs_trans_handle
Date:   Mon, 20 Jan 2020 16:09:14 +0200
Message-Id: <20200120140918.15647-8-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120140918.15647-1-nborisov@suse.com>
References: <20200120140918.15647-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All callers have a reference to a transaction handle so pass it to
pin_down_extent. This is the final step before switching pinned extent
tracking to a per-transaction basis.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-tree.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a9a54b7ae15a..7dcf9217a622 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2586,7 +2586,8 @@ static u64 first_logical_byte(struct btrfs_fs_info *fs_info, u64 search_start)
 	return bytenr;
 }
 
-static int pin_down_extent(struct btrfs_block_group *cache,
+static int pin_down_extent(struct btrfs_trans_handle *trans,
+			   struct btrfs_block_group *cache,
 			   u64 bytenr, u64 num_bytes, int reserved)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
@@ -2618,7 +2619,7 @@ int btrfs_pin_extent(struct btrfs_trans_handle *trans,
 	cache = btrfs_lookup_block_group(trans->fs_info, bytenr);
 	BUG_ON(!cache); /* Logic error */
 
-	pin_down_extent(cache, bytenr, num_bytes, reserved);
+	pin_down_extent(trans, cache, bytenr, num_bytes, reserved);
 
 	btrfs_put_block_group(cache);
 	return 0;
@@ -2645,7 +2646,7 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 	 */
 	btrfs_cache_block_group(cache, 1);
 
-	pin_down_extent(cache, bytenr, num_bytes, 0);
+	pin_down_extent(trans, cache, bytenr, num_bytes, 0);
 
 	/* remove us from the free space cache (if we're there at all) */
 	ret = btrfs_remove_free_space(cache, bytenr, num_bytes);
@@ -3297,7 +3298,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 		cache = btrfs_lookup_block_group(fs_info, buf->start);
 
 		if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
-			pin_down_extent(cache, buf->start, buf->len, 1);
+			pin_down_extent(trans, cache, buf->start, buf->len, 1);
 			btrfs_put_block_group(cache);
 			goto out;
 		}
@@ -4198,7 +4199,7 @@ int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 start,
 		return -ENOSPC;
 	}
 
-	ret = pin_down_extent(cache, start, len, 1);
+	ret = pin_down_extent(trans, cache, start, len, 1);
 	btrfs_put_block_group(cache);
 	return ret;
 }
-- 
2.17.1

