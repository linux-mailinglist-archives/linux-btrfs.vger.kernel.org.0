Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 211D01437B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 08:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgAUHeX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 02:34:23 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41937 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727453AbgAUHeX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 02:34:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ToHExQp_1579592060;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHExQp_1579592060)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 15:34:20 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: remove unused actions
Date:   Tue, 21 Jan 2020 15:34:19 +0800
Message-Id: <1579592059-86386-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Seems no one care ret and features in func btrfs_sysfs_feature_update,
so better to remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Chris Mason <clm@fb.com> 
Cc: Josef Bacik <josef@toxicpanda.com> 
Cc: David Sterba <dsterba@suse.com> 
Cc: linux-btrfs@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/btrfs/sysfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5ebbe8a5ee76..93f870727aa7 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1148,13 +1148,10 @@ void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_fs_devices *fs_devs;
 	struct kobject *fsid_kobj;
-	u64 features;
-	int ret;
 
 	if (!fs_info)
 		return;
 
-	features = get_features(fs_info, set);
 	ASSERT(bit & supported_feature_masks[set]);
 
 	fs_devs = fs_info->fs_devices;
@@ -1168,7 +1165,7 @@ void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
 	 * to use sysfs_update_group but some refactoring is needed first.
 	 */
 	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
-	ret = sysfs_create_group(fsid_kobj, &btrfs_feature_attr_group);
+	sysfs_create_group(fsid_kobj, &btrfs_feature_attr_group);
 }
 
 int __init btrfs_init_sysfs(void)
-- 
1.8.3.1

