Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6930DD7A0A
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 17:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfJOPmf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 11:42:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:44330 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727429AbfJOPmc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 11:42:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF861B523;
        Tue, 15 Oct 2019 15:42:30 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 7/8] btrfs: Rename find_oldest_super_backup to init_backup_root_slot
Date:   Tue, 15 Oct 2019 18:42:23 +0300
Message-Id: <20191015154224.21537-8-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015154224.21537-1-nborisov@suse.com>
References: <20191015154224.21537-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The old name name was an awful misnomer because it didn't really find
the oldest super backup per se but rather its slot. For example if we
have:

slot0: gen - 2
slot1: gen - 1
slot2: gen
slot3: empty

init_backup_root_slot will return slot3 and not slot0.

The new name is more appropriate since the function doesn't care whether
there is a valid backup in the returned slot or not.
---
 fs/btrfs/disk-io.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index bcb21a35d30c..ac899fdb1414 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1786,13 +1786,11 @@ static int find_newest_super_backup(struct btrfs_fs_info *info)
 	return -EINVAL;
 }
 
-
 /*
- * find the oldest backup so we know where to store new entries
- * in the backup array.  This will set the backup_root_index
- * field in the fs_info struct
+ * Initialize backup_root_index with the next available slot, where subsequent
+ * transaction commit will store the back up root
  */
-static void find_oldest_super_backup(struct btrfs_fs_info *info)
+static void init_backup_root_slot(struct btrfs_fs_info *info)
 {
 	int newest_index;
 
@@ -2904,7 +2902,7 @@ int __cold open_ctree(struct super_block *sb,
 	 * run through our array of backup supers and setup
 	 * our ring pointer to the oldest one
 	 */
-	find_oldest_super_backup(fs_info);
+	init_backup_root_slot(fs_info);
 
 	/*
 	 * In the long term, we'll store the compression type in the super
-- 
2.17.1

