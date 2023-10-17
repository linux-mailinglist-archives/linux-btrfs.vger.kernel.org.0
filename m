Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5D47CBD00
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Oct 2023 10:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjJQIBX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 04:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQIBW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 04:01:22 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A05893
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 01:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697529680; x=1729065680;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=swV16Rd7ks1yCdUwc25tqlaCJ44isQ9p6Xqktq0xDJg=;
  b=ogHdgxeNX5GDXY1oRjbMwMNyOgi3H4BqE82bAZq9Off8ft7UB/SPadxt
   zicnRcY2BmMeRhx54ze6gTxfR6tokWjg10Cew4ZXsSde8lqUKF18+1E1n
   oE8Ag7QZ6KQDFa40XzMT4bks32AISmd1tAYSWxChok2yiffqKMn4GDOGv
   aIug5Npcd5dPj7xhcDk/Dqll9lX0MFpehB6XW0ibjQG+FT1nE4vohABoQ
   AD+ALkk7qzHkoKrIL1U4QzOR4iz4+/4usGm1/LNOIA3AHud1GFVZWM76j
   G4gQf3cyZl/fMBqZYrLlEZee3XRx87VQDCgg4pgL1VSzLHq/TPzL4Vxl8
   Q==;
X-CSE-ConnectionGUID: C1qPDZ2ARi2A5q/gcc3EFQ==
X-CSE-MsgGUID: H0TeQMvpTuyGO9xpExku7A==
X-IronPort-AV: E=Sophos;i="6.03,231,1694707200"; 
   d="scan'208";a="352082036"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2023 16:01:20 +0800
IronPort-SDR: IZSMVnygahdBiPL3WyP03Xq4j6bjfBjq2o6tMZCPTL76khIXjqXtyisJrw5a6p2TC2ZD/Wdaym
 3xf+qR4PYLep/p1aFwVEXVTVp3SCfcjXMa8EGF7nLr8yy5x30aVMp+tUY0tX/HwTc9qu0G6on6
 Sjl5Lg8kMaIe5FFpe0vVrbVy6irIz0RHkQL76dgU25dHa8ya1IAon+JAaPkoNgq6yWf8mI0faS
 gNNCWERmDc3pCVAOPz4Vky7yduTCM40l42+nELMBM2MRIgCPHiAuT9DElA0lWC/GOJbs56ATu0
 nYs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2023 00:07:41 -0700
IronPort-SDR: bd1mKNfrpsMeDGCulQ+buLW8rI+SXnUeDX5MkvqgchI/HHot+lnbQu5hGrmfdaOlCXTo15h6gr
 vlZOSlnu7EaFV2JLW7i2SWJhpKLvRNlTepA+3fju/U11wde8yjwDKIQ4q3JHlBBYfGbdP7g3sz
 P/ogk0mZtp4Om3bpKZs7PvuX+pHogdVhmsstgiLt9oRClWtJOwiCRG8CTwsJ8X+ygGoFXqO2fr
 e1u9sbFlwnNmfTuJbIkiuAmylcL7MSwpjkacPpAWP+vj7oZuEwq9Q9wx3kTNmPcw9dCi7c+Ewe
 7ps=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.39])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Oct 2023 01:01:20 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] btrfs: zoned: wait for data BG to be finished on direct IO allocation
Date:   Tue, 17 Oct 2023 17:00:31 +0900
Message-ID: <36d4b7502a8654882718421a18472d41dbc1c83c.1697529529.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Running the fio command below on a ZNS device results in "Resource
temporarily unavailable" error.

fio: io_u error on file /mnt/w.2.0: Resource temporarily unavailable: write offset=117440512, buflen=16777216
fio: io_u error on file /mnt/w.2.0: Resource temporarily unavailable: write offset=134217728, buflen=16777216
...

This happens because -EAGAIN error returned from btrfs_reserve_extent()
called from btrfs_new_extent_direct() is splling over to the userland.

btrfs_reserve_extent() returns -EAGAIN when there is no active zone
available. Then, the caller should wait for some other on-going IO to
finish a zone and retry the allocation.

This logic is already implemented for buffered write in cow_file_range(),
but it is missing for the direct IO counterpart. Implement the same logic
for it.

Fixes: 2ce543f47843 ("btrfs: zoned: wait until zone is finished when allocation didn't progress")
CC: stable@vger.kernel.org # 6.1+
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b388505c91cc..a979e964375d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6979,8 +6979,16 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	int ret;
 
 	alloc_hint = get_extent_allocation_hint(inode, start, len);
+again:
 	ret = btrfs_reserve_extent(root, len, len, fs_info->sectorsize,
 				   0, alloc_hint, &ins, 1, 1);
+	if (ret == -EAGAIN) {
+		ASSERT(btrfs_is_zoned(fs_info));
+		wait_on_bit_io(&inode->root->fs_info->flags,
+			       BTRFS_FS_NEED_ZONE_FINISH,
+			       TASK_UNINTERRUPTIBLE);
+		goto again;
+	}
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.42.0

