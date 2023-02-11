Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7234693082
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Feb 2023 12:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjBKLuz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Feb 2023 06:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjBKLuy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Feb 2023 06:50:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8962D1ADF6
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 03:50:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 998535D408
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676116251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZZJu+95eN++woWMH9qUngvf58+f4zoLlj11SxlCuIJo=;
        b=d4DDa6l8dNpqktHy9WJCS4gTdoKmwMfKlgC7Ac1HtUnIxoHmeammKmpY2MA8mJRnMNqCJq
        aeXXL73fl5FfIgNIJPobCtogpydevV0utr0JIJylKw65hFGdeZiGmCgTQzcxrGO0q7kjbh
        5Xutp825cc649J/sY4QTKh9GopZrKfs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF08313A10
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 11:50:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wC/ELRqB52ObVgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 11:50:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: filesystem-usage: handle missing seed device properly
Date:   Sat, 11 Feb 2023 19:50:30 +0800
Message-Id: <0695352140625cd66a86e8a12365271def5db39b.1676115988.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1676115988.git.wqu@suse.com>
References: <cover.1676115988.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Test case btrfs/249 always fails since its introduction, the failure
comes from "btrfs filesystem usage" subcommand, and the error output
looks like this:

  QA output created by 249
  ERROR: unexpected number of devices: 1 >= 1
  ERROR: if seed device is used, try running this command as root
  FAILED: btrfs filesystem usage, ret 1. Check btrfs.ko and btrfs-progs version.
  (see /home/adam/xfstests/results//btrfs/249.full for details)

[CAUSE]
In function load_device_info(), we only allocate enough space for all
*RW* devices, expecting we can rule out all seed devices.

And in that function, we check if a device is a seed by checking its
super block fsid.

So if a seed device is missing (it can be an seed device without any
chunks on it, or a degraded RAID1 as seed), then we can not read the
super block.

In that case, we just assume it's not a seed device, and causing too
many devices than our expectation and cause the above failure.

[FIX]
Instead of unconditionally assume a missing device is not a seed, we add
a new safe net, is_seed_device_tree_search(), to search chunk tree and
determine if that device is a seed or not.

And if we found the device is still a seed, then just skip it as usual.

And since we're here, extract the seed device checking into a dedicated
helper, is_seed_device() for later expansion.

Now the test case btrfs/249 passes as expected:

  btrfs/249        2s
  Ran: btrfs/249
  Passed all 1 tests

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/filesystem-usage.c | 119 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 107 insertions(+), 12 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 5810324f245e..abde04d715a7 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -700,6 +700,102 @@ out:
 	return ret;
 }
 
