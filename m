Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7217E24C207
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgHTPTb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbgHTPSm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:18:42 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6696AC061388
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:18:41 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id r19so1045471qvw.11
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BrxymPo0KQldLgVMlOY2ByrTkaohT4kw6OeQQUYcIio=;
        b=mUiUYKfR3UqB1ppskdyweaTxdlKcdEKbDA3NLC1XwJZr0N4BK1eoXrtcWxeIwXzS4U
         ea1DxoEFGHSYDWUzhNTYqlfB66zKAreGk2G8c4V+6M4IF/rzqn9BpEyxNr7VwImCskz0
         yrKjcGJtn/yS3KPi6K/Y7vzgrF/ZFTm1i2EMsxtNrR1PFOy7k2j6249kbSengJQTkTwx
         zWMMg7+Jlx7gzlZaFyK63btwTvUrGK1tNCI9mVAwsC/aUMYQwNuFxURyWCjTXMDr75i5
         WoKtG+5zJAico7+NhfsMVlanvq3w2Bg8MJHHEuxzMlE8lGNsXToY8O3G9HVb29IDbIv5
         vBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BrxymPo0KQldLgVMlOY2ByrTkaohT4kw6OeQQUYcIio=;
        b=nYku5A+hqmsxNg2sGn9hq2cGQl8RHXGImj0P7NjkOUjPpZibR3jqNQSEb0U+L9YBsA
         /ySAWybi7w3LfHi5OdT3P3+LDKRfOp4u9F1uw/UxH8/DcIca2967a+yc2238IXGqm3o3
         ZVfiZGRUQciBQvdEhSSZDdLOmu9MDsZQ5KdM/Rwq7ze3U7x3S0BA+qa9N1yjekMmzrfw
         f6SvkLPW1UJRQRdVi44qIEfyARxilJWmXT0/rTX20V8XY4AjGVLvAsolF3stgpbSmxvQ
         gzU6mJOoHyRmcYI4X1tOI+klJyIJsXuicSuPLk7kGLJndCDmcOhvfjc99Wf9PHXnrVA3
         g3+g==
X-Gm-Message-State: AOAM531j+TMXZ32esBMvy9NzFdj1SFr6JmBhaqVCRApUWChkRI0f+6bH
        x8FHg9BxRNZjWpWg0t3nrugOoSTxoCoR04h2
X-Google-Smtp-Source: ABdhPJxOZTephoQvf7c7ueaF+PxgN8MsBdNZsR/uroPk+aM2LFdPSK8ky70HKoe+fxRJl7eqkXkR1w==
X-Received: by 2002:a0c:b598:: with SMTP id g24mr3440429qve.55.1597936720308;
        Thu, 20 Aug 2020 08:18:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d8sm3180486qtr.12.2020.08.20.08.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:18:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/8] btrfs: move btrfs_scratch_superblocks into btrfs_dev_replace_finishing
Date:   Thu, 20 Aug 2020 11:18:26 -0400
Message-Id: <f057e5076450f399e87cf54c3951bb2033febe36.1597936173.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597936173.git.josef@toxicpanda.com>
References: <cover.1597936173.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to move the closing of the src_device out of all the device
replace locking, but we definitely want to zero out the superblock
before we commit the last time to make sure the device is properly
removed.  Handle this by pushing btrfs_scratch_superblocks into
btrfs_dev_replace_finishing, and then later on we'll move the src_device
closing and freeing stuff where we need it to be.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/dev-replace.c |  3 +++
 fs/btrfs/volumes.c     | 12 +++---------
 fs/btrfs/volumes.h     |  3 +++
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 769ac3098880..cd240714a7af 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -745,6 +745,9 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	/* replace the sysfs entry */
 	btrfs_sysfs_remove_devices_dir(fs_info->fs_devices, src_device);
 	btrfs_sysfs_update_devid(tgt_device);
+	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &src_device->dev_state))
+		btrfs_scratch_superblocks(fs_info, src_device->bdev,
+					  src_device->name->str);
 	btrfs_rm_dev_replace_free_srcdev(src_device);
 
 	/* write back the superblocks */
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 756ac903a19f..33ecfcb472a8 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1998,9 +1998,9 @@ static u64 btrfs_num_devices(struct btrfs_fs_info *fs_info)
 	return num_devices;
 }
 
-static void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
-				      struct block_device *bdev,
-				      const char *device_path)
+void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
+			       struct block_device *bdev,
+			       const char *device_path)
 {
 	struct btrfs_super_block *disk_super;
 	int copy_num;
@@ -2223,12 +2223,6 @@ void btrfs_rm_dev_replace_free_srcdev(struct btrfs_device *srcdev)
 	struct btrfs_fs_info *fs_info = srcdev->fs_info;
 	struct btrfs_fs_devices *fs_devices = srcdev->fs_devices;
 
-	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &srcdev->dev_state)) {
-		/* zero out the old super if it is writable */
-		btrfs_scratch_superblocks(fs_info, srcdev->bdev,
-					  srcdev->name->str);
-	}
-
 	btrfs_close_bdev(srcdev);
 	synchronize_rcu();
 	btrfs_free_device(srcdev);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5eea93916fbf..302c9234f7d0 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -573,6 +573,9 @@ void btrfs_set_fs_info_ptr(struct btrfs_fs_info *fs_info);
 void btrfs_reset_fs_info_ptr(struct btrfs_fs_info *fs_info);
 bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 					struct btrfs_device *failing_dev);
+void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
+			       struct block_device *bdev,
+			       const char *device_path);
 
 int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
-- 
2.24.1

