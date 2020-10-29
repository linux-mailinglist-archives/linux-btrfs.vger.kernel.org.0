Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05E629E4BC
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 08:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbgJ2HqO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 03:46:14 -0400
Received: from out20-73.mail.aliyun.com ([115.124.20.73]:55146 "EHLO
        out20-73.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733214AbgJ2HqI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 03:46:08 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2009614|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0978301-0.00237592-0.899794;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.IptkHuJ_1603949757;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.IptkHuJ_1603949757)
          by smtp.aliyun-inc.com(10.147.42.241);
          Thu, 29 Oct 2020 13:36:00 +0800
From:   wangyugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kreijack@libero.it, wangyugui <wangyugui@e16-tech.com>
Subject: [PATCH 4/4] btrfs: tier-aware free space cacl
Date:   Thu, 29 Oct 2020 13:35:56 +0800
Message-Id: <20201029053556.10619-5-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029053556.10619-1-wangyugui@e16-tech.com>
References: <20201029053556.10619-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Detect some case of free space 0 because of tier policy of data.
Full support is yet TODO/FIXME.

Signed-off-by: wangyugui <wangyugui@e16-tech.com>
---
 fs/btrfs/super.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index c8dfa89..feb1ae3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2105,6 +2105,9 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 	int num_stripes = 1;
 	int i = 0, nr_devices;
 	const struct btrfs_raid_attr *rattr;
+	/* tier-aware */
+	int nr_top_tier = 0;
+	u8 top_tier_score = 0;
 
 	/*
 	 * We aren't under the device list lock, so this is racy-ish, but good
@@ -2176,12 +2179,27 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 		devices_info[i].dev = device;
 		devices_info[i].max_avail = avail_space;
 
+		if (devices_info[i].dev->tier_score > top_tier_score) {
+			top_tier_score = devices_info[i].dev->tier_score;
+			nr_top_tier = 1;
+		}
+		else if (devices_info[i].dev->tier_score == top_tier_score) {
+			nr_top_tier++;
+		}
+
 		i++;
 	}
 	rcu_read_unlock();
 
 	nr_devices = i;
 
+	if (fs_info->data_tier_policy == OTHER_TIER_ONLY &&
+		nr_top_tier != nr_devices && nr_devices - nr_top_tier < rattr->devs_min) {
+		/* FIXME: full support of tier-aware. */
+		*free_bytes = 0;
+		return 0;
+	}
+
 	btrfs_descending_sort_devices(devices_info, nr_devices);
 
 	i = nr_devices - 1;
-- 
2.29.1

