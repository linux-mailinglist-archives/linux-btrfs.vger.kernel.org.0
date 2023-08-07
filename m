Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5F6772A41
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Aug 2023 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjHGQNM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Aug 2023 12:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjHGQNG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Aug 2023 12:13:06 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556EFE76
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Aug 2023 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691424784; x=1722960784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sNbAKAy+kC+Wc23YE/wIUBncRpx21RCAvcHOtTdCSWs=;
  b=l777dB+pb+PbHHLKoyi5uKqrdN82dJx5u4sNiRn4oPZdprhgFF1Gqard
   bzKR5mNI1OR63gbclxg7tySinY+BWEB1cIorzWElFGp5eK9qoaJi8V5rl
   Mm3SO+IGF/90UoCgKoeJUNRH+ZZ6ZjyuelXhndSY3abm+q/6nEYfKJ7f2
   /wlEsoLQx3dCBIpzlI+DoVP5dGARjxmLMqSh9fsVuKRPeBjYQEUV5zeWD
   jzuHK4QwuHOGFNIPBwIOy+myqoTq9xsxR5h90OXr2UrZ3rE0ZJOXPzFaU
   mC7pnc/JlkCRTNjBrdMBZAARYV0F0gZ5jXFeNcWDu4bGbzxQ2c0doJG41
   g==;
X-IronPort-AV: E=Sophos;i="6.01,262,1684771200"; 
   d="scan'208";a="240711012"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2023 00:12:57 +0800
IronPort-SDR: WEPIeEzS0K7saSRN7UcGHJkMMQFVx6BBSaiOj0KWp5kwyUBgiyQzYUCgZDkReiIjLfX2fxjhgU
 4aD4PB9WIJNVHFrVTrpH5yjH8gFctL00ahxpBcQ5jLZ3wFiK1bgs+MEKuxZR4cSCxZIqPDyE7n
 HY9e1fdDkhNaCAfa/k7IOoCRomO9Oy7VCU3J0ypDfXhemqbCWTRrDdwyycMJJ/XXdRgxBriD/j
 QYpq9IYLEgRMyxqtl8/bwXsJRu8jbX4LDszvH7JlH4nSlkb4yY527VA9IJer7lqZ6wt5vax1L2
 fnA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2023 08:26:25 -0700
IronPort-SDR: OxVxPwM8VKJEwZsENOuAV40PfZzfZ5Hc77zfXiu91kYgJXtOwu+KsYYT/44FptezOmqlGw9wlm
 4Lbzqn+/D8hQ3OdEs/VecgFoIrQQ8GVCVne0YWqvM85BucdRBtre1vNg7aMGPLnzGFm1zrNsLa
 cnYLryoZ4LsASOICUnzN+w0VO3NcTe1W48oUEhSyp4cvD6+VxMFlL8FdC35NN/As3oFpLcyhhE
 kCIOd0nkr+ZFvsTv/XeExW7ob4ShTdjEsb0Zfy4u4D40IpnIMR4+YqO9Cmp24YsNr4KOppvmml
 U5w=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Aug 2023 09:12:57 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 10/10] btrfs: zoned: re-enable metadata over-commit for zoned mode
Date:   Tue,  8 Aug 2023 01:12:40 +0900
Message-ID: <57ce9e40808eb46ad1ceff1d3bde4cbd82b2cc2f.1691424260.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691424260.git.naohiro.aota@wdc.com>
References: <cover.1691424260.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/space-info.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 356638f54fef..d7e8cd4f140c 100644
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

