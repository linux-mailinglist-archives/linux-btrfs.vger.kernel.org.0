Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C41105209
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 13:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKUMDi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 07:03:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:52398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfKUMDi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 07:03:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0014B19D;
        Thu, 21 Nov 2019 12:03:37 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs: Open code __btrfs_free_reserved_extent in btrfs_free_reserved_extent
Date:   Thu, 21 Nov 2019 14:03:30 +0200
Message-Id: <20191121120331.29070-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121120331.29070-1-nborisov@suse.com>
References: <20191121120331.29070-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

__btrfs_free_reserved_extent performs 2 entirely different operations
depending on whether its 'pin' argument is true or false. This patch
lifts the 2nd case (pin is false) into it's sole caller
btrfs_free_reserved_extent. No semantics changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-tree.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 613c7bbf5cbd..dae6f8d07852 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4164,17 +4164,7 @@ static int __btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 		return -ENOSPC;
 	}
 
-	if (pin) {
-		ret = pin_down_extent(cache, start, len, 1);
-		if (ret)
-			goto out;
-	} else {
-		btrfs_add_free_space(cache, start, len);
-		btrfs_free_reserved_bytes(cache, len, delalloc);
-		trace_btrfs_reserved_extent_free(fs_info, start, len);
-	}
-
-out:
+	ret = pin_down_extent(cache, start, len, 1);
 	btrfs_put_block_group(cache);
 	return ret;
 }
@@ -4182,7 +4172,21 @@ static int __btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 			       u64 start, u64 len, int delalloc)
 {
-	return __btrfs_free_reserved_extent(fs_info, start, len, 0, delalloc);
+	struct btrfs_block_group *cache;
+
+	cache = btrfs_lookup_block_group(fs_info, start);
+	if (!cache) {
+		btrfs_err(fs_info, "Unable to find block group for %llu",
+			  start);
+		return -ENOSPC;
+	}
+
+	btrfs_add_free_space(cache, start, len);
+	btrfs_free_reserved_bytes(cache, len, delalloc);
+	trace_btrfs_reserved_extent_free(fs_info, start, len);
+
+	btrfs_put_block_group(cache);
+	return 0;
 }
 
 int btrfs_free_and_pin_reserved_extent(struct btrfs_fs_info *fs_info,
-- 
2.17.1

