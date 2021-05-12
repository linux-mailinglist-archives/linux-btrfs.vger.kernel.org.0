Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C199937B71C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 09:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhELHyY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 03:54:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63118 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhELHyX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 03:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620805994; x=1652341994;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6rqX0nV0yaP9//nozDSp+HZ9tsJieu6DKHbYsmiVtKs=;
  b=hdY+TmXLRsDgc+C2rDddlzYOqAcobMYFNnPtYYb/qg/x62BcyTHwspUh
   zA6XUk6vYs0+Gv2goSui+2EhF/+n3j5cGbqO3Afb2MglzdpDrXhlzU72o
   ANcj16YSQFD8IoxSgTQBP30fAigNzVyRFMut2bXrsassPLZ7HGAq5lLlS
   XaJBpVcV2cKKBj71wo5wl4qEbG4QYWSXKHidkQK6Wr5yWGR8LIG6N5U/7
   Q71aqMmEFQd2OEoAxcsT0EzCWewHaJ3I6U1yCV11Zft9mlR9EId9bKWfJ
   wE9H95u0jnD1T1gQYKa7cq5P8LcXeSZmUMEquHBQm1dnqkhUOHufC4EYO
   w==;
IronPort-SDR: B8lwVuF+Y6l1Pvl//qBY0XHhbKaVmZgvbmC0lhDe6dBCUb9DKvL86eu8bvzKukmxv7EPo7Odxz
 311axVywavHgsGadRdVC70QaLyLRT2VTfopDMzfY6bLsWg1Ybn9A21QlJKRsZir7ynSq8L0e3K
 Vm5Hhdy3l70+JWRZbMfFX/KnaZl0WUe2cHgedCF8nopUgH7WoFwrUNS1ZRWvX5GnUmYv7gujhb
 Rij8EBoGNREw/HTk3MYsQtFoXkLNhUj1w4vMUL8nWqO0WFTcrgh9QMnlgx/iE1NFTELRQoffKN
 SCg=
X-IronPort-AV: E=Sophos;i="5.82,293,1613404800"; 
   d="scan'208";a="167870016"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2021 15:53:13 +0800
IronPort-SDR: LVSYQNrKs95+33RLHxdZLeACh1QQiZV2zYZWvs+oxA1fkPMmh/oKChl76F0cLTsncU6KrlMDn6
 IC4Eq8++L8B9NMOTb+fwMBhSRAe/e3SwQ/EeZz6o/jOKldCacuoBzQgMl9WsUWGfcoDFTehMoB
 x0+NSyjshSXK/9Pu5EIGHElUqLLqArs4zgCLi4GO4zkNz95IIXlNHKFu3LenwWh9tieiyRe0nf
 OlSx60/pXpZ8Ivj1UmOEyQN8+8Lo310mCQh95gAV+CI25X/oqKlQCbhLCcXfPD2feqXrQsLpEg
 GFlm1O1tCujV7HTje9Cj3py+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 00:33:12 -0700
IronPort-SDR: VmBadrEClSDYIiAr+mglA61N/NHRrugfuepVAjI1Go4OGNKYyjY+/Pvk0S+i/QeJUzjQDp6wAx
 IVmRr+PkghhFyz61w4CgNbFMOchLp5J1u2YijI+ltf3pSmQdhH8mBeDm91Z5SksID0fsZjijEF
 LVH2ExbgtL+CqnVhGSejOXd0q/jgdvyZ+3kacBJi2ljnROkcjsUZWMmCieBeK0nhc8T6156nq4
 wza9SFTFaS8essY3OigvEKvUA35s6l5qrhYf3BON5nGV3DStRQxRrZbAeOi2PEOcXusu/OzyRM
 nSs=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 May 2021 00:53:14 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs-progs: check for minimal needed number of zones
Date:   Wed, 12 May 2021 16:53:05 +0900
Message-Id: <20210512075305.19048-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In order to create a usable zoned filesystem a minimum of 5 zones is
needed:

- 2 zones for the 1st superblock
- 1 zone for the system block group
- 1 zone for a metadata block group
- 1 zone for a data block group

Some tests in xfstests create a sized filesystem and depending on the zone
size of the underlying device, it may happen, that this filesystem is too
small to be used. It's better to not create a filesystem at all than to
create an unusable filesystem.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 mkfs/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index 104eead2cee8..a56d970f6362 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1283,6 +1283,14 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			min_dev_size);
 		goto error;
 	}
+	if (zoned && block_count && block_count < 5 * zone_size(file)) {
+		error("size %llu is too small to make a usable filesystem",
+			block_count);
+		error("minimum size for a zoned btrfs filesystem is %llu",
+			min_dev_size);
+		goto error;
+	}
+
 	for (i = saved_optind; i < saved_optind + dev_cnt; i++) {
 		char *path;
 
-- 
2.31.1

