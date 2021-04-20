Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8A8365F2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 20:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhDTS2G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 14:28:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54900 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhDTS2D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 14:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618943266; x=1650479266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kwNrES7sF/1V0h9bpoi4I1u4bIjRndTaw6cwW9N8Zec=;
  b=jA0Bo7ENyzmUgseM4aYI3PxB7GD+GNiGXu50jmrq930lPDcuDSAy5CSB
   EmfGSGe8ZGkoItLuJuIgs7Roi+AsQbYM/zMwD2NBc0YRit+i3v3yxDIlE
   q9p36vfj7gbCMQLCXJlaynLb6EMmPI+rqm6rVM1+eyJsGlwTNzp3qKmd0
   8VIewRig+qyXN/TcbAM3FWCvNQ3CLbddfvseePLBRwh9OfnmXlvsH+WeR
   7b408GYdsMbS1ea8F3cCSB6+4xVrRBuIU+ZpTQRALivwm0buQ9pw+7tB6
   RygGckgxUwUSpTjaMXHf6cr8r4H1gUyKxdvwXVjeqiW74ShsFfrgQIrng
   w==;
IronPort-SDR: J9w+15gLDktFVCYB6rqNLaA+1e2AQSUTEDR2HWu5AVxcmA52SdpK8DqDztasGoZu29y8ueO9gg
 7Jr3xa8Xo0cC1TBHGsb0XWZ0UH7DIW0NKuwcso+Tl2ScP5zdTGLEvEdjTo7dK6MEjOk/au764z
 t9jYRFwIdODSoIN9NhXBB8hV4SpVcX0ghBbT840WO/yw5GQ8KZP4IRaYu1chHM6LMOGpyjYZlN
 ov/hR/4RUqtXnGaFKJn86AlDoMCZ8VmyAex/kzFvjA1FQlL5cnvfRXjrcs2gj4v090B6VoHpAr
 Hp0=
X-IronPort-AV: E=Sophos;i="5.82,237,1613404800"; 
   d="scan'208";a="269507070"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2021 02:27:46 +0800
IronPort-SDR: j8dxKH9SnMhBVzwuX8rGe9ITnlFpM2CH1P6PB7+lt3EurYDLfSMViv6sfPtWQMhX1ymvONrSpJ
 +s0QfRB1Z2VEQ9g6iqB8cjKyWtp/kPuRquwXXzoz9lat+01MvaMT8FRCdL+8U/3PKNgLT4mUXR
 d5JH2hNjZxEQTzTMCKfuyqGOv0Kh7CFBVJuh0z9SK8N55kS/OWN0jNkXOwpvONy7ZBhgy9LzlO
 tNwxYJjIrsnAVqgYEPdj/e1ULT96dbSumpVc02X6cd2lMELy73lBm6D+G+3LeftQ8eDIwqLSq3
 Na17+wyM40SCODw+aGa7sNrl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:08:10 -0700
IronPort-SDR: t5GLE9BelisE1xK8X8WUG9lnwWn7Ifq+e2ANqRg4LxRWAMmyioI/aqzoS3QGKC9R87R/oiHuTY
 xQf8hcNzrlOr4wvXQZBt9UXHtLS8DX22ndVSgqjHUimD4zaYTPrpdrc7zXQPH03aW8IxdEE7c6
 kEApZuC0YElzg1xa31qq7Xv5/jqkH4A/iEFaopTcYn4iQ+/W99EyN+ejPUO1dUlYHe2iW1xnpU
 aDHOXNbR35ER+DINxVeC165kvGBK8evCjj3om8BR0Yg0QBKc9cI+/6Q406HDhtDUMfG0pfHMZa
 TKY=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Apr 2021 11:27:31 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v6 1/3] btrfs: zoned: reset zones of relocated block groups
Date:   Wed, 21 Apr 2021 03:27:23 +0900
Message-Id: <accfdd59409776466cacb8b5bf67db7e346f6435.1618943115.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1618943115.git.johannes.thumshirn@wdc.com>
References: <cover.1618943115.git.johannes.thumshirn@wdc.com>
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

