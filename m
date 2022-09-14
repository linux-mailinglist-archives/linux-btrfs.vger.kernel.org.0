Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509BC5B90D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiINXIA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiINXH6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:07:58 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496D087094
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:07:54 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id ay9so1659716qtb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=bGTljzgjlG0L3SNv7Kpbd2lJWKRBuiAPmPQ/y9uSgQo=;
        b=VoEvL8ybPdAAR/tE+0EtBckLar8whHX3Ni4GVsT03LOpasp4p8tmdoYyvPpJkuU+w7
         UZuNFXMAk29y4T9g7gq9nYHlLQnk7pjpyWhnPOjPyP5ziJ18uBW4URBYR2+CTGZhBmmh
         GA7fSmMHUlqqaVBzKrlEv5pfXa762+jNO0blrqlcBuVNe2ecEigogUAp0mEeAfDewP1F
         slZRjRjRMlrw5pEMT5R2ThM6VHoPFIcCvOixCTSH8aMgtXAjHtLa337qa3Q6tmgXXRYB
         5q9ucTTRS+8IFeeAKP7Nfkr2Vqmq5MqQoAaHPus2ZN5KdGDn/cWibV+taGxPPy9CQ6HP
         GQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bGTljzgjlG0L3SNv7Kpbd2lJWKRBuiAPmPQ/y9uSgQo=;
        b=tV0BTEHDTkN/ASMJ+zzs6Y/NyVliDrbgQMnkSyOraTh09tn1AUK481QgTqa0MgJhk4
         +ArXo/8D955VbjCOjiosR9vvAQ2zO7AmnP46Df3ufAX9hHr0aKm4PR13YvS2BDa5JwSr
         Au47Ae7KY2XrZ4vU2EOTHnKosatFl/oVcCvGgzZ4xqlbSn30xQD+vYG92tfmxeM9pqkd
         kzwTfRcMggE1pumnwAv8pL4W6qeCIbWFCuXABuhTnbEytrmwmDJtjXkPu2p27sn9eNwP
         qG/WibmqkO3HDYyvb1mz3PXzrPrXRDKo5v9E/ietaPIk7QFtF/5iovPsxYJez0qV+KD+
         YcMA==
X-Gm-Message-State: ACgBeo0ZR0tuCJuFYkaOU6LjKy9VXvbdakMWZw/4zCh9cohyhsX7KmaU
        42V9U7cwy8LKd3xnr7YWGOhLELF2ogyXtQ==
X-Google-Smtp-Source: AA6agR4sF/TGj0zieQ2sDpZl5Ll4oV43iQW2xMnqWKlxAnjZxVJQyfZGWUteWBw++4UFXBxiSwQtnw==
X-Received: by 2002:ac8:7f16:0:b0:35b:b8c3:ef93 with SMTP id f22-20020ac87f16000000b0035bb8c3ef93mr12861891qtk.209.1663196873029;
        Wed, 14 Sep 2022 16:07:53 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a424800b006ce5fe31c2dsm2988620qko.65.2022.09.14.16.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:07:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/10] btrfs: add a helper for opening a new device to add to the fs
Date:   Wed, 14 Sep 2022 19:07:41 -0400
Message-Id: <280fe61f3405e88a0a4a5ac0cacff3993f9f31ff.1663196746.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196746.git.josef@toxicpanda.com>
References: <cover.1663196746.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We currently duplicate our device init code for adding a new device to a
file system and replacing an existing device in a file system.  These
two init functions are subtle-y different, however they both open the
disk and check it's zoned status to see if it's compatible.  Combine
this step into a single helper and use that helper from both init
functions.  The goal of this change is to move the zoned helper out of
zoned.h in order to avoid using helpers that aren't defined in zoned.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/dev-replace.c | 10 +---------
 fs/btrfs/volumes.c     | 28 +++++++++++++++++++++-------
 fs/btrfs/volumes.h     |  2 ++
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index c6222057f655..8f5922ba0129 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -258,20 +258,12 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 		return -EINVAL;
 	}
 
-	bdev = blkdev_get_by_path(device_path, FMODE_WRITE | FMODE_EXCL,
-				  fs_info->bdev_holder);
+	bdev = btrfs_open_device_for_adding(fs_info, device_path);
 	if (IS_ERR(bdev)) {
 		btrfs_err(fs_info, "target device %s is invalid!", device_path);
 		return PTR_ERR(bdev);
 	}
 
-	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
-		btrfs_err(fs_info,
-		"dev-replace: zoned type of target device mismatch with filesystem");
-		ret = -EINVAL;
-		goto error;
-	}
-
 	sync_blockdev(bdev);
 
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 09c1434c3cae..ea76458d7c70 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2583,6 +2583,26 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
+struct block_device *btrfs_open_device_for_adding(struct btrfs_fs_info *fs_info,
+						  const char *device_path)
+{
+	struct block_device *bdev;
+
+	bdev = blkdev_get_by_path(device_path, FMODE_WRITE | FMODE_EXCL,
+				  fs_info->bdev_holder);
+	if (IS_ERR(bdev))
+		return bdev;
+
+	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
+		btrfs_err(fs_info,
+			  "dev-replace: zoned type of target device mismatch with filesystem");
+		blkdev_put(bdev, FMODE_EXCL);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return bdev;
+}
+
 int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path)
 {
 	struct btrfs_root *root = fs_info->dev_root;
@@ -2602,16 +2622,10 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	if (sb_rdonly(sb) && !fs_devices->seeding)
 		return -EROFS;
 
-	bdev = blkdev_get_by_path(device_path, FMODE_WRITE | FMODE_EXCL,
-				  fs_info->bdev_holder);
+	bdev = btrfs_open_device_for_adding(fs_info, device_path);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
-		ret = -EINVAL;
-		goto error;
-	}
-
 	if (fs_devices->seeding) {
 		seeding_dev = true;
 		down_write(&sb->s_umount);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 2bf7dbe739fd..60d74554edf2 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -757,4 +757,6 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 unsigned long btrfs_chunk_item_size(int num_stripes);
 bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
+struct block_device *btrfs_open_device_for_adding(struct btrfs_fs_info *fs_info,
+						  const char *device_path);
 #endif
-- 
2.26.3

