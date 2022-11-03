Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543D46177E3
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 08:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiKCHpH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 03:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiKCHpG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 03:45:06 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A038F2661;
        Thu,  3 Nov 2022 00:45:04 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N2wgz1CnSzJnRq;
        Thu,  3 Nov 2022 15:42:07 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 15:44:48 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 15:44:48 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] btrfs: fix match incorrectly in dev_args_match_device
Date:   Thu, 3 Nov 2022 16:33:01 +0800
Message-ID: <20221103083301.626561-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzkaller found an assert failed:

 assertion failed: (args->devid != (u64)-1) || args->missing, in fs/btrfs/volumes.c:6921

This can be trigger when we set devid to (u64)-1) by ioctl. In this case,
the match of devid will be skipped and the match of device may be succeed
incorrectly.

Patch 562d7b1512f7 introduced this function which is used to match device.
This function contaions two matching scenarios, we can distinguish them by
checking the value of args->missing rather than check whether args->devid
and args->uuid is default value.

Reported-by: syzbot+031687116258450f9853@syzkaller.appspotmail.com
Fixes: 562d7b1512f7 ("btrfs: handle device lookup with btrfs_dev_lookup_args")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 fs/btrfs/volumes.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 94ba46d57920..bf2d886cfb4b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6918,18 +6918,18 @@ static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
 static bool dev_args_match_device(const struct btrfs_dev_lookup_args *args,
 				  const struct btrfs_device *device)
 {
-	ASSERT((args->devid != (u64)-1) || args->missing);
+	if (args->missing) {
+		if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state) &&
+		    !device->bdev)
+			return true;
+		return false;
+	}
 
-	if ((args->devid != (u64)-1) && device->devid != args->devid)
+	if (device->devid != args->devid)
 		return false;
 	if (args->uuid && memcmp(device->uuid, args->uuid, BTRFS_UUID_SIZE) != 0)
 		return false;
-	if (!args->missing)
-		return true;
-	if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state) &&
-	    !device->bdev)
-		return true;
-	return false;
+	return true;
 }
 
 /*
-- 
2.25.1

