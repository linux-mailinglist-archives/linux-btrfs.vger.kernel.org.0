Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49EAAD7A04
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 17:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfJOPma (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 11:42:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:44288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727786AbfJOPma (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 11:42:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9620DB51F;
        Tue, 15 Oct 2019 15:42:28 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/8] btrfs: Cleanup and simplify find_newest_super_backup
Date:   Tue, 15 Oct 2019 18:42:17 +0300
Message-Id: <20191015154224.21537-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015154224.21537-1-nborisov@suse.com>
References: <20191015154224.21537-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Backup roots are always written in a circular manner. By definition we
can only ever have 1 backup root whose generation equals to that of the
superblock. Hence, the 'if' in the for loop will trigger at most once.
This is sufficient to return the newest backup root.

Furthermore thew newest_gen parameter is always set to the generation
of the superblock. This value can be obtained from the fs_info.

This patch removes the unnecessary code dealing with the wraparound
case and makes 'newest_gen' a local variable.
---
 fs/btrfs/disk-io.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index de5696023391..8b1f6385023d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1761,18 +1761,18 @@ static int transaction_kthread(void *arg)
 }
 
 /*
- * this will find the highest generation in the array of
+ * This will find the highest generation in the array of
  * root backups.  The index of the highest array is returned,
- * or -1 if we can't find anything.
+ * or -EINVAL if we can't find anything.
  *
  * We check to make sure the array is valid by comparing the
  * generation of the latest  root in the array with the generation
  * in the super block.  If they don't match we pitch it.
  */
-static int find_newest_super_backup(struct btrfs_fs_info *info, u64 newest_gen)
+static int find_newest_super_backup(struct btrfs_fs_info *info)
 {
+	u64 newest_gen = btrfs_super_generation(info->super_copy);
 	u64 cur;
-	int newest_index = -1;
 	struct btrfs_root_backup *root_backup;
 	int i;
 
@@ -1780,17 +1780,10 @@ static int find_newest_super_backup(struct btrfs_fs_info *info, u64 newest_gen)
 		root_backup = info->super_copy->super_roots + i;
 		cur = btrfs_backup_tree_root_gen(root_backup);
 		if (cur == newest_gen)
-			newest_index = i;
+			return i;
 	}
 
-	/* check to see if we actually wrapped around */
-	if (newest_index == BTRFS_NUM_BACKUP_ROOTS - 1) {
-		root_backup = info->super_copy->super_roots;
-		cur = btrfs_backup_tree_root_gen(root_backup);
-		if (cur == newest_gen)
-			newest_index = 0;
-	}
-	return newest_index;
+	return -EINVAL;
 }
 
 
@@ -1802,11 +1795,11 @@ static int find_newest_super_backup(struct btrfs_fs_info *info, u64 newest_gen)
 static void find_oldest_super_backup(struct btrfs_fs_info *info,
 				     u64 newest_gen)
 {
-	int newest_index = -1;
+	int newest_index;
 
-	newest_index = find_newest_super_backup(info, newest_gen);
+	newest_index = find_newest_super_backup(info);
 	/* if there was garbage in there, just move along */
-	if (newest_index == -1) {
+	if (newest_index == -EINVAL) {
 		info->backup_root_index = 0;
 	} else {
 		info->backup_root_index = (newest_index + 1) % BTRFS_NUM_BACKUP_ROOTS;
@@ -1923,9 +1916,7 @@ static noinline int next_root_backup(struct btrfs_fs_info *info,
 	int newest = *backup_index;
 
 	if (*num_backups_tried == 0) {
-		u64 gen = btrfs_super_generation(super);
-
-		newest = find_newest_super_backup(info, gen);
+		newest = find_newest_super_backup(info);
 		if (newest == -1)
 			return -1;
 
-- 
2.17.1

