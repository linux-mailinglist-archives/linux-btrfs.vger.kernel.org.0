Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3066815C633
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 17:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgBMP6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 10:58:20 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60885 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgBMP6R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581609544; x=1613145544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ocD1DeGcrpk7hS1e3Dd2W5x9nZUmy/dSs27jsyp3PDc=;
  b=q437U6wkRUGjXkT5tyPQuDPS+9R+N4PFE12kzJ2LhFdP2mLwo1MBL2dP
   zxaklNrR3PSutmUpxvkYlkUWA9hHaCIvll0y8wsLON70BNxRiLPMR+dVG
   9/1nIe3crHvGqeV4EYPw/wrMQpUm3jbrrhavxJd6IF7tJIsifmrasS434
   h5sEmKgelfianx0NH2K+AuLqk9qNsijjmg9J0W3yTts0ykDe2cS8bL72q
   IWeFVMHv8F3hj/X4eJs5iEl4aknqDAJlGGXlmz3LwB9P3MbCShudSWceU
   YQ3wCfYp0E+UoMLZUYX/K2+fmaXzSx/mjBjKwqgPIVnq0bX+oDFS9Jebl
   A==;
IronPort-SDR: 6y+saXc/QzEaBaUjRrWkVaqyR3FK1New2t+qPkBbFwTfm7pKASa6D4tH4tJmR3hfjMNWo0qCIw
 H5cQXkGveHYkOT6gccUmlFGeyZbLwYOk5t3KDfab5ilhN6SVK+9GV73rYaYWiLLm5HB42KCZqK
 8gJRJ45VKR6qhMrSRZR85A322M8kHb9YlKMxnXDG/6T51UcYVy/lOBgbTK3UYxoOmPswzvBpoN
 cPKo9nxwLTPTW/4SBMP5FHA0QUsQxi0EVM4RewHOFn7edVOP8PNitQSc5zYDzI2xYdOUpSryOZ
 Dzk=
X-IronPort-AV: E=Sophos;i="5.70,437,1574092800"; 
   d="scan'208";a="231587565"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 23:59:02 +0800
IronPort-SDR: k13ykpgjrq+BbqmKRhcXQOtnlerfS5npsKuaaQfnidEPCgBdi3zD4utB5v5YH9NMViUXsa3FIV
 xVAEnWxw3VhcKiYcrVx9D0x/ctLqbxggtG69AQkZQuSG0DBq9Djs3raLyX/M27o9ycrEmOZy1C
 6fdOCYw9Z5uZDhKACCKy6O/RBAI0qR5ERjYbtcHJo3koya9HCNTg0A5YomQ3Vud6nu2FqArufH
 1L1SyWMZRYcpARcSphaMGZQ+h3OJLXK0MgIk6i7LtnpukMrtClTq/KQqQ/kUTxZXxrrUu6s9KR
 dJfWV00fjOWOdSEyd9jO3xds
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 07:51:02 -0800
IronPort-SDR: fDOL8Q4qjZnLgA/WpVCC9iikbUvSIijRn/QRGeodiE8Fm7ZZR5e4Gl4pODUpFo00mVMUm/FAQv
 MdkYx2C58QeQrYBYL9YyZlChy6Exx3JlbVDlTdt/aQ1q899JLJ1FeoRPCbeaX0KIJzJ3ybdix9
 NPKOUlwDcGl0cvDAX1CkDif9P1wcDp25SjUEzcPIBcn4KWV+B4QU2zQNvtn4q4NvTHsydH1qB2
 1uH0BxDmnyb2Ri5BPVKOGE2hOaGt+Oj/unIGTEmdSg3xVyJJBxsVCWG5Dflh2yu3Dos5BMhXn7
 6lo=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2020 07:58:15 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/5] btrfs: use inode from io_ctl in io_ctl_prepare_pages
Date:   Fri, 14 Feb 2020 00:58:00 +0900
Message-Id: <20200213155803.14799-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213155803.14799-1-johannes.thumshirn@wdc.com>
References: <20200213155803.14799-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

io_ctl_prepare_pages() get's a 'struct btrfs_io_ctl' as well as a 'struct
inode', but btrfs_io_ctl::inode points to the same struct inode as this is
assgined in io_ctl_init().

Use the inode form io_ctl to reduce the arguments of
io_ctl_prepare_pages().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/free-space-cache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3c7660b04a81..657a969a93ad 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -377,10 +377,10 @@ void btrfs_drop_dirty_io_ctl(struct btrfs_io_ctl *io_ctl)
 	io_ctl_free(io_ctl);
 }
 
-static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, struct inode *inode,
-				int uptodate)
+static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, int uptodate)
 {
 	struct page *page;
+	struct inode *inode = io_ctl->inode;
 	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
 	int i;
 
@@ -738,7 +738,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 
 	readahead_cache(inode);
 
-	ret = io_ctl_prepare_pages(&io_ctl, inode, 1);
+	ret = io_ctl_prepare_pages(&io_ctl, 1);
 	if (ret)
 		goto out;
 
@@ -1297,7 +1297,7 @@ static int __btrfs_write_out_cache(struct btrfs_root *root, struct inode *inode,
 	}
 
 	/* Lock all pages first so we can lock the extent safely. */
-	ret = io_ctl_prepare_pages(io_ctl, inode, 0);
+	ret = io_ctl_prepare_pages(io_ctl, 0);
 	if (ret)
 		goto out_unlock;
 
-- 
2.24.1

