Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051B1377141
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 May 2021 12:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhEHKkC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 May 2021 06:40:02 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:57955 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230234AbhEHKkB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 8 May 2021 06:40:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UY8peFV_1620470331;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UY8peFV_1620470331)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 08 May 2021 18:38:58 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] btrfs: Remove redundant assignment to ret
Date:   Sat,  8 May 2021 18:38:49 +0800
Message-Id: <1620470329-27792-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Variable ret is set to zero, but this value is never read as it is
overwritten or not used later on, hence it is a redundant assignment
and can be removed.

Clean up the following clang-analyzer warning:

fs/btrfs/extent_io.c:5357:4: warning: Value stored to 'ret' is never
read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/btrfs/extent_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 074a78a..cea58be 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5354,7 +5354,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 				goto out_free;
 			if (ret)
 				flags |= FIEMAP_EXTENT_SHARED;
-			ret = 0;
 		}
 		if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
 			flags |= FIEMAP_EXTENT_ENCODED;
-- 
1.8.3.1

