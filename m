Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB2D56C4FB
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 02:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbiGHXTU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 19:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbiGHXTQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 19:19:16 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB4B4198E;
        Fri,  8 Jul 2022 16:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657322355; x=1688858355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CEiqME908kz6QYHxabvGx9pQaRLg7nY4WcQdW60RnH8=;
  b=bebP+AjCOC2zjnoWUt1xoLGkkh0lWDVpDdCVEas09DveWXX5nc8GXCrD
   Oh+lIqn2iHPJSFB4iKSONfKe4e0Vc0edkHKFjD9neSMjyEfpSImd3OzOJ
   41XoOeJwcSFI08dnNaP140o5HizLQjpx/WWFBWlBK8LE/sBJkUcEcPEfF
   D73BH17THXQ3XPu7glX/jh0IpN2nviJVJu4m8bVPM0FP8DIEfa8JjmkoH
   MnUOkvoHd4UyZbZx+Z9gRlZkK2rpJhDhbWe6W5B/Fm5RIIRrOcqL9Xap8
   7KzCUF6/Cmjm/26QjGUaGLo/MiVYhECRFGdY5pmvEeI/YF8Jgw85wlLkk
   g==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650902400"; 
   d="scan'208";a="203871834"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2022 07:19:15 +0800
IronPort-SDR: dmbMpwOdNIYZ18mKgsBHdjhJi5tG2OSDnsBvUlZEWauu4D1NA9bDskBehAUaSo3LI2YTvmRI4G
 jmNGGDzYhSeRy1+zYmZn6lLlRKBtoGuJBtZgENS4VCL/TqUtLq3QDtPCjzdjbUrcuy9hxvn8Xv
 mMhDUFC69FgrDbHs5LMhPWiFpNcb28p7cfUT9oU5Wi/73AV+NtVilFlcjjXz1kQ/zhfbfMHFs6
 /tCjTUZhSguYzjaHSFwU6YHun2F7zgTazT63rg2LnzPtV11c7HgnsbDeK9IJSBMo5uaZAvRNo5
 wCtWOH+5zpMyEUtbK6JX+1aA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2022 15:36:21 -0700
IronPort-SDR: eUMj/ZsmIzaPJO1Aapall29LD7Sh1+WJcQletCRnRUTx/qhNfA0bK8GRH+0ygVcL2TUlylujuP
 Xhd1RdTRGaMcn0ShNsiCpzQhYsVnP3BEAcC7eSNY+q1YSdt7iXLR5eCfEG//cEwYUx0B0B9lBU
 NZEDiD9yzjWUmdyGZ5PyEQfNCxJPbu/4Ajd/f1Xwl6JatM82wSjbvl0smkq1QEzwb3/pZMlmkZ
 QjfuLctX/6vKlU0e3mZUk6e1CzXUK1ffZ96Bd431q0BNoE0HcaLgOdZ1mr3v3Hq35X4c9oC4M2
 QKc=
WDCIronportException: Internal
Received: from phd010370.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.250])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jul 2022 16:19:15 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 11/13] btrfs: zoned: activate necessary block group
Date:   Sat,  9 Jul 2022 08:18:48 +0900
Message-Id: <c086655f0fe9f9e3aad7f73dbc126380f703f413.1657321126.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1657321126.git.naohiro.aota@wdc.com>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
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

There are two places where allocating a chunk is not enough. These two
places are trying to ensure the space by allocating a chunk. To meet the
condition for active_total_bytes, we also need to activate a block group
there.

CC: stable@vger.kernel.org # 5.16+
Fixes: afba2bc036b0 ("btrfs: zoned: implement active zone tracking")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 51e7c1f1d93f..14084da12844 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2664,6 +2664,14 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
 		goto out;
+	/*
+	 * We have allocated a new chunk. We also need to activate that chunk to
+	 * grant metadata tickets for zoned btrfs.
+	 */
+	ret = btrfs_zoned_activate_one_bg(fs_info, cache->space_info, true);
+	if (ret < 0)
+		goto out;
+
 	ret = inc_block_group_ro(cache, 0);
 	if (ret == -ETXTBSY)
 		goto unlock_out;
@@ -3889,6 +3897,14 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
 		if (IS_ERR(bg)) {
 			ret = PTR_ERR(bg);
 		} else {
+			/*
+			 * We have a new chunk. We also need to activate it for
+			 * zoned btrfs.
+			 */
+			ret = btrfs_zoned_activate_one_bg(fs_info, info, true);
+			if (ret < 0)
+				return;
+
 			/*
 			 * If we fail to add the chunk item here, we end up
 			 * trying again at phase 2 of chunk allocation, at
-- 
2.35.1

