Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1C62166D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 11:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfEQJmb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 05:42:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:33332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728423AbfEQJma (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 05:42:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2845AEDB
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 09:42:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9DD62DA871; Fri, 17 May 2019 11:43:29 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 08/15] btrfs: use raid_attr table to find profiles for integrity lowering
Date:   Fri, 17 May 2019 11:43:29 +0200
Message-Id: <012ba0ba1f25b1ee453cc9ebe76be1202b169ee5.1558085801.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558085801.git.dsterba@suse.com>
References: <cover.1558085801.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Replace open coded list of the profiles by selecting them from the
raid_attr table. The criteria are now more explicit, we need profiles
that have more than 1 copy of the data or can reconstruct the data with
a missing device.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 34e4d2269802..9bcda2d76a33 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4110,11 +4110,16 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
-	/* allow to reduce meta or sys integrity only if force set */
-	allowed = BTRFS_BLOCK_GROUP_DUP | BTRFS_BLOCK_GROUP_RAID1 |
-			BTRFS_BLOCK_GROUP_RAID10 |
-			BTRFS_BLOCK_GROUP_RAID5 |
-			BTRFS_BLOCK_GROUP_RAID6;
+	/*
+	 * Allow to reduce metadata or system integrity only if force set for
+	 * profiles with redundancy (copies, parity)
+	 */
+	allowed = 0;
+	for (i = 0; i < ARRAY_SIZE(btrfs_raid_array); i++) {
+		if (btrfs_raid_array[i].ncopies >= 2 ||
+		    btrfs_raid_array[i].tolerated_failures >= 1)
+			allowed |= btrfs_raid_array[i].bg_flag;
+	}
 	do {
 		seq = read_seqbegin(&fs_info->profiles_lock);
 
-- 
2.21.0

