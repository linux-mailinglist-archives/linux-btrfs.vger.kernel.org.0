Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF08C4675BA
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 11:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380170AbhLCK7E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 05:59:04 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30174 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbhLCK7E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 05:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638528940; x=1670064940;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EvkFAoZwQ/vXOBod031+oXJo1Xu3LWkCAURzET63jcs=;
  b=LfQw9OI0Grh4Ahy7p+khAgx040TVaAsFnIGJh0qK689ZwYG73utwK3ee
   3TPo/qUO2PKBpArMNRATSy+AACQiQ2kOkDlmoAX/2+LNAvDcThcOpJyA7
   jl/EdbzrgE14jSaCYTrptVHvaa4DFkIx+82VT5PgJoOOM3XpxEDvM2eq0
   iwDFJWfsw2w4qE26Sn4RPu0y+GOMjz9oLOQ4A/LBpBk2Hyv/VvX4WMDIS
   uLZ+K2n3sTExx+j0GqavtkP0On67VWOCOBsxgDN16IGKwpc11vcFACvjs
   z3wTa9PVxOCPiHYTPGOEG9VjKF58uq/2md3T38X8Yu44f4H+eVPqqpTjd
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,284,1631548800"; 
   d="scan'208";a="299216502"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2021 18:55:40 +0800
IronPort-SDR: izhxbgBw0twhIPZf2/aXAQzSKyTSREjdYWX1vkAxw+ZdYPRSSD6vmthzbJGr45/TzNmskMgUwd
 8htvb9kAz8U01I+iFjIW2tiqZtsdPfoYcx8rm12FfHZM7wYhVHmWEDYKa2dMHI9ZMcCHGO0xhg
 JMakQnFZdF3raJtoZXwbegy3DzstHfygRwDJiHCRtK8nAG042n3weu2swq40ulHkivJnn+AWL1
 DRtrIsWtB7iToxxPKACzDDFeqsczMRSnVJzzYvW5LddWVJ3RQJINEFvGR3kYqTTK4cjgBndmJ8
 F1SzKkVX0ArtkJfbLCe6k7KV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 02:28:49 -0800
IronPort-SDR: YytBOS+4MzMLPTpSdMFIGEM/Pg369l+hVzWesepXjYt1pH3bJxzDL3hxu2q9C+/GtFsnI3j3fx
 hym5KtyV4BufZBaZTTfeodXVoIt7pxxaXo9WU23lY/b+DpcTSuEIpIZVhkS7hUGD70J5XuunOl
 HkZWDq/fhgCID/ElgKkWmf4eFgjACRpPANiv83MBUVf195dp83DmQmT9oL2ydTXXhZChZnL+y5
 TLTCoKFFY3GpCSCwrULyB4UopPjeLwjhAm9fdFUzdAzAJSDdImHI25vkB9N3FDQGrr+q8qQtsP
 CiU=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Dec 2021 02:55:40 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: free exchange changeset on failures
Date:   Fri,  3 Dec 2021 02:55:33 -0800
Message-Id: <95ce11234dd6911a433b1a016e4d4194856212b5.1638523623.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fstests runs on my VMs have show several kmemleak reports like the following.

  unreferenced object 0xffff88811ae59080 (size 64):
    comm "xfs_io", pid 12124, jiffies 4294987392 (age 6.368s)
    hex dump (first 32 bytes):
      00 c0 1c 00 00 00 00 00 ff cf 1c 00 00 00 00 00  ................
      90 97 e5 1a 81 88 ff ff 90 97 e5 1a 81 88 ff ff  ................
    backtrace:
      [<00000000ac0176d2>] ulist_add_merge+0x60/0x150 [btrfs]
      [<0000000076e9f312>] set_state_bits+0x86/0xc0 [btrfs]
      [<0000000014fe73d6>] set_extent_bit+0x270/0x690 [btrfs]
      [<000000004f675208>] set_record_extent_bits+0x19/0x20 [btrfs]
      [<00000000b96137b1>] qgroup_reserve_data+0x274/0x310 [btrfs]
      [<0000000057e9dcbb>] btrfs_check_data_free_space+0x5c/0xa0 [btrfs]
      [<0000000019c4511d>] btrfs_delalloc_reserve_space+0x1b/0xa0 [btrfs]
      [<000000006d37e007>] btrfs_dio_iomap_begin+0x415/0x970 [btrfs]
      [<00000000fb8a74b8>] iomap_iter+0x161/0x1e0
      [<0000000071dff6ff>] __iomap_dio_rw+0x1df/0x700
      [<000000002567ba53>] iomap_dio_rw+0x5/0x20
      [<0000000072e555f8>] btrfs_file_write_iter+0x290/0x530 [btrfs]
      [<000000005eb3d845>] new_sync_write+0x106/0x180
      [<000000003fb505bf>] vfs_write+0x24d/0x2f0
      [<000000009bb57d37>] __x64_sys_pwrite64+0x69/0xa0
      [<000000003eba3fdf>] do_syscall_64+0x43/0x90

In case brtfs_qgroup_reserve_data() or btrfs_delalloc_reserve_metadata()
fail the allocated extent_changeset will not be freed.

So in btrfs_check_data_free_space() and btrfs_delalloc_reserve_space()
free the allocated extent_changeset to get rid of the allocated memory.

Cc: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/delalloc-space.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index bca438c7c972..fb46a28f5065 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -143,10 +143,13 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
 
 	/* Use new btrfs_qgroup_reserve_data to reserve precious data space. */
 	ret = btrfs_qgroup_reserve_data(inode, reserved, start, len);
-	if (ret < 0)
+	if (ret < 0) {
 		btrfs_free_reserved_data_space_noquota(fs_info, len);
-	else
+		extent_changeset_free(*reserved);
+		*reserved = NULL;
+	} else {
 		ret = 0;
+	}
 	return ret;
 }
 
@@ -452,8 +455,11 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 	if (ret < 0)
 		return ret;
 	ret = btrfs_delalloc_reserve_metadata(inode, len);
-	if (ret < 0)
+	if (ret < 0) {
 		btrfs_free_reserved_data_space(inode, *reserved, start, len);
+		extent_changeset_free(*reserved);
+		*reserved = NULL;
+	}
 	return ret;
 }
 
-- 
2.31.1

