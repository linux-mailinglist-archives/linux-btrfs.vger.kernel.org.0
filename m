Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3F515C636
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 17:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgBMP6W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 10:58:22 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60892 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387438AbgBMP6R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581609545; x=1613145545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ZeCHCcflvcCwv6jgAyyLcuEDPIhjPzAQPoXSRPeNe4=;
  b=EkI9ZQt//WHcbMQJ+VQ4XB3MMbz8wJ3fpFSvn+BT2AzzizPB2rJ/V3lC
   Mt0HDTvOFNpCoVg4oM/Y193dFmsCDzzQjz0vLJxlHwdYoifa9qjehWPvz
   ECwG/0A++X7lYyowUgJkekFIM5yV17D3KKLIdBDrziEbJRpfusl9Xxawo
   1MpYxxOYtIIrR8hX39dJxSJuls8NYDbuJ3ABls/yuupR/P38qoD+Zc8wx
   MhYpB5Qztz4pOayZosgkr5CPJRjYN2FF9fGSX0HScLGwH1t7nN9uEJ3eN
   e5PDZqbQexbDSLezm86oSFNKjF3jnjTOnfp5l0H1KeeRhcIxUN4iW/OJZ
   A==;
IronPort-SDR: mJrbBV3O0BkVM+ToMXh6QcMS2op0jCgTLzisQotdPbHBNrG6gITHGuy6tV5QgiVgw2zc+/Ks/T
 efkqYaeKs/SLCKkHFfME10eXKCy4C29D1SIeJKh5E74qCCCix68HvpVSyO2zGTxYS3vOJI/zxE
 BaXV/pa1o1UTYjVuYYw80C01bbCMIS3r/nLv0oPSnLaJ2uxTVAjs5SrTlGzXrZ8pCsete4kGvq
 /rNdF4ohecJmXkH2WunBTPDuuiH6hAtBrBrWmVoFSNUuTcwKLKvTZ99tljAqyUvldOUglHdkLs
 NUY=
X-IronPort-AV: E=Sophos;i="5.70,437,1574092800"; 
   d="scan'208";a="231587568"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 23:59:05 +0800
IronPort-SDR: YPd/0CNHMtKWy96xf89gcShUlPvm8KuyzlCC2CbHbE6Wi28gCmm2tDUq7vcIKTjO8bOK8IfzRv
 C2g8mXZwmgD5BBioYti29hh5+exWml4hLiM+K8br5arx2IE7A9rJUL2Ff/ISJ1elXAlm1+jCIH
 99oOXNglw86/vTCnmeyqHncU8APt4MbKr74admpWETtE0wVghHo8FMr31VRH/I3sdDvHDrVBww
 XK3uuFrbKLBej+6opJiHH7ys9HU146mehjPBNvCxWlBBiGtxhBmPvHt/CtsDu7+iiL3tAL60VB
 TXWs1cgsr6f3O1pTxSvH+wjA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 07:51:04 -0800
IronPort-SDR: zM7u0nseUHMuVQtvKiHbzDcOqUSa/nqJDIFgAlkJYbJFdZxrh+31gx4/MaIW2W4tHfAjhmbfJs
 SQkQkkbHncKIL3k1ssNZzUC5lSlrg7I+zo1Acbjhmnj5F6uP4gik4hOWX2GfnlS2T5mzrJLpf8
 Psw5JW+1Xr0SWL/5Fr3baL6oXCHsJUwxwNCNHewbrbPpc8NnrPs0L/2PDGHTO1OjwGCT0PBXkq
 8DBkIiiDM6m9yOzUWwri/6IvrpvT+zHa12qbJhvtQHhVGik0vzI2MywWTUXHajd1R3JxSXlZgx
 7Mo=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2020 07:58:16 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 4/5] btrfs: use standard debug config option to enable free-space-cache debug prints
Date:   Fri, 14 Feb 2020 00:58:02 +0900
Message-Id: <20200213155803.14799-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213155803.14799-1-johannes.thumshirn@wdc.com>
References: <20200213155803.14799-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

free-space-cache.c has it's own set of DEBUG ifdefs which need to be
turned on instead of the global CONFIG_BTRFS_DEBUG to print debug messages
about failed block-group writes.

Switch this over to CONFIG_BTRFS_DEBUG so we always see these messages
when running a debug kernel.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/free-space-cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 8da592eaf6f8..41e138f2ae12 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1196,7 +1196,7 @@ static int __btrfs_wait_cache_io(struct btrfs_root *root,
 		invalidate_inode_pages2(inode->i_mapping);
 		BTRFS_I(inode)->generation = 0;
 		if (block_group) {
-#ifdef DEBUG
+#ifdef CONFIG_BTRFS_DEBUG
 			btrfs_err(root->fs_info,
 				  "failed to write free space cache for block group %llu",
 				  block_group->start);
@@ -1422,7 +1422,7 @@ int btrfs_write_out_cache(struct btrfs_trans_handle *trans,
 	ret = __btrfs_write_out_cache(fs_info->tree_root, inode, ctl,
 				block_group, &block_group->io_ctl, trans);
 	if (ret) {
-#ifdef DEBUG
+#ifdef CONFIG_BTRFS_DEBUG
 		btrfs_err(fs_info,
 			  "failed to write free space cache for block group %llu",
 			  block_group->start);
@@ -4042,7 +4042,7 @@ int btrfs_write_out_ino_cache(struct btrfs_root *root,
 		if (release_metadata)
 			btrfs_delalloc_release_metadata(BTRFS_I(inode),
 					inode->i_size, true);
-#ifdef DEBUG
+#ifdef CONFIG_BTRFS_DEBUG
 		btrfs_err(fs_info,
 			  "failed to write free ino cache for root %llu",
 			  root->root_key.objectid);
-- 
2.24.1

