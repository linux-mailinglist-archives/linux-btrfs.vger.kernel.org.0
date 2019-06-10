Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 700FC3B504
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2019 14:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389875AbfFJM26 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jun 2019 08:28:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:46868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389865AbfFJM26 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jun 2019 08:28:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 202B5AE48
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2019 12:28:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 69D03DAC82; Mon, 10 Jun 2019 14:29:46 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 2/6] btrfs: use mask for RAID56 profiles
Date:   Mon, 10 Jun 2019 14:29:46 +0200
Message-Id: <9bb95462387c084985ea3c60cc029e4b490735bb.1559917235.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559917235.git.dsterba@suse.com>
References: <cover.1559917235.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't need to enumerate the profiles, use the mask for consistency.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3413f78a3032..556deb03c215 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -7874,8 +7874,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		if (!block_group_bits(block_group, flags)) {
 			u64 extra = BTRFS_BLOCK_GROUP_DUP |
 				BTRFS_BLOCK_GROUP_RAID1_MASK |
-				BTRFS_BLOCK_GROUP_RAID5 |
-				BTRFS_BLOCK_GROUP_RAID6 |
+				BTRFS_BLOCK_GROUP_RAID56_MASK |
 				BTRFS_BLOCK_GROUP_RAID10;
 
 			/*
@@ -9562,8 +9561,7 @@ static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
 
 	num_devices = fs_info->fs_devices->rw_devices;
 
-	stripped = BTRFS_BLOCK_GROUP_RAID0 |
-		BTRFS_BLOCK_GROUP_RAID5 | BTRFS_BLOCK_GROUP_RAID6 |
+	stripped = BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID56_MASK |
 		BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10;
 
 	if (num_devices == 1) {
@@ -10446,8 +10444,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		if (!(get_alloc_profile(info, space_info->flags) &
 		      (BTRFS_BLOCK_GROUP_RAID10 |
 		       BTRFS_BLOCK_GROUP_RAID1_MASK |
-		       BTRFS_BLOCK_GROUP_RAID5 |
-		       BTRFS_BLOCK_GROUP_RAID6 |
+		       BTRFS_BLOCK_GROUP_RAID56_MASK |
 		       BTRFS_BLOCK_GROUP_DUP)))
 			continue;
 		/*
-- 
2.21.0

