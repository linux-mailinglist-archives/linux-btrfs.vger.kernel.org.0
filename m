Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0701F3CC9A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 15:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390130AbfFKNJn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jun 2019 09:09:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:57158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387844AbfFKNJm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jun 2019 09:09:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE02DAEA0;
        Tue, 11 Jun 2019 13:09:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DD62DDA8CC; Tue, 11 Jun 2019 15:10:32 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, Hugo Mills <hugo@carfax.org.uk>
Subject: [PATCH] btrfs: raid56: clear incompat block group flags after removing the last one
Date:   Tue, 11 Jun 2019 15:10:24 +0200
Message-Id: <20190611131024.23422-1-dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The incompat bit for RAID56 is set either at mount time or automatically
when the profile is used by balance. The part where the bit is removed
is missing and can be unexpected or undesired when an older kernel is
needed.

This patch will drop the incompat bit after this command, assuming
that RAID5 profile is not used by system or metadata:

 $ btrfs balance start -dconvert=raid5 /mnt
 $ btrfs balance start -dconvert=raid1 /mnt

This will print "clearing 128 feature flag" to the system log.

The patch is safe for backporting to older kernels.

Reported-by: Hugo Mills <hugo@carfax.org.uk>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index cc4f8c1681fa..59a6f92530f8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -10606,6 +10606,34 @@ static void clear_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 	write_sequnlock(&fs_info->profiles_lock);
 }
 
+/*
+ * Clear incompat bits for the following feature(s):
+ *
+ * - RAID56 - in case there's no profile with either RAID5 or RAID6
+ */
+static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
+{
+	if (flags & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		struct list_head *head = &fs_info->space_info;
+		struct btrfs_space_info *sinfo;
+
+		list_for_each_entry_rcu(sinfo, head, list) {
+			bool found = false;
+
+			down_read(&sinfo->groups_sem);
+			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID5]))
+				found = true;
+			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID6]))
+				found = true;
+			up_read(&sinfo->groups_sem);
+
+			if (found)
+				return;
+		}
+		btrfs_clear_fs_incompat(fs_info, RAID56);
+	}
+}
+
 int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			     u64 group_start, struct extent_map *em)
 {
@@ -10752,6 +10780,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		clear_avail_alloc_bits(fs_info, block_group->flags);
 	}
 	up_write(&block_group->space_info->groups_sem);
+	clear_incompat_bg_bits(fs_info, block_group->flags);
 	if (kobj) {
 		kobject_del(kobj);
 		kobject_put(kobj);
-- 
2.21.0

