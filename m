Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5C95A5C1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 08:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiH3GuQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 02:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiH3GuK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 02:50:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FDB3C176
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Aug 2022 23:50:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E81F31F8C2
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 06:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661842206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=96hxalTpm65X0ZozyoS31n3a82KmVXsNyL8u6QqRUuk=;
        b=T3Wps5ncJOAkOiDb1zBith/pnCQy9RYeA4T//HJA0B610KIx9BOQQ19WqETkXXeLyU3RkN
        C99vA2HYuO5JtSrOcY/USUL7Bo9KuRBfG96WEXfsaVEFwIhiXYSiaLj+cBuoCbZYI08cJ6
        MbdNMnj5J2/hYXkJTWPohn5ESP72aTA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1AC613ACF
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 06:50:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mF6NJh2zDWO7JgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 06:50:05 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: rescue: allow fix-device-size to shrink device item
Date:   Tue, 30 Aug 2022 14:49:44 +0800
Message-Id: <1ea0a53a17b487fb7d7b73b0fc4e30500d0be1ae.1661841983.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661841983.git.wqu@suse.com>
References: <cover.1661841983.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we found that the underlying block device size is smaller than
total_bytes in dev item, kernel will reject the mount, and there is no
progs tool to fix it.

Under most case it's just a small mismatch, and there is no dev extent
in the shrunk range.

In that case, we can let "btrfs rescue fix-device-size" to reset the
total_bytes in dev items to fix.

We add some extra checks, like to make sure there is no dev extent in
the shrunk device range, to make sure we won't lose data during the
device item shrink.

And also update the test case to verify the repaired fs can pass the
check.

Issue: #504
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/volumes.c | 135 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 126 insertions(+), 9 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 40032a4b4059..af764b7ae915 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2786,12 +2786,63 @@ u64 btrfs_stripe_length(struct btrfs_fs_info *fs_info,
 }
 
 /*
- * Return 0 if size of @device is already good
- * Return >0 if size of @device is not aligned but fixed without problems
- * Return <0 if something wrong happened when aligning the size of @device
+ * Return <0 for error.
+ * Return >0 if we can not find any dev extent beyond @physical
+ * REturn 0 if we can find any dev extent beyond @physical or covers @physical.
  */
-int btrfs_fix_device_size(struct btrfs_fs_info *fs_info,
-			  struct btrfs_device *device)
+static int check_dev_extent_beyond_bytenr(struct btrfs_fs_info *fs_info,
+					  struct btrfs_device *device,
+					  u64 physical)
+{
+	struct btrfs_root *root = fs_info->dev_root;
+	struct btrfs_path path = { 0 };
+	struct btrfs_dev_extent *dext;
+	struct btrfs_key key;
+	u64 dext_len;
+	u64 last_dev_extent_end = 0;
+	int ret;
+
+	key.objectid = device->devid;
+	key.type = BTRFS_DEV_EXTENT_KEY;
+	key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret < 0)
+		return ret;
+	if (ret == 0) {
+		ret = -EUCLEAN;
+		error("invalid dev extent found for devid %llu", device->devid);
+		goto out;
+	}
+
+	ret = btrfs_previous_item(root, &path, device->devid,
+				  BTRFS_DEV_EXTENT_KEY);
+	/*
+	 * Either <0 we error out, or ret > 0 we can not find any
+	 * dev extent for this device, then last_dev_extent_end will be 0
+	 * and we will return 1.
+	 */
+	if (ret)
+		goto out;
+
+	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+	dext = btrfs_item_ptr(path.nodes[0], path.slots[0],
+			      struct btrfs_dev_extent);
+	dext_len = btrfs_dev_extent_length(path.nodes[0], dext);
+	last_dev_extent_end = dext_len + key.offset;
+
+out:
+	btrfs_release_path(&path);
+	if (ret < 0)
+		return ret;
+	if (last_dev_extent_end <= physical)
+		return 1;
+	return 0;
+}
+
+static int reset_device_item_total_bytes(struct btrfs_fs_info *fs_info,
+					 struct btrfs_device *device,
+					 u64 new_size)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_key key;
@@ -2801,12 +2852,10 @@ int btrfs_fix_device_size(struct btrfs_fs_info *fs_info,
 	u64 old_bytes = device->total_bytes;
 	int ret;
 
-	if (IS_ALIGNED(old_bytes, fs_info->sectorsize))
-		return 0;
+	ASSERT(IS_ALIGNED(new_size, fs_info->sectorsize));
 
 	/* Align the in-memory total_bytes first, and use it as correct size */
-	device->total_bytes = round_down(device->total_bytes,
-					 fs_info->sectorsize);
+	device->total_bytes = new_size;
 
 	key.objectid = BTRFS_DEV_ITEMS_OBJECTID;
 	key.type = BTRFS_DEV_ITEM_KEY;
@@ -2854,6 +2903,74 @@ err:
 	return ret;
 }
 
+static int btrfs_fix_block_device_size(struct btrfs_fs_info *fs_info,
+				       struct btrfs_device *device)
+{
+	struct stat st;
+	u64 block_dev_size;
+	int ret;
+
+	if (device->fd < 0 || !device->writeable) {
+		error("devid %llu is missing or not writable", device->devid);
+		return -EINVAL;
+	}
+
+	ret = fstat(device->fd, &st);
+	if (ret < 0) {
+		error("failed to get block device size for devid %llu: %m",
+		      device->devid);
+		return -errno;
+	}
+
+	block_dev_size = round_down(btrfs_device_size(device->fd, &st),
+				    fs_info->sectorsize);
+
+	/*
+	 * Total_bytes in device item is no larger than the device block size,
+	 * already the correct case.
+	 */
+	if (device->total_bytes <= block_dev_size)
+		return 0;
+
+	/*
+	 * Now we need to check if there is any device extent beyond
+	 * @block_dev_size.
+	 */
+	ret = check_dev_extent_beyond_bytenr(fs_info, device, block_dev_size);
+	if (ret < 0)
+		return ret;
+
+	if (ret == 0) {
+		error("there are dev extents covering or beyond bytenr %llu, can not shrink the device without losing data",
+			device->devid);
+		return -EINVAL;
+	}
+
+	/* Now we can shrink the device item total_bytes to @block_dev_size. */
+	return reset_device_item_total_bytes(fs_info, device, block_dev_size);
+}
+
+/*
+ * Return 0 if size of @device is already good
+ * Return >0 if size of @device is not aligned but fixed without problems
+ * Return <0 if something wrong happened when aligning the size of @device
+ */
+int btrfs_fix_device_size(struct btrfs_fs_info *fs_info,
+			  struct btrfs_device *device)
+{
+	u64 old_bytes = device->total_bytes;
+
+	/*
+	 * Our value is already good, then check if it's device item mismatch against
+	 * block device size.
+	 */
+	if (IS_ALIGNED(old_bytes, fs_info->sectorsize))
+		return btrfs_fix_block_device_size(fs_info, device);
+
+	return reset_device_item_total_bytes(fs_info, device,
+			round_down(old_bytes, fs_info->sectorsize));
+}
+
 /*
  * Return 0 if super block total_bytes matches all devices' total_bytes
  * Return >0 if super block total_bytes mismatch but fixed without problem
-- 
2.37.2

