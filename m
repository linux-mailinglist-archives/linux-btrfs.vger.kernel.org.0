Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BE6274B05
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 23:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgIVVSi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 17:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVVSi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 17:18:38 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D36C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 14:18:37 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f142so20664483qke.13
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q4RyGL1VJG4SU29OYchV/RwfjC4Y/g03qGNnsSHlyOU=;
        b=0f3lk8F9DJSTspeEEpRWdmA9ohrePSliZLa9/SNYFZsmeXsEIagPWMeVKY7K5yJQvT
         ldQR9EpgVPO+nkzcaeGH1yVMZWMab+z7QroNWPzluawH9Z9dB+RTJ/nws334bIM8W/+A
         LXnMhwE4oo2KgWiSaZNb9izdDu3gMywLnLSPkF7ib6kzAYFKSnDSr9CQfDyKdtSSYffj
         NmVViCpEJoXuLmGqXgba22E56cifwYSbVZNXeVictH+d0dRlfEkOlVGivdjeKmZ7CIyv
         3FSzZkJwBpt6TN+IAPfpzLbqbOzWmp7Dhh0wWeDGfblNquNT1fJMvDfBdtbFO0AtZKk3
         Lg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q4RyGL1VJG4SU29OYchV/RwfjC4Y/g03qGNnsSHlyOU=;
        b=CdS+Emj0LQVeYJM91v79ycd1tbxLvERYR3iHCPaFTL4CyH7i+wjYSV4U2Sx8yYStbE
         GmXr8cOmzSw1I/X5z2aPkJGZwZ7Dv3mX+IPLLl5duydt2Cy8LxXH93X2x9Y9yq1UM5uy
         3yhRwEKhURyJm5+hCnu+Q8qQrHBwhsiVs+cvrFNXa6jcnqaJRnv8x7oVXhXWRD3wnGmS
         /m78eeLRdEk8TAPYBy5L3VA1DYRNOf/9Wd0EHzFWEZWPWBFj3ZysBlLg2TRO/cqRZ/nZ
         6srEuxF0m96STjVrIhlaS0VO+N22NCLoAwMbSgwpHBAoQzws5y1+hg6yLknxpkQBbw2U
         XREQ==
X-Gm-Message-State: AOAM530lv6rjxybocJzB21F2rVrp1BXwwc2c8BUVzR+TwYBEOtxDf3ym
        NLT50LEtORZ+PwDX1tt+sFemYf41mpYGvQJD
X-Google-Smtp-Source: ABdhPJxTidYjypVB7/I8hl/8SQqkUi9w5ghhNdeN8Vd5tT/0c8n57q7r06W2e3f0QaRhQTmlRj5FcQ==
X-Received: by 2002:a37:4d8c:: with SMTP id a134mr7072247qkb.500.1600809516753;
        Tue, 22 Sep 2020 14:18:36 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q72sm11910551qka.22.2020.09.22.14.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 14:18:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 2/2] btrfs: return error if we're unable to read device stats
Date:   Tue, 22 Sep 2020 17:18:30 -0400
Message-Id: <39d1268e66082fe065c49c8fe634628373521301.1600809318.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600809318.git.josef@toxicpanda.com>
References: <cover.1600809318.git.josef@toxicpanda.com>
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
 fs/btrfs/volumes.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ed6de5817efb..5c7b0c0e9408 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7223,8 +7223,7 @@ static void btrfs_set_dev_stats_value(struct extent_buffer *eb,
 			    sizeof(val));
 }
 
-static void init_dev_stats(struct btrfs_device *device,
-			   struct btrfs_path *path)
+static int init_dev_stats(struct btrfs_device *device, struct btrfs_path *path)
 {
 	struct btrfs_root *dev_root = device->fs_info->dev_root;
 	struct btrfs_dev_stats_item *ptr;
@@ -7242,7 +7241,7 @@ static void init_dev_stats(struct btrfs_device *device,
 			btrfs_dev_stat_set(device, i, 0);
 		device->dev_stats_valid = 1;
 		btrfs_release_path(path);
-		return;
+		return ret < 0 ? ret : 0;
 	}
 	slot = path->slots[0];
 	eb = path->nodes[0];
@@ -7262,6 +7261,7 @@ static void init_dev_stats(struct btrfs_device *device,
 	device->dev_stats_valid = 1;
 	btrfs_dev_stat_print_on_load(device);
 	btrfs_release_path(path);
+	return 0;
 }
 
 int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
@@ -7269,22 +7269,30 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
 	struct btrfs_device *device;
 	struct btrfs_path *path = NULL;
+	int ret = 0;
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
 	mutex_lock(&fs_devices->device_list_mutex);
-	list_for_each_entry(device, &fs_devices->devices, dev_list)
-		init_dev_stats(device, path);
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		ret = init_dev_stats(device, path);
+		if (ret)
+			goto out;
+	}
 	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
-		list_for_each_entry(device, &seed_devs->devices, dev_list)
-			init_dev_stats(device, path);
+		list_for_each_entry(device, &seed_devs->devices, dev_list) {
+			ret = init_dev_stats(device, path);
+			if (ret)
+				goto out;
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

