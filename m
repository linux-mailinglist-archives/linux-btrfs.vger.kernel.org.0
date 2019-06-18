Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65BCF4A8F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 19:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfFRR71 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 13:59:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:45102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727616AbfFRR70 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 13:59:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AAB4FAEBD
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 17:59:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B5EC3DA871; Tue, 18 Jun 2019 20:00:13 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/6] btrfs: use raid_attr for minimum stripe count in btrfs_calc_avail_data_space
Date:   Tue, 18 Jun 2019 20:00:13 +0200
Message-Id: <ffdc7e77015c2f5ad45de7acc2336fe2901bb605.1560880630.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560880630.git.dsterba@suse.com>
References: <cover.1560880630.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Minimum stripe count matches the minimum devices required for a given
profile. The open coded assignments match the raid_attr table.

What's changed here is the meaning for RAID5/6. Previously their
min_stripes would be 1, while newly it's devs_min. This however shold be
the same as before because it's not possible to create filesystem on
fewer devices than the raid_attr table allows.

There's no adjustment regarding the parity stripes (like
calc_data_stripes does), because we're interested in overall space that
would fit on the devices.

Missing devices make no difference for the whole calculation, we have
the size stored in the structures.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/super.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a813b582fa72..9286f9e49c0c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1902,7 +1902,7 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 	u64 type;
 	u64 avail_space;
 	u64 min_stripe_size;
-	int min_stripes = 1, num_stripes = 1;
+	int min_stripes, num_stripes = 1;
 	int i = 0, nr_devices;
 	const struct btrfs_raid_attr *rattr;
 
@@ -1930,14 +1930,12 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 	type = btrfs_data_alloc_profile(fs_info);
 	rattr = &btrfs_raid_array[btrfs_bg_flags_to_raid_index(type)];
 	ASSERT(rattr);
+	min_stripes = rattr->devs_min;
 	if (type & BTRFS_BLOCK_GROUP_RAID0) {
-		min_stripes = 2;
 		num_stripes = nr_devices;
 	} else if (type & BTRFS_BLOCK_GROUP_RAID1) {
-		min_stripes = 2;
 		num_stripes = 2;
 	} else if (type & BTRFS_BLOCK_GROUP_RAID10) {
-		min_stripes = 4;
 		num_stripes = 4;
 	}
 
-- 
2.21.0

