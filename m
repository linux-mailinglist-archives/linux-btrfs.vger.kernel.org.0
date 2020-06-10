Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840E51F54E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 14:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgFJMdd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 08:33:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12377 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgFJMd3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 08:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591792408; x=1623328408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oMfoutGETTP0olztKA64IXtyFkR9BV6V/NZVlxq+TJw=;
  b=ggemvFnNM++pavZHt46LpKnVZCzo2HT43Ep6HRZmWeY0U0h+cbu8yti7
   PZzZlOtqIZTup7H/cQNAFgkvRWVV64vCGMZPFV4R8r9xbqe94gKIzIrIz
   pbQjmAlp431yKSxsvEvaBpV9ljB2bolZ0BhwIIo4ZyYA/zbGPm9O/cwl/
   MB3aEGGLAul7mabAG6RoUK4mzbg1IBERB2aWkasq6KV7S+IwanW5stdXn
   cbty0zLO8hy7pzueGnUcNX9iQw/R9DwfSoDKoBX13nmfO+Id4cZNwxzqJ
   dEklVIpp+io5kMZ5dJiyIyHnHcauTGx0PeBu7401dirJn0OeuPj4v+8AJ
   A==;
IronPort-SDR: X0T7O/xREKT7rk831JGLqqxKPjGaHlpggEpoK2nzMaQTdexPEILmsCizRWO0RBv66zP4xpxtj2
 eC9FbBodMU0M0B2TTD6m+Vaj7XSgSPWprbH5OTgMNy7SdkFW1z0ODS7zWN8kf53b3biRGn7TlB
 bpmeSXwCnVRxNZL3m8FqlXqjlWN2SfYebcBXPQVPuHkBm4dCReLnikdIOT44RznIZA+L30ql3U
 tbDPactKVTN34yLYiwRkZQYjgvWIsoNGPzecgJ9KGyP6MnFFSW8QwXMpQ+6PgvTjwe2pEv+Me2
 YCQ=
X-IronPort-AV: E=Sophos;i="5.73,496,1583164800"; 
   d="scan'208";a="139632709"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 20:33:13 +0800
IronPort-SDR: SMv6d/trapU147e4PXveToQTpOlVS6O6Gbc0eFlWQC/HHnAAdPZbDoissDIZm1SSsFnuD/M83W
 x35RNhuXlpzD6YJfcphs9rSamiFZTFZNc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:22:40 -0700
IronPort-SDR: hzT8yQZfP3dobmkE53s8/dkyt5pYh3sx0X+fEK/fFbH1snxAHmw6cNV6vJ06Po7aWpZws6kNo8
 gO2Sg/7619FQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jun 2020 05:33:12 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 11/15] btrfs-progs: consolidate num_stripes sanity check
Date:   Wed, 10 Jun 2020 21:32:54 +0900
Message-Id: <20200610123258.12382-12-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For all RAID profiles in btrfs_alloc_chunk() we're doing a sanity check if
the number of stripes is smaller than the minimal number of stripes
needed for this profile.

Consolidate this per-profile check to a single check after assigning the
number of stripes to further reduce code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/volumes.c b/volumes.c
index 80b4b373f012..80144a763b72 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1133,36 +1133,27 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	    ctl.type == BTRFS_RAID_RAID1C3 ||
 	    ctl.type == BTRFS_RAID_RAID1C4) {
 		ctl.num_stripes = min(ctl.min_stripes, ctl.total_devs);
-		if (ctl.num_stripes < ctl.min_stripes)
-			return -ENOSPC;
 	}
 	if (ctl.type == BTRFS_RAID_RAID0) {
 		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
 		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
 	}
 	if (ctl.type == BTRFS_RAID_RAID10) {
-		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
 		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
-		if (ctl.num_stripes < ctl.min_stripes)
-			return -ENOSPC;
 		ctl.num_stripes &= ~(u32)1;
 	}
 	if (ctl.type == BTRFS_RAID_RAID5) {
-		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
 		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
-		if (ctl.num_stripes < ctl.min_stripes)
-			return -ENOSPC;
 		ctl.stripe_len = find_raid56_stripe_len(ctl.num_stripes - 1,
 				    btrfs_super_stripesize(info->super_copy));
 	}
 	if (ctl.type == BTRFS_RAID_RAID6) {
-		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
 		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
-		if (ctl.num_stripes < ctl.min_stripes)
-			return -ENOSPC;
 		ctl.stripe_len = find_raid56_stripe_len(ctl.num_stripes - 2,
 				    btrfs_super_stripesize(info->super_copy));
 	}
+	if (ctl.num_stripes < ctl.min_stripes)
+		return -ENOSPC;
 
 	/* we don't want a chunk larger than 10% of the FS */
 	percent_max = div_factor(btrfs_super_total_bytes(info->super_copy), 1);
-- 
2.26.2

