Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC7332166A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 11:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfEQJmZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 05:42:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:33288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728985AbfEQJmV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 05:42:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6702AEDB
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 09:42:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 476B0DA871; Fri, 17 May 2019 11:43:20 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 04/15] btrfs: use raid_attr table in get_profile_num_devs
Date:   Fri, 17 May 2019 11:43:20 +0200
Message-Id: <31c439a3d4e1731c4002e6df86bef101e40c2ab6.1558085801.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558085801.git.dsterba@suse.com>
References: <cover.1558085801.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The dev_max constraints are defined in the raid_attr table, use it
instead of open-coding it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 12889a7a1bb1..37d7e5261079 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4324,15 +4324,9 @@ static u64 get_profile_num_devs(struct btrfs_fs_info *fs_info, u64 type)
 {
 	u64 num_dev;
 
-	if (type & (BTRFS_BLOCK_GROUP_RAID10 |
-		    BTRFS_BLOCK_GROUP_RAID0 |
-		    BTRFS_BLOCK_GROUP_RAID5 |
-		    BTRFS_BLOCK_GROUP_RAID6))
+	num_dev = btrfs_raid_array[btrfs_bg_flags_to_raid_index(type)].devs_max;
+	if (!num_dev)
 		num_dev = fs_info->fs_devices->rw_devices;
-	else if (type & BTRFS_BLOCK_GROUP_RAID1)
-		num_dev = 2;
-	else
-		num_dev = 1;	/* DUP or single */
 
 	return num_dev;
 }
-- 
2.21.0

