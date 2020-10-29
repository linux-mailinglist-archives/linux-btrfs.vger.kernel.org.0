Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DCE29E4C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 08:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbgJ2HrB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 03:47:01 -0400
Received: from out20-50.mail.aliyun.com ([115.124.20.50]:40976 "EHLO
        out20-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732929AbgJ2HqK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 03:46:10 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1893146|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0374877-0.000188561-0.962324;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.IptkHuJ_1603949757;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.IptkHuJ_1603949757)
          by smtp.aliyun-inc.com(10.147.42.241);
          Thu, 29 Oct 2020 13:35:59 +0800
From:   wangyugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kreijack@libero.it, wangyugui <wangyugui@e16-tech.com>
Subject: [PATCH 3/4] btrfs: tier-aware mirror path select
Date:   Thu, 29 Oct 2020 13:35:55 +0800
Message-Id: <20201029053556.10619-4-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029053556.10619-1-wangyugui@e16-tech.com>
References: <20201029053556.10619-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This feature help the read performance, so it is enabled even if tier=off.

Signed-off-by: wangyugui <wangyugui@e16-tech.com>
---
 fs/btrfs/volumes.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2a422ac..b65f916 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5568,6 +5568,11 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	int tolerance;
 	struct btrfs_device *srcdev;
 
+	/* tier-aware even if tier=off */
+	int top_tier_num_stripes = 0;
+	int top_tier_stripe_idxs[4]; /* RAID1C4 */
+	u8 top_tier_score = 0;
+
 	ASSERT((map->type &
 		 (BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10)));
 
@@ -5576,7 +5581,21 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	else
 		num_stripes = map->num_stripes;
 
-	preferred_mirror = first + current->pid % num_stripes;
+	for (i = 0; i < num_stripes; ++i)
+	{
+		if (map->stripes[i].dev->tier_score > top_tier_score)
+		{
+			top_tier_score = map->stripes[i].dev->tier_score;
+			top_tier_stripe_idxs[0] = i;
+			top_tier_num_stripes = 1;
+		}
+		else if (map->stripes[i].dev->tier_score == top_tier_score)
+		{
+			top_tier_stripe_idxs[top_tier_num_stripes] = i;
+			top_tier_num_stripes++;
+		}
+	}
+	preferred_mirror = first + top_tier_stripe_idxs[current->pid % top_tier_num_stripes];
 
 	if (dev_replace_is_ongoing &&
 	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==
-- 
2.29.1

