Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD40AD7A0D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 17:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfJOPmi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 11:42:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:44324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729592AbfJOPmc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 11:42:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82ACFB522;
        Tue, 15 Oct 2019 15:42:30 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 6/8] btrfs: Remove unused next_root_backup function
Date:   Tue, 15 Oct 2019 18:42:22 +0300
Message-Id: <20191015154224.21537-7-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015154224.21537-1-nborisov@suse.com>
References: <20191015154224.21537-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function is no longer used so just remove it
---
 fs/btrfs/disk-io.c | 50 ----------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 418619dfb76c..bcb21a35d30c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1943,56 +1943,6 @@ static int read_backup_root(struct btrfs_fs_info *fs_info, u8 priority)
 	return backup_index;
 }
 
-/*
- * this copies info out of the root backup array and back into
- * the in-memory super block.  It is meant to help iterate through
- * the array, so you send it the number of backups you've already
- * tried and the last backup index you used.
- *
- * this returns -1 when it has tried all the backups
- */
-static noinline int next_root_backup(struct btrfs_fs_info *info,
-				     struct btrfs_super_block *super,
-				     int *num_backups_tried, int *backup_index)
-{
-	struct btrfs_root_backup *root_backup;
-	int newest = *backup_index;
-
-	if (*num_backups_tried == 0) {
-		newest = find_newest_super_backup(info);
-		if (newest == -1)
-			return -1;
-
-		*backup_index = newest;
-		*num_backups_tried = 1;
-	} else if (*num_backups_tried == BTRFS_NUM_BACKUP_ROOTS) {
-		/* we've tried all the backups, all done */
-		return -1;
-	} else {
-		/* jump to the next oldest backup */
-		newest = (*backup_index + BTRFS_NUM_BACKUP_ROOTS - 1) %
-			BTRFS_NUM_BACKUP_ROOTS;
-		*backup_index = newest;
-		*num_backups_tried += 1;
-	}
-	root_backup = super->super_roots + newest;
-
-	btrfs_set_super_generation(super,
-				   btrfs_backup_tree_root_gen(root_backup));
-	btrfs_set_super_root(super, btrfs_backup_tree_root(root_backup));
-	btrfs_set_super_root_level(super,
-				   btrfs_backup_tree_root_level(root_backup));
-	btrfs_set_super_bytes_used(super, btrfs_backup_bytes_used(root_backup));
-
-	/*
-	 * fixme: the total bytes and num_devices need to match or we should
-	 * need a fsck
-	 */
-	btrfs_set_super_total_bytes(super, btrfs_backup_total_bytes(root_backup));
-	btrfs_set_super_num_devices(super, btrfs_backup_num_devices(root_backup));
-	return 0;
-}
-
 /* helper to cleanup workers */
 static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 {
-- 
2.17.1

