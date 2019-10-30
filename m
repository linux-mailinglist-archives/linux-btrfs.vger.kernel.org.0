Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F19E9B67
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 13:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfJ3MWb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 08:22:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:41572 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfJ3MWb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 08:22:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D294B6CA;
        Wed, 30 Oct 2019 12:22:30 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs-progs: Initialize sub_stripes to 1 in btrfs_alloc_data_chunk
Date:   Wed, 30 Oct 2019 14:22:25 +0200
Message-Id: <20191030122227.28496-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030122227.28496-1-nborisov@suse.com>
References: <20191030122227.28496-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

sub_stripe variables is by default initialized to 0 and it's overriden
only in case we have RAID10 mode. This leads to the following (minor)
artifacts on a freshly created filesystem:

item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15863 itemsize 112
		length 1073741824 owner 2 stripe_len 65536 type METADATA|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 0
			stripe 0 devid 2 offset 9437184
			dev_uuid a020fc2f-b526-4800-9278-156f2f431fe9
			stripe 1 devid 1 offset 30408704
			dev_uuid 0f78aa72-4626-4057-a8f2-285f46b2c664

After balance resulting chunk item is:

item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 3251634176) itemoff 15863 itemsize 112
		length 268435456 owner 2 stripe_len 65536 type METADATA|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 1
			stripe 0 devid 2 offset 3230662656
			dev_uuid a020fc2f-b526-4800-9278-156f2f431fe9
			stripe 1 devid 1 offset 3251634176
			dev_uuid 0f78aa72-4626-4057-a8f2-285f46b2c664

Kernel code usually initializes it to 1, since it takes the value from
the raid description table which has it set to 1 for all but RAID10 types.
In userspace it has be statically initialized by 1 since we don't have
btrfs_bg_flags_to_raid_index. Eventually the kernel/userspace needs
to be merged but for now it wouldn't bring much value if this function
is copied.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/volumes.c b/volumes.c
index fbbc22b5b1b3..1d088d93e788 100644
--- a/volumes.c
+++ b/volumes.c
@@ -993,7 +993,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int num_stripes = 1;
 	int max_stripes = 0;
 	int min_stripes = 1;
-	int sub_stripes = 0;
+	int sub_stripes = 1;
 	int looped = 0;
 	int ret;
 	int index;
@@ -1258,7 +1258,7 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 	struct map_lookup *map;
 	u64 calc_size = SZ_8M;
 	int num_stripes = 1;
-	int sub_stripes = 0;
+	int sub_stripes = 1;
 	int ret;
 	int index;
 	int stripe_len = BTRFS_STRIPE_LEN;
-- 
2.7.4

