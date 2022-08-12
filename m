Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7CD590C85
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 09:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbiHLH1e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 03:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiHLH1d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 03:27:33 -0400
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C8789805
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 00:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1660289245; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=E9oqga/muqmJ1nGqAmexdFD77sOJ4I87j/51KJ5jnmNl5mnJzrG9YpHFdm4lVu3GjC0z9KUf9XlClujmLCydnLPkqUFKZKek54Jdb81Vx5nwO9koQAq/ErDQ9Y/kn+rjju7A6WE/q4YyjlyhFRVt/sZZ3rspmFK78ViDhd93hSs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1660289245; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=6iPYub3xiE7eOYZgj4tGUQRk1aTnZgeAMRtWFP7NFaY=; 
        b=GwiBnUo/xajHiL/GbeMGu8KdVOUsI/cI2TYjAV4p31ZBtd7zIDKrXHfVxOwBU1snZLzvL61PBUCsoEcmldninM+ggO4F4YGW0RxKjh8bGB7k8h0Dt2rU6zGHEVfSAzmS84maWQyis8ystr598BbHeKJJQHIVkjUeHmOfAWdq9Rg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:mime-version; 
  b=V1jAUllYRqdKYBmUtr8Xp4Ozg9T0nIm7ArIeJm8ifgqPKDnubWX62mSumcHi8Ibeh1hkrNsnB84V
    u52toBNMFzKyYSWQdGM++R+5zounrMaytKLni4xGgZlPcr86yjJs  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1660289245;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=6iPYub3xiE7eOYZgj4tGUQRk1aTnZgeAMRtWFP7NFaY=;
        b=S6dTEk4RZP+vPpsbK7hEKL03Op4yQtLsJy/uQSouVpKIO1v+yXl4PzO1i6B2pPlD
        FGGPGayziMHHs/7s5b2xaQLr1f1mZvlXCWw0vpzNawP7mp1CaOyUuhQQ7CvpRyXLAWX
        AqkN8QKAMn3ZfgQCPcH551gaXRnW8pIZ8YwOwS7g=
Received: from localhost.localdomain (58.247.201.31 [58.247.201.31]) by mx.zohomail.com
        with SMTPS id 1660289243873609.741930579875; Fri, 12 Aug 2022 00:27:23 -0700 (PDT)
From:   "Flint.Wang" <hmsjwzb@zoho.com>
To:     quwenruo.btrfs@gmx.com
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        anand.jain@oracle.com, clm@fb.com, hmsjwzb@zoho.com,
        strongbox8@zoho.com
Subject: [PATCH v1] btrfs-progs: chunk tree search solution for btrfs249
Date:   Fri, 12 Aug 2022 15:26:35 +0800
Message-Id: <20220812072635.10979-1-hmsjwzb@zoho.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-ZohoMail-Owner: <20220812072635.10979-1-hmsjwzb@zoho.com>+zmo_0_hmsjwzb@zoho.com
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
Thanks for your proposal. I have implemented the first edition of chunk
tree search solution.
But it seems chunk tree search solution need root privilege.

Btrfs249 failed due to btrfs_ioctl_fs_info() return RW devices for 
fi_args->num_devices. This patch search chunk tree to find no seed device.

Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
---
 cmds/filesystem-usage.c | 89 +++++++++++++++++++++++++++++++++--------
 cmds/filesystem-usage.h |  5 +++
 common/utils.c          | 11 +++--
 common/utils.h          |  2 +-
 4 files changed, 85 insertions(+), 22 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 01729e18..ef022ae4 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -25,6 +25,7 @@
 #include <getopt.h>
 #include <fcntl.h>
 #include <linux/limits.h>
+#include <uuid/uuid.h>
 
 #include "common/utils.h"
 #include "kerncompat.h"
@@ -689,6 +690,59 @@ out:
 	return ret;
 }
 
+static int load_devid_uuid(int fd, struct devid_uuid *pair,
+			    int ndev, u8 *noseed_fsid)
+{
+	struct btrfs_ioctl_search_args_v2 *args2;
+	struct btrfs_ioctl_search_key *sk;
+	struct btrfs_ioctl_search_header *sh;
+	struct btrfs_dev_item *dev_item;
+	int args2_size = 1024;
+	char args2_buf[args2_size];
+	int ret, i, num, noseed_dev = 0, pidx = 0;
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
+		if (!uuid_compare(dev_item->fsid, noseed_fsid)) {
+			noseed_dev += 1;
+			pair[pidx].devid = dev_item->devid;
+			memcpy(&pair[pidx++].uuid, dev_item->uuid, BTRFS_UUID_SIZE);
+		}
+		if (pidx > ndev) {
+			error("unexpected number of devices: %d >= %d", pidx, ndev);
+			return -1;
+		}
+		sh = (struct btrfs_ioctl_search_header *) dev_item + 1;
+		dev_item = (struct btrfs_dev_item *) sh + 1;
+	}
+
+	if (ndev != noseed_dev)
+		error("unexpected number of devices: %d != %d", ndev, noseed_dev);
+
+	return 0;
+}
+
 /*
  *  This function loads the device_info structure and put them in an array
  */
