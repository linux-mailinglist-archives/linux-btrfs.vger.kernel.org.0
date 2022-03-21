Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446584E2DA4
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Mar 2022 17:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348295AbiCUQQJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Mar 2022 12:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351078AbiCUQQC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Mar 2022 12:16:02 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F1726C4
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Mar 2022 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647879271; x=1679415271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=za+nd/YjyhWLL0KnFAqXQ5fGPSN6suf/J77GM2MXiTU=;
  b=DgHgjzEIo7bjPBjeX9SpqFPpKLjrRadiCtJnL2hvp4Q7I8yL00APoMVJ
   YSNT71F90S7Kd67KXqUOsDdY4OQ23BiPhlLG+a02CE96ekSGGH7HRH7Vz
   iFlTADXXW0ikLbQeDq8AybhAnx34H1tGL/GTgYiBT4I2ykiNlZmHeqtEO
   TlepONXA1VOCPsmmmnPlVlVSuxVeRkcRjtyjv02G/4inLKH+DC4I+ybnk
   RwxnMw++HnkqF/MbSOCpbn+hUaxXU/TGUSNB6fPF9nQu5dNszY4CtGuU7
   pq94X0z/HfA5NWZbeNXdtCa3iGpH7sDTLqDyIFDfLo0HyXFr0jbSI7CvD
   g==;
X-IronPort-AV: E=Sophos;i="5.90,199,1643644800"; 
   d="scan'208";a="307836354"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2022 00:14:31 +0800
IronPort-SDR: 857iaN4GPJqV+66PSZd/FXuCdeqvKqUuD1dEVI5FaBu244RGnnFAwi2CaceY/XS72lKnGQsdsw
 noJbCNS290k8U91KGXxfXF2eDlc8rILevvhweYknseWl/Bt0Wg9QDVBhc5OJXnvfcMvWAMVxUC
 QnaQ/sBxp+gd6D00s5oJDSZyYBbbty5sMmHAgOY/02A+NX7M5XhVtgvtqRjmWVVbQAfVqxB5vF
 F6KmG8ljK3bZQPEx3NtIyv609M9dVQkS9Fez7+vH08RgnGekBVl49/wyKgvXMYqwiqWOmvTakP
 FyI5nSiV7OMnVNv2mPslMe6A
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 08:45:31 -0700
IronPort-SDR: tW2/Ma4zrOtiZuaMuEcLevm0DVC7WiO/xMTBOT4jqb2cp4t7wAC2djZDmcCscewTVvYy/EYRq1
 qWIoysmrXpoI971JRUtrEtPoVuVOV+bNtGjtOxGVRkfM6qbvyIT7513naMAUo1L30WzzgrKiNA
 QlNh0wQGicU24qXhS/BuXl/6Mid0krikIWL32OcmuGapa3UMV4O4guRHFhlUjh3kQHoVrMk29P
 gfl8vtGF5MVyXue7fVUK1+GoQAP1KzmoVA3vf7+HteBewWOZuSvRIcJYwR4UTnr1+bTKn2cC/Q
 Mmc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Mar 2022 09:14:30 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 4/5] btrfs: make calc_available_free_space available outside of space-info
Date:   Mon, 21 Mar 2022 09:14:13 -0700
Message-Id: <c77bf5c2e069891e6885197dbb080f8847bf7b7b.1647878642.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647878642.git.johannes.thumshirn@wdc.com>
References: <cover.1647878642.git.johannes.thumshirn@wdc.com>
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

Make calc_available_free_space available outside of space-info.c and
rename to btrfs_calc_available_free_space.

This is a preparation for the next commit and does not impose any
functional changes.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/space-info.c | 8 ++++----
 fs/btrfs/space-info.h | 4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 60d0a58c4644..e1fd1b1681fd 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -301,7 +301,7 @@ struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 	return NULL;
 }
 
-static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
+u64 btrfs_calc_available_free_space(struct btrfs_fs_info *fs_info,
 			  struct btrfs_space_info *space_info,
 			  enum btrfs_reserve_flush_enum flush)
 {
@@ -349,7 +349,7 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 		return 0;
 
 	used = btrfs_space_info_used(space_info, true);
-	avail = calc_available_free_space(fs_info, space_info, flush);
+	avail = btrfs_calc_available_free_space(fs_info, space_info, flush);
 
 	if (used + bytes < space_info->total_bytes + avail)
 		return 1;
@@ -722,7 +722,7 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 
 	lockdep_assert_held(&space_info->lock);
 
-	avail = calc_available_free_space(fs_info, space_info,
+	avail = btrfs_calc_available_free_space(fs_info, space_info,
 					  BTRFS_RESERVE_FLUSH_ALL);
 	used = btrfs_space_info_used(space_info, true);
 
@@ -803,7 +803,7 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	 * much delalloc we need for the background flusher to kick in.
 	 */
 
-	thresh = calc_available_free_space(fs_info, space_info,
+	thresh = btrfs_calc_available_free_space(fs_info, space_info,
 					   BTRFS_RESERVE_FLUSH_ALL);
 	used = space_info->bytes_used + space_info->bytes_reserved +
 	       space_info->bytes_readonly + global_rsv_size;
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 0c45f539e3cf..a957d84d8ff0 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -151,4 +151,8 @@ static inline void btrfs_space_info_free_bytes_may_use(
 }
 int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 			     enum btrfs_reserve_flush_enum flush);
+
+u64 btrfs_calc_available_free_space(struct btrfs_fs_info *fs_info,
+				    struct btrfs_space_info *space_info,
+				    enum btrfs_reserve_flush_enum flush);
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.35.1

