Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC36D7A08
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 17:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfJOPmc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 11:42:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:44306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728991AbfJOPmb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 11:42:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C721B517;
        Tue, 15 Oct 2019 15:42:29 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/8] btrfs: Add read_backup_root
Date:   Tue, 15 Oct 2019 18:42:19 +0300
Message-Id: <20191015154224.21537-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015154224.21537-1-nborisov@suse.com>
References: <20191015154224.21537-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function will replace next_root_backup with a much saner/cleaner
interface.
---
 fs/btrfs/disk-io.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d51f76abde45..9ed3b40aa10d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1899,6 +1899,50 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	       sizeof(*root_backup) * BTRFS_NUM_BACKUP_ROOTS);
 }
 
+/*
+ * read_backup_root - Reads a backup root based on the passed priority. Prio 0
+ * is the newest, prio 1/2/3 are 2nd newest/3rd newest/4th (oldest) backup roots
+ *
+ * fs_info - filesystem whose backup roots need to be read
+ * priority - priority of backup root required
+ *
+ * Returns backup root index on success and -EINVAL otherwise.
+ */
+static int read_backup_root(struct btrfs_fs_info *fs_info, u8 priority)
+{
+	int backup_index = find_newest_super_backup(fs_info);
+	struct btrfs_super_block *super = fs_info->super_copy;
+	struct btrfs_root_backup *root_backup;
+
+	if (priority < BTRFS_NUM_BACKUP_ROOTS && backup_index >= 0) {
+		if (priority == 0)
+			return backup_index;
+
+		backup_index = (backup_index + BTRFS_NUM_BACKUP_ROOTS - priority) %
+			BTRFS_NUM_BACKUP_ROOTS;
+	} else {
+		return -EINVAL;
+	}
+
+	root_backup = super->super_roots + backup_index;
+
+	btrfs_set_super_generation(super,
+				   btrfs_backup_tree_root_gen(root_backup));
+	btrfs_set_super_root(super, btrfs_backup_tree_root(root_backup));
+	btrfs_set_super_root_level(super,
+				   btrfs_backup_tree_root_level(root_backup));
+	btrfs_set_super_bytes_used(super, btrfs_backup_bytes_used(root_backup));
+
+	/*
+	 * fixme: the total bytes and num_devices need to match or we should
+	 * need a fsck
+	 */
+	btrfs_set_super_total_bytes(super, btrfs_backup_total_bytes(root_backup));
+	btrfs_set_super_num_devices(super, btrfs_backup_num_devices(root_backup));
+
+	return backup_index;
+}
+
 /*
  * this copies info out of the root backup array and back into
  * the in-memory super block.  It is meant to help iterate through
-- 
2.17.1

