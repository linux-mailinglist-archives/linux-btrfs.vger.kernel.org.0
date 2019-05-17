Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A43721672
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 11:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfEQJmj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 05:42:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:33350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729019AbfEQJmi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 05:42:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 08D07AECD
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 09:42:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A1209DA871; Fri, 17 May 2019 11:43:36 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 11/15] btrfs: use u8 for raid_array members
Date:   Fri, 17 May 2019 11:43:36 +0200
Message-Id: <01fda29d9834fd84cb0fdbc32606618219b324bc.1558085801.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558085801.git.dsterba@suse.com>
References: <cover.1558085801.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The raid_attr table is now 7 * 56 = 392 bytes long, consisting of just
small numbers so we don't have to use ints. New size is 7 * 32 = 224,
saving 3 cachelines.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c |  4 ++--
 fs/btrfs/volumes.h | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cdd6e7ee76b6..c4a4e6c42456 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3709,7 +3709,7 @@ int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags)
 
 	if ((flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0 ||
 	    (flags & BTRFS_AVAIL_ALLOC_BIT_SINGLE))
-		min_tolerated = min(min_tolerated,
+		min_tolerated = min_t(int, min_tolerated,
 				    btrfs_raid_array[BTRFS_RAID_SINGLE].
 				    tolerated_failures);
 
@@ -3718,7 +3718,7 @@ int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags)
 			continue;
 		if (!(flags & btrfs_raid_array[raid_type].bg_flag))
 			continue;
-		min_tolerated = min(min_tolerated,
+		min_tolerated = min_t(int, min_tolerated,
 				    btrfs_raid_array[raid_type].
 				    tolerated_failures);
 	}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 07156d974ac4..73520a6ed90a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -336,16 +336,16 @@ struct btrfs_device_info {
 };
 
 struct btrfs_raid_attr {
-	int sub_stripes;	/* sub_stripes info for map */
-	int dev_stripes;	/* stripes per dev */
-	int devs_max;		/* max devs to use */
-	int devs_min;		/* min devs needed */
-	int tolerated_failures; /* max tolerated fail devs */
-	int devs_increment;	/* ndevs has to be a multiple of this */
-	int ncopies;		/* how many copies to data has */
-	int nparity;		/* number of stripes worth of bytes to store
+	u8 sub_stripes;		/* sub_stripes info for map */
+	u8 dev_stripes;		/* stripes per dev */
+	u8 devs_max;		/* max devs to use */
+	u8 devs_min;		/* min devs needed */
+	u8 tolerated_failures;	/* max tolerated fail devs */
+	u8 devs_increment;	/* ndevs has to be a multiple of this */
+	u8 ncopies;		/* how many copies to data has */
+	u8 nparity;		/* number of stripes worth of bytes to store
 				 * parity information */
-	int mindev_error;	/* error code if min devs requisite is unmet */
+	u8 mindev_error;	/* error code if min devs requisite is unmet */
 	const char raid_name[8]; /* name of the raid */
 	u64 bg_flag;		/* block group flag of the raid */
 };
-- 
2.21.0

