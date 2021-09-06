Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D745B401D61
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 17:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhIFPGP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 11:06:15 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60335 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhIFPGO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Sep 2021 11:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630940709; x=1662476709;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lwN7i8oYcDhYizeYOytqLePr7a5ni/5tD53IO5z2CGA=;
  b=qzQB3R2ZF42A+BzDf1dSNvW2SkeqQWeCteAxijKpYoRB1s06QethLAx2
   yw6JOINXpfqRYqbkPv7SIjOAp3jivy4QJ0R9eDeD9w4gs9cINUUFKNga9
   n60xY056B3dUbyBcKHSyb30qZmuubal9YlrZWl3V1/bUdT98vAfychx8p
   jfoMILyL/BneHsMO5W9I7/EX/m8+IxIWkHcoSftN5qvdgvnYhDZsOOqlJ
   mgu4GTUf1IVJgPdsbqI1Gb7NIHc5IaZ/t9KwiSVq4fHwKXReqQb2jbyzg
   FCExg6zB30AVM2ibiwjDvLUGvGWD9/f20DYKPvGbwg4pqyC8F2tlsHi3B
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,272,1624291200"; 
   d="scan'208";a="283095376"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2021 23:05:01 +0800
IronPort-SDR: wtj43KcONZZ2jgd0MlnVIWIxw28hFOlJGLn+3t2MQn5rdfbrxyRDZqUdbk8MuxxGyxploZHiki
 kYwF0xQxm88s3B52c8Bs/noiEmu/QnoMpBjvjWLAHa9A0ZGjmLyj221p5aeH/+0ycjcfouO5T3
 fOf4sEF9T7xl3nwrDHRK7KjlUIlhazosA0vTHtd1reXeGpCfCQ4QLrzVnANXObl07e8YoRKo+/
 MSZ78BhhCbLIS/QsKtLHJfHJ4T/K2STLL+fxMLf8HtDw4s3MX9x3yfQf45BWs9jvx0WliEhFfS
 KHMJ+dOcU1cTnPWq7GvApymf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 07:40:01 -0700
IronPort-SDR: pFAZicz/Jb+WpMWj1wJX2hDiTt2Gd2NhF/Hi1mHHWwH85+dunGMeaIEHTYAXtHBzRhIyai1/TD
 yPGvgdjr+UPtWNGbZJhkY5nTiSKBfFdY9kS8cpM3BLUEvUeIytxNnvHJWDj3OTmgc4MXTmxwwr
 2TT8vonusY0ZXCRQegfBsgaKH0u/fx7W160exrbV3aC2DLS+GcHaRSN8jquLkQ0gqk16W+Zu8+
 tDaI3BL9X89868lsAsPusImg4NjFpBSDnfWOMNrJbjwLlWFzgcSrFq+C76SfcfMUXD+TY9QzEV
 O3E=
WDCIronportException: Internal
Received: from 8x4k3x2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.51.17])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Sep 2021 08:05:02 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: fix double counting of split ordered extent
Date:   Tue,  7 Sep 2021 00:04:28 +0900
Message-Id: <20210906150428.2399128-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_add_ordered_extent_*() add num_bytes to fs_info->ordered_bytes.
Then, splitting an ordered extent will call btrfs_add_ordered_extent_*()
again for split extents, leading to double counting of the region of
a split extent. These leaked bytes are finally reported at unmount time
as follow.

BTRFS info (device dm-1): at unmount dio bytes count 364544

This commit fixes the double counting by subtracting split extent's size
from fs_info->ordered_bytes.

Fixes: d22002fd37bd ("btrfs: zoned: split ordered extent when bio is sent")
Cc: stable@vger.kernel.org # 5.12+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ordered-data.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index edb65abf0393..6b51fd2ec5ac 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1049,6 +1049,7 @@ static int clone_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pos,
 				u64 len)
 {
 	struct inode *inode = ordered->inode;
+	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	u64 file_offset = ordered->file_offset + pos;
 	u64 disk_bytenr = ordered->disk_bytenr + pos;
 	u64 num_bytes = len;
@@ -1066,6 +1067,13 @@ static int clone_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pos,
 	else
 		type = __ffs(flags_masked);
 
+	/*
+	 * The splitting extent is already counted and will be added again
+	 * in btrfs_add_ordered_extent_*(). Subtract num_bytes to avoid
+	 * double counting.
+	 */
+	percpu_counter_add_batch(&fs_info->ordered_bytes, -num_bytes,
+				 fs_info->delalloc_batch);
 	if (test_bit(BTRFS_ORDERED_COMPRESSED, &ordered->flags)) {
 		WARN_ON_ONCE(1);
 		ret = btrfs_add_ordered_extent_compress(BTRFS_I(inode),
-- 
2.33.0

