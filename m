Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0485274B04
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 23:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIVVSg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 17:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVVSg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 17:18:36 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E1C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 14:18:36 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id n10so16888775qtv.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 14:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mMtH2xrIGNzomYeSgx68sjRk5XwcFs4nzbBnTWD7fMs=;
        b=iGsM4p995VkcJqSUO4wXJ2yvaQd9i7MK4BOKZfRrevOndIFIw8g+gRRjlt7gh4HWO6
         NfDHGGDYibaY6MTQwFRxrIbXPnf85eaUjIM8AHxS6USOWj9MbmomVRTVTe9hfVmmpPDM
         v57AkyTatFpkOt247gOPAXjpt7PczWbPFt1yKB5rmTiF3yGpJF4K73CWu5EE77C/2LHO
         hdGVAz91N0Psa0CRIw294gc42DUg3DKc7NO5kgVabLUSJT7QB1wSteowheJUwz/GXJ/J
         VpsLnTjk0H/i+D/dr9VgbnKs6D3WbB4IiY+/USjM4JWKRaqBzmNsq/Thfvt1x5staVoC
         1AFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMtH2xrIGNzomYeSgx68sjRk5XwcFs4nzbBnTWD7fMs=;
        b=Xwcc+30T7nwoSY3keqRMQbougnterPHOgde3D1VDraxUeJlX1U5lGsG0XK09n5tExH
         B2qJVeq04fxndqAS3lv8O1JP16rOAxlLQ6TNdbSwL5J661pgzFruSRLKQnasFzWJI48t
         dui2VatrBqNd2dVSKYm3s4YO5hErzfi8ayzPC0SM4H388Pmmu7/bejxfQWF26sqzjSE9
         CTjzcj723EqGuu8AtZBmLPTK7ZkQ5+u/ovW0hFBiXQkXITPyzOlZVUM0NOc1MbDBsgl8
         w4YuOqjflZgpf149Nw/WY6LzBLbEFMPmn/M0dXDPHv9kIj9D3bPlG0wW19YrVGhA3zat
         wbNw==
X-Gm-Message-State: AOAM5302hyr15ixwC2IYSge6aKsMTslIhYv4zFCAIcvQzJU1Qrt+ckCr
        wD63u1XKS36JYhFSE4ETRSjXE8X2lLZYy+zy
X-Google-Smtp-Source: ABdhPJzJjPSFLBK5zFRbDrcP+3Vr0vms7PumYwHeLNFrtIYlDWNx0sDeyF6MXmSuwVxGZ2AEGc3KbQ==
X-Received: by 2002:ac8:67ce:: with SMTP id r14mr6737413qtp.239.1600809514886;
        Tue, 22 Sep 2020 14:18:34 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e7sm14017522qtk.17.2020.09.22.14.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 14:18:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 1/2] btrfs: init device stats for seed devices
Date:   Tue, 22 Sep 2020 17:18:29 -0400
Message-Id: <09ddcc488654bc02dccb831569a7f189098641a2.1600809318.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600809318.git.josef@toxicpanda.com>
References: <cover.1600809318.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We recently started recording device stats across the fleet, and noticed
a large increase in messages such as this

BTRFS warning (device dm-0): get dev_stats failed, not yet valid

on our tiers that use seed devices for their root devices.  This is
because we do not initialize the device stats for any seed devices if we
have a sprout device and mount using that sprout device.  The basic
steps for reproducing are

mkfs seed device
mount seed device
fill seed device
umount seed device
btrfstune -S 1 seed device
mount seed device
btrfs device add -f sprout device /mnt/wherever
umount /mnt/wherever
mount sprout device /mnt/wherever
btrfs device stats /mnt/wherever

This will fail with the above message in dmesg.

Fix this by iterating over the fs_devices->seed if they exist in
btrfs_init_dev_stats.  This fixed the problem and properly reports the
stats for both devices.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 89 +++++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6c7c8819cb31..ed6de5817efb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7223,61 +7223,68 @@ static void btrfs_set_dev_stats_value(struct extent_buffer *eb,
 			    sizeof(val));
 }
 
-int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
+static void init_dev_stats(struct btrfs_device *device,
+			   struct btrfs_path *path)
 {
-	struct btrfs_key key;
-	struct btrfs_root *dev_root = fs_info->dev_root;
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_root *dev_root = device->fs_info->dev_root;
+	struct btrfs_dev_stats_item *ptr;
 	struct extent_buffer *eb;
-	int slot;
-	int ret = 0;
+	struct btrfs_key key;
+	int item_size;
+	int i, ret, slot;
+
+	key.objectid = BTRFS_DEV_STATS_OBJECTID;
+	key.type = BTRFS_PERSISTENT_ITEM_KEY;
+	key.offset = device->devid;
+	ret = btrfs_search_slot(NULL, dev_root, &key, path, 0, 0);
+	if (ret) {
+		for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++)
+			btrfs_dev_stat_set(device, i, 0);
+		device->dev_stats_valid = 1;
+		btrfs_release_path(path);
+		return;
+	}
+	slot = path->slots[0];
+	eb = path->nodes[0];
+	item_size = btrfs_item_size_nr(eb, slot);
+
+	ptr = btrfs_item_ptr(eb, slot,
+			     struct btrfs_dev_stats_item);
+
+	for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++) {
+		if (item_size >= (1 + i) * sizeof(__le64))
+			btrfs_dev_stat_set(device, i,
+					   btrfs_dev_stats_value(eb, ptr, i));
+		else
+			btrfs_dev_stat_set(device, i, 0);
+	}
+
+	device->dev_stats_valid = 1;
+	btrfs_dev_stat_print_on_load(device);
+	btrfs_release_path(path);
+}
+
+int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
 	struct btrfs_device *device;
 	struct btrfs_path *path = NULL;
-	int i;
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
 	mutex_lock(&fs_devices->device_list_mutex);
-	list_for_each_entry(device, &fs_devices->devices, dev_list) {
-		int item_size;
-		struct btrfs_dev_stats_item *ptr;
-
-		key.objectid = BTRFS_DEV_STATS_OBJECTID;
-		key.type = BTRFS_PERSISTENT_ITEM_KEY;
-		key.offset = device->devid;
-		ret = btrfs_search_slot(NULL, dev_root, &key, path, 0, 0);
-		if (ret) {
-			for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++)
-				btrfs_dev_stat_set(device, i, 0);
-			device->dev_stats_valid = 1;
-			btrfs_release_path(path);
-			continue;
-		}
-		slot = path->slots[0];
-		eb = path->nodes[0];
-		item_size = btrfs_item_size_nr(eb, slot);
-
-		ptr = btrfs_item_ptr(eb, slot,
-				     struct btrfs_dev_stats_item);
-
-		for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++) {
-			if (item_size >= (1 + i) * sizeof(__le64))
-				btrfs_dev_stat_set(device, i,
-					btrfs_dev_stats_value(eb, ptr, i));
-			else
-				btrfs_dev_stat_set(device, i, 0);
-		}
-
-		device->dev_stats_valid = 1;
-		btrfs_dev_stat_print_on_load(device);
-		btrfs_release_path(path);
+	list_for_each_entry(device, &fs_devices->devices, dev_list)
+		init_dev_stats(device, path);
+	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
+		list_for_each_entry(device, &seed_devs->devices, dev_list)
+			init_dev_stats(device, path);
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 
 	btrfs_free_path(path);
-	return ret < 0 ? ret : 0;
+	return 0;
 }
 
 static int update_dev_stat_item(struct btrfs_trans_handle *trans,
-- 
2.26.2

