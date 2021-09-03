Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7768640016F
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 16:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349508AbhICOqK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 10:46:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12664 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349170AbhICOqG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 10:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630680306; x=1662216306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o1pPTApODhfhCGNE4ZarZZKzoOD7rJELNlvXKjukYnE=;
  b=eKKsLt/dx++F2eCNu9SFYeAA2WqpvR1RYtMU3pzTutWx4yucLUIt6yr7
   OovJrD2jI6oqutljsc6moMYBQncKxiKmMIzXXQitUuaOKrb0WqXDqzmjO
   TBrCNZdXroWLubxvp6ra4L1nGLoR6hotS1v30hZvuMv2GVB9v2Wzp7P6H
   j1Skbj/1ueKtyVH8PICvHS507ACsDCf7HOjB1hW1nMmhgCwvNB/fQ1L/G
   K5pJffu8sBgoDD00tvLFCIeR5rDL2gn7vVEpVp7ycmpQvZ/CzKy0wEQJ+
   J0NeFWW44I1w/pJ5oQkLe629g0gaEVvXUr3bkD2jxXpe/ZpJDB7gCi1L0
   A==;
X-IronPort-AV: E=Sophos;i="5.85,265,1624291200"; 
   d="scan'208";a="179681181"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2021 22:45:06 +0800
IronPort-SDR: AEcgke1srxoXV0HsEUW2SIvR4I0UfIUagGSbIUXAaHFz8W/TGqRFWiRx1vsdI6HnYdfLRpyuuV
 zczS9hvZSqO2gs5YG8EWJMDgw0muyowbntQUDb76eA6lkAlaK0VRfJs5OMVweI4Jp0QjHJsHKy
 ydiyxQWcUv2mKBk0IpyuJysNK/jkIuBAevf88EipAGX41R4SD+mLCwHt0UdDeCEfhTFfZXxpJ0
 uEwtIP9W/ahT1+x1yyDiTgpFw81S1FH3M6tmEaRY6JH7zNWkCuz0hYLSamCdFabnb13IAFIyZJ
 Ma2cPI4707lkW4NtrROBSdWW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 07:20:09 -0700
IronPort-SDR: ccHBJGN60IVW9esFzJkjuZ5pFgmS29S5xnHSFZbAfMdKe5hyZrEZmW2fU2Ro5r0eVx/7bxVxpR
 z9OE1J8MKNtuiyilpLQ5cr+Bx8DkwJ6OdCv8omN5Q4aM8ip3NAs4u/rjFNUM2OGSPBlBdUiEJR
 RfcQwTCmv58kXlHC3is+XWgaxYOTLOUsxq3TP7irHEb8vW7gsF2wyi862iZF0GxoqgAr+AoHiS
 +AlxI84N8NyP2usqW40GYx8U51kFwQ5xzpaKqgmkSlByyCiPyZ6XeWCLOaVVwzJFOVOQH4daVM
 75g=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2021 07:45:05 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 4/6] btrfs: check for relocation inodes on zoned btrfs in should_nocow
Date:   Fri,  3 Sep 2021 23:44:45 +0900
Message-Id: <4ab859fbb26ec582130b8064621cac9de1100baf.1630679569.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1630679569.git.johannes.thumshirn@wdc.com>
References: <cover.1630679569.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Prepare for allowing preallocation for relocation inodes.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8e1a46e9c63e..5f4c8e12ebcc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1944,7 +1944,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
 
 	if (should_nocow(inode, start, end)) {
-		ASSERT(!zoned);
+		ASSERT(!zoned ||
+		       (zoned && btrfs_is_data_reloc_root(inode->root)));
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, nr_written);
 	} else if (!inode_can_compress(inode) ||
-- 
2.32.0

