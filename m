Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696DA47FC3C
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Dec 2021 12:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbhL0Ley (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Dec 2021 06:34:54 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:53531 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233591AbhL0Lex (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Dec 2021 06:34:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V.vZjZa_1640604876;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V.vZjZa_1640604876)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 19:34:41 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] btrfs: Use min() instead of doing it manually
Date:   Mon, 27 Dec 2021 19:34:35 +0800
Message-Id: <20211227113435.88262-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Eliminate following coccicheck warning:

./fs/btrfs/volumes.c:7768:13-14: WARNING opportunity for min().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 730355b55b42..dca3f0cedff9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7765,7 +7765,7 @@ static int btrfs_device_init_dev_stats(struct btrfs_device *device,
 			btrfs_dev_stat_set(device, i, 0);
 		device->dev_stats_valid = 1;
 		btrfs_release_path(path);
-		return ret < 0 ? ret : 0;
+		return min(ret, 0);
 	}
 	slot = path->slots[0];
 	eb = path->nodes[0];
-- 
2.20.1.7.g153144c

