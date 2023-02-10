Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA88F691805
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 06:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjBJFjb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 00:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBJFja (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 00:39:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3FE367FB
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 21:39:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70DF138875
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 05:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676007566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IrR8hMG6aytWHf3ud/S3v8GpWp6apD/mhpxx2E28VHA=;
        b=eqMDMQHB85mb7kEaBaxCum1PFYam98TmdCbk+mVX3u7uQw3dfl1ZzZnFzgGFmfZ57KQB38
        l5O6TKP4rF2hTrv6SxUJpC8EoXa3XhSh/RJRNXai8nmGmNg9WV/eag/tGn8+0DBsM1qa7G
        Bq8ziKVGQH717KxyitjHqDUGgI0NoQ8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8CC313206
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 05:39:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 83JtH43Y5WNkPAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 05:39:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: filesystem-usage: handle missing seed device properly
Date:   Fri, 10 Feb 2023 13:39:08 +0800
Message-Id: <29a0e54c8461e3c25e63d5b7b3e48fa6f4254d3f.1676007519.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
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

Now the test case btrfs/249 passes as expected:

  btrfs/249        2s
  Ran: btrfs/249
  Passed all 1 tests

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This version is different from the original fix from Anand by:

- No need for kernel patching
  Thus no compatible problems

And also different from the fix from Flint:

- No need to search chunk tree unconditionally
  Tree search itself is a privileged operation while "filesystem usage"
  subcommand is not.

  Now we only needs root privilege if we hit a missing seed device,
  which is super rare.

  And we can still fallback to assume the device is not seed.

- Better commit message
---
 cmds/filesystem-usage.c | 72 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 5810324f245e..214cad2fa75b 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -700,6 +700,56 @@ out:
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
+static int is_seed_device_tree_search(int fd, u64 devid, u8 *fsid)
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
 /*
  *  This function loads the device_info structure and put them in an array
  */
@@ -708,7 +758,6 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
 {
 	int ret, i, ndevs;
 	struct btrfs_ioctl_fs_info_args fi_args;
-	struct btrfs_ioctl_dev_info_args dev_info;
 	struct device_info *info;
 	u8 fsid[BTRFS_UUID_SIZE];
 
@@ -730,6 +779,8 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
 	}
 
 	for (i = 0, ndevs = 0 ; i <= fi_args.max_id ; i++) {
+		struct btrfs_ioctl_dev_info_args dev_info = {0};
+
 		if (ndevs >= fi_args.num_devices) {
 			error("unexpected number of devices: %d >= %llu", ndevs,
 				fi_args.num_devices);
@@ -737,7 +788,6 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
 		"if seed device is used, try running this command as root");
 			goto out;
 		}
-		memset(&dev_info, 0, sizeof(dev_info));
 		ret = get_device_info(fd, i, &dev_info);
 
 		if (ret == -ENODEV)
@@ -747,6 +797,24 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
 			goto out;
 		}
 
+		/*
+		 * A missing device, we can not determing if it's a seed
+		 * device by reading its super block.
+		 * Thus we have to go tree-search to make sure if it's a seed
+		 * device.
+		 */
+		if (!dev_info.path[0]) {
+			ret = is_seed_device_tree_search(fd, i, fi_args.fsid);
+			if (ret < 0) {
+				errno = -ret;
+				warning(
+		"unable to determine if devid %u is seed: %m, assuming not", i);
+			}
+			/* Skip the missing seed device. */
+			if (ret > 0)
+				continue;
+		}
+
 		/*
 		 * Skip seed device by checking device's fsid (requires root).
 		 * And we will skip only if dev_to_fsid is successful and dev
-- 
2.39.1

