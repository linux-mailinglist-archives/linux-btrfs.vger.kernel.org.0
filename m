Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1017715C635
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 17:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbgBMP6V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 10:58:21 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60891 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbgBMP6R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581609544; x=1613145544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=325QAbuPh1UjGuykfs465BipbXIHHvqK9iVL+yKUCXc=;
  b=Upwu5Xo/eUPtBLsW7e7lP+uhuUgYrw2It8TTvs36jWVyqYywxW85KdmS
   qCD1e/ZDZMT/r5mDlxLRWAYYzP3SLw+FnY/UmmZBajVYP+d3ZPwTRmi7Z
   pHjuJw5VrLwLPBQdaO3gDnkJ1jypITT85N5P6OApnzSi9dbahVkf9ItI9
   9V0j2CO2YG7CoT9KpZg2YM8Xru5yOL6adL1kolSUzU+AA6wvyz5Q3ujSn
   2Bd2jrfn+FEMEj/6bXtQF0TdGXPSIPNNEc8D5skO5dN0OyUcEbhd2BjdR
   GUB1YPhicDIZQWuEo344ns+tQ69WhsDhZ9Vv6DVeERfLot3BuQf5HfH1h
   g==;
IronPort-SDR: FBbdBF4jyf9N2h/YO42+eZJ1whGedF8RSfgGA1HUQr/2gqMvEu+q4YAIwXc/yV1Fge7oaFFzO1
 z8qW0nxI3AjyBYIlBip72xsT+zAPvoPWQOpGf39hyBJlMIHwBzgNUNQi3HE3DZNuJIZsZsU4PV
 js3w4bKK2FJ6ERHl1ghdTgzuhXeLN9i3xcgrLTdrUdlFsAjB89NysMzO8/aUHTGQO3gPn4ghbt
 4n/KUMZTsU3a/81xTC4masKlJb797fWWZjPJ6VuIUBKZM4mJqpw/trX81GWjYHuLYOmLtxzVTu
 Sf0=
X-IronPort-AV: E=Sophos;i="5.70,437,1574092800"; 
   d="scan'208";a="231587566"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 23:59:03 +0800
IronPort-SDR: MoRVJ1vxXEVgfZqNeV4VzvcZD4GKNbxD3gAcsr6OsMFs7P9FjpRp8uKYYO9CjMoue2MOmK9NVB
 /4Hk4QkMaTCAsF89D6K0RcFAzlmJcjaRhFYCJcF+INDMnvoDKD9mhZ+WhiKvjGaO0KTquofOWc
 wnSIWm50VbnQHf4nKGRp86OAYbAQ6ZAoUPB6htbMQLHuKKPSz+6YYbwXZSvrlm5HWqJMlPaJUk
 6ab2b1tCDDROGAX86EhcM9ldC9liqFQUWh7wTJHCxxY4+nh7J4ZzJCxJvvGX4TZW7IZ3zhzLxk
 UPfBAPSOkLW4M2+2LZcoE2Z5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 07:51:03 -0800
IronPort-SDR: GxkJRVeZVQwgwpex4FnDcH4HltvvxtDk/jYbLgklIfPc9E9fOL8MAjI0tEmD1swZ3zmJWXH+FJ
 lcJjAme4927PvMAc6uzCnqoxmd3VrGdGB9kJ3mGeyQUUG3d8Z9Je+5MU45jGZ4GIGuHVWDtx52
 s0/55QCjpDRlthlQnpCdlgANbwMfl5ZHrKbLriozsw8ApD+I3t3iaaeTSFggT6b0lN+bnz4f0M
 QMg0sTYrg+/g5ej4TwezQXKsP2EOI+fw3RIu017HhFeR75i76cN1vvMGcx4DRo5Y1OIHE5hDKZ
 z7A=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2020 07:58:15 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/5] btrfs: make the uptodate argument of io_ctl_add_pages() boolean.
Date:   Fri, 14 Feb 2020 00:58:01 +0900
Message-Id: <20200213155803.14799-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213155803.14799-1-johannes.thumshirn@wdc.com>
References: <20200213155803.14799-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Make the uptodate argument of io_ctl_add_pages() boolean.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/free-space-cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 657a969a93ad..8da592eaf6f8 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -377,7 +377,7 @@ void btrfs_drop_dirty_io_ctl(struct btrfs_io_ctl *io_ctl)
 	io_ctl_free(io_ctl);
 }
 
-static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, int uptodate)
+static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 {
 	struct page *page;
 	struct inode *inode = io_ctl->inode;
@@ -738,7 +738,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 
 	readahead_cache(inode);
 
-	ret = io_ctl_prepare_pages(&io_ctl, 1);
+	ret = io_ctl_prepare_pages(&io_ctl, true);
 	if (ret)
 		goto out;
 
@@ -1297,7 +1297,7 @@ static int __btrfs_write_out_cache(struct btrfs_root *root, struct inode *inode,
 	}
 
 	/* Lock all pages first so we can lock the extent safely. */
-	ret = io_ctl_prepare_pages(io_ctl, 0);
+	ret = io_ctl_prepare_pages(io_ctl, false);
 	if (ret)
 		goto out_unlock;
 
-- 
2.24.1

