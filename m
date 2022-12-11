Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5B3649737
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 00:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiLKXUi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Dec 2022 18:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKXUf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Dec 2022 18:20:35 -0500
Received: from sender4-pp-o91.zoho.com (sender4-pp-o91.zoho.com [136.143.188.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FAAC76E
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 15:20:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670800823; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=XVgrgOS2Az3jpEYji+BRlDhKqVv3X11y2/VltjMnhXyPh1MSG9m19HtoI37SNTDL+9IFlKS5iXJbGcno7tOBLtBkQ+Zedz+iqSGemnwSm93naBdGsNDN1r+1fQihpj7OD28tS5YkBwzz8l0jVcDrIsNO77NM17PuBhal5CGYEKA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670800823; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=AoRIXeR/3hys1JzMWhSqrEzokGkvb4l69DEuL7KV618=; 
        b=UFEGCYPkB1gpcnMF1NcDf489Vreng9QoszLqWx1mRBuCvta59lGCGgTwDrPNAv8u2JetkKGf+RlgkE9ffjy/YpyqIvXDgCcSz+xqg0//gGz99pSkfyuXrwzvSzKXGWiI/+HytYenLullhl3++LDmJnmp4+NDh9Fv6YsdrMRq2xw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670800823;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:Reply-To;
        bh=AoRIXeR/3hys1JzMWhSqrEzokGkvb4l69DEuL7KV618=;
        b=VkR1ubOedZVdd1/rAL1aKZ2zeahle3qxM4QxctIGX2cj3hESn9nQpr3hcnhka8db
        Wg75k3x5FMk0evxXA1wXn/DcQGfxE+NZgXYCSSPRiTdlkyP8MzaWN41MLOD7arMXGjc
        79irjaBcYvr1lBmPn0GJAH9kFbBHzUbHAhHKh5bQ=
Received: from localhost.localdomain (117.143.174.243 [117.143.174.243]) by mx.zohomail.com
        with SMTPS id 1670800822624876.9998674865401; Sun, 11 Dec 2022 15:20:22 -0800 (PST)
From:   hmsjwzb <hmsjwzb@zoho.com>
To:     quwenruo.btrfs@gmx.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        sunzhipeng.scsmile@bytedance.com, strongbox8@zoho.com,
        wqu@suse.com, hmsjwzb@zoho.com, mabruce@micron.com
Subject: [PATCH] btrfs-progs: change load_device_info to chunk tree search solution
Date:   Mon, 12 Dec 2022 07:20:11 +0800
Message-Id: <20221211232011.20388-1-hmsjwzb@zoho.com>
X-Mailer: git-send-email 2.17.1
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

From: "Flint.Wang" <hmsjwzb@zoho.com>

btrfs/249 fails due to unexpected number of devices

[How to reproduce]
mkfs.btrfs -f -d raid1 -m raid1 /dev/sdb /dev/sdc
btrfstune -S 1 /dev/sdb
wipefs -a /dev/sdb
mount -o degrade /dev/sdc /mnt/scratch
btrfs device add -f /dev/sdd /mnt/scratch
btrfs filesystem usage /mnt/scratch

[Root cause]
ioctl call BTRFS_IOC_FS_INFO returns both rw device and seed device.
It will cause device number mismatch issues.

[How to Fix]
This patch introduce function load_devid which only return the information
of rw devices.

Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
---
 cmds/filesystem-usage.c | 81 +++++++++++++++++++++++++++++++++++------
 1 file changed, 70 insertions(+), 11 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 5810324f..887fe034 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -27,6 +27,7 @@
 #include <fcntl.h>
 #include <dirent.h>
 #include <limits.h>
+#include <uuid/uuid.h>
 #include "kernel-lib/sizes.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
@@ -700,6 +701,65 @@ out:
 	return ret;
 }
 
+/*
+ * This function searches chunk tree to find rw_devs
+ */
+static int load_devid(int fd, struct device_info *info,
+		int ndev, u8 *fsid)
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
+		return -1;
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
@@ -729,19 +789,18 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
 		return 1;
 	}
 
-	for (i = 0, ndevs = 0 ; i <= fi_args.max_id ; i++) {
-		if (ndevs >= fi_args.num_devices) {
-			error("unexpected number of devices: %d >= %llu", ndevs,
-				fi_args.num_devices);
-			error(
-		"if seed device is used, try running this command as root");
-			goto out;
-		}
+	ret = load_devid(fd, info, fi_args.num_devices, fi_args.fsid);
+	if (ret == -1)
+		goto out;
+
+	for (i = 0, ndevs = 0; i < fi_args.num_devices; i++) {
 		memset(&dev_info, 0, sizeof(dev_info));
-		ret = get_device_info(fd, i, &dev_info);
+		ret = get_device_info(fd, info[i].devid, &dev_info);
+
+		if (ret == -ENODEV) {
+			error("device not found\n");
+		}
 
-		if (ret == -ENODEV)
-			continue;
 		if (ret) {
 			error("cannot get info about device devid=%d", i);
 			goto out;
-- 
2.37.2

