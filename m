Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA50132C51E
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 01:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383097AbhCDATO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Mar 2021 19:19:14 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:58887 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356728AbhCCKsO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Mar 2021 05:48:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UQELT1u_1614764730;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UQELT1u_1614764730)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Mar 2021 17:45:37 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] btrfs: Assign boolean values to a bool variable
Date:   Wed,  3 Mar 2021 17:45:28 +0800
Message-Id: <1614764728-14857-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix the following coccicheck warnings:

./fs/btrfs/volumes.c:1462:10-11: WARNING: return of 0/1 in function
'dev_extent_hole_check_zoned' with return type bool.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/btrfs/volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bc3b33e..995920f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1458,8 +1458,8 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
 		/* Given hole range was invalid (outside of device) */
 		if (ret == -ERANGE) {
 			*hole_start += *hole_size;
-			*hole_size = 0;
-			return 1;
+			*hole_size = false;
+			return true;
 		}
 
 		*hole_start += zone_size;
-- 
1.8.3.1

