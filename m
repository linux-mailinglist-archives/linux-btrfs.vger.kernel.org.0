Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725F3360B34
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 15:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhDON7Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 09:59:24 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:46699 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhDON7X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 09:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618495141; x=1650031141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MoCcl/0HATB1DrxZlF860oBJ5o00QB6mhbpEGDWyuUo=;
  b=UdXkZt3bKQ+Le8oFjZbKuABbCedqO+XlqUZsuU0QezGVv0DnjCqR7XQm
   WPisk5TBU/53tvFD4jVmbe6FYg5l8//eaX0GZkQhXrmWebJfRlK3i2hX2
   XdJ6w7yhmcdOzC/GpFISpyTK6VsoXIH/RA2kR8D/2q0Oe/JlxyYqmUqb6
   OdVrxBBOsKiJZyq2GjOgE/V4ag7kloc15KxRIl1uVGSZFQmtbubWp9+WQ
   uh8ITC08PWbFT9yWA9/TPkCaSdhIWiW8NAKx2D8XAQayl5r1tmKpImXNq
   RqJoGuASs44ezM24Y+NketmcB76+qUpx/SfvfiOwxeG/MhN5/u1nQOaR6
   g==;
IronPort-SDR: GKMqBSrHXt4FaTuzLVSxeOcmu0gmkgDV+9Zhx6vEzDLUPTjUh56uWVcmW3kVVESp+c2X4eAjR3
 M5reLx9ehcg7tjCnx/WwaXltFuR+LmwPKOMtgm95lKUZJgNbbYeEOmoPJQpx1O3xUF6QvvONFp
 ifbTbUloD4+pXvlr+kNixUrCn0CwpGVz8wrHbfUvYDfHFStyp5QGB8VTOlHJJcJEMtfMcqay2a
 MzMakFLS8tocd8/IsL9+epuFOrzLGYaagVTR9FldXBMdp5W+hWyu6SflW8itMHSbfKvlXBVeqx
 KwM=
X-IronPort-AV: E=Sophos;i="5.82,225,1613404800"; 
   d="scan'208";a="165555188"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2021 21:58:55 +0800
IronPort-SDR: rR9lLBhCTzRnuIdqZNqeYmV7/Zb1/WGdE4W5frHYHLUVqKF5OqMMoFoAHztMKQvdMR/YCY3Q+x
 YF63a8qWXbFHSeJn3MjYghmlRHGDLzH9KLzz9MRsISd5cyqIIXTZqtdws09BRUhHI4Oa4myPwK
 Ito1CnSqqpQx0VhUwjNoDi0jV3QaFpkwb2wtfONvm0DfVzYBrc011try8gMr7jUgIbtaPCOXMh
 PBmJlc5uWm/eJImwhaU+SSGsiH/exIjZjzroVJEgJF8xKDOWrW1+Bag+zkqz9Y1K6PYozZjWxK
 FO3xGcdG/OSxhG/guRseGhp8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 06:38:07 -0700
IronPort-SDR: ZJEoaSfy0XeC05Nn+Hi/cDLCILrdLg+U+vj0YKBYZ+ii6Fwt2OS85j6UlMWh292CeWmgXvpOC9
 a/X0TsusfXqEfMeq9mSH+DdwVmqxYSZspX43c1CNsrGuNr6YhSHWWMs5WkT6u8RncQNpjtjY28
 sCAcdLXP6CNz4R09KvtFGAM1akttGB87rA5HOnpriybhH+y5svZfxnZLt2LeWCNfp4erNgSF/6
 NahGJD9WkvLMalNVHEBlEQT0B5mZQFcoLMyEfB78r99H+jQ4g0plfcAN9INSEarZ7YwWntZc3z
 MMg=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2021 06:58:48 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v4 1/3] btrfs: zoned: reset zones of relocated block groups
Date:   Thu, 15 Apr 2021 22:58:33 +0900
Message-Id: <d3aec3e168a547dcc39a764f242d1df9d3489928.1618494550.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1618494550.git.johannes.thumshirn@wdc.com>
References: <cover.1618494550.git.johannes.thumshirn@wdc.com>
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
---
 fs/btrfs/volumes.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6d9b2369f17a..b1bab75ec12a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3103,6 +3103,7 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	struct btrfs_root *root = fs_info->chunk_root;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_block_group *block_group;
+	u64 length;
 	int ret;
 
 	/*
@@ -3130,8 +3131,24 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	if (!block_group)
 		return -ENOENT;
 	btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
+	length = block_group->length;
 	btrfs_put_block_group(block_group);
 
+	/*
+	 * Step two, delete the device extents and the chunk tree entries.
+	 *
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
@@ -3140,10 +3157,6 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 		return ret;
 	}
 
-	/*
-	 * step two, delete the device extents and the
-	 * chunk tree entries
-	 */
 	ret = btrfs_remove_chunk(trans, chunk_offset);
 	btrfs_end_transaction(trans);
 	return ret;
-- 
2.30.0

