Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE267A575D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Sep 2023 04:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjISCV5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 22:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjISCVx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 22:21:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87520118
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 19:21:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 22FE120382
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Sep 2023 02:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695090105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ScIrHnvnmH0mqR7/D+/viV6gKjXGEgFid7pdkYs7/ko=;
        b=CXO8quk1jXEKIyszctGYY+YCSm3VpuOCKQwfgT/lPHnO4Fi5nnSekRM3GBY3ovnXnRE9M0
        mePeSXJLxgwbDPsYZ1tEb8qQkPZbfofJAO/AmaHGL4iYs43Pz9urY1mGZiRtj5NRJI/GwG
        5tuFRicsO13wpjQtH2IUh7ofZpHSkGM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C13A1333E
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Sep 2023 02:21:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4JyyArgFCWXBbQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Sep 2023 02:21:44 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: reduce the width of device counters
Date:   Tue, 19 Sep 2023 11:51:23 +0930
Message-ID: <1cf7d5f66d1fb9caabc8ccadb4a4c3be02df0c8b.1695089790.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695089790.git.wqu@suse.com>
References: <cover.1695089790.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we will reject the super block if its num_devices is beyond
U16_MAX, there is no need to go u64 to count the devices.

We can shrink the width of the following members:

- num_devices
- open_devices
- rw_devices
- missing_devices
- total_devices

And for the ioctls which will add a new device, always make sure the
existing num_devices (the real total number of devices, including
missing and replace-source) would never go beyond U16_MAX.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/dev-replace.c |  9 +++++++++
 fs/btrfs/volumes.c     | 11 ++++++++++-
 fs/btrfs/volumes.h     | 12 ++++++------
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index d3998cad62c2..1a7a8caf1e51 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -250,6 +250,15 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	u64 devid = BTRFS_DEV_REPLACE_DEVID;
 	int ret = 0;
 
+	mutex_lock(&fs_devices->device_list_mutex);
+	if (unlikely(fs_devices->num_devices >= U16_MAX)) {
+		mutex_unlock(&fs_devices->device_list_mutex);
+		btrfs_err(fs_info,
+			  "too many devices, has %u devices, up limit is %u",
+			  fs_devices->num_devices, U16_MAX);
+		return -EINVAL;
+	}
+	mutex_unlock(&fs_devices->device_list_mutex);
 	*device_out = NULL;
 	if (srcdev->fs_devices->seeding) {
 		btrfs_err(fs_info, "the filesystem is a seed filesystem!");
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2f05d38980ce..96bfa86d7371 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2652,6 +2652,15 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	if (sb_rdonly(sb) && !fs_devices->seeding)
 		return -EROFS;
 
+	mutex_lock(&fs_info->chunk_mutex);
+	if (unlikely(fs_devices->num_devices >= U16_MAX)) {
+		btrfs_err(fs_info, "too many devices, has %u devices, up limit is %u",
+			  fs_devices->num_devices, U16_MAX);
+		mutex_unlock(&fs_info->chunk_mutex);
+		return -EINVAL;
+	}
+	mutex_unlock(&fs_info->chunk_mutex);
+
 	bdev = blkdev_get_by_path(device_path, BLK_OPEN_WRITE,
 				  fs_info->bdev_holder, NULL);
 	if (IS_ERR(bdev))
@@ -5263,7 +5272,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 		}
 
 		if (ndevs == fs_devices->rw_devices) {
-			WARN(1, "%s: found more than %llu devices\n",
+			WARN(1, "%s: found more than %u devices\n",
 			     __func__, fs_devices->rw_devices);
 			break;
 		}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b513b2846793..045e9eadd025 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -308,28 +308,28 @@ struct btrfs_fs_devices {
 	 * Number of devices under this fsid including missing and
 	 * replace-target device and excludes seed devices.
 	 */
-	u64 num_devices;
+	u16 num_devices;
 
 	/*
 	 * The number of devices that successfully opened, including
 	 * replace-target, excludes seed devices.
 	 */
-	u64 open_devices;
+	u16 open_devices;
 
 	/* The number of devices that are under the chunk allocation list. */
-	u64 rw_devices;
+	u16 rw_devices;
 
 	/* Count of missing devices under this fsid excluding seed device. */
-	u64 missing_devices;
-	u64 total_rw_bytes;
+	u16 missing_devices;
 
 	/*
 	 * Count of devices from btrfs_super_block::num_devices for this fsid,
 	 * which includes the seed device, excludes the transient replace-target
 	 * device.
 	 */
-	u64 total_devices;
+	u16 total_devices;
 
+	u64 total_rw_bytes;
 	/* Highest generation number of seen devices */
 	u64 latest_generation;
 
-- 
2.42.0

