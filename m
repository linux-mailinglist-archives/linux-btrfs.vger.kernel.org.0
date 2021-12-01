Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1165B465844
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 22:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344051AbhLAVWQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 16:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344040AbhLAVWP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 16:22:15 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755D9C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 13:18:54 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id u16so23029854qvk.4
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 13:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h6kR4gzlA46tz3V9klx8YiB7h5SbxbcMsX4E0uq2dBk=;
        b=y8/mHMfpbWqwKg0PBDXMqX67rMvBmVmYps16wcHe6R9AKxwd/TccirOmZrhjKoIJzo
         MajcbCS0o1g20aZIAVL0EthbBgCzLOfHBX9l/3BI8yBd0S1qdb7xWfDJ7kFa7v125d2z
         jlfd2TfMUPxHtmE2zGR8lbSb6A79jM+ohai4w8bZGlTF4Bad609sHeiV4qAZHZEJOCJ3
         LWUfrksZbanraEQZdTQlTS8Lct9LmY/7zk4Bz7xZr9vpUalw30Jh8BbTNSMhOJa7M2jy
         J0Nps4d6WcvoF7TCKsCzqCAdy6N+hp1lEV1apIMJs5Er4ks3pRWy6sb80uocynqQ7uzz
         XQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h6kR4gzlA46tz3V9klx8YiB7h5SbxbcMsX4E0uq2dBk=;
        b=NzN+FRKGBRPpPI43aVDUJ9OkyRlZzECTHQC/Do+nfqutSajVj30Qqlzp4vfrUl1xLm
         B9NCAxAfor5t6Qh7oUgVIOmt4UtBCfFwYWw5gKXpv49GpJPgdA/wHyz7kb/0AqMx/Nvx
         Y6cB45POFvOnjtHG+UqDvbrbJk9OeOCLiDu/6ANq8Xj7E9hP8QerkAEfmLrcI8K0WVQc
         5NdFKtSlgg7dU0w2Pz2FregeGkWEYdVUHIiID5HppWugqhVaIV3CoMPBTWWsGAYzL0jO
         7Od8/x48ayPtb1a0dcbxG8xFzL3K0QtMX5o07EdHli7/Pqj3kcc7I25hpnFZbnbmCeYw
         n4Aw==
X-Gm-Message-State: AOAM5328befwDUrpZmy6T5+uri0+ZvqBSIqC4++hHlLyfjEYMArGXgkl
        b8naiMa0uDNb1532p/QK2vZb/sgENNBbrQ==
X-Google-Smtp-Source: ABdhPJxBTUEdpjEUd0wTwaFURs37FcaXVm6sgvWeyJt2/pkFYkuRiZyZy1y6ftXhJ4Il30q3D9brgQ==
X-Received: by 2002:a05:6214:4107:: with SMTP id kc7mr9317508qvb.57.1638393533146;
        Wed, 01 Dec 2021 13:18:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u10sm505399qkp.104.2021.12.01.13.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 13:18:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: free device if we fail to open it
Date:   Wed,  1 Dec 2021 16:18:51 -0500
Message-Id: <7cfd63a1232900565abf487e82b7aa4af5fbca29.1638393521.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We've been having transient failures of btrfs/197 because sometimes we
don't show a missing device.

This turned out to be because I use LVM for my devices, and sometimes we
race with udev and get the "/dev/dm-#" device registered as a device in
the fs_devices list instead of "/dev/mapper/vg0-lv#" device.  Thus when
the test adds a device to the existing mount it doesn't find the old
device in the original fs_devices list and remove it properly.

This is fine in general, because when we open the devices we check the
UUID, and properly skip using the device that we added to the other file
system.  However we do not remove it from our fs_devices, so when we get
the device info we still see this old device and think that everything
is ok.

We have a check for -ENODATA coming back from reading the super off of
the device to catch the wipefs case, but we don't catch literally any
other error where the device is no longer valid and thus do not remove
the device.

Fix this to not special case an empty device when reading the super
block, and simply remove any device we are unable to open.

With this fix we properly print out missing devices in the test case,
and after 500 iterations I'm no longer able to reproduce the problem,
whereas I could usually reproduce within 200 iterations.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 2 +-
 fs/btrfs/volumes.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5c598e124c25..fa34b8807f8d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3924,7 +3924,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 	super = page_address(page);
 	if (btrfs_super_magic(super) != BTRFS_MAGIC) {
 		btrfs_release_disk_super(super);
-		return ERR_PTR(-ENODATA);
+		return ERR_PTR(-EINVAL);
 	}
 
 	if (btrfs_super_bytenr(super) != bytenr_orig) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f38c230111be..890153dd2a2b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1223,7 +1223,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 		if (ret == 0 &&
 		    (!latest_dev || device->generation > latest_dev->generation)) {
 			latest_dev = device;
-		} else if (ret == -ENODATA) {
+		} else if (ret) {
 			fs_devices->num_devices--;
 			list_del(&device->dev_list);
 			btrfs_free_device(device);
-- 
2.26.3

