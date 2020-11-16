Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EBE2B3DF9
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 08:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbgKPHxI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 02:53:08 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44907 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgKPHxH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 02:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605513749; x=1637049749;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+DW+OTCUR2gUjKZhhweHDb6FP21HrZ4oPYgOJ9iE++0=;
  b=Jy+03qn8vH6RL3/kKIBYQI0+/Bwxpucf646HLt6h9OdIdKWVxS/jP36e
   rWulfbf/CNzln83R8xlYGSIvG8Ku1XWAnW9GGYTnkeaj2pSh9L2BPuG+y
   4PLeSqg+qOZl5KTvIcUfRSdBfzKeyUYfF8RI/W6E1j367Tq5kx8CXMUrk
   ma5rCFwuGHMd/3IeivumDoW3FcE7p6Wfgpxb6oPH0G2yRP4vu5RuDpzeq
   L8EpGl2JBBpHE/fP8A7/zjpDqTYGqAcHFyf1bEkPsmm6Y9Q883sPYBPIC
   KNqsOElhw02R9TCwTag+ioUiLFG0h73yeIeZ06kWvpLyo5pBV/hpOS+0L
   w==;
IronPort-SDR: bGG3nXfYk/A8k352m6jJozdFn45iayquaC09XCO17kiksiC50F7i9OPxUKKZ2olGuFA2g3aDjo
 ckzWULKU7yFRn7yb6gtqkR+gDKsso/Y9XBJDhWpWXHG+DLKUVxmnABlN8IQOJiKDY8Xp3BtV3M
 oEc3Hco41/TbatDlDNWJo9C1yA7C2aoOJlOYo8fzdsaK5ho9DMUArwmLpnw1wPd08RsnQoFRT0
 tCWxz/PECN8DrWZ8Of2vIR91xOKVJXWKi0tVimZoc7UNh6VYbMHMFxs4+zLidtd97QRt+qu5mB
 fIs=
X-IronPort-AV: E=Sophos;i="5.77,481,1596470400"; 
   d="scan'208";a="256267310"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2020 16:02:29 +0800
IronPort-SDR: bYouf8i4bEeF6gDWziKKMRDPO1B1WP+HpJep+e96C2nbLH5IgnV+7El28gq8r70IUXPnyYWO1l
 dV7YPu+WYS6pj1s9bXK60J8BgpMRtRCdhCW6k5tcbujTTO2eYaATX1KoS9gDjOw+tikS6ElaZx
 Hql8Cp+Ne8petnMDx8Ny+trb5C+rzvep5Qjrtu/+5Zv4togUjCjNkzNmHzbgy64fs6dbsQ1EVV
 adWT5duB4uDtdmvdIw3qDk6vdRCTDAazZcFMevTHOUN1dtt8S54lJrjdGXm0SZrcZBHR5UhyWZ
 0eB8EtpGCnud1hM6OYm6ZAuU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 23:39:00 -0800
IronPort-SDR: 70NEvbnEekYEdIge1GuHXloky2KdR/KltmXAApx8SZlcr9I5UvYm1/tw5Q71bhbvqCBGaGUGap
 NzKPPngDmKlO5/dumLLg51lHEKU/wg/iUA/lfOr5ESOJuN+dmtI8wa172XXf+1jZjwmbfnfjTV
 IlPtivN7+aMRTF0WUtrzGwzfz1F6AKrOc1iXoP87BCyCY+NRlk4EOnLmMlkVLgimf1KWFrTUb3
 mjXMS1KAhNCgiYHAy4Uf9OswQw3cP8+vjbsM/3zG9bFlvmISDv/w7T2n8UIGHm2+Ms0dcjzoOw
 qfs=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Nov 2020 23:53:05 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>,
        syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
Subject: [PATCH v2] btrfs: don't access possibly stale fs_info data for printing duplicate device
Date:   Mon, 16 Nov 2020 16:52:54 +0900
Message-Id: <0e9eb675e0a199bf034f13c58fbe5678f4e94a3c.1605513154.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Syzbot reported a possible use-after-free when printing a duplicate device
warning device_list_add().

At this point it can happen that a btrfs_device::fs_info is not correctly
setup yet, so we're accessing stale data, when printing the warning
message using the btrfs_printk() wrappers.

Instead of printing possibly uninitialized or already freed memory in
btrfs_printk(), explicitly pass in a NULL fs_info so the printing of the
device name will be skipped altogether.

Reported-by: syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bb1aa96e1233..507f6f17b3a9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -940,7 +940,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			if (device->bdev != path_bdev) {
 				bdput(path_bdev);
 				mutex_unlock(&fs_devices->device_list_mutex);
-				btrfs_warn_in_rcu(device->fs_info,
+				btrfs_warn_in_rcu(NULL,
 	"duplicate device %s devid %llu generation %llu scanned by %s (%d)",
 						  path, devid, found_transid,
 						  current->comm,
-- 
2.26.2

