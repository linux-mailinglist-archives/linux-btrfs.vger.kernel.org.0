Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F55D7A0B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 17:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfJOPmg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 11:42:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:44312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729876AbfJOPme (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 11:42:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 47DFCB526;
        Tue, 15 Oct 2019 15:42:31 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 8/8] btrfs: Streamline btrfs_fs_info::backup_root_index semantics
Date:   Tue, 15 Oct 2019 18:42:24 +0300
Message-Id: <20191015154224.21537-9-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015154224.21537-1-nborisov@suse.com>
References: <20191015154224.21537-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The backup_root_index member stores the index at which  the backup root
should be saved upon next transaction commit. However, there is a
small deviation from this behavior in the form of a check in
backup_super_roots which checks if current root generation equals to the
generation of the previous root. This can trigger in the following
scenario:

slot0: gen-2
slot1: gen-1
slot2: gen
slot3: unused

Now suppose slot3 (which is also the root specified in the super block)
is corrupted hence init_tree_roots chooses to use the backup root at
slot2, meaning read_backup_root will read slot2 and assign the
superblock generation to gen-1. Despite this backup_root_index will
point at slot3 because its init happens in init_backup_root_slot, long
before any parsing of the backup roots occur. Then on next transaction
start, gen-1 will be incremented by 1 making the root's generation
equal gen. Subsequently, on transaction commit the following check
triggers:

  if (btrfs_backup_tree_root_gen(root_backup) ==
           btrfs_header_generation(info->tree_root->node))

This causes the 'next_backup', which is the index at which the backup is
going to be written to, to set to last_backup, which will be slot2.

All of this is a very confusing way of expressing the following
invariant:

 Always write a backup root at the index following the last used backup
 root.

This commit streamlines this logic by setting backup_root_index to the
next index after the one used for mount.
---
 fs/btrfs/disk-io.c | 48 +++++++++-------------------------------------
 1 file changed, 9 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ac899fdb1414..e266949529fb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1786,23 +1786,6 @@ static int find_newest_super_backup(struct btrfs_fs_info *info)
 	return -EINVAL;
 }
 
-/*
- * Initialize backup_root_index with the next available slot, where subsequent
- * transaction commit will store the back up root
- */
-static void init_backup_root_slot(struct btrfs_fs_info *info)
-{
-	int newest_index;
-
-	newest_index = find_newest_super_backup(info);
-	/* if there was garbage in there, just move along */
-	if (newest_index == -EINVAL) {
-		info->backup_root_index = 0;
-	} else {
-		info->backup_root_index = (newest_index + 1) % BTRFS_NUM_BACKUP_ROOTS;
-	}
-}
-
 /*
  * copy all the root pointers into the super backup array.
  * this will bump the backup pointer by one when it is
@@ -1810,22 +1793,8 @@ static void init_backup_root_slot(struct btrfs_fs_info *info)
  */
 static void backup_super_roots(struct btrfs_fs_info *info)
 {
-	int next_backup;
+	int next_backup = info->backup_root_index;
 	struct btrfs_root_backup *root_backup;
-	int last_backup;
-
-	next_backup = info->backup_root_index;
-	last_backup = (next_backup + BTRFS_NUM_BACKUP_ROOTS - 1) %
-		BTRFS_NUM_BACKUP_ROOTS;
-
-	/*
-	 * just overwrite the last backup if we're at the same generation
-	 * this happens only at umount
-	 */
-	root_backup = info->super_for_commit->super_roots + last_backup;
-	if (btrfs_backup_tree_root_gen(root_backup) ==
-	    btrfs_header_generation(info->tree_root->node))
-		next_backup = last_backup;
 
 	root_backup = info->super_for_commit->super_roots + next_backup;
 
@@ -2531,6 +2500,7 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
 
 int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 {
+	int backup_index = find_newest_super_backup(fs_info);
 	struct btrfs_super_block *sb = fs_info->super_copy;
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	bool handle_error = false;
@@ -2557,7 +2527,7 @@ int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 			/* we can't trust the free space cache either */
 			btrfs_set_opt(fs_info->mount_opt, CLEAR_CACHE);
 
-			ret = read_backup_root(fs_info, i);
+			ret = backup_index = read_backup_root(fs_info, i);
 			if (ret < 0)
 				return ret;
 		}
@@ -2604,6 +2574,12 @@ int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 		/* All successful */
 		fs_info->generation = generation;
 		fs_info->last_trans_committed = generation;
+
+		/* Always begin writing backup roots after one being used */
+		if (backup_index < 0)
+			fs_info->backup_root_index = 0;
+		else
+			fs_info->backup_root_index = (backup_index + 1) % BTRFS_NUM_BACKUP_ROOTS;
 		break;
 
 	}
@@ -2898,12 +2874,6 @@ int __cold open_ctree(struct super_block *sb,
 	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_ERROR)
 		set_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state);
 
-	/*
-	 * run through our array of backup supers and setup
-	 * our ring pointer to the oldest one
-	 */
-	init_backup_root_slot(fs_info);
-
 	/*
 	 * In the long term, we'll store the compression type in the super
 	 * block, and it'll be used for per file compression control.
-- 
2.17.1

