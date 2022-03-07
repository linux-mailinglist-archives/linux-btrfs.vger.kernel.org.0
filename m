Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5709B4CF91D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 11:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbiCGKDh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 05:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240616AbiCGKBJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 05:01:09 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BAA44741
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 01:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646646633; x=1678182633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ul9GXlz1m+drUDFZI0YV7rX7GRPyTWgtJ0WYupYmPhU=;
  b=oaymshnbiFBkNTb5UOjPQEhG7n6CGz75pytqIaZyaiEfwb1XoOOZJSg7
   LfwFmUFQLMkvFXB6095tJ0Aiein9VMhOaewCukoMt/vVEEN9/H10XdVjd
   k/qJuEPSk3T+5BadfrcAR235/TXoSTPYq8UyInpSe01PGcP+/F5XFrzSC
   DwAarxFThXEuPQphU8TS49zN4rYDbZ4jh0zjJP8mjLuiqiNcANbkLJpki
   O2SEtHYQ+D/TB47r3ng5P66ny2QAgPonkAUXLrxEQxYoR65Maf9UPyqe4
   LvRXwYjOkrmeKG3EIIVeSUmQXBnj0a2GDZNjPsuDB9CXt9r0S+yjHO3VD
   A==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643644800"; 
   d="scan'208";a="195612174"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 17:50:32 +0800
IronPort-SDR: 3J87Af7d2k9E8GFpSdN0lX9M1sUxTgnwMzPLtxFBZmXp0MZU6zI+O5sKKJaQHXCzzUnxem0+Fh
 Axcv87C7v7XDzxUbbjqMJIuFf/dLiiayengi4UpyQgpSxkfwRaaiIM/jF3pF3a4mpZvZ+tu8m0
 I0acVSkWXnHMmr2gIc8bJEe8E3UFb7Co7PQdSHMbf6MRgQWBlAlswUTGdBBNIfSIFmcfGOqaH/
 KnOfczgEsXK2oB2GWjCTIUMJ2vUh1va2r4sVC6qALno5IqFaI/2JA7Oy7TbMjTGPibEE2aVtSA
 vNxcobNE7KbJode8s0xxfNQu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:21:49 -0800
IronPort-SDR: Nq88JFKwhlFM66en81ksP6J/f1WfK2LPGJYeuzAojppEDpWcxvpr96vQ8hKgu14bgsBlue2VWI
 709TrAi7otds1MCOi0Ks3Kcq4Wcf5tePiDwmElRfWIoVtUZw9XU/wchVs7Q14CLtnDSgLMdW+s
 9D0FlooDdx2kNNk4US1l+LW5U9HHUCdigaeUfH2jXPcv+cSIvsWNIMPtnoYJdY0+MdAe6EFvQz
 rmWkaV8mXATP575LEsedcmAWFtyzxsqjjBfw7IzipuD90HdRQRRRoah3LkImlw5so6TvjdUgX8
 nRU=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Mar 2022 01:50:31 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wwdc.com>
Subject: [PATCH 1/2] btrfs: zoned: use rcu list in btrfs_can_activate_zone
Date:   Mon,  7 Mar 2022 01:50:24 -0800
Message-Id: <b1495af336d60ff11a0fac6c27f15533e9b82b31.1646646324.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646646324.git.johannes.thumshirn@wdc.com>
References: <cover.1646646324.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_can_activate_zone() can be called with the device_list_mutex already
held, which will lead to a deadlock.

As we're only traversing the list for reads we can switch from the
device_list_mutex to an rcu traversal of the list.

Fixes: a85f05e59bc1 ("btrfs: zoned: avoid chunk allocation if active block group has enough space")
Cc: Naohiro Aota <naohiro.aota@wwdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b7b5fac1c779..cf6341d45689 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1986,8 +1986,8 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 	ASSERT((flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0);
 
 	/* Check if there is a device with active zones left */
-	mutex_lock(&fs_devices->device_list_mutex);
-	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
 		struct btrfs_zoned_device_info *zinfo = device->zone_info;
 
 		if (!device->bdev)
@@ -1999,7 +1999,7 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 			break;
 		}
 	}
-	mutex_unlock(&fs_devices->device_list_mutex);
+	rcu_read_unlock();
 
 	return ret;
 }
-- 
2.35.1

