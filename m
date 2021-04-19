Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A931D363CDD
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 09:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbhDSHmJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 03:42:09 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21554 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbhDSHmB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 03:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618818093; x=1650354093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tQRuhKnrCLWygmg4qKcmv1OQZLEI50TxoYyeU6gL2uE=;
  b=Xo0Y6u+ldOC6dWLD3gUXS9dI3MKr4tHiJdAkpDZ21oISGrUcF36MIHhG
   DRVxZY0+i6laH+Sw6giB8SkNUnjntpRLwuDCG07WrAxgIwCYK5mWXkKfl
   S884q7XRCUE3iWbSbvFRXZ5huAyTukP+PrkO+rtXwJX95QOy1+1ZnutW0
   BemCxnBWPZz6NtEP5ICY8CdpIcBhJOW6wAjl6YOtQcQ3Fy16deOH4kPqp
   9wHevkDxEOYD1SA6Y+pn0RVec0D4JAZ38Vu6D1BTX1wf6UA7vwpTddjVE
   3lvYqKA5iLVVV/gACfyi/4QlIMuGy99aswMiDw6yyvYCUS+CiZhyBGfSo
   Q==;
IronPort-SDR: TBwxUWs65aArsGN3nkEXmLYDmHAGc1jhqSCIJ4MV4ZnGm/pl6L2TmFlVgfsxAXjqsGN636KPGB
 pQSXJm7K8ad6ebuhPMQG0a/74Kx+w3tIe2EJYgTwnRYatlK1y0QwkKuSk1vyRN/gPm8RHhM2hq
 VmU2eexI5NBKPf8jyGopksP57diDbmx77kzSk7jUaOtfxZ/DvHnw9PbK85A9MPRZAZNlhNj9Qy
 HIS8ZFUVKdUq/C8CSke9eGUSRTTKZWCYDtHc6TFcp5FjzQJYjiDwHasfO2NuB4g3ynrEKvDhv6
 7BM=
X-IronPort-AV: E=Sophos;i="5.82,233,1613404800"; 
   d="scan'208";a="165966778"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2021 15:41:13 +0800
IronPort-SDR: vWnA3SaAKAqMQgxrexd82+L+Iag1jW3IFjN3jek5bazr5IQPSaFSbvZF2/RNNsQojmIUwNYlUo
 ZoVfUVhQd1fV69zz8D102JnMsdoJovX7UrdfjU6LNe3nbUzV5+1qqPoB3QWDQmfdNMsEKESr37
 EsSBf8c5wN4ZXVrXjb5Td2IF++CRC78MpPAwalLR0gAYoT9KzD1MKLcRP+kSVzkKepx1iY20Tj
 B4IOkPjq+3+IlGd59OdujyG3lqEebl8fFRcEYw2KlYzbyMD35qNTixOyQ5ZZC6RSqt/jENeH4Y
 SqFl7K3IpsHNngTMjiGkiSkK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 00:21:54 -0700
IronPort-SDR: h6EH/kG6HytdqZr4zz5S19+4zcXDcMt+ujxfIXsUivMlD1QhlHxBZ9YNqYmRTsg1v5iMiNU+EE
 Y8i0lGeBEniqDFZrrb1zVL3PeTmomH+m2ejUgP15wMr9dcdemSPODZvGgli6/WHA8u8dnFI0na
 bpSyyhAiTIA1Y5DFfQQAwoAY3BUthvs32AoCSOvV7sJxnvcnKkE6y6e9mwl28oVl2kezeCjvh+
 a46dnbWwgmoGxlS/ENDrcZtdF/X1s2qA2z7UEOX/XCoxFU0KjLfDnt5YycqBR5y6T0YGy2zxhF
 wtU=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2021 00:41:11 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v5 1/3] btrfs: zoned: reset zones of relocated block groups
Date:   Mon, 19 Apr 2021 16:41:00 +0900
Message-Id: <accfdd59409776466cacb8b5bf67db7e346f6435.1618817864.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1618817864.git.johannes.thumshirn@wdc.com>
References: <cover.1618817864.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When relocating a block group the freed up space is not discarded in one
big block, but each extent is discarded on it's own with -odisard=sync.

For a zoned filesystem we need to discard the whole block group at once,
so btrfs_discard_extent() will translate the discard into a
REQ_OP_ZONE_RESET operation, which then resets the device's zone.

Link: https://lore.kernel.org/linux-btrfs/459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6d9b2369f17a..124c17ec53e9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3103,6 +3103,7 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	struct btrfs_root *root = fs_info->chunk_root;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_block_group *block_group;
+	u64 length;
 	int ret;
 
 	/*
@@ -3130,8 +3131,22 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	if (!block_group)
 		return -ENOENT;
 	btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
+	length = block_group->length;
 	btrfs_put_block_group(block_group);
 
+	/*
+	 * On a zoned file system, discard the whole block group, this will
+	 * trigger a REQ_OP_ZONE_RESET operation on the device zone. If
+	 * resetting the zone fails, don't treat it as a fatal problem from the
+	 * filesystem's point of view.
+	 */
+	if (btrfs_is_zoned(fs_info)) {
+		ret = btrfs_discard_extent(fs_info, chunk_offset, length, NULL);
+		if (ret)
+			btrfs_info(fs_info, "failed to reset zone %llu",
+				   chunk_offset);
+	}
+
 	trans = btrfs_start_trans_remove_block_group(root->fs_info,
 						     chunk_offset);
 	if (IS_ERR(trans)) {
-- 
2.30.0

