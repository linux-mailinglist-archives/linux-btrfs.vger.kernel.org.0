Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47013155220
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 06:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgBGFic (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 00:38:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:34714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgBGFic (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 00:38:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9B5F7AB95;
        Fri,  7 Feb 2020 05:38:31 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 2/2] btrfs: qgroup: Remove the unnecesaary spin lock for qgroup_rescan_running|queued
Date:   Fri,  7 Feb 2020 13:38:21 +0800
Message-Id: <20200207053821.25643-3-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207053821.25643-1-wqu@suse.com>
References: <20200207053821.25643-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Those two members are all protected by
btrfs_fs_info::qgroup_rescan_lock, thus no need for the extra spinlock.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- New patch split in v2
---
 fs/btrfs/qgroup.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 812f51f67903..e07d6a6b2049 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3247,7 +3247,6 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 	}
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
-	spin_lock(&fs_info->qgroup_lock);
 
 	if (init_flags) {
 		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
@@ -3262,7 +3261,6 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		}
 
 		if (ret) {
-			spin_unlock(&fs_info->qgroup_lock);
 			mutex_unlock(&fs_info->qgroup_rescan_lock);
 			return ret;
 		}
@@ -3273,8 +3271,6 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		sizeof(fs_info->qgroup_rescan_progress));
 	fs_info->qgroup_rescan_progress.objectid = progress_objectid;
 	init_completion(&fs_info->qgroup_rescan_completion);
-
-	spin_unlock(&fs_info->qgroup_lock);
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
 	btrfs_init_work(&fs_info->qgroup_rescan_work,
@@ -3351,9 +3347,7 @@ int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
 	int ret = 0;
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
-	spin_lock(&fs_info->qgroup_lock);
 	running = fs_info->qgroup_rescan_running;
-	spin_unlock(&fs_info->qgroup_lock);
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
 	if (!running)
-- 
2.25.0

