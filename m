Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7681C803A
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 04:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgEGCyz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 22:54:55 -0400
Received: from mail.synology.com ([211.23.38.101]:60724 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725827AbgEGCyz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 May 2020 22:54:55 -0400
Received: from localhost.localdomain (unknown [10.17.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id D5B09CE781CF;
        Thu,  7 May 2020 10:54:52 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1588820092; bh=sfu6+rQzpt0IQbGZ1vhyJoRZBIu6nex20g7qBPWzhHg=;
        h=From:To:Cc:Subject:Date;
        b=P8tIcjqirmN6gtV/8QMaSp8CHdX7NJHqZ+qNYVZKL83xQpPv4ZRR/dWkyJCBL169/
         yjr3xIyTNGEElan4C8ujHRn6TeZJ+VEP48MwrNVftlJYxq+eWpBjtcutOwvFK737P/
         YTHUgrfIDIe4kOsXOlS986TpB7ikkc4VoHy68SZs=
From:   robbieko <robbieko@synology.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Robbie Ko <robbieko@synology.com>
Subject: [PATCH v2] Btrfs : improve the speed of compare orphan item and dead roots with tree root when mount
Date:   Thu,  7 May 2020 10:54:40 +0800
Message-Id: <20200507025440.6619-1-robbieko@synology.com>
X-Mailer: git-send-email 2.17.1
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Robbie Ko <robbieko@synology.com>

When mounting, we handle deleted subvol and orphan items.
First, find add orphan roots, then add them to fs_root radix tree.
Second, in tree-root, process each orphan item, skip if it is dead root.

The original algorithm is based on the list of dead_roots,
one by one to visit and check whether the objectid is consistent,
the time complexity is O (n ^ 2).
When processing 50000 deleted subvols, it takes about 120s.

Because btrfs_find_orphan_roots has already ran before us,
and added deleted subvol to fs_roots radix tree.

The fs root will only be removed from the fs_roots radix tree
after the cleaner is processed, and the cleaner will only start
execution after the mount is complete.

btrfs_orphan_cleanup can be called during the whole filesystem mount
lifetime, but only "tree root" will be used in this section of code,
and only mount time will be brought into tree root.

So we can quickly check whether the orphan item is dead root
through the fs_roots radix tree.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
Changes in v2:
- update changelog
---
 fs/btrfs/inode.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 320d1062068d..1becf5c63e5a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3000,18 +3000,16 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 			 * orphan must not get deleted.
 			 * find_dead_roots already ran before us, so if this
 			 * is a snapshot deletion, we should find the root
-			 * in the dead_roots list
+			 * in the fs_roots radix tree.
 			 */
-			spin_lock(&fs_info->trans_lock);
-			list_for_each_entry(dead_root, &fs_info->dead_roots,
-					    root_list) {
-				if (dead_root->root_key.objectid ==
-				    found_key.objectid) {
-					is_dead_root = 1;
-					break;
-				}
-			}
-			spin_unlock(&fs_info->trans_lock);
+
+			spin_lock(&fs_info->fs_roots_radix_lock);
+			dead_root = radix_tree_lookup(&fs_info->fs_roots_radix,
+							 (unsigned long)found_key.objectid);
+			if (dead_root && btrfs_root_refs(&dead_root->root_item) == 0)
+				is_dead_root = 1;
+			spin_unlock(&fs_info->fs_roots_radix_lock);
+
 			if (is_dead_root) {
 				/* prevent this orphan from being found again */
 				key.offset = found_key.objectid - 1;
-- 
2.17.1

