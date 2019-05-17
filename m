Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA482166C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 11:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfEQJm3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 05:42:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:33322 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728423AbfEQJm2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 05:42:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BBA3CAEDB
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 09:42:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 55EB8DA871; Fri, 17 May 2019 11:43:27 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 07/15] btrfs: use raid_attr to get allowed profiles for balance conversion
Date:   Fri, 17 May 2019 11:43:27 +0200
Message-Id: <4a3e7afe1f1a850ec16a1edfb96ca85cdb3e85fe.1558085801.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558085801.git.dsterba@suse.com>
References: <cover.1558085801.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Iterate over the table and gather all allowed profiles for a given
number of devices, instead of open coding.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 743ed1f0b2a6..34e4d2269802 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4047,6 +4047,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	u64 num_devices;
 	unsigned seq;
 	bool reducing_integrity;
+	int i;
 
 	if (btrfs_fs_closing(fs_info) ||
 	    atomic_read(&fs_info->balance_pause_req) ||
@@ -4076,16 +4077,11 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	}
 
 	num_devices = btrfs_num_devices(fs_info);
+	allowed = 0;
+	for (i = 0; i < ARRAY_SIZE(btrfs_raid_array); i++)
+		if (num_devices >= btrfs_raid_array[i].devs_min)
+			allowed |= btrfs_raid_array[i].bg_flag;
 
-	allowed = BTRFS_AVAIL_ALLOC_BIT_SINGLE | BTRFS_BLOCK_GROUP_DUP;
-	if (num_devices > 1)
-		allowed |= (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID1);
-	if (num_devices >= 2)
-		allowed |= BTRFS_BLOCK_GROUP_RAID5;
-	if (num_devices >= 3)
-		allowed |= BTRFS_BLOCK_GROUP_RAID6;
-	if (num_devices > 3)
-		allowed |= BTRFS_BLOCK_GROUP_RAID10;
 	if (validate_convert_profile(&bctl->data, allowed)) {
 		int index = btrfs_bg_flags_to_raid_index(bctl->data.target);
 
-- 
2.21.0

