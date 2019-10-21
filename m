Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3767EDE844
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 11:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfJUJiH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 05:38:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:37932 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727469AbfJUJiG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 05:38:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D1FCB901
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 09:38:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: disk-io: Handle backup root more correctly
Date:   Mon, 21 Oct 2019 17:37:54 +0800
Message-Id: <20191021093755.56835-3-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021093755.56835-1-wqu@suse.com>
References: <20191021093755.56835-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Current backup root handling has extra check on super generation:

static int find_best_backup_root(struct btrfs_super_block *super)
{
	u64 orig_gen = btrfs_super_generation(super);
...
		if (btrfs_backup_tree_root_gen(backup) != orig_gen &&
 		    btrfs_backup_tree_root_gen(backup) > gen) {
 			best_index = i;
 			gen = btrfs_backup_tree_root_gen(backup);

This check is to ensure we don't get backup root with current
generation, but it can still return backup root newer than current root.

So for the following super:
generation:		10
backup[0] generation:	8
backup[1] generation:	9
backup[2] generation:	10
backup[3] generation:	11

If we're calling find_best_backup_root() then we can pick up slot 3
which is newer than current generation.

This patch introduce a new parameter for find_best_backup_root() to
specify the max generation.

So with above superblock, calling find_best_backup_root(sb, sb_gen - 1)
will ensure we get slot 1, other than slot 3.
This also affects how we update backup roots.

Furthermore, due to the change in the return value,
find_best_backup_root() can now return -1 to indicates error (no valid
backup found), so change callers to co-operate.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 disk-io.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/disk-io.c b/disk-io.c
index be44eead5cef..36db1be264cd 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -845,17 +845,22 @@ int btrfs_check_fs_compatibility(struct btrfs_super_block *sb,
 	return 0;
 }
 
-static int find_best_backup_root(struct btrfs_super_block *super)
+/*
+ * Find the newest backup slot whose generation <= @max_gen
+ *
+ * Can return <0 for error, indicating no valid backup slot for @max_gen.
+ */
+static int find_best_backup_root(struct btrfs_super_block *super,
+				 u64 max_gen)
 {
 	struct btrfs_root_backup *backup;
-	u64 orig_gen = btrfs_super_generation(super);
 	u64 gen = 0;
-	int best_index = 0;
+	int best_index = -1;
 	int i;
 
 	for (i = 0; i < BTRFS_NUM_BACKUP_ROOTS; i++) {
 		backup = super->super_roots + i;
-		if (btrfs_backup_tree_root_gen(backup) != orig_gen &&
+		if (btrfs_backup_tree_root_gen(backup) <= max_gen &&
 		    btrfs_backup_tree_root_gen(backup) > gen) {
 			best_index = i;
 			gen = btrfs_backup_tree_root_gen(backup);
@@ -908,9 +913,10 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 		root_tree_bytenr = btrfs_super_root(sb);
 	} else if (flags & OPEN_CTREE_BACKUP_ROOT) {
 		struct btrfs_root_backup *backup;
-		int index = find_best_backup_root(sb);
-		if (index >= BTRFS_NUM_BACKUP_ROOTS) {
-			fprintf(stderr, "Invalid backup root number\n");
+		int index = find_best_backup_root(sb,
+					btrfs_super_generation(sb) - 1);
+		if (index < 0) {
+			error("can't find any valid backup root");
 			return -EIO;
 		}
 		backup = fs_info->super_copy->super_roots + index;
@@ -1707,10 +1713,22 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 static void backup_super_roots(struct btrfs_fs_info *info)
 {
 	struct btrfs_root_backup *root_backup;
+	u64 current_gen = btrfs_super_generation(info->super_copy);
 	int next_backup;
 	int last_backup;
 
-	last_backup = find_best_backup_root(info->super_copy);
+	last_backup = find_best_backup_root(info->super_copy, current_gen - 1);
+	/* No older backups, retry current gen */
+	if (last_backup < 0) {
+		last_backup = find_best_backup_root(info->super_copy,
+						    current_gen);
+		/*
+		 * Still failed, means no valid backup root at all, restart
+		 * from slot 0.
+		 */
+		if (last_backup < 0)
+			last_backup = 0;
+	}
 	next_backup = (last_backup + 1) % BTRFS_NUM_BACKUP_ROOTS;
 
 	/* just overwrite the last backup if we're at the same generation */
-- 
2.23.0

