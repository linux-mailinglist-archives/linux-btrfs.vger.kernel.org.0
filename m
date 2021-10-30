Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D9A440991
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Oct 2021 16:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhJ3Ojc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Oct 2021 10:39:32 -0400
Received: from out20-3.mail.aliyun.com ([115.124.20.3]:58110 "EHLO
        out20-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhJ3Ojb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Oct 2021 10:39:31 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07638914|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00171305-0.000136274-0.998151;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.LkeF9iB_1635604619;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LkeF9iB_1635604619)
          by smtp.aliyun-inc.com(10.147.41.143);
          Sat, 30 Oct 2021 22:36:59 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs-progs: fix btrfs_group_profile_str regression
Date:   Sat, 30 Oct 2021 22:36:58 +0800
Message-Id: <20211030143658.39136-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str to use raid table")
introduced a regression that raid profile of GlobalReserve will be output
as 'unknown'.

 $ btrfs filesystem df /mnt/test
 Data, single: total=5.02TiB, used=4.98TiB
 System, single: total=4.00MiB, used=624.00KiB
 Metadata, single: total=11.01GiB, used=6.94GiB
 GlobalReserve, unknown: total=512.00MiB, used=0.00B

fix it by
- add the process of BTRFS_BLOCK_GROUP_RESERVED
- fix the define of BTRFS_BLOCK_GROUP_RESERVED too.

Fixes: dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str to use raid table")
Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>

---
 common/utils.c        | 2 +-
 kernel-shared/ctree.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/utils.c b/common/utils.c
index aee0eedc..e8744199 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -1030,7 +1030,7 @@ const char* btrfs_group_profile_str(u64 flag)
 {
 	int index;
 
-	flag &= ~BTRFS_BLOCK_GROUP_TYPE_MASK;
+	flag &= ~(BTRFS_BLOCK_GROUP_TYPE_MASK | BTRFS_BLOCK_GROUP_RESERVED);
 	if (flag & ~BTRFS_BLOCK_GROUP_PROFILE_MASK)
 		return "unknown";
 
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 563ea50b..99ebc3ad 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -972,7 +972,8 @@ struct btrfs_csum_item {
 #define BTRFS_BLOCK_GROUP_RAID6    	(1ULL << 8)
 #define BTRFS_BLOCK_GROUP_RAID1C3    	(1ULL << 9)
 #define BTRFS_BLOCK_GROUP_RAID1C4    	(1ULL << 10)
-#define BTRFS_BLOCK_GROUP_RESERVED	BTRFS_AVAIL_ALLOC_BIT_SINGLE
+#define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
+					 BTRFS_SPACE_INFO_GLOBAL_RSV)
 
 enum btrfs_raid_types {
 	BTRFS_RAID_RAID10,
-- 
2.32.0

