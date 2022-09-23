Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6C65E74D1
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 09:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiIWH0N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 03:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiIWH0M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 03:26:12 -0400
Received: from out20-217.mail.aliyun.com (out20-217.mail.aliyun.com [115.124.20.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8CF12A4A0
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 00:26:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07349961|-1;BR=01201311R151S80rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0714219-0.000522219-0.928056;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.PMQCTzy_1663917967;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PMQCTzy_1663917967)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 15:26:08 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] fixup btrfs: relax block-group-tree feature dependency checks
Date:   Fri, 23 Sep 2022 15:26:07 +0800
Message-Id: <20220923072607.24584-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <20220923113120.DC30.409509F4@e16-tech.com>
References: <20220923113120.DC30.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs misc-next broken fstest btrfs/056.

dmesg output of fstests btrfs/056 failure.
[  658.119910] BTRFS error (device dm-0): cannot replay dirty log with unsupported compat_ro features (0x3), try rescue=nologreplay

there are 2 problems.
1) this error should not happen.
2) the message 'unsupported compat_ro features (0xXX)' should only output the unsupported part of compat_ro.

so fixup a4c79f3f1c2a (btrfs: relax block-group-tree feature dependency checks).

please fold it in because the orig patch is still in misc-next.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
 fs/btrfs/disk-io.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c10d368aed7b..9262d7af99b0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3311,11 +3311,13 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb)
 	struct btrfs_super_block *disk_super = fs_info->super_copy;
 	u64 incompat = btrfs_super_incompat_flags(disk_super);
 	u64 compat_ro = btrfs_super_compat_ro_flags(disk_super);
+	u64 incompat_unsupp = incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP;
+	u64 compat_ro_unsupp = compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP;
 
-	if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
+	if (incompat_unsupp) {
 		btrfs_err(fs_info,
 		"cannot mount because of unknown incompat features (0x%llx)",
-		    incompat);
+		    incompat_unsupp);
 		return -EINVAL;
 	}
 
@@ -3344,10 +3346,10 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb)
 	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
 		incompat |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
 
-	if (compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP && !sb_rdonly(sb)) {
+	if (compat_ro_unsupp && !sb_rdonly(sb)) {
 		btrfs_err(fs_info,
 	"cannot mount read-write because of unknown compat_ro features (0x%llx)",
-		       compat_ro);
+		       compat_ro_unsupp);
 		return -EINVAL;
 	}
 
@@ -3356,11 +3358,11 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb)
 	 * should not cause any metadata writes, including log replay.
 	 * Or we could screw up whatever the new feature requires.
 	 */
-	if (compat_ro && btrfs_super_log_root(disk_super) &&
+	if (compat_ro_unsupp && btrfs_super_log_root(disk_super) &&
 	    !btrfs_test_opt(fs_info, NOLOGREPLAY)) {
 		btrfs_err(fs_info,
 "cannot replay dirty log with unsupported compat_ro features (0x%llx), try rescue=nologreplay",
-			  compat_ro);
+			  compat_ro_unsupp);
 		return -EINVAL;
 	}
 
-- 
2.36.2

