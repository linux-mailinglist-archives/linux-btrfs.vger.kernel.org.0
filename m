Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4FC4A98E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 13:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiBDMGe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 07:06:34 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26466 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiBDMGe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 07:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643976395; x=1675512395;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kp6xSHCU0pBFLOGTH1+N4MuTwHCvIaNlUd5Y2yXsV4s=;
  b=AAErWGtquoDkW+nqZNxy8g1B/GiXcs1b13q0/XwLb7xJBqWDgLPeGE0C
   FfbdpCDq14joPiX0gDO5cIxOJ/wE9/HMtxJxC0fqlT5dGPve03BeSt4hw
   dQ5R4ViCiLamfDi5uYnVWmR1SuMERamBZnHcWG6JUO6wAwJrS/vJjaUHr
   2AAWRl0Cz9G3zn3EWg2hPMiqzVIKpzdDiyrSOcMkKkcNpaVX5qKeU5Yyq
   6C7h+RpShWnCXMRZIEGeEpmTTdHiICzn+50+H4Jbt/MTRrY6YO0X6ZXYN
   GNiAjyYqtkUofptm7ZvHlGxIeeetuofK8rvmfgllsjAZn/rY+J/r2Wqe2
   w==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635177600"; 
   d="scan'208";a="193148752"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2022 20:06:34 +0800
IronPort-SDR: Bm3fX7SKvwv2S1avOK/Xl9DmquAWKgK99LqZ//DIUbyXGGz+tSvzlP4S/p26yyWC3eIteC8nlC
 wq9ccG7xV5hfY/ThRBVWQFNZvPr1U0tbg9/hNjQ1m36AITpjvJQTJqnzVrKyMPiOG3umGR/vla
 NGQ1I9H4IS7yNm5ZKyuAfCuKlsuW13eTidvxRls8Mt6fivcxE4YSj/CqCMa9Aolklgvaecj4gl
 xLtSMnFBJ5+HegLqj722rDeBGEPLKNy1taDjBSY5ctJG6dxjj6iFsFlQn0+zFbcCvySXDwPR1I
 ULrmsfDGflnLLoaM/fG59hVh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 03:38:28 -0800
IronPort-SDR: PUb2Od7o2XlZ1ZXznNmkO8+nXNz9+12cuLA+TQeRwy7fZb/CDm5fe4XOGXfYzdtTJm2ccdesvm
 nB8nKK20LNnmhl4PigxaeklAlsjc6+Xe31ONK0dAS0iqhNRFOjpF0rse79wU+8x7yxh/ud9xIe
 UokxB5OyiyCx5bpJJbLzXx5Z47hpkx4McbuFwIk/cHKKBnSrAjaOw4TpDyEXWL2g6qPXXwQseI
 QxYFQHM2o+rJkvC+DFwGqMGNpvUqv0wHNkE1RE5SNYtaX3qutIOTaes5Nzx7ni3jj39iq4aqm6
 nxc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2022 04:06:33 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: stop checking for NULL return from btrfs_get_extent_fiemap()
Date:   Fri,  4 Feb 2022 04:06:27 -0800
Message-Id: <90e3cf42e593327159cd261d71da2bedb53cc562.1643976372.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In get_extent_skip_holes() we're checking the return of
btrfs_get_extent_fiemap() for an error-pointer or NULL, but
btrfs_get_extent_fiemap() will never return NULL, only error-pointers or a
valid extent_map.

The other caller of btrfs_get_extent_fiemap(), find_desired_extent(),
correctly only checks for error-pointers.

Cc: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 409bad3928db..ad3d8e53a75a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5390,7 +5390,7 @@ static struct extent_map *get_extent_skip_holes(struct btrfs_inode *inode,
 			break;
 		len = ALIGN(len, sectorsize);
 		em = btrfs_get_extent_fiemap(inode, offset, len);
-		if (IS_ERR_OR_NULL(em))
+		if (IS_ERR(em))
 			return em;
 
 		/* if this isn't a hole return it */
-- 
2.34.1

