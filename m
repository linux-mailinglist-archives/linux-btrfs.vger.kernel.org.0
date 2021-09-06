Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217A440189C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 11:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhIFJLB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 05:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhIFJLA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Sep 2021 05:11:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1531961050
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Sep 2021 09:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630919396;
        bh=aBZY8IQpherPBJTNrwkYut3aLVSxlKLNbXIZKT2pBZo=;
        h=From:To:Subject:Date:From;
        b=f7kHytp25IYpWR+ihygn4zv6s4buBoBS1LlHLHrHaVsl8J2m72XHYl1ASZ5eEclXc
         1cqTOEDQ1ZD71HvnyJzqTNfwwajdoreeRMzwEvsQpdcbKQJ/HHiwz0AMdSt6PfUBgW
         4E1hh62IjSMDOy1/mFST6cG0N/lUXhvB40thNxVnZSFv6cEZFv6i/3f4Q4rjrXmGN+
         i0Xu84Olc5rk3ldIbmxe1NwKKEjpCZST/Ce5Z9KPh23UDkuscY2i7oMAhkibT/8H4e
         8E3DKS2/x78YczQXvJlDZ3q9G2xt05prf/nk1BjYDC+dAKbpId9cgM8vFDmxnu0zOy
         FEd2TVuZj8M8w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix mount failure due to past and transient device flush error
Date:   Mon,  6 Sep 2021 10:09:53 +0100
Message-Id: <f9dfa4183e5c84f71c3f50d504e3d6cdc43b0ae9.1630919202.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we get an error flushing one device, during a super block commit, we
record the error in the device structure, in the field 'last_flush_error'.
This is used to later check if we should error out the super block commit,
depending on whether the number of flush errors is greater than or equals
to the maximum tolerated device failures for a raid profile.

However if we get a transient device flush error, unmount the filesystem
and later try to mount it, we can fail the mount because we treat that
past error as critical and consider the device is missing. Even if it's
very likely that the error will happen again, as it's probably due to a
hardware related problem, there may be cases where the error might not
happen again. One example is during testing, and a test case like the
new generic/648 from fstests always triggers this. The test cases
generic/019 and generic/475 also trigger this scenario, but very
sporadically.

When this happens we get an error like this:

  $ mount /dev/sdc /mnt
  mount: /mnt wrong fs type, bad option, bad superblock on /dev/sdc, missing codepage or helper program, or other error.

  $ dmesg
  (...)
  [12918.886926] BTRFS warning (device sdc): chunk 13631488 missing 1 devices, max tolerance is 0 for writable mount
  [12918.888293] BTRFS warning (device sdc): writable mount is not allowed due to too many missing devices
  [12918.890853] BTRFS error (device sdc): open_ctree failed

So fix this by making sure btrfs_check_rw_degradable() does not consider
flush errors from past mounts when it is being called at open_ctree() for
the purpose of checking if devices are missing, and clears the record of
such past errors from the devices. Any path during the mount that can
trigger a super block commit (replaying log trees, conversion from free
space cache v1 to v2) must do the usual checks for device flush errors,
just like before.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h   |  3 +++
 fs/btrfs/disk-io.c | 13 ++++++++++---
 fs/btrfs/volumes.c | 25 +++++++++++++++++++++----
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 38870ae46cbb..6871c43c2881 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -598,6 +598,9 @@ enum {
 	BTRFS_FS_32BIT_ERROR,
 	BTRFS_FS_32BIT_WARN,
 #endif
+
+	/* Used to signal we are checking if we can mount a fs in rw mode. */
+	BTRFS_FS_MOUNT_RW_CHECK,
 };
 
 /*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7d80e5b22d32..2d668a070ec2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3564,10 +3564,17 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sysfs;
 	}
 
-	if (!sb_rdonly(sb) && !btrfs_check_rw_degradable(fs_info, NULL)) {
-		btrfs_warn(fs_info,
+	if (!sb_rdonly(sb)) {
+		bool can_mount;
+
+		set_bit(BTRFS_FS_MOUNT_RW_CHECK, &fs_info->flags);
+		can_mount = btrfs_check_rw_degradable(fs_info, NULL);
+		clear_bit(BTRFS_FS_MOUNT_RW_CHECK, &fs_info->flags);
+		if (!can_mount) {
+			btrfs_warn(fs_info,
 		"writable mount is not allowed due to too many missing devices");
-		goto fail_sysfs;
+			goto fail_sysfs;
+		}
 	}
 
 	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, tree_root,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b81f25eed298..53da6735ef1b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7395,12 +7395,29 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 		for (i = 0; i < map->num_stripes; i++) {
 			struct btrfs_device *dev = map->stripes[i].dev;
 
-			if (!dev || !dev->bdev ||
-			    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
-			    dev->last_flush_error)
+			if (dev && dev->last_flush_error) {
+				/*
+				 * If we had a flush error from a previous mount,
+				 * don't treat it as an error and clear the error
+				 * status. Such an error may be transient, and
+				 * just because it happened in a previous mount,
+				 * it does not mean it will happen again if we
+				 * mount the fs again. If it turns out the error
+				 * happens again after mounting, then we will
+				 * deal with it, abort the running transaction
+				 * and set the fs state to BTRFS_FS_STATE_ERROR.
+				 */
+				if (test_bit(BTRFS_FS_MOUNT_RW_CHECK,
+					     &fs_info->flags))
+					dev->last_flush_error = 0;
+				else
+					missing++;
+			} else if (!dev || !dev->bdev ||
+			    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state)) {
 				missing++;
-			else if (failing_dev && failing_dev == dev)
+			} else if (failing_dev && failing_dev == dev) {
 				missing++;
+			}
 		}
 		if (missing > max_tolerated) {
 			if (!failing_dev)
-- 
2.33.0

