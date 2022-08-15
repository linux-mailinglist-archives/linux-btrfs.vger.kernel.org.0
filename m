Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD1A5927DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Aug 2022 04:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiHOCok (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Aug 2022 22:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiHOCoj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Aug 2022 22:44:39 -0400
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5392B13DD6
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Aug 2022 19:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1660531474; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=BZuXRCg13pxY9AJeD9Nc68hzqrwfVeBwi41sYO7G9FhTH8jPJ0tcVzwfVBYE/OczU1E0i29JXcfcxKp6IhFO7VLd7jfw9mc7cQUZ7BYiJtQ1u7TkLSe2MCdIPYM34V8buNBvprwbvL7d7TaZdyUcHHofpDocaCt2kFbd6lFZjfg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1660531474; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=60fMEgfWjYf4r0iUL49Z0pT8INo3I6auU7CdUaBfUBk=; 
        b=ffMpKRmOJhDgVl+3ycmy8QAzPk/dexU0nf/rPhlkh4y/V1QyErqTDEGWHExdUCn1tPC3aC6MidCHsbrr3uXNi7APu6EX+XYzb2VRf5Gs7KFIk1mTz5t8iBSAPUFklRrD74PP6cwhc42RtCKSEcOwfOpjnfxnNAY9HbBP2JVMj6c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:mime-version; 
  b=P7n5oHdFFMhf7UCmMK/VYBjRH+26HopIRfbijsHGIPrBcohqR6QZuMtuWYhKrJ28KdE7HNyH0rMz
    kEDLXA/vHn/7OB0x9qzdVdWoRqQBHm3fA/iit3Zy+UkVs1i1mSdt  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1660531474;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=60fMEgfWjYf4r0iUL49Z0pT8INo3I6auU7CdUaBfUBk=;
        b=W32EPuAF2/E6ywSEGM7nZfmQZbrln0AYUxUoA5OnUO0Zvu0u+wV/NEW/PIrM2zYJ
        rPD/E8WhBfa2dbMeruRrnrDNhvGXTqxAn4o0v5SH2jpOEM98lKXmkY82W1eZpWkUpXD
        5IWNezqiQDGNj40LxC0VMrbryLlKUNiGjkE7UXhA=
Received: from localhost.localdomain (58.247.201.46 [58.247.201.46]) by mx.zohomail.com
        with SMTPS id 1660531473221747.4671818330204; Sun, 14 Aug 2022 19:44:33 -0700 (PDT)
From:   "Flint.Wang" <hmsjwzb@zoho.com>
To:     quwenruo.btrfs@gmx.com
Cc:     linux-btrfs@vger.kernel.org, anand.jain@oracle.com,
        hmsjwzb@zoho.com
Subject: [PATCH v2] btrfs-progs: chunk tree search solution for btrfs249
Date:   Mon, 15 Aug 2022 10:43:41 +0800
Message-Id: <20220815024341.4677-1-hmsjwzb@zoho.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Thanks for your comment. I fix the issue you suggest.
It is much clean now.

Btrfs249 failed due to btrfs_ioctl_fs_info() return RW devices for fi_args->num_devices.
This patch search chunk tree to find rw devices.

v2 change:
1. code style fix.
2. noseed_dev => rw_devs, noseed_fsid => fsid.
3. remove redundant structure devid_uuid.
4. reuse the dev_info structure.
5. remove redundant uuid argument.

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

Thanks,
Flint
