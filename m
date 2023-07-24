Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC4775EA76
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 06:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjGXETK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 00:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjGXETF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 00:19:05 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526F112B
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 21:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690172344; x=1721708344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fXEuxlJbtMpUQmEtvAa9FpAu8brpelokqTcANQs5Wto=;
  b=QRaGcnSXGRSGH1HLiVv1E6DrmwRKE2qsoz1OKZ3n9yH4v+F7dee/TVFe
   5o4MJbALdiyxF1y4QgqusZ4bq4WNeVsR/p/Qv0i7DS9dW6MFC75Skb1x1
   U7o0LRf7u1tHYCTQUD9MDiCNSPL6nLVN/XUaoUmoOdjIfWsdfujBUyrK/
   986qa9oD9kTMHIVfID+ngXeI0NCGrfEBubc/EWjHDPvwfJpLSn5ETFH8G
   A5o0/+1lY8PmsmnesGFfOwKumE9e5PwzEUSYE+L8BHfAdRrjEs4Zaa4oj
   nJ5g54Q4C0QO3SWRaN06u72F75FzpCohwKZW0OYo7U4IEWmwydH8iIpYe
   w==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684771200"; 
   d="scan'208";a="237227990"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2023 12:19:03 +0800
IronPort-SDR: /4oy9v7m6gHXYCrTiVCfE9DQtZfLrgATXLCkL3bRh8wysiBOw8AlwFrjJlq+2sLCkPrem9alHQ
 lpIs8jbtddDjDPGiA0m+wJi4qZiEjhQwVjuExLhXyafFEWMwgR//DDa9hboPFCKyulJ3XVyz6M
 f0xAR2Wu41DPZVljeWrAkBbtsU0q4Ne3Y3UdQ/lY4RaVuFmPowFrR3tKBt/xFN+b9pGU9hSxEi
 LERY0DHR/j5/THN83/W6DTG9GEes5oYKxtvRm+AEElQm0bXfDEexGrxMSILB8e4coLk3G2kTo/
 X+w=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2023 20:27:09 -0700
IronPort-SDR: 0xFm37NnXtRcRv35qlzwbsZjzGhxEVoncsqg7LwmNkd1kGNbPdrd4iHn0OAc1KdwqLLDI7R72H
 hoveDbdffbAhFX5SElz6ItdrDgcnW9uVVES4hGcWeuRld58+69dgJTf1J/xPXoQu8n49eRv4OX
 xlzx/lutB3wISPbxZTFyUvhpIOqs083jJ7tYc1pvYsVNU13by0IVF+NLbHZYmEMjSgJFRLKJ6G
 mptPAIvJbSCwOdMUWzCHcs4+ec9mB/n4pS+5fzdviihflwrRH0v2HBM8GhOXM3Fcv55oOWr3Wd
 eWg=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.123])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jul 2023 21:19:03 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 8/8] btrfs: zoned: re-enable metadata over-commit for zoned mode
Date:   Mon, 24 Jul 2023 13:18:37 +0900
Message-ID: <3de6d3396704159bb30d77061907e789966fcf67.1690171333.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690171333.git.naohiro.aota@wdc.com>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
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

Now that, we can re-enable metadata over-commit. As we moved the activation
from the reservation time to the write time, we no longer need to ensure
all the reserved bytes is properly activated.

Without the metadata over-commit, it suffers from lower performance because
it needs to flush the delalloc items more often and allocate more block
groups. Re-enabling metadata over-commit will solve the issue.

Fixes: 79417d040f4f ("btrfs: zoned: disable metadata overcommit for zoned")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/space-info.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a84b6088a73d..4c4a30439fcf 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -389,11 +389,7 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 		return 0;
 
 	used = btrfs_space_info_used(space_info, true);
-	if (test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &fs_info->flags) &&
-	    (space_info->flags & BTRFS_BLOCK_GROUP_METADATA))
-		avail = 0;
-	else
-		avail = calc_available_free_space(fs_info, space_info, flush);
+	avail = calc_available_free_space(fs_info, space_info, flush);
 
 	if (used + bytes < space_info->total_bytes + avail)
 		return 1;
-- 
2.41.0

