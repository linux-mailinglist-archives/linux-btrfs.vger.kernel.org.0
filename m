Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAB8D2D45
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 17:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfJJPGx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 11:06:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:53140 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbfJJPGw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 11:06:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7EC1B1AE;
        Thu, 10 Oct 2019 15:06:50 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/3] btrfs: Jump to correct label on init_root_trees failure
Date:   Thu, 10 Oct 2019 18:06:47 +0300
Message-Id: <20191010150647.20940-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010150647.20940-1-nborisov@suse.com>
References: <20191010150647.20940-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

During the refactoring and introduction of init_root_trees the code
retained the special handling of 'next_root_backup' failure by returning
-ESPIPE from init_root_trees and jumping to fail_block_groups.

This is wrong because next_root_backup doesn't tinker with blockgroups
at all and so any failure in it should be handled the same way as
failures from its sole caller (init_root_trees) - jumping to
fail_tree_roots. This was introduced in the original commit which
implemented backup roots af31f5e5b84b ("Btrfs: add a log of past tree
roots").

Fix it by always jumping to fail_tree_roots. While at it put some
sanity into next_root_backup by returning -EINVAL.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 72580eb6b706..1eed0de4020f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1913,7 +1913,7 @@ static void backup_super_roots(struct btrfs_fs_info *info)
  * the array, so you send it the number of backups you've already
  * tried and the last backup index you used.
  *
- * this returns -1 when it has tried all the backups
+ * Returns EINVAL when it has tried all the backups
  */
 static noinline int next_root_backup(struct btrfs_fs_info *info,
 				     struct btrfs_super_block *super,
@@ -1927,13 +1927,13 @@ static noinline int next_root_backup(struct btrfs_fs_info *info,
 
 		newest = find_newest_super_backup(info, gen);
 		if (newest == -1)
-			return -1;
+			return -EINVAL;
 
 		*backup_index = newest;
 		*num_backups_tried = 1;
 	} else if (*num_backups_tried == BTRFS_NUM_BACKUP_ROOTS) {
 		/* we've tried all the backups, all done */
-		return -1;
+		return -EINVAL;
 	} else {
 		/* jump to the next oldest backup */
 		newest = (*backup_index + BTRFS_NUM_BACKUP_ROOTS - 1) %
@@ -2585,8 +2585,8 @@ int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 
 			ret = next_root_backup(fs_info, sb, &num_backups_tried,
 					       &backup_index);
-			if (ret == -1)
-				return -ESPIPE;
+			if (ret)
+				return ret;
 		}
 		generation = btrfs_super_generation(sb);
 		level = btrfs_super_root_level(sb);
@@ -3067,11 +3067,8 @@ int __cold open_ctree(struct super_block *sb,
 	}
 
 	ret = init_tree_roots(fs_info);
-	if (ret) {
-		if (ret == -ESPIPE)
-			goto fail_block_groups;
+	if (ret)
 		goto fail_tree_roots;
-	}
 
 	ret = btrfs_verify_dev_extents(fs_info);
 	if (ret) {
-- 
2.17.1

