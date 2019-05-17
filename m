Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23EC021665
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 11:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfEQJmR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 05:42:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:33238 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727338AbfEQJmR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 05:42:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E91CEAEEA
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 09:42:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8D544DA871; Fri, 17 May 2019 11:43:15 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 02/15] btrfs: raid56: allow the exact minimum number of devices for balance convert
Date:   Fri, 17 May 2019 11:43:15 +0200
Message-Id: <69f7feedac4f0c6f4034927bf1a4a720586d0a71.1558085801.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558085801.git.dsterba@suse.com>
References: <cover.1558085801.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The minimum number of devices for RAID5 is 2, though this is only a bit
expensive RAID1, and for RAID6 it's 3, which is a triple copy that works
only 3 devices.

mkfs.btrfs allows that and mounting such filesystem also works, so the
conversion via balance filters is inconsistent with the others and we
should not prevent it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8508f6028c8d..10f7de0cc7e6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4080,11 +4080,12 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	allowed = BTRFS_AVAIL_ALLOC_BIT_SINGLE | BTRFS_BLOCK_GROUP_DUP;
 	if (num_devices > 1)
 		allowed |= (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID1);
-	if (num_devices > 2)
+	if (num_devices >= 2)
 		allowed |= BTRFS_BLOCK_GROUP_RAID5;
+	if (num_devices >= 3)
+		allowed |= BTRFS_BLOCK_GROUP_RAID6;
 	if (num_devices > 3)
-		allowed |= (BTRFS_BLOCK_GROUP_RAID10 |
-			    BTRFS_BLOCK_GROUP_RAID6);
+		allowed |= BTRFS_BLOCK_GROUP_RAID10;
 	if (validate_convert_profile(&bctl->data, allowed)) {
 		int index = btrfs_bg_flags_to_raid_index(bctl->data.target);
 
-- 
2.21.0

