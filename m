Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03DD402B87
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 17:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345096AbhIGPRB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 11:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345106AbhIGPRB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Sep 2021 11:17:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D25D6101C
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Sep 2021 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631027754;
        bh=SDZq6R9xe1F4rn0/jWqImlPoQzltyIVsjQS9mU66DkU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BdOqid+loxbplWrkiTgUnvSO8BKEq/kW2ytPYMAeTLA0K6y1grspXuYHU0140DUAg
         gFNDHxfnPkSCx+qCZMhkkPIO8L1/86ulyXvcqD7hbsyBUzcfARy6FEPXEaiw5CttGT
         lVmGEKM70C/bzfNTYPLT64fsWEl26mjJMmejEDlTr51SuRe1tfD3MGiWXEpquOU3hA
         CoJEqA9U7ZVVjTVIZsm2Bj6jDnOsfVDh8CYsNMSx69Y+gNd1ih+3+utn4XJFj2dYlq
         2rwloC3SV7bRYASQtAB1dTdSn83mcHxpmmU0mNLL+1WOpKbqGTepb0mjG0U9J4KIbb
         cTROPBcEAH0RA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: remove the failing device argument from btrfs_check_rw_degradable()
Date:   Tue,  7 Sep 2021 16:15:50 +0100
Message-Id: <6979a21084ce679d34896cf8092349e845e1843e.1631026981.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631026981.git.fdmanana@suse.com>
References: <cover.1631026981.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently all callers of btrfs_check_rw_degradable() pass a NULL value for
its 'failing_dev' argument, therefore making it useless. So just remove
that argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c |  4 ++--
 fs/btrfs/super.c   |  2 +-
 fs/btrfs/volumes.c | 10 ++--------
 fs/btrfs/volumes.h |  1 -
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6d7d6288f80a..f5133833bba8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3564,7 +3564,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sysfs;
 	}
 
-	if (!sb_rdonly(sb) && !btrfs_check_rw_degradable(fs_info, NULL, true)) {
+	if (!sb_rdonly(sb) && !btrfs_check_rw_degradable(fs_info, true)) {
 		btrfs_warn(fs_info,
 		"writable mount is not allowed due to too many missing devices");
 		goto fail_sysfs;
@@ -4013,7 +4013,7 @@ static blk_status_t wait_dev_flush(struct btrfs_device *device)
 
 static int check_barrier_error(struct btrfs_fs_info *fs_info)
 {
-	if (!btrfs_check_rw_degradable(fs_info, NULL, false))
+	if (!btrfs_check_rw_degradable(fs_info, false))
 		return -EIO;
 	return 0;
 }
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 51519141b12f..da0395512cc2 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2017,7 +2017,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 			goto restore;
 		}
 
-		if (!btrfs_check_rw_degradable(fs_info, NULL, true)) {
+		if (!btrfs_check_rw_degradable(fs_info, true)) {
 			btrfs_warn(fs_info,
 		"too many missing devices, writable remount is not allowed");
 			ret = -EACCES;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2a5beba98273..a8352965e24c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7361,13 +7361,10 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 /*
  * Check if all chunks in the fs are OK for read-write degraded mount
  *
- * If the @failing_dev is specified, it's accounted as missing.
- *
  * Return true if all chunks meet the minimal RW mount requirements.
  * Return false if any chunk doesn't meet the minimal RW mount requirements.
  */
-bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
-			       struct btrfs_device *failing_dev, bool mounting_fs)
+bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info, bool mounting_fs)
 {
 	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
 	struct extent_map *em;
@@ -7414,13 +7411,10 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 			} else if (!dev || !dev->bdev ||
 			    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state)) {
 				missing++;
-			} else if (failing_dev && failing_dev == dev) {
-				missing++;
 			}
 		}
 		if (missing > max_tolerated) {
-			if (!failing_dev)
-				btrfs_warn(fs_info,
+			btrfs_warn(fs_info,
 	"chunk %llu missing %d devices, max tolerance is %d for writable mount",
 				   em->start, missing, max_tolerated);
 			free_extent_map(em);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 7299aa36f41f..f880d5404b25 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -575,7 +575,6 @@ void btrfs_commit_device_sizes(struct btrfs_transaction *trans);
 
 struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);
 bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
-			       struct btrfs_device *failing_dev,
 			       bool mounting_fs);
 void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 			       struct block_device *bdev,
-- 
2.33.0