@@ -699,6 +753,7 @@ static int load_device_info(int fd, struct device_info **device_info_ptr,
 	struct btrfs_ioctl_fs_info_args fi_args;
 	struct btrfs_ioctl_dev_info_args dev_info;
 	struct device_info *info;
+	struct devid_uuid *pair;
 	u8 fsid[BTRFS_UUID_SIZE];
 
 	*device_info_count = 0;
@@ -718,19 +773,23 @@ static int load_device_info(int fd, struct device_info **device_info_ptr,
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
+	pair = malloc(sizeof(struct devid_uuid) * fi_args.num_devices);
+	if (!pair) {
+		error("not enough memory");
+		return 1;
+	}
+
+	ret = load_devid_uuid(fd, pair, fi_args.num_devices, fi_args.fsid);
+	if (ret == -1)
+		goto out;
+
+	for (i = 0, ndevs = 0 ; i < fi_args.num_devices ; i++) {
 		memset(&dev_info, 0, sizeof(dev_info));
-		ret = get_device_info(fd, i, &dev_info);
+		ret = get_device_info(fd, pair[i].devid, pair[i].uuid, &dev_info);
 
-		if (ret == -ENODEV)
-			continue;
+		if (ret == -ENODEV) {
+			error("device not found\n");
+		}
 		if (ret) {
 			error("cannot get info about device devid=%d", i);
 			goto out;
@@ -759,21 +818,17 @@ static int load_device_info(int fd, struct device_info **device_info_ptr,
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
 
 	*device_info_count = fi_args.num_devices;
 	*device_info_ptr = info;
+	free(pair);
 
 	return 0;
 
 out:
+	free(pair);
 	free(info);
 	return ret;
 }
diff --git a/cmds/filesystem-usage.h b/cmds/filesystem-usage.h
index cab38462..f78b2f2e 100644
--- a/cmds/filesystem-usage.h
+++ b/cmds/filesystem-usage.h
@@ -44,6 +44,11 @@ struct chunk_info {
 	u64	num_stripes;
 };
 
+struct devid_uuid {
+	__le64 devid;
+	u8 uuid[BTRFS_UUID_SIZE];
+};
+
 int load_chunk_and_device_info(int fd, struct chunk_info **chunkinfo,
 		int *chunkcount, struct device_info **devinfo, int *devcount);
 void print_device_chunks(struct device_info *devinfo,
diff --git a/common/utils.c b/common/utils.c
index 1ed5571f..d09177ef 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -284,13 +284,16 @@ void btrfs_format_csum(u16 csum_type, const u8 *data, char *output)
 	}
 }
 
-int get_device_info(int fd, u64 devid,
+int get_device_info(int fd, u64 devid, u8 *uuid,
 		struct btrfs_ioctl_dev_info_args *di_args)
 {
 	int ret;
 
 	di_args->devid = devid;
-	memset(&di_args->uuid, '\0', sizeof(di_args->uuid));
+	if (!uuid)
+		memset(&di_args->uuid, '\0', sizeof(di_args->uuid));
+	else
+		memcpy(&di_args->uuid, uuid, sizeof(di_args->uuid));
 
 	ret = ioctl(fd, BTRFS_IOC_DEV_INFO, di_args);
 	return ret < 0 ? -errno : 0;
@@ -498,7 +501,7 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
 		 * search_chunk_tree_for_fs_info() will lacks the devid 0
 		 * so manual probe for it here.
 		 */
-		ret = get_device_info(fd, 0, &tmp);
+		ret = get_device_info(fd, 0, NULL, &tmp);
 		if (!ret) {
 			fi_args->num_devices++;
 			ndevs++;
@@ -521,7 +524,7 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
 		memcpy(di_args, &tmp, sizeof(tmp));
 	for (; last_devid <= fi_args->max_id && ndevs < fi_args->num_devices;
 	     last_devid++) {
-		ret = get_device_info(fd, last_devid, &di_args[ndevs]);
+		ret = get_device_info(fd, last_devid, NULL, &di_args[ndevs]);
 		if (ret == -ENODEV)
 			continue;
 		if (ret)
diff --git a/common/utils.h b/common/utils.h
index ea05fe5b..f1bbd807 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -67,7 +67,7 @@ int ask_user(const char *question);
 int lookup_path_rootid(int fd, u64 *rootid);
 int find_mount_fsroot(const char *subvol, const char *subvolid, char **mount);
 int find_mount_root(const char *path, char **mount_root);
-int get_device_info(int fd, u64 devid,
+int get_device_info(int fd, u64 devid, u8 *uuid,
 		struct btrfs_ioctl_dev_info_args *di_args);
 int get_df(int fd, struct btrfs_ioctl_space_args **sargs_ret);
 
-- 
2.37.0

