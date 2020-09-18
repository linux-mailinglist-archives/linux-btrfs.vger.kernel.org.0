Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF10270740
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 22:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIRUoi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 16:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgIRUoi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 16:44:38 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1CCC0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Sep 2020 13:44:38 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id d20so7745519qka.5
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Sep 2020 13:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6ZsfnZ8+SWwfr1H4h84Ujf6dD1DEdP+AK3CoE8yrey0=;
        b=jeNdwx6mpUBJgtYgwQBMMH3UZLKcDSLZJT/aQAP22mSxyY+PvdQi+7/6yQTo2PyGq9
         nfX+dnckZoFPmVCTWwnfVZT1eq8nY7278Z/tYiRbeiCUQ8Yj+djVyn7Fa8XiKLmqPoPi
         RHjXBl1fYeeN/ccUoOuEFpyNvXDZOTxgv5hPKsqfcaxpvHcFmGnHO4pQgpu7SK09TCof
         /Q2Py/M0jKZl1f16dl3OzyEabUUSldfND5GKdhvWgFKzq8TVFvf9kYHfCIEXA3yvsgUc
         b9mKT9scd9xOvD9s1ADf7wUnD2T/KhsD/hlR/Xqwwq7K7PhXE+reVm13NnQz7MOhypgz
         xHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ZsfnZ8+SWwfr1H4h84Ujf6dD1DEdP+AK3CoE8yrey0=;
        b=lPXnv3pEHTqIP1u95JEOBUd5YwXV3UrlDEaNaBgSbh+KA39Wvu+nbFphXwS5XzIK0n
         wUsp8vwdCQbWW6QVq2MDT9fH9usJI44ML05oFgd5/1Wh2VySkDno6gEncGrZEJ2jq2ss
         jg2H7p0SyqnXtNHWEWEAwbGaPIlJJFrlW8Xq4h7ZQQMlnWe/J6xzNOIYujJOOfsUwt4i
         q+Bs4VsD25ZKwRPhA5rFgPpA9jqe1w8R0I/L8zGwGaphCHwIFkM/G0mdDn0K2HlPqSRa
         P50SaJ1SScZsTNQPhzpO7fiOJHTULFyGCi1fMKh8ULKqjSsbBrrMT3ps3lWk7402cVlq
         7IdA==
X-Gm-Message-State: AOAM533JvXn8FZLJcRjrLpv4hWE7lOBS7roEAXcSvCTVUWou1zC9DS2j
        WZruZcaMnrlRNjqarsTxU7ndClJxL1sZY9Uq
X-Google-Smtp-Source: ABdhPJz9lUqO1uo0CjuVyJ3hqvw+CBAE8QkX6EeIe6TZWzra2NQFpiAGfxQXE1gmZWuhINBWPlR6Tw==
X-Received: by 2002:a37:2715:: with SMTP id n21mr35508154qkn.401.1600461877138;
        Fri, 18 Sep 2020 13:44:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w59sm2957891qtd.1.2020.09.18.13.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 13:44:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: init device stats for seed devices
Date:   Fri, 18 Sep 2020 16:44:32 -0400
Message-Id: <b0c2be2e6722f091821521301f251628afcd8313.1600461724.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600461724.git.josef@toxicpanda.com>
References: <cover.1600461724.git.josef@toxicpanda.com>
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
 fs/btrfs/volumes.c | 88 +++++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6c7c8819cb31..c0cea9f5fdbc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7223,61 +7223,69 @@ static void btrfs_set_dev_stats_value(struct extent_buffer *eb,
 			    sizeof(val));
 }
 
-int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
+static void __btrfs_init_dev_stats(struct btrfs_fs_info *fs_info,
+				   struct btrfs_device *device,
+				   struct btrfs_path *path)
 {
-	struct btrfs_key key;
 	struct btrfs_root *dev_root = fs_info->dev_root;
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
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
+		__btrfs_init_dev_stats(fs_info, device, path);
+	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
+		list_for_each_entry(device, &seed_devs->devices, dev_list)
+			__btrfs_init_dev_stats(fs_info, device, path);
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 
 	btrfs_free_path(path);
-	return ret < 0 ? ret : 0;
+	return 0;
 }
 
 static int update_dev_stat_item(struct btrfs_trans_handle *trans,
-- 
2.26.2

