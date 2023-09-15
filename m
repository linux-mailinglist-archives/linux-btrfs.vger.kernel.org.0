Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F047A1C4A
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 12:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjIOKcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 06:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjIOKc2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 06:32:28 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB492D65
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 03:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694773397; x=1726309397;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NZ7iXRMHv24m1giGga0vLplIfr5PwXJCq/iB1S1+hmU=;
  b=RP/Yso01vqHS9Xe1WuRkyT+3c8l7v+X2GfYb4QwzyhvmXESsWeY290HK
   KfPFN3mZkregLmPiGTlvfwCVOtmIIkZ7usN57DZo7Vt8ds9gsbQM5CtEA
   vwTQR889gZUykBpF2eA8pz93MH8/9Dm7moDgSMilX43UGhE8EamXLAswW
   Zphj1xoDrSkEzZObG0atp64NgAX+M+5TY3GzHL4B0o32VLQSRXKx0EPFs
   txtZqG8orV09aZKiemL5hssiLklvfNJSziOP7r3f1mkF2IFuuwZQy4ev/
   kcaMq/Wz+Vh2sF0swyYNas1irI+uYEHZN700cdGzlyv8HzZih9tOfgTSW
   w==;
X-CSE-ConnectionGUID: 3kv/qe51SvmZ319u23eXMA==
X-CSE-MsgGUID: 8kdqCDsSQza5rFpIkQ0syA==
X-IronPort-AV: E=Sophos;i="6.02,148,1688400000"; 
   d="scan'208";a="349355394"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 18:23:16 +0800
IronPort-SDR: 0WKZzhkpRpIR0PxCEpygdYhM32BYC3FnHNzmdBIPJH+Gd0TDaF8bryyEsgZFb2/Wokqvs78Qjv
 jKQH+yqRzKjUuBCvbf80IW2eWQMHFL8LkQbfZ0rAMSAYG74dlx9GnIiOqZCzV/EIr4yUXqE+Dk
 hCvTWX6z6+HO1CrLKFTUE6VqcVWjSEIxs/rxPVJUQHBASd+cyvb7qgSjwRNv8MlfWu/kDwMIyH
 3UF7RoD016ErHUfH1GsIRjue6Y1aUCdo5FBMIpQ1W9BcFSBXGIqsagyQ7WN1mvTI09HuF4ZGcC
 /LI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2023 02:30:17 -0700
IronPort-SDR: qV1BGpM36JQp1rQsKeBGQ5pmxNh/z9teJwT/lMbqND6GnIgJCgr916FxiVP0I7wG8gJbdK7/8d
 Ghd1JeklCWu2u+APG0ild1BNkGFjTGvxHbzb49HBnAwUQfsoDo7cWwfljLG3zBgadEOk+un0Ei
 usrPWGfPsgJ6aMKcLhuckbkDW7C86w5uCvSFMoIS1DuPVt9PCrPj3B+I+oFjW6Br+GFvbYtBDP
 +sCRYYS6hXgUEWfhFP36mFMSFNeXVIA2TGma/Hn3cUVGlxH38IAEe7lOsS3NkD2a1+sZi5Bx4q
 J2Q=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Sep 2023 03:23:17 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] btrfs: fix 64bit division in btrfs_insert_striped_mirrored_raid_extents
Date:   Fri, 15 Sep 2023 03:23:11 -0700
Message-ID: <d1aa8b4fdead6f1e470f22b3986c1001abf33caf.1694773341.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix modpost error due to 64bit division on 32bit systems in
btrfs_insert_striped_mirrored_raid_extents.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 85e8e389990f..0c0e620ed8b9 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -148,10 +148,10 @@ static int btrfs_insert_striped_mirrored_raid_extents(
 {
 	struct btrfs_io_context *bioc;
 	struct btrfs_io_context *rbioc;
-	const int nstripes = list_count_nodes(&ordered->bioc_list);
-	const int index = btrfs_bg_flags_to_raid_index(map_type);
-	const int substripes = btrfs_raid_array[index].sub_stripes;
-	const int max_stripes = trans->fs_info->fs_devices->rw_devices / substripes;
+	const size_t nstripes = list_count_nodes(&ordered->bioc_list);
+	const enum btrfs_raid_types index = btrfs_bg_flags_to_raid_index(map_type);
+	const u8 substripes = btrfs_raid_array[index].sub_stripes;
+	const int max_stripes = div_u64(trans->fs_info->fs_devices->rw_devices, substripes);
 	int left = nstripes;
 	int i;
 	int ret = 0;
-- 
2.41.0