+/*
+ * Return 0 if this devid is not a seed device.
+ * Return 1 if this devid is a seed device.
+ * Return <0 if error (IO error or EPERM).
+ *
+ * Since this is done by tree search, it needs root privilege, and
+ * should not be triggered unless we hit a missing device and can not
+ * determine if it's a seed one.
+ */
+static int is_seed_device_tree_search(int fd, u64 devid, const u8 *fsid)
+{
+	struct btrfs_ioctl_search_args args = {0};
+	struct btrfs_ioctl_search_key *sk = &args.key;
+	struct btrfs_ioctl_search_header *sh;
+	struct btrfs_dev_item *dev;
+	unsigned long off = 0;
+	int ret;
+	int err;
+
+	sk->tree_id = BTRFS_CHUNK_TREE_OBJECTID;
+	sk->min_objectid = BTRFS_DEV_ITEMS_OBJECTID;
+	sk->max_objectid = BTRFS_DEV_ITEMS_OBJECTID;
+	sk->min_type = BTRFS_DEV_ITEM_KEY;
+	sk->max_type = BTRFS_DEV_ITEM_KEY;
+	sk->min_offset = devid;
+	sk->max_offset = devid;
+	sk->max_transid = (u64)-1;
+	sk->nr_items = 1;
+
+	ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args);
+	err = errno;
+	if (err == EPERM)
+		return -err;
+	if (ret < 0) {
+		error("cannot lookup chunk tree info: %m");
+		return ret;
+	}
+	/* No dev item found. */
+	if (sk->nr_items == 0)
+		return -ENOENT;
+
+	sh = (struct btrfs_ioctl_search_header *)(args.buf + off);
+	off += sizeof(*sh);
+
+	dev = (struct btrfs_dev_item *)(args.buf + off);
+	if (memcmp(dev->fsid, fsid, BTRFS_UUID_SIZE) == 0)
+		return 0;
+	return 1;
+}
+
+/*
+ * Return 0 if this devid is not a seed device.
+ * Return 1 if this devid is a seed device.
+ * Return <0 if error (IO error or EPERM).
+ */
+static int is_seed_device(int fd, u64 devid, const u8 *fsid,
+			  const struct btrfs_ioctl_dev_info_args *dev_arg)
+{
+	int ret;
+	u8 found_fsid[BTRFS_UUID_SIZE];
+
+	/*
+	 * A missing device, we can not determing if it's a seed
+	 * device by reading its super block.
+	 * Thus we have to go tree-search to make sure if it's a seed
+	 * device.
+	 */
+	if (!dev_arg->path[0]) {
+		ret = is_seed_device_tree_search(fd, devid, fsid);
+		if (ret < 0) {
+			errno = -ret;
+			warning(
+	"unable to determine if devid %llu is seed using tree search: %m",
+				devid);
+			return ret;
+		}
+		return ret;
+	}
+
+	/*
+	 * This device is not missing, try read its super block to determine its
+	 * fsid.
+	 */
+	ret = dev_to_fsid((const char *)dev_arg->path, found_fsid);
+	if (ret < 0) {
+		errno = -ret;
+		warning(
+	"unable to determine if devid %llu is seed using its super block: %m",
+			devid);
+		return ret;
+	}
+	if (!memcmp(found_fsid, fsid, BTRFS_UUID_SIZE))
+		return 0;
+	return 1;
+}
+
 /*
  *  This function loads the device_info structure and put them in an array
  */
@@ -708,9 +804,7 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
 {
 	int ret, i, ndevs;
 	struct btrfs_ioctl_fs_info_args fi_args;
-	struct btrfs_ioctl_dev_info_args dev_info;
 	struct device_info *info;
-	u8 fsid[BTRFS_UUID_SIZE];
 
 	*devcount_ret = 0;
 	*devinfo_ret = NULL;
@@ -730,6 +824,8 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
 	}
 
 	for (i = 0, ndevs = 0 ; i <= fi_args.max_id ; i++) {
+		struct btrfs_ioctl_dev_info_args dev_info = {0};
+
 		if (ndevs >= fi_args.num_devices) {
 			error("unexpected number of devices: %d >= %llu", ndevs,
 				fi_args.num_devices);
@@ -737,7 +833,6 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
 		"if seed device is used, try running this command as root");
 			goto out;
 		}
-		memset(&dev_info, 0, sizeof(dev_info));
 		ret = get_device_info(fd, i, &dev_info);
 
 		if (ret == -ENODEV)
@@ -747,16 +842,16 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
 			goto out;
 		}
 
-		/*
-		 * Skip seed device by checking device's fsid (requires root).
-		 * And we will skip only if dev_to_fsid is successful and dev
-		 * is a seed device.
-		 * Ignore any other error including -EACCES, which is seen when
-		 * a non-root process calls dev_to_fsid(path)->open(path).
-		 */
-		ret = dev_to_fsid((const char *)dev_info.path, fsid);
-		if (!ret && memcmp(fi_args.fsid, fsid, BTRFS_FSID_SIZE) != 0)
+		ret = is_seed_device(fd, i, fi_args.fsid, &dev_info);
+		/* Skip seed device. */
+		if (ret > 0)
 			continue;
+		if (ret < 0){
+			errno = -ret;
+			warning(
+		"unable to determine if devid %u is seed: %m, assuming not", i);
+			ret = 0;
+		}
 
 		info[ndevs].devid = dev_info.devid;
 		if (!dev_info.path[0]) {
-- 
2.39.1

