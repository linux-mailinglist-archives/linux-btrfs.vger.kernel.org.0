Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642EF36E87A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 12:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbhD2KQZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 06:16:25 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:38574 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232261AbhD2KQY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 06:16:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UX9ofNw_1619691321;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UX9ofNw_1619691321)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Apr 2021 18:15:36 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] btrfs: Remove redundant assignment to ret
Date:   Thu, 29 Apr 2021 18:15:20 +0800
Message-Id: <1619691320-81639-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Variable ret is set to zero but this value is never read as it
is overwritten or not used later on, hence it is a redundant
assignment and can be removed.

Cleans up the following clang-analyzer warning:

fs/btrfs/volumes.c:8019:4: warning: Value stored to 'ret' is never read
[clang-analyzer-deadcode.DeadStores].

fs/btrfs/volumes.c:4757:4: warning: Value stored to 'ret' is never read
[clang-analyzer-deadcode.DeadStores].

fs/btrfs/volumes.c:7951:4: warning: Value stored to 'ret' is never read
[clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/btrfs/volumes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9a1ead0..30504fa 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4754,7 +4754,6 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			if (ret < 0)
 				goto done;
-			ret = 0;
 			btrfs_release_path(path);
 			break;
 		}
@@ -7939,7 +7938,7 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 	struct btrfs_key key;
 	u64 prev_devid = 0;
 	u64 prev_dev_ext_end = 0;
-	int ret = 0;
+	int ret;
 
 	/*
 	 * We don't have a dev_root because we mounted with ignorebadroots and
@@ -8016,7 +8015,6 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 		if (ret < 0)
 			goto out;
 		if (ret > 0) {
-			ret = 0;
 			break;
 		}
 	}
-- 
1.8.3.1

