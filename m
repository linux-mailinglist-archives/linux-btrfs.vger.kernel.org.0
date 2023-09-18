Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303147A4CE4
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 17:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjIRPnG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 11:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjIRPnE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 11:43:04 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673D510A;
        Mon, 18 Sep 2023 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695051696; x=1726587696;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=U9qbeiDSJYQbLhJrQS7p5rADrDE7muaLT4aPGuFW2ps=;
  b=JtIho2RRfnFTsGpz1t8rHXoNXpOqd/8heWiRzww9WkGigtNT2yNhHlIw
   FjXnYB+A7NlPR50AQv2cRso7dubE5qa/A3sZsk5TUJSr3mO49z82w7A/7
   DptpNT67rI1mOuG7HbN1twsplDzBV/DDNrOy3cGiUCIqeGxp9R1fdWOt4
   V75iujvXdPtKjyeX8c4pnTFhVNFQOtXhnqe/rFo2z3iNW4Eay2pGGdlux
   VLrjMtrPfHn6/2ZFBiPLyLnQqUNPrdkljiEeZCiydAeh07qAWW3x+xLYq
   yxWWkCLl2HAWzd+rnjQO9HLVHgRYXVLOWSF+vTbK4Xg1VfdLACOWRcSMx
   w==;
X-CSE-ConnectionGUID: HIKYJ9nFR1aDXHcwxUjuXg==
X-CSE-MsgGUID: 5BPDJXQPR7izjc/wzRXV6A==
X-IronPort-AV: E=Sophos;i="6.02,156,1688400000"; 
   d="scan'208";a="242446870"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2023 22:14:38 +0800
IronPort-SDR: eW/FyVE0qniifqTZNYNMQa9ZTwKmi6ouo1gsHuAsYRY+2kq+uixvYHDx+JIkd5vsvJu89AChvc
 EuQKhmvYtH/e9Qiqqi8x1bBu+QgdMANDKQgkH5vuB0Nq/N9UZHmuIsh4lLfDqep6rnnjZW9+yY
 /+2nJeTWQMNkMvjGXyJF6cZCMwHirZnDBtqZWuoMi7ZpAYiWFg7umc+669PmoAd1I2RSaUf8H5
 VW5TRyLlh+7AWHdmHfaRiDyLuwM1m8LC1x+D/GNm89/Q44fQ+3fgmjIf21U1ZJQeZqNLMWHHNA
 Rng=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2023 06:21:35 -0700
IronPort-SDR: caD0NdUxqZHEWJI1EhPtt8NPYt9h7MBvKWfW6BhS621lYssSFF96kBAYbPslYMXkKXW2N/E1PT
 AUUd79mfF1fYFeDXtQ6ocmIk1y5a2Z2mTMFGtWJXwvW/rzGdg7tP09ZkZQ4gpHVq2q7385MNel
 FORX9RNYPLFPeQv+RHvNJCycQ14vabNkDZCmdaeFh95HeyWqSavf1A9ThNmImabk9bpzawxlhx
 BVZsvDdV5C+NM0Tb5zpvt+05wNGp3o2zCuV6lqcMCQ91z9qmkXjD1RNH3GOymbpv5M3ZxArXnV
 Iv0=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Sep 2023 07:14:37 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Mon, 18 Sep 2023 07:14:30 -0700
Subject: [PATCH 1/4] btrfs: fix 64bit division in
 btrfs_insert_striped_mirrored_raid_extents
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-rst-updates-v1-1-17686dc06859@wdc.com>
References: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
In-Reply-To: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695046476; l=1280;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=U9qbeiDSJYQbLhJrQS7p5rADrDE7muaLT4aPGuFW2ps=;
 b=Ozf+ipDi8Mm7lWMbgnIb2J2c0Xah43hULZG86xBGVs9N4P1rloFXxWIWyhD3PxUWO5iq7boMl
 ZY4qteZM3HjCMd92H3qvA3wJDcSoSKQGvpEjKtOi7+d/G3Rh4NpBxC+
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

