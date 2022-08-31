Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22C75A754E
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Aug 2022 06:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiHaE4A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Aug 2022 00:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHaEz7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Aug 2022 00:55:59 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3CD9BB4B
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 21:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661921758; x=1693457758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CoyglIpRn/cBm8OfG9EZB5ROBbekV9mxRLFC7fbrlWc=;
  b=Pqs9oPAzzG/I49+XsBgVoxAzqupP9SGokrfI4wWhqT4KwMXdkeU3q80+
   KpbGLbXVCzrGK5CoA8D+rdLfLzqxPD8lo/4PeFTqgrcC57DXZOq1sT8JQ
   3u+RBxprkCpyxvvSio+q4evIqNjeW0YVqZ0x5+AL7qM6ycxIoK5yZl6ZS
   AU2k6LXoPwaUdK5h8WlZlirHWCDegCqJnANu/uyr/FmAIm4tqDNAc2hGO
   F73cHGNvpuKXgV6jpgUEaPp3idu6bkk5TMBqKdv6crVRZ4073W+lEW0c+
   0EOjhT44OW85NiaYE6C05gP40VxRLrjIM7XK5CovmVYVoVsskBuEgcsf6
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,276,1654531200"; 
   d="scan'208";a="322205055"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2022 12:55:58 +0800
IronPort-SDR: QB8CqoLOACJm/Np8Raxpd2NbifMmuTfuDwLUNtwL1Nzo85Bo46xS1V38i/pwjS85ak8m7/8ZqL
 Q6sdRGJ5c5Q9W42czpc32xthnSqYVtguMsadOfwitLav6qRg/B2Wdt7Og3Pmyty7Oz0UEVA1uj
 3c9pg8wvgzeNQkme4HybAFh6v+1J/rPATFi1qNUD80Rax/Nxb/Blv7I3gGBwpZX9TD27mBgYKb
 bzwMbITZ2Bv2rnH/9IAUtWRe4mFwDGAVjBHBHQjLfo4DWKlyQMWgWqBF35Cir3ca5NW8u6YGqQ
 jn7JWn9PZoFeiXrhnXY3wooz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2022 21:16:28 -0700
IronPort-SDR: n8FYzV+NtalWhVYzFbj3garMmG1S+3e4Go7NBt1VVFQhWvwGsNiYi+fHWf+aFxKDtqTDVNtNYZ
 XpKEiN6lkSeIxVfV1R4zlkgGN74mgrmQ7tnffBpZkZimaYW/q+iJQO57WdCHkObjtMxwSey0u2
 Az2IE0FQNLdWxc9SZey/THa0wrqzOBsV+rBrWg9S6zN9jJBuRoN4jHqoVDXSBu6IvWH/ToqSo+
 x/E8ZG0WGDXNoYlE7Hl7bL72sNwiJfQHg1p8J8Pw49P8bVC1J0DH/XFd+W/MX+Y6F3sq76UDY9
 cRY=
WDCIronportException: Internal
Received: from 47bj3x2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.10])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Aug 2022 21:55:57 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: fix API misuse of zone finish waiting
Date:   Wed, 31 Aug 2022 13:55:48 +0900
Message-Id: <7f579ef2f4d4ab38577bd9768f4e38ac4d00fc48.1661921714.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The commit 2ce543f47843 ("btrfs: zoned: wait until zone is finished when
allocation didn't progress") implemented a zone finish waiting mechanism to
the write path of zoned mode. However, using wait_var_event()/wake_up_all()
on fs_info->zone_finish_wait is wrong and wait_var_event() just hangs
because no one ever wakes it up once it goes into sleep.

Indeed, we can simply use wait_on_bit_io() and clear_and_wake_up_bit() on
fs_info->flags with a proper barrier installed.

Fixes: 2ce543f47843 ("btrfs: zoned: wait until zone is finished when allocation didn't progress")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h   | 2 --
 fs/btrfs/disk-io.c | 1 -
 fs/btrfs/inode.c   | 7 +++----
 fs/btrfs/zoned.c   | 3 +--
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0069bc86c04f..5d03fc267b58 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1089,8 +1089,6 @@ struct btrfs_fs_info {
 
 	spinlock_t zone_active_bgs_lock;
 	struct list_head zone_active_bgs;
-	/* Waiters when BTRFS_FS_NEED_ZONE_FINISH is set */
-	wait_queue_head_t zone_finish_wait;
 
 	/* Updates are not protected by any lock */
 	struct btrfs_commit_stats commit_stats;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 912e0b2bd0c5..b5470ac2db5b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3079,7 +3079,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	init_waitqueue_head(&fs_info->transaction_blocked_wait);
 	init_waitqueue_head(&fs_info->async_submit_wait);
 	init_waitqueue_head(&fs_info->delayed_iputs_wait);
-	init_waitqueue_head(&fs_info->zone_finish_wait);
 
 	/* Usable values until the real ones are cached from the superblock */
 	fs_info->nodesize = 4096;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b9d40e25d978..e5284f2686c8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1644,10 +1644,9 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 			done_offset = end;
 
 		if (done_offset == start) {
-			struct btrfs_fs_info *info = inode->root->fs_info;
-
-			wait_var_event(&info->zone_finish_wait,
-				       !test_bit(BTRFS_FS_NEED_ZONE_FINISH, &info->flags));
+			wait_on_bit_io(&inode->root->fs_info->flags,
+				       BTRFS_FS_NEED_ZONE_FINISH,
+				       TASK_UNINTERRUPTIBLE);
 			continue;
 		}
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index dc96b3331bfb..9c6a8c38c67e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2010,8 +2010,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	/* For active_bg_list */
 	btrfs_put_block_group(block_group);
 
-	clear_bit(BTRFS_FS_NEED_ZONE_FINISH, &fs_info->flags);
-	wake_up_all(&fs_info->zone_finish_wait);
+	clear_and_wake_up_bit(BTRFS_FS_NEED_ZONE_FINISH, &fs_info->flags);
 
 	return 0;
 }
-- 
2.37.3

