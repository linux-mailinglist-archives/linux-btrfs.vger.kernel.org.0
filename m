Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4851270741
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 22:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgIRUok (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 16:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgIRUok (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 16:44:40 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0806AC0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Sep 2020 13:44:40 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id di5so3645442qvb.13
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Sep 2020 13:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OcX0f39hhHLDqFOrRQIzjcAoz5CaoR9Zaa77Mu3z78k=;
        b=fCTIX7Exgv0Ac+lRxkcRx1p9Hj4r+xGRArINyYRQz7jj+/u8ZJAJ4dUvyioa45TSpb
         ddDzvq0LY8z+fOBZU+AdEj3c+szzPYoDTjmCEzfwPEGz3t0PbygbZUAusbsROCQksBmv
         qrgJqwaaoOMQYd7kL+uvNipc9VrP4ShKPjBb/W+QNT9SkBTh377sbp0Orb5qixZWYWAg
         4jO45hQcJk2RacT+T7TLZ4sFuwDss4XHi0SckDy0EQUXQO51mwyenYd3CIxFO3FcF6rz
         qC68n7lZuVnWc3wxKA50pU7VsyXvMuFT2v430Mo6O+9rhPrT5CS1kmVJd0KwH2yGvY0c
         7t0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OcX0f39hhHLDqFOrRQIzjcAoz5CaoR9Zaa77Mu3z78k=;
        b=ExpZoAQEsa99Jry4/prfCzVjDjaWco/m2C9e2up20S8mN0vGsk+zlduzf0YccNamkA
         FoaLymxgyelh7RZBaUQ/dCjJ81BUwqGXwxEYHJngtETArfjzBwvOP1rXyyuQn/b8nU7r
         J43tvRGpuWcCMjLhA9hSFp9OoubHt92YjmhlGBa3ktIR2KeGCsfgr5xTrVujZxtQV20c
         XC0MlR8hgPIyVn4Mt37uAONQ+bskoCVIXd29194bdzBWUp5QN2jRpGU6Ur/e49BO90zG
         +5TCu8xI1Bo5AYynEmaNi+/GntTl4OXIupzNUKBeRaSCt1favP0lp52pD9QAcpv4OuF6
         sCUw==
X-Gm-Message-State: AOAM533288SHZ1tcaJZu149FkTsFFRN6XRkL2i8YqwpiVCgJcYRUSJMD
        yBTrGAAiOpPGuYfNZ3gpEC5B2QbLAS5mrZJt
X-Google-Smtp-Source: ABdhPJwujtM+0CG7dHo1GX15VXXOLl1zavi+AnUTh5bwawnTbAxAkmmWxbFpceGHgir1OioL7qc3hQ==
X-Received: by 2002:a0c:8001:: with SMTP id 1mr35611077qva.21.1600461878905;
        Fri, 18 Sep 2020 13:44:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k22sm2773719qkk.13.2020.09.18.13.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 13:44:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: return error if we're unable to read device stats
Date:   Fri, 18 Sep 2020 16:44:33 -0400
Message-Id: <6f50f5be859468da38bd504c0f78a97dbcd0306d.1600461724.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600461724.git.josef@toxicpanda.com>
References: <cover.1600461724.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I noticed when fixing device stats for seed devices that we simply threw
away the return value from btrfs_search_slot().  This is because we may
not have stat items, but we could very well get an error, and thus miss
reporting the error up the chain.  Fix this by returning ret if it's an
actual error, and then stop trying to init the rest of the devices stats
and return the error up the chain.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c0cea9f5fdbc..7cc677a7e544 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7223,9 +7223,9 @@ static void btrfs_set_dev_stats_value(struct extent_buffer *eb,
 			    sizeof(val));
 }
 
-static void __btrfs_init_dev_stats(struct btrfs_fs_info *fs_info,
-				   struct btrfs_device *device,
-				   struct btrfs_path *path)
+static int __btrfs_init_dev_stats(struct btrfs_fs_info *fs_info,
+				  struct btrfs_device *device,
+				  struct btrfs_path *path)
 {
 	struct btrfs_root *dev_root = fs_info->dev_root;
 	struct btrfs_dev_stats_item *ptr;
@@ -7243,7 +7243,7 @@ static void __btrfs_init_dev_stats(struct btrfs_fs_info *fs_info,
 			btrfs_dev_stat_set(device, i, 0);
 		device->dev_stats_valid = 1;
 		btrfs_release_path(path);
-		return;
+		return ret < 0 ? ret : 0;
 	}
 	slot = path->slots[0];
 	eb = path->nodes[0];
@@ -7263,6 +7263,7 @@ static void __btrfs_init_dev_stats(struct btrfs_fs_info *fs_info,
 	device->dev_stats_valid = 1;
 	btrfs_dev_stat_print_on_load(device);
 	btrfs_release_path(path);
+	return 0;
 }
 
 int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
@@ -7270,22 +7271,30 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
 	struct btrfs_device *device;
 	struct btrfs_path *path = NULL;
+	int ret = 0;
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
 	mutex_lock(&fs_devices->device_list_mutex);
-	list_for_each_entry(device, &fs_devices->devices, dev_list)
-		__btrfs_init_dev_stats(fs_info, device, path);
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		ret = __btrfs_init_dev_stats(fs_info, device, path);
+		if (ret)
+			goto out;
+	}
 	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
-		list_for_each_entry(device, &seed_devs->devices, dev_list)
-			__btrfs_init_dev_stats(fs_info, device, path);
+		list_for_each_entry(device, &seed_devs->devices, dev_list) {
+			ret = __btrfs_init_dev_stats(fs_info, device, path);
+			if (ret)
+				break;
+		}
 	}
+out:
 	mutex_unlock(&fs_devices->device_list_mutex);
 
 	btrfs_free_path(path);
-	return 0;
+	return ret;
 }
 
 static int update_dev_stat_item(struct btrfs_trans_handle *trans,
-- 
2.26.2

