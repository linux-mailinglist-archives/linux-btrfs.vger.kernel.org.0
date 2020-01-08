Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87823134170
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 13:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgAHMHm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 07:07:42 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22197 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgAHMHl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jan 2020 07:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578485262; x=1610021262;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0h1XY3i0u6x13Aan4/g2vlXvskF0RfVVMHAJIJPhEes=;
  b=OtB26PT8PS9Mo//sofq9e5hJJ02GGDBOHkryxAcjLy2oU0gtEg2iuvqT
   WjREasnki3EoXquK1aSAAHwmI4zaMreOfV6kdmGI7PXtNnl71krLerOS1
   rMxbTzygoatpNEENXvjxbUhrVOZViz8mBLvmsbN30s7TDEVs6wxdFqpB/
   r/Ycvcz6V7QVRhu5Q0qO2TtYQV2gSva4JoaocDpGpX+X65038Txxk39fi
   pE8au+UmwmLNmQDh26gESMRWkwil/B9zlDh6l8E7vBZyGYDkIEu6KJM4n
   aiplrlNT6A2rIqOzd5gfOimmOJyvRDJ4BJODjX29ybMOOJaBoq7OPR6oc
   A==;
IronPort-SDR: 4YrIEEBkdiTVLmboswmcwddfL3ChYCTMkYRGdTDngEwcsZPbz2CWk4rSFZodJFoEG9fMj8KpVT
 a8GfJ4hWLVq2v9uUVTRQw47wMlpkK8kxjwnvgUKqwTZI1x/c19NDHwCgmzkv9aVcM1XYplfkqJ
 ScPOYALQKHiJoyQTezOsh/dgzsEXy4vS/bnbg/IQvkmPOWtXUCgymki8BFZhI7P33txmJKWjqR
 4ePzV3IGIDy8eBWdlBSRJWh2oAamFMUCgW6G5TeTss9b3aTTd0Q60GXYI6fm62gapVRjR4Geq4
 Rc4=
X-IronPort-AV: E=Sophos;i="5.69,409,1571673600"; 
   d="scan'208";a="128525879"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2020 20:07:41 +0800
IronPort-SDR: 0hblEt21yWvLhGz+9i1EYqq96NlA1tllmHdV34dFadOO2fCUykaCzk1EgtZ2Q6c+Oq69kWCpbs
 8QtpzdLbUV1ammy0eANhrimga4FrtP2Yj64hwogznOh6bK67DueOcJxP6ewfHX/inPAx9bCZsJ
 vAIa5UBB+FmnoA8Ylz6G2/2Z3RQjr6PcB4KP0VLAwhBwLTbdLQBiqHEQ3T0nPaYyOCAKR7WeeK
 gRkdW4tYwDJ7v5OP5t33G8E59MoInaV2rNUqd1v2bkobU4WLQrjK1KdeJpKI68rUY2v7m0ocAO
 MYphrS4YOpUwnyqZDl8kViWj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 04:01:29 -0800
IronPort-SDR: 2tNRk8WEDAp7zEMh6ERPclvF2PxPNLCXl3JZ7CAwL7TidpBMe769Q24OPJ5NmOAOpz4LRK3hLT
 EknTqS4ZIvIj4hrBMt6yAC5ntYBEPPku2e03LZWIaxgCq385L05g8mkLn9kzraSCDOuXmEA/0m
 gC5x4/Ssd58lhV641XjIc7p+BqaMJceB9sQW4gC54e7TYoGouErp6oC+GeYV8o4YZ2nQiL9L/o
 206E4pBuM/obGPQitl5GLnrAkBtht8YBkvEarzsmiWdfxenQEPfvt2bhQ4B+bWbgFH97z6knzT
 uDk=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Jan 2020 04:07:41 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: fix memory leak in qgroup accounting
Date:   Wed,  8 Jan 2020 21:07:32 +0900
Message-Id: <20200108120732.30451-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When running xfstests on the current btrfs I get the following splat from
kmemleak:
unreferenced object 0xffff88821b2404e0 (size 32):
  comm "kworker/u4:7", pid 26663, jiffies 4295283698 (age 8.776s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 10 ff fd 26 82 88 ff ff  ...........&....
    10 ff fd 26 82 88 ff ff 20 ff fd 26 82 88 ff ff  ...&.... ..&....
  backtrace:
    [<00000000f94fd43f>] ulist_alloc+0x25/0x60 [btrfs]
    [<00000000fd023d99>] btrfs_find_all_roots_safe+0x41/0x100 [btrfs]
    [<000000008f17bd32>] btrfs_find_all_roots+0x52/0x70 [btrfs]
    [<00000000b7660afb>] btrfs_qgroup_rescan_worker+0x343/0x680 [btrfs]
    [<0000000058e66778>] btrfs_work_helper+0xac/0x1e0 [btrfs]
    [<00000000f0188930>] process_one_work+0x1cf/0x350
    [<00000000af5f2f8e>] worker_thread+0x28/0x3c0
    [<00000000b55a1add>] kthread+0x109/0x120
    [<00000000f88cbd17>] ret_from_fork+0x35/0x40

This corresponds to:
(gdb) l *(btrfs_find_all_roots_safe+0x41)
0x8d7e1 is in btrfs_find_all_roots_safe (fs/btrfs/backref.c:1413).
1408
1409            tmp = ulist_alloc(GFP_NOFS);
1410            if (!tmp)
1411                    return -ENOMEM;
1412            *roots = ulist_alloc(GFP_NOFS);
1413            if (!*roots) {
1414                    ulist_free(tmp);
1415                    return -ENOMEM;
1416            }
1417

Following the lifetime of the allocated 'roots' ulist, it get's freed
again in btrfs_qgroup_account_extent().

But this does not happen if the function is called with the
'BTRFS_FS_QUOTA_ENABLED' flag cleared, then btrfs_qgroup_account_extent()
does a short leave and directly returns.

Instead of directly returning we should jump to the 'out_free' in order to
free all resources as expected.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/qgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b046b04d7cce..7ebcdd201eed 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2416,7 +2416,7 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	int ret = 0;
 
 	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
-		return 0;
+		goto out_free;
 
 	if (new_roots) {
 		if (!maybe_fs_roots(new_roots))
-- 
2.24.1

