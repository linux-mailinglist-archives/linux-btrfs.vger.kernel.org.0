Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A8F23ACE8
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 21:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgHCTXM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 15:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHCTXM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Aug 2020 15:23:12 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B84C06174A
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Aug 2020 12:23:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l23so36274980qkk.0
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Aug 2020 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ka+aiBkNQXdjyRjy1HaX0z0b35ALU+JIhfbX3ifklmc=;
        b=xUZqV8PgSin17QA/6gdQVVYeERHGAtNJe1Dwxyiv1KSzc465+VNcFuzQuWSWbMC9OF
         MfN1wcBbPEIVsHXTwnJP0/+SqmiYBXo0+oXvFzc+NVU1O/AHN62uSNQzC93DFh9HpkwK
         uOzBmUFZmJp8fMvLwvqsUS2pxi3huPIjwOZUz/mc51TgrCyweNCQJMGg40halsKc8+3p
         qntxkWDRUdzVqTrKS8uZiti4eYaT9sFf2cUkhcXl+ywiLs83Ptf+dan9mkjTPXVYywyp
         wgT5Qs2CA2U/c655qHUywD8FMKtFHzkj+MKLDyke0sJ3LYoYbDQxfeaC28qyOIEmFF2q
         uIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ka+aiBkNQXdjyRjy1HaX0z0b35ALU+JIhfbX3ifklmc=;
        b=lwVzxwjnqK/+pM/7rW8c12EN5RKNwFMkLvfhFm+VZs3nYG0azgWwCOtiMbDy2gUIua
         LuXd3OBMGPWk2oFNRQKplKQUW67SPm5Oqnu0xhiSxQeAUWbfgaWax+iXLL238EXm/C2e
         rB9q9mJ0L1By8NA4CKBTdME0E8yysiqkpi5ZAeRdK3zB43cwfUvFD1Oj6IkIZEs7tJ4X
         rj45s7bnCGyaCAVQQt3zJz3INwOJs3jSo/ngFc2MGCbCJ4u7qOlebyFhByi0X8LAiQjH
         JAu1U/g9yusk8T4cYP0ux5FUicN1OcczsSvCZR07oW/d58uRsExr1cv/+3zWNiGhUuj5
         e/pw==
X-Gm-Message-State: AOAM533bLCT3/pwa3nD0/e6RMkYQ8hAGStX9Ivhi1aqy26/9+eSWq11v
        dvlBrX4LdZR7Oy+hM7mKKPcMynywOGYuSQ==
X-Google-Smtp-Source: ABdhPJzGQ04kmlZXOludHVSf9wrR/1F6Mapu7DCS1l09W/4iX5/g/XSHqugVJHMppre667Xdn8hhqw==
X-Received: by 2002:a05:620a:414e:: with SMTP id k14mr17386217qko.374.1596482590672;
        Mon, 03 Aug 2020 12:23:10 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h144sm19345503qke.83.2020.08.03.12.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 12:23:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: init device stats for seed devices
Date:   Mon,  3 Aug 2020 15:23:08 -0400
Message-Id: <20200803192308.17977-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
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
 fs/btrfs/volumes.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d7670e2a9f39..dab295880117 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7225,7 +7225,7 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-
+again:
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		int item_size;
@@ -7263,6 +7263,12 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 
+	/* If we have seed devices we need to init those stats as well. */
+	if (fs_devices->seed) {
+		fs_devices = fs_devices->seed;
+		goto again;
+	}
+
 	btrfs_free_path(path);
 	return ret < 0 ? ret : 0;
 }
-- 
2.24.1

