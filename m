Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF43E518FC7
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 23:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242651AbiECVOj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 17:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242650AbiECVOi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 17:14:38 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E9B19C19
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 14:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651612264; x=1683148264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iK2cAJ3OveEuRleuFnh5dirh0d9V7IkS9A+y7C5CFeM=;
  b=YMUMI6Qeo/Q9NLzii63bSDLxH37urZ7ACaMSqkiNYZgTXZoSupN6cs/u
   J36mRSl9YEaGES2eWsy8XoW85Vvz547B4SiWnXfeXzA4+1WlkrHjkuLU6
   iWcfVj4l+w7DrADGrhGDkFuOTHjRakxEhBLSE1wI4zlY/ym/pqOWCXvcY
   8URGpXnsyeyPcnL/QvAykI1OldNSmgvU7BvTxyguFmRhBFU1qsqrhZv0E
   Ex6+rIVR1nlzSWVxoTAzOhdkqNDPwMrZXXaplmgJzZJmb7mZn+sft7W+m
   42OEPbS8KMmr+lZr99WM1DG/1Hudtgni5U7lFqMSPU770pTKBNVrvDO2G
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,196,1647273600"; 
   d="scan'208";a="199451686"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2022 05:11:04 +0800
IronPort-SDR: WdgNOS9CSS+h8kbKv6kgsK9IIZ7HCsTIb49upvmL6j8J0hlt1BcZWndpvTRMXET+G/nH6kHRWt
 EA5lLGSLh1Ggy4d4EUs8kOWUv/40XfV1gsNMp+7A5QbGlX6rX7kYvSZqdgToQW3i4amI9RBqUq
 KMc7+zmOc2BtfvvX42BikBIXJSjBsXRqH1W1R9TvJhcSKQLUvQCATJOpW5cMxrqfIWMKJmtcrc
 j5FIpdGID+m6a/0EKJatzx6AekyaRRLPISYsoDjEw+C+oVX8cBYPGZ3YN7AR18iCnwUPb42qay
 h/yhxhfEf2QPnl0a0E+Yy/IV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2022 13:41:07 -0700
IronPort-SDR: 0arWXLvupYnet3t9Rb+bxRtF7jpPmGQ1ynQWe9BQ2+aD+IoeHeSEOnKxFx0mRKn8JJzVgS3XiP
 i3ZSOqz3k4Eot5Uqmvus9uwh5j5KojszCV+iVQPaSkARM/Xzgfb0CEyTYKTcndpobw1J0nmFFR
 xtAQr7OV3ICMbIIec3s01wmx3eg+Q/2x9Jzw9/aGlHvNAdr6ZTNrJ5+BKfxokBOK0GfGS0tGxZ
 sLJiThnUWOpSp3u7a0As/e/bZtA2MSMKYH7d+ohbf0lsmTuSkD5+IsQstBlQlTd8nYXnobqTfD
 BrE=
WDCIronportException: Internal
Received: from jpf008298.ad.shared (HELO naota-x1.wdc.com) ([10.225.48.200])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 May 2022 14:11:04 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/2] btrfs: zoned: activate block group properly on unlimited active zone device
Date:   Tue,  3 May 2022 14:10:05 -0700
Message-Id: <b93f19c22b684773b19f7f54a9e927da67b084f1.1651611385.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651611385.git.naohiro.aota@wdc.com>
References: <cover.1651611385.git.naohiro.aota@wdc.com>
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

btrfs_zone_activate() checks if it activated all the underlying zones in
the loop. However, that check never hit on an unlimited activate zone
device (max_active_zones == 0).

Fortunately, it still works without ENOSPC because btrfs_zone_activate()
returns true in the end, even if block_group->zone_is_active == 0. But, it
is confusing to have non zone_is_active block group still usable for
allocation. Also, we are wasting CPU time to iterate the loop every time
btrfs_zone_activate() is called for the BGs.

Since error case in the loop is handled by out_unlock, we can just set
zone_is_active and do the list stuff after the loop.

Fixes: f9a912a3c45f ("btrfs: zoned: make zone activation multi stripe capable")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 80a86f26ab7b..6e91022ae9f6 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1853,24 +1853,18 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 			ret = false;
 			goto out_unlock;
 		}
-
-		/* Successfully activated all the zones */
-		if (i == map->num_stripes - 1)
-			block_group->zone_is_active = 1;
-
-
 	}
+
+	/* Successfully activated all the zones */
+	block_group->zone_is_active = 1;
 	spin_unlock(&block_group->lock);
 
-	if (block_group->zone_is_active) {
-		/* For the active block group list */
-		btrfs_get_block_group(block_group);
+	/* For the active block group list */
+	btrfs_get_block_group(block_group);
 
-		spin_lock(&fs_info->zone_active_bgs_lock);
-		list_add_tail(&block_group->active_bg_list,
-			      &fs_info->zone_active_bgs);
-		spin_unlock(&fs_info->zone_active_bgs_lock);
-	}
+	spin_lock(&fs_info->zone_active_bgs_lock);
+	list_add_tail(&block_group->active_bg_list, &fs_info->zone_active_bgs);
+	spin_unlock(&fs_info->zone_active_bgs_lock);
 
 	return true;
 
-- 
2.35.1

