Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC42647FE6
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Dec 2022 10:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiLIJLe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Dec 2022 04:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiLIJL2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Dec 2022 04:11:28 -0500
Received: from sender4-pp-o91.zoho.com (sender4-pp-o91.zoho.com [136.143.188.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B3C554CD
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Dec 2022 01:11:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670577079; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=J6iYBSrUftk/+DFSB/Q4phKzvyuLFvwOifuTISmPkZNIvpwH06aK3EZg+UiM4+yZoP0VUDh6o3ajdpeVO6q+HTSeAPJy9YnFWX4rnsFOT9qQfMvTnVOGdHGIIGIW2dCPCCwyCg5+YrSOR8Bkkw5M/Qzt0ga+/fJhraqXCucpFFY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670577079; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=9trdlTO+9mPhU7UgJQZjiqsI4CBTvN348Nt7Fx+4U1Q=; 
        b=EkU0c6l259geKtm8AG0sVFu33/JQcqmejrDkSS5a/3BcmdYol+oEe2GYkHJxO73NX5Cte0srCW5yjuDin8GVkj6pN3Mk0nH71/TAJFBhFcqzbMKHT4oRAcKw+E2+aExiI5b099d8DAYeeTpsQvnSzf9a9s5x/aGk3Ztdrmh34Qg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670577079;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=9trdlTO+9mPhU7UgJQZjiqsI4CBTvN348Nt7Fx+4U1Q=;
        b=VW06DMkoS0IoVMuteLwJq6e6mXQLTTEj8z4RoT8YuzqwKRDM0XZmIbXAB+pUtzyw
        ZDr+5MApgl515nVqHjhVCFzRst0+XL8og87UvyVrjlSKRMbRWMrPXvlk6ylhiZ+cf5N
        zPS9ewbrilDZdnQKXs99Ofwc9BeO1TjM+cTLLFHw=
Received: from localhost.localdomain (58.247.201.213 [58.247.201.213]) by mx.zohomail.com
        with SMTPS id 1670577078660295.67123427272963; Fri, 9 Dec 2022 01:11:18 -0800 (PST)
From:   "Flint.Wang" <hmsjwzb@zoho.com>
To:     linux-btrfs@vger.kernel.org, quwenruo.btrfs@gmx.com,
        anand.jain@oracle.com
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        sunzhipeng.scsmile@bytedance.com, strongbox8@zoho.com,
        wqu@suse.com, hmsjwzb@zoho.com
Subject: [PATCH] btrfs-progs: change load_device_info to chunk tree search solution
Date:   Fri,  9 Dec 2022 17:08:25 +0800
Message-Id: <20221209090825.2900-1-hmsjwzb@zoho.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs/249 failed due to btrfs_ioctl_fs_info() return RW devices for fi_args->num_devices.
This patch change load_device_info to chunk tree search solution.

Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
---
 cmds/filesystem-usage.c | 83 ++++++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 17 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 01729e18..71f0e14c 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -25,6 +25,7 @@
 #include <getopt.h>
 #include <fcntl.h>
 #include <linux/limits.h>
+#include <uuid/uuid.h>
 
 #include "common/utils.h"
 #include "kerncompat.h"
@@ -689,6 +690,62 @@ out:
 	return ret;
 }
 
+static int load_devid(int fd, struct device_info *info,
+			    int ndev, u8 *fsid)
+{
+	struct btrfs_ioctl_search_args_v2 *args2;
+	struct btrfs_ioctl_search_key *sk;
+	struct btrfs_ioctl_search_header *sh;
+	struct btrfs_dev_item *dev_item;
+	int args2_size = 1024;
+	char args2_buf[args2_size];
+	int ret = 0;
+	int i = 0;
+	int num = 0;
+	int rw_devs = 0;
+	int idx = 0;
+
+	args2 = (struct btrfs_ioctl_search_args_v2 *) args2_buf;
+	sk = &(args2->key);
+
+	sk->tree_id = BTRFS_CHUNK_TREE_OBJECTID;
+	sk->min_objectid = BTRFS_DEV_ITEMS_OBJECTID;
+	sk->max_objectid = BTRFS_DEV_ITEMS_OBJECTID;
+	sk->min_type = BTRFS_DEV_ITEM_KEY;
+	sk->max_type = BTRFS_DEV_ITEM_KEY;
+	sk->min_offset = 0;
+	sk->max_offset = (u64)-1;
+	sk->min_transid = 0;
+	sk->max_transid = (u64)-1;
+	sk->nr_items = -1;
+	args2->buf_size = args2_size - sizeof(struct btrfs_ioctl_search_args_v2);
+	ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH_V2, args2);
+	if (ret != 0)
+	       return -1;
+
+	sh = (struct btrfs_ioctl_search_header *) args2->buf;
+	num = sk->nr_items;
+
+	dev_item = (struct btrfs_dev_item *) (sh + 1);
+	for (i = 0; i < num; i++) {
+		if (!uuid_compare(dev_item->fsid, fsid)) {
+			rw_devs += 1;
+			info[idx++].devid = dev_item->devid;
+		}
+		if (idx > ndev) {
+			error("unexpected number of devices: %d >= %d", idx, ndev);
+			return -1;
+		}
+		sh = (struct btrfs_ioctl_search_header *) dev_item + 1;
+		dev_item = (struct btrfs_dev_item *) sh + 1;
+	}
+
+	if (ndev != rw_devs)
+		error("unexpected number of devices: %d != %d", ndev, rw_devs);
+
+	return 0;
+}
+
 /*
  *  This function loads the device_info structure and put them in an array
  */
@@ -718,19 +775,17 @@ static int load_device_info(int fd, struct device_info **device_info_ptr,
 		return 1;
 	}
 
-	for (i = 0, ndevs = 0 ; i <= fi_args.max_id ; i++) {
-		if (ndevs >= fi_args.num_devices) {
-			error("unexpected number of devices: %d >= %llu", ndevs,
-				(unsigned long long)fi_args.num_devices);
-			error(
-		"if seed device is used, try running this command as root");
-			goto out;
-		}
+	ret = load_devid(fd, info, fi_args.num_devices, fi_args.fsid);
+	if (ret == -1)
+		goto out;
+
+	for (i = 0, ndevs = 0 ; i < fi_args.num_devices ; i++) {
 		memset(&dev_info, 0, sizeof(dev_info));
-		ret = get_device_info(fd, i, &dev_info);
+		ret = get_device_info(fd, info[i].devid, &dev_info);
 
-		if (ret == -ENODEV)
-			continue;
+		if (ret == -ENODEV) {
+			error("device not found\n");
+		}
 		if (ret) {
 			error("cannot get info about device devid=%d", i);
 			goto out;
@@ -759,12 +814,6 @@ static int load_device_info(int fd, struct device_info **device_info_ptr,
 		++ndevs;
 	}
 
-	if (ndevs != fi_args.num_devices) {
-		error("unexpected number of devices: %d != %llu", ndevs,
-				(unsigned long long)fi_args.num_devices);
-		goto out;
-	}
-
 	qsort(info, fi_args.num_devices,
 		sizeof(struct device_info), cmp_device_info);
 
-- 
2.37.0

