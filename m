Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0CA47637F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhLOUkQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhLOUkP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:40:15 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE44C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:15 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z9so23161063qtj.9
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1zmzgINx///wU/Gk6p2nXlHkBhH7P6kiDKgaEb1W5Bc=;
        b=qw8A2pOFcQyvc7Kt9LP6n2gnPvbVXpBs3KY+bmrzP+wXL0oUjFYCnFa+blOafiosLi
         zRl6z0KT7xsDi5+t5Lngr+tmQRnK46VQ+vR2VoUoG8AHOZh34wt1LVwy7VDgh/5xPyBG
         PacJGSDT79CDe187AFd+V/o/IwFI3dnmM/mTvjyTlA/AwiTuqlC8ntLL7FHxTQK4VKq4
         BFSqBBMV3ttMEDMA8uakihF5GpTNXQ7dF1LNPB3Jl462kkIqv+cERw8EJDGluFgXZzL3
         Spf4WyPRTwbnTVy4apyMZKdkPC3eWGv64wsN9ixaTbRW82z6Akjcr3aKhOCEVCHrnXOu
         1CnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1zmzgINx///wU/Gk6p2nXlHkBhH7P6kiDKgaEb1W5Bc=;
        b=h+sLy/Y9sS3/mnODYqAVMMK+bMvjZLgL/EkoRNXUhdTPkTb2nCXAtq4+/Gn/0mxVVX
         BedH913ukWiT/eVIiWJv7TKRWjUeGaKwIHEfmAgOXEVXygEk7j++lOgH6RUGk9S13UfF
         YuNrYW8lEdXpS7NU3HE2zntB15Rq4tnL/eWSTO6qQwkYYBXXZbsv5bk0dm3m+8twm4KN
         mAyQqkc/UcK3SmHr2ZbLFNX9tNjIyxkzt5E4OmHdSgf2oyGRJ7EWDsZdHjyyexziTnh+
         9Siae7oJd4sz2JUbF7kHKVegaiYsA4k+uKE+XO8V8KDTUtNSH9ylKE/SiWbrU9uwaL5u
         KBKQ==
X-Gm-Message-State: AOAM533RpS6yLmrwrvE/e6AtKhXCdfZP+WTDQw2kxJ75GrPmX5cyzWt2
        uBODGte+hPA4z+rztX4VKzNkPiZbvwKydw==
X-Google-Smtp-Source: ABdhPJxNvVnFAVMYLFDIiAz6XMCV5ydzk5jxkiZFma1oG71+NEFeL/3JcsYapfLIyndas8cGxTNRGA==
X-Received: by 2002:a05:622a:152:: with SMTP id v18mr13890298qtw.380.1639600814583;
        Wed, 15 Dec 2021 12:40:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k14sm1605148qkh.100.2021.12.15.12.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:40:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 03/11] btrfs: disable device manipulation ioctl's EXTENT_TREE_V2
Date:   Wed, 15 Dec 2021 15:40:00 -0500
Message-Id: <f48fd4d0ef3179fc4e451c83ae3a2106efa299d8.1639600719.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600719.git.josef@toxicpanda.com>
References: <cover.1639600719.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Device add, remove, and replace all require balance, which doesn't work
right now on extent tree v2, so disable these for now.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c   | 10 ++++++++++
 fs/btrfs/volumes.c |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 61c90086072d..4ae87f44ce46 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3178,6 +3178,11 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		btrfs_err(fs_info, "device add not supported on extent tree v2 yet.");
+		return -EINVAL;
+	}
+
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD)) {
 		if (!btrfs_exclop_start_try_lock(fs_info, BTRFS_EXCLOP_DEV_ADD))
 			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
@@ -3802,6 +3807,11 @@ static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		btrfs_err(fs_info, "device replace not supported on extent tree v2 yet.");
+		return -EINVAL;
+	}
+
 	p = memdup_user(arg, sizeof(*p));
 	if (IS_ERR(p))
 		return PTR_ERR(p);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 802bfc63aa21..9b7ad5002508 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2101,6 +2101,11 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	u64 num_devices;
 	int ret = 0;
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		btrfs_err(fs_info, "device remove not supported on extent tree v2 yet.");
+		return -EINVAL;
+	}
+
 	/*
 	 * The device list in fs_devices is accessed without locks (neither
 	 * uuid_mutex nor device_list_mutex) as it won't change on a mounted
-- 
2.26.3

