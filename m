Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100BE2B0494
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 12:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgKLL7q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 06:59:46 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64731 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbgKLL7p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 06:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605183114; x=1636719114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n6LZxRetONMPaSDBCXBFFYZ0GwHhiWTyXf2xbhaH3V8=;
  b=ZxISqof9IZ1EGe0Ue9gUggdsHo8Qu0hzT9opOwY6t32MgNF5VQERoJI4
   osxfUDYAOvRNorsGyhEkHEwy1Gjpjhip6k1Zd1VtcEn3qSeBMuSdyDc5w
   tkLxgC+Eu2L3GR6E7DVb3SPlS9zf3G4WUqEn3J+JvRIHdTsIO37z9IEgh
   BH2TMyTAbk2had23sIdXtreCzV9UYCFKevrdMH1eXrmmva9aX9XfbnzUS
   CjzifunwaUAj8J3mIuzeVuydx54/q5r4URmbSGxSXLcElwuwIf3QlKLWJ
   FVORseYPT+1w6Yg52JrrTTDyUAWekhFSCsVgd+IORMXivdn5PjZ4MVknM
   w==;
IronPort-SDR: kNFd7UDWFN+Ya1TSkgaeCbZiI4S+toAsc2N+NvlpiAUYGO/QFdjRpPrye7O9yNYaef7A9zQVwa
 92eqh4CoA93vhBwBwWZeubbbmdGMldvD1YavpFEsAAy6O5Q+5e3EDaCEBvvNczJwwu+WbL5u6W
 KCQSNoY8iWIeJ6mrps2IhOksmDjj8x/Ium23t1owMm/jYmj7bdO3MFm/WDmDWWeKyMg1J+oT9Q
 OeeSoIj51dkETnlaTopGM3JHIX5Fxg0KiXxByuzeHTxyrZ0aPKOajfIp/+RJ7FXbboKQlyac7S
 Ifo=
X-IronPort-AV: E=Sophos;i="5.77,471,1596470400"; 
   d="scan'208";a="256045124"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2020 20:11:54 +0800
IronPort-SDR: lG9sF8ugybSWGVrjrwsvKQJzIfOlcDHhrduIOzpZoN/ke7NOxpTVx0qn00SPPl62fHI6dKtoZP
 JPkHDGrJ7yvPBAlLc0KERYOOc5lPOU0l2/ediLf9psM//5CBZL9dVN1l18WHxFazsNTh/cijhP
 pTn/ll21t7qpnxQZGaTobByQMd/9f0vv2KDQ0lVg/X2KGv1Z34hBoDZyJPQg0T4jTfaehF/+wq
 i/WWGksRwXhd8Uj+gmQK6nJZL7GJGctPupYYM+BQWnOF4D9rQnh+DljUdpY3qRGxh4AFfRcD3A
 KGqJfH3J7H3FL2HDlnJStvir
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 03:45:43 -0800
IronPort-SDR: CbIIpPSV9MrSu5c3Froo5Rfi2Ihr6SHptPDTL6IJrGWtXcUN+7b7r6MRT2HCzOAFzxJNnpkIla
 Tqb1Ztx/ih9TY5Re6U/7zGUFP2jvucCODlVc66hcCScGgA7UktbiUxz1lBgr7TDBcEPGGzjpEp
 8mfOXeHqE7DUPTkRGHqcfvZi65oLW1BdDGAipQmBOLv9inL+FJabLhtW0Q2kh9nrFubSy8BOUJ
 hBDUV1LjVMSgAXpSyw/FAT0NjvWaEwal6ycdGgcfI9xfNcpNcvH1j4481vn9fMzWpGJmd2UrWl
 qog=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Nov 2020 03:59:44 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>,
        syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: don't access possibly stale fs_info data for printing duplicate device
Date:   Thu, 12 Nov 2020 20:59:30 +0900
Message-Id: <2bb63b693331e27b440768b163a84935fe01edda.1605182240.git.johannes.thumshirn@wdc.com>
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
btrfs_printk(), use a normal pr_warn().

Reported-by: syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

This is an alternative and IMHO simpler aproach to what Anand proposed in
https://lore.kernel.org/linux-btrfs/20200114060920.4527-2-anand.jain@oracle.com/T/


 fs/btrfs/volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bb1aa96e1233..eb1af5e3d596 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -940,8 +940,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			if (device->bdev != path_bdev) {
 				bdput(path_bdev);
 				mutex_unlock(&fs_devices->device_list_mutex);
-				btrfs_warn_in_rcu(device->fs_info,
-	"duplicate device %s devid %llu generation %llu scanned by %s (%d)",
+				pr_warn(
+	"BTRFS: duplicate device %s devid %llu generation %llu scanned by %s (%d)",
 						  path, devid, found_transid,
 						  current->comm,
 						  task_pid_nr(current));
-- 
2.26.2

