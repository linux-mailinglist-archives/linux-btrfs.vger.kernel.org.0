Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83E846FFE9
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Dec 2021 12:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbhLJLfo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Dec 2021 06:35:44 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19104 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbhLJLfn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Dec 2021 06:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639135929; x=1670671929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4rvlZI/rh7axzyN2zCP0QG6GAX0rkMJqLGWZ/6UgLHc=;
  b=IlCNwBoji2fbZLYjS6I6EBiF6C6Xzu+QKg038AtkF+ngRPvQp/XM/aHU
   xs5iABdLOmAcLjlsFzC8VeaipjktpBm76lM4nw6E41CLjLwGp0NGNPFJi
   a6qhMJN5EMennKY9Q+l94/R71F+GjbzljznyXAvgxZXEFatMhYM2G0YPh
   JsP459lXkQuMLtERXmGxzo4LB2DysTgFbUFypHFXVOHyp8wd0C8kf+tgb
   U6iEz1X2Bltu0g4Slsdgv11LRs2d3heWW2qtO8M3lJTHI88IF1s9JOuiv
   tV3RDe+9TvUoC1pIvcOYQ1G3Pcv5XqDLgBKNmc6eNQc3VkhBJ8iTJEbus
   w==;
X-IronPort-AV: E=Sophos;i="5.88,195,1635177600"; 
   d="scan'208";a="299779451"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2021 19:32:09 +0800
IronPort-SDR: jwlx+iDDehJpn5xeUQWGO7M0rqHVaAUz28mhlXVgeN24TXRQHFwcn8RqJr7zzU3ieBWDiDZS05
 Dd0p6Nskiil/zMGBazE9lq1BqtozvKcbHVEphbfqiYfieHm3VayfM5OUQ8sRC1Ii88CIVbgMRH
 uSM9rE59giJSIvunmzxVNdoNoETbPPHKxJwVUcVffI9Br5798N+mCqV27Gq+MuSWfY+QHwqrzE
 AiBz/+LlE7sGvTcQePJF391G7nRv92d4Tzqg+7UfjTNfBM/X2hU4p7wFkWnn/3nvS7yhuy5xZ7
 Uw5PCumiy9kVg1jjxePSeh6J
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:06:40 -0800
IronPort-SDR: 6Rii8YTk74Fkqy73xG0qJX7ifElNCjXzDoiOzjQS27JEOzDauqgHW9rWdfnsIyWpBgKAzxCBK7
 1CIwn6XRenoe+PKtAFAviXm/pKeGWEHyJnB0T31GTyBunHiC3/Mgw3Uyu0dte7qtFWaqygH5uH
 QeLFMTNpwP78ElQXJ/5i0n4Vpvm0PZCujpoGtvq1+8o5fChz345TW1Hol5C2tp5/nPTPiglx7T
 LeiXJtrHRRB5kVYcfjpEZ5mjd9Ff5OTLNTZyg7KxRe9PQpzjUXVdLliGsNUa8o9m2F0c9QL0bK
 q2c=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Dec 2021 03:32:08 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-btrfs@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] btrfs: zoned: fix leak of zone_info in btrfs_get_dev_zone_info
Date:   Fri, 10 Dec 2021 03:32:00 -0800
Message-Id: <8a54e85cf93d2042f1a2e29517f8f91fce56f6ab.1639135880.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some error paths of  btrfs_get_dev_zone_info do not free zone_info,
so assign zone_info to device->zone_info as soon as we've successfully
allocated it, so it wiill get freed by the error handling.

a411e32badc4 ("btrfs: zoned: cache reported zone during mount")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 5e5cb9aa0569..f559d517c7c4 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -375,6 +375,8 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	if (!zone_info)
 		return -ENOMEM;
 
+	device->zone_info = zone_info;
+
 	if (!bdev_is_zoned(bdev)) {
 		if (!fs_info->zone_size) {
 			ret = calculate_emulated_zone_size(fs_info);
@@ -460,8 +462,6 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		}
 	}
 
-	device->zone_info = zone_info;
-
 	/* Get zones type */
 	nactive = 0;
 	while (sector < nr_sectors) {
-- 
2.31.1

