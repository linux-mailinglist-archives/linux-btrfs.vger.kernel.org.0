Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E624A8F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 19:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfFRR7Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 13:59:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:45090 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727616AbfFRR7X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 13:59:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CDBF6AEA1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 17:59:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 12ACEDA871; Tue, 18 Jun 2019 20:00:11 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/6] btrfs: use raid_attr to adjust minimal stripe size in btrfs_calc_avail_data_space
Date:   Tue, 18 Jun 2019 20:00:11 +0200
Message-Id: <353ead8638fbac0abe61e1647110bcd795662b27.1560880630.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560880630.git.dsterba@suse.com>
References: <cover.1560880630.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Special case for DUP can be replaced by lookup to the attribute table,
where the dev_stripes is the right coefficient.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/super.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6e196b8a0820..a813b582fa72 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1904,6 +1904,7 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 	u64 min_stripe_size;
 	int min_stripes = 1, num_stripes = 1;
 	int i = 0, nr_devices;
+	const struct btrfs_raid_attr *rattr;
 
 	/*
 	 * We aren't under the device list lock, so this is racy-ish, but good
@@ -1927,6 +1928,8 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 
 	/* calc min stripe number for data space allocation */
 	type = btrfs_data_alloc_profile(fs_info);
+	rattr = &btrfs_raid_array[btrfs_bg_flags_to_raid_index(type)];
+	ASSERT(rattr);
 	if (type & BTRFS_BLOCK_GROUP_RAID0) {
 		min_stripes = 2;
 		num_stripes = nr_devices;
@@ -1938,10 +1941,8 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 		num_stripes = 4;
 	}
 
-	if (type & BTRFS_BLOCK_GROUP_DUP)
-		min_stripe_size = 2 * BTRFS_STRIPE_LEN;
-	else
-		min_stripe_size = BTRFS_STRIPE_LEN;
+	/* Adjust for more than 1 stripe per device */
+	min_stripe_size = rattr->dev_stripes * BTRFS_STRIPE_LEN;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
-- 
2.21.0

