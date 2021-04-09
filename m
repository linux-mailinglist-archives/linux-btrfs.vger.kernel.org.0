Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638EA359C5B
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 12:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhDIKxa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 06:53:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19455 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDIKxa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Apr 2021 06:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617965597; x=1649501597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ktEHdbH1ARtW4VHGUkqQhBFcJtgulBUBGE/DVUJdUY=;
  b=VS9xq8hAsnbYfnMdpVMSkiOa5THUUSQ6jTYbsnx0w2Vl2MeSvUm39KXE
   jqbNTA+qLJYemWR2xxx/8ovH+QlGhg4Y+aR0IeK2Z73uymfctSvcZWurI
   fpqifzic0yVnykmP9N9AMcHuJ3EdoxBxQcA351U1cXZGoSSjDG+KdV+1x
   re2bx1a+ncYJz1UXtYzdJb5KyTpKtZP1sEDAopRDbx/qgmdEaNqnge1Ne
   I8SAahmRDw44cNQyPJnkbMsLPKOiqYfeo1zphCmtzGhphawLt9JEyto+q
   v16G/4UPOEmNLspRlKv9Lz8ZPKlFWg3zzJhGYxjRJVbWxHMEkW55/J+hS
   w==;
IronPort-SDR: /Rh3hDg/csQlGRe6mgdTUius/e2re3Oa9SVeVKJ7ipE7PE5WouMNn7FMlLRzIFJy0PaaJ+dpIK
 4aBls2bSI708TViruycObj/DRKfwDdzRaY7cZs+pVWC5OSr0qMypnDs19wYwC5y7n7xsx6+H1/
 z9fdpUH0xwRMfN86JC1A8Z2PvKMQsxCcc5XJcWSVxhvWhYHIrolnUsRF0k4SBFKcFUbCLxp2ln
 ZLBcJ+Psjt1K63UC3v0w4TqjaPZjgEE1pD1CjdhKeVsDRScbD2qDT2xFwgBt2yKGw92ns/uWvY
 4/c=
X-IronPort-AV: E=Sophos;i="5.82,209,1613404800"; 
   d="scan'208";a="168797957"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 18:53:17 +0800
IronPort-SDR: Ad93I9VswxOPWpIKdt26s2rTNeahfXF5IfAfyQm4AjBP9I/mY+PCVSNYDS4qfIxm6tHLAVSgxL
 ivSzmbLNEesiZ6/ZlgHH1xfE6mAUdTxr2KtBdGiuwiTEjgrKxWCNxHGasD95XnsgEFwaFkNIQ+
 +uePQZ28md/adP1/VRHy8vbsMflRZJm0jXFTPkPnI3cEdk8WtPcyTZlQWpa1llkV47CILS46Gs
 rvmte4jhosFK3rubCAJ1hB/ZwAJ+gdBFNsB+F9BkZ3r+yAhvaXLB33fLqmK3EvBPBEOtpBgnHV
 xwyRSToOxekQLDB2qTO/wBPt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 03:32:53 -0700
IronPort-SDR: 4YTBhdAmHjcXvVX5Q7XcFgyYHQFykTKyog0/nG/uFS4Q2XNh93CYAcbAOQF2pnxUhvEHixRZYm
 AaYipszw5mi2WqHxQE2vAwk1XsAxxTDFJYBpr/6azmn+hFDeBwfGjS+s0vymaTvTAiq/O0PQmk
 Xu2f5kS/9Kn2dKE9D5634sVAMXAwGJgZy+uKShaGVB21Q86TrPPWjouSp617IzWr9A63ExOmhU
 MUGWSh7hzWHHu+hSXq9IuVmY6csXYvElFA692TW+2XQXr8ZcCJLgDEFiiABugCfPshV4tTJS+S
 otY=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Apr 2021 03:53:16 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 1/3] btrfs: discard relocated block groups
Date:   Fri,  9 Apr 2021 19:53:07 +0900
Message-Id: <459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1617962110.git.johannes.thumshirn@wdc.com>
References: <cover.1617962110.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When relocating a block group the freed up space is not discarded. On
devices like SSDs this hint is useful to tell the device the space is
freed now. On zoned block devices btrfs' discard code will reset the zone
the block group is on, freeing up the occupied space.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6d9b2369f17a..d9ef8bce0cde 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3103,6 +3103,10 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	struct btrfs_root *root = fs_info->chunk_root;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_block_group *block_group;
+	const bool trim = btrfs_is_zoned(fs_info) ||
+				btrfs_test_opt(fs_info, DISCARD_SYNC);
+	u64 trimmed;
+	u64 length;
 	int ret;
 
 	/*
@@ -3130,6 +3134,7 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	if (!block_group)
 		return -ENOENT;
 	btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
+	length = block_group->length;
 	btrfs_put_block_group(block_group);
 
 	trans = btrfs_start_trans_remove_block_group(root->fs_info,
@@ -3144,6 +3149,14 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	 * step two, delete the device extents and the
 	 * chunk tree entries
 	 */
+	if (trim) {
+		ret = btrfs_discard_extent(fs_info, chunk_offset, length,
+					   &trimmed);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+	}
 	ret = btrfs_remove_chunk(trans, chunk_offset);
 	btrfs_end_transaction(trans);
 	return ret;
-- 
2.30.0

