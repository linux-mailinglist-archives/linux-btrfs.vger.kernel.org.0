Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9ED315F7A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 21:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgBNUWL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 15:22:11 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38397 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbgBNUWL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 15:22:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id z19so10455627qkj.5
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2020 12:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OnpDr4KkUDwZ7IFZOzmCil/o6rpitttQYeYD61sOAIE=;
        b=0U7HT/A2HTS8zmGuu02lvYOZ1g/dpzPKjfI33Vax5MND60S3NJ1adMik+Q7GWAOm45
         5nE0BG56d8pkD+18z9sCnrBjRFlTe8zyyROPuedqeSfqjjANCdQ6KTxhgyd+JvkzqFER
         vze1d34HU5nHhfcEBzWlW9fhkuu7ZBHZJsu9Ci990xgvnt6ryk5RS396G2n2DiwBXPjg
         Vd8aP7d7J/MLHsK7ewqSGw3tBk0SPa/8CLO7FiyVRrPkWF+lAl6ZzdqRZXdIYKaEArqo
         CjtCJEx4srAO82MW2xg26E+uqEcuHr5zAzae1HiROEqihX60VheeV9nas2ZszWnjLQ07
         l+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OnpDr4KkUDwZ7IFZOzmCil/o6rpitttQYeYD61sOAIE=;
        b=gnVM5hDM6FASc5zxKCE2qDn/2TSr9cenafO/J0MCTqBSIppcH8VwyTKhhlAr0bZWji
         4kK/Ju7kS4KDsgkk8WD3xrgYCf/EP+QVnpjAhfUIrjuzpvcL/yN6xsbOK6JqhXyu5HZ8
         DGlxSx4161yPXy8RUCPciy1X6ZTlMP+GYjR/mFxCTfvBppH+ioXA5xRTDUjMPI9oSV2Z
         AfhQJGbIVea2EU2Ee+V88QL/rUoK86ECvgUsG9yDVJ/3i8zPenhdRDey3sdAk05K07P2
         cG+j8VvpfmdD0/RNU5nlX7wvJ2KBzey028wLDiEBnVYvYzHx567WmPc2pRz7MNYGIrhg
         uYQg==
X-Gm-Message-State: APjAAAX5TqPvOIBJJAyZ7zIQDWvRrTJ05gIivW3/Zwr5vRGtZP2+Um/z
        vBy7qEfJ89f6lp4mXrarMSNIHmkEHcg=
X-Google-Smtp-Source: APXvYqyaNY/iQxIfOxFc7vAlUUYJzI2yFBwRS1XhETh1UB/QQ/eA2Lk0edTfW2u6do/TqUSUalm6Kg==
X-Received: by 2002:a37:4fc3:: with SMTP id d186mr4525780qkb.100.1581711728263;
        Fri, 14 Feb 2020 12:22:08 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c17sm3748591qko.134.2020.02.14.12.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:22:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: set update the uuid generation as soon as possible
Date:   Fri, 14 Feb 2020 15:22:06 -0500
Message-Id: <20200214202206.1642-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In my EIO stress testing I noticed I was getting forced to rescan the
uuid tree pretty often, which was weird.  This is because my error
injection stuff would sometimes inject an error after log replay but
before we loaded the UUID tree.  If log replay committed the transaction
it wouldn't have updated the uuid tree generation, but the tree was
valid and didn't change, so there's no reason to not update the
generation here.

Fix this by setting the BTRFS_FS_UPDATE_UUID_TREE_GEN bit immediately
after reading all the fs roots if the uuid tree generation matches the
fs generation.  Then any transaction commits that happen during mount
won't screw up our uuid tree state, forcing us to do needless uuid
rescans.

Fixes: 70f801754728 ("Btrfs: check UUID tree during mount if required")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e3a2db4d09a6..772cf0fa7c55 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3114,6 +3114,19 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (ret)
 		goto fail_tree_roots;
 
+	/*
+	 * If we have a uuid root and we're not being told to rescan we need to
+	 * check the generation here so we can set the
+	 * BTRFS_FS_UPDATE_UUID_TREE_GEN bit.  Otherwise we could commit the
+	 * transaction during a balance or the log replay without updating the
+	 * uuid generation, and then if we crash we would rescan the uuid tree,
+	 * even though it was perfectly fine.
+	 */
+	if (fs_info->uuid_root && !btrfs_test_opt(fs_info, RESCAN_UUID_TREE) &&
+	    fs_info->generation ==
+	    btrfs_super_uuid_tree_generation(disk_super))
+		set_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags);
+
 	ret = btrfs_verify_dev_extents(fs_info);
 	if (ret) {
 		btrfs_err(fs_info,
@@ -3338,8 +3351,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 			close_ctree(fs_info);
 			return ret;
 		}
-	} else {
-		set_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags);
 	}
 	set_bit(BTRFS_FS_OPEN, &fs_info->flags);
 
-- 
2.24.1

