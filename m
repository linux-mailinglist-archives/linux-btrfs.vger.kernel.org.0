Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DA5465FCF
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 09:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356215AbhLBIux (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 03:50:53 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5816 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhLBIuw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 03:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638434850; x=1669970850;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QYtF28DB1SCpGSD/SkqsVIRBSHjaVE+h2/+t6sogOsM=;
  b=cnSFnsABjsvmjIxIvR4fQV5cL+MS0gWqKnCN7eVlgETJFZvQdFzzKY2j
   Gub310IGvzFNBJ4nUm8f7cN0s7XKvp8P1i+AmHgargbHpFZ0NLb9C5kMS
   UeP2UxEGmWNu/Be/cGX1Tmpt09oUAOeXIQp3PVpqQvhSdjfRb/U30xZtI
   BACQd9HGluk4zcC0G4q+YYITnv6tQCCytKPOXWENLfzbH1VI56GwXhuhh
   8Aq0QrV8YgW93PBVHS/yf2eMzddBTz5tpDByH9IKeGQ41ZhUwI2Y68rVV
   D9bUn1dim8J4597MoRAclruGNAe1vlh6PIpGk0MuGU16tUe3s3DSCGiUC
   A==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="186250963"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 16:47:25 +0800
IronPort-SDR: ufXNqeXVdYfhC/qq73U5OmKHzWCbrEfjcTGVmSwhfE6axofy/WBwp9EwdVd8pgqlE1WypisIQh
 +4/dRqWacvwQFdZs1D5li8teG+orDPjLcTH6Z4hPl3EULx0bfK+8oU0ktflUEuQwEO1ENu5k9G
 XpJZuasivb73TNfASftEXhfsTrkGTAJRsq7/i/I3d6taXU06+CT7UbkEZ588ipID66gO7U6zfN
 SlfVnayF2qht0sLSOncpyMYvXL/adDm/3CayZlR9AIXT4e3E1NhYbz7qLTC+w9bT4kuVmz3huB
 ZUmvTY4ABvzQYZuxoSKh4D4W
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:20:35 -0800
IronPort-SDR: OlLzBMNs+oThbk7E1kYgSLKDnMDV5w9ffsYK9OfpMkc/U1CumvIvMpLkHN5S/aYJCheZjvBE2K
 puQEMn1cnZAo8ucRQrUjshc87GuAsPfn24VAlH05MLk4XINhMhNlkiTiyiOLgdRFtzc5yf5XTW
 5XzA0Amfa33w+8PNnS6G6S4kj4llDw6Ox5OHHree/CPL8RkP3pxk/JuY33SQm7BgImoCKYh/Rf
 xfg9hGOXKhfs/ICC7Omv2YwTZjKnUZcM8HVGNRTGOTVHkLwrsNBHmV1kceFKjRDl0ihbnfj794
 d1Y=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Dec 2021 00:47:24 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH] btrfs: zoned: clear data relocation bg on zone finish
Date:   Thu,  2 Dec 2021 00:47:14 -0800
Message-Id: <50bfb0a3d3bedc7038f2e1926c95aa71a3260e75.1638434808.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When finishing a zone that is used by a dedicated data relocation
block_group, also remove its reference from fs_info, so we're not trying
to use a full block_group for allocations during data relocation, which
will always fail.

The result is we're not making any forward progress and end up in a
deadlock situation.

Cc: Naohiro Aota <Naohiro.Aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index c917867a4261..9cdef5e8f6b7 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1915,6 +1915,7 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group)
 	block_group->alloc_offset = block_group->zone_capacity;
 	block_group->free_space_ctl->free_space = 0;
 	btrfs_clear_treelog_bg(block_group);
+	btrfs_clear_data_reloc_bg(block_group);
 	spin_unlock(&block_group->lock);
 
 	ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
@@ -1997,6 +1998,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 len
 	ASSERT(block_group->alloc_offset == block_group->zone_capacity);
 	ASSERT(block_group->free_space_ctl->free_space == 0);
 	btrfs_clear_treelog_bg(block_group);
+	btrfs_clear_data_reloc_bg(block_group);
 	spin_unlock(&block_group->lock);
 
 	map = block_group->physical_map;
-- 
2.31.1

