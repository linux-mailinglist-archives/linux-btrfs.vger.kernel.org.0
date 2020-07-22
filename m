Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E336229B24
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 17:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbgGVPSL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 11:18:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26302 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgGVPSL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 11:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595431091; x=1626967091;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4ti7NNkD/qKZs8Lw4siE1lKQ2DzfPYxF+fc7HNLD5OI=;
  b=TOplPoRNMREWIeaLxu8EgoqC0UW+wWOg2/946mOlNr3l9pq/ytVJWdvg
   rgdmIRIlyJVE7ha5zprQxMSq7eqVvo8xqMoPVOpMOueMA5mQlSckV9LRn
   0Ompz9mYibx2ec6CzioN4XOmPvBXtbD1/B2oHX5WLJuLl7aOeZR3L+kiU
   nu3J9nnP71Le6GtBW5/DuAcfo9ErDmXe6HC39zhvyP5zBLB4MI3x3sS2i
   adwiJnDBOMWXe/s9e1E+CTyOoDfDS6WvSTbZOCdCtEk7JHIZ4Pijoubuh
   76RzKQ8kUP5Cqc1zzg0OSkkWrWsNnL4i4sG4TyI3hQFrpLuisoEVM4i5d
   g==;
IronPort-SDR: eGJc3hvmvQJumH1EPPBoB0QtwI1W1KYuAZi6SqtWNCcxB97flrE6JBSoaNAL/j+m+IMfHwQ4AC
 YB0Osxd/9aVG1sPIRxRAr2JVPSv/KSPPWK2yMKfRNJKpPJJlGymER0xUtfEHZHYbLHpvGZcOIS
 ObXn+IxgZnkjQ8vzZYDdqWlgFWsYbn0ibqSgoxrSXRSUo9VLfG+A4F9uWibUQPFLkQGIul6M9w
 uQCUYFlsvlmiUaStmLUHzBpWo3Q/NSgGBpX7HtBj+Aj4gWo8z7mTu03HI0xnybil6A7eteeh/U
 lk0=
X-IronPort-AV: E=Sophos;i="5.75,383,1589212800"; 
   d="scan'208";a="143215272"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 23:18:11 +0800
IronPort-SDR: Bn/FB4bF135GchUbZAUAKd1F9d/EMhJNOzh8oB5LEgoUDofbshnaflygPK3HBeZgFHRJFSqYaS
 KWPmqBX9xCwqa2TDl4MHRuoua5THDBrew=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 08:05:51 -0700
IronPort-SDR: EnW665RWFvU6j13DJVPhJwpArRMYAjNR0CPrc3TkeqkaOyXfrOczfnMyjSZVKJZFNFKGyp4c8v
 Q0wWDg3OJDkg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Jul 2020 08:18:10 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: open-code remount flag setting in btrfs_remount
Date:   Thu, 23 Jul 2020 00:18:04 +0900
Message-Id: <20200722151804.33590-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we're (re)mounting a btrfs filesystem we set the
BTRFS_FS_STATE_REMOUNTING state in fs_info to serialize against async
reclaim or defrags.

This flag is set in btrfs_remount_prepare() called by btrfs_remount(). As
btrfs_remount_prepare() does nothing but setting this flag and doesn't
have a second caller, we can just open-code the flag setting in
btrfs_remount().

Similarly do for so clearing of the flag by moving it out of
btrfs_remount_cleanup() into btrfs_remount() to be symmetrical.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes to v1:
- Move clearing of the flag as well (David)
---
 fs/btrfs/super.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a4f0bb29b8d6..5a9dc31d95c9 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1782,11 +1782,6 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
 				new_pool_size);
 }
 
-static inline void btrfs_remount_prepare(struct btrfs_fs_info *fs_info)
-{
-	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
-}
-
 static inline void btrfs_remount_begin(struct btrfs_fs_info *fs_info,
 				       unsigned long old_opts, int flags)
 {
@@ -1820,8 +1815,6 @@ static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 	else if (btrfs_raw_test_opt(old_opts, DISCARD_ASYNC) &&
 		 !btrfs_test_opt(fs_info, DISCARD_ASYNC))
 		btrfs_discard_cleanup(fs_info);
-
-	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 }
 
 static int btrfs_remount(struct super_block *sb, int *flags, char *data)
@@ -1837,7 +1830,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	int ret;
 
 	sync_filesystem(sb);
-	btrfs_remount_prepare(fs_info);
+	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 
 	if (data) {
 		void *new_sec_opts = NULL;
@@ -1959,6 +1952,8 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 out:
 	wake_up_process(fs_info->transaction_kthread);
 	btrfs_remount_cleanup(fs_info, old_opts);
+	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
+
 	return 0;
 
 restore:
@@ -1973,6 +1968,8 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		old_thread_pool_size, fs_info->thread_pool_size);
 	fs_info->metadata_ratio = old_metadata_ratio;
 	btrfs_remount_cleanup(fs_info, old_opts);
+	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
+
 	return ret;
 }
 
-- 
2.26.2

