Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F789414EC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 19:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhIVRIt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 13:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236676AbhIVRIt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 13:08:49 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125CEC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 10:07:19 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r2so3360041pgl.10
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5VvVCs/6Tkh6FhkUSWTQr57bYZI7XNe/o2Rd7gl/Zo=;
        b=BSNujoo+NGuPJtGCc1gPUFLdWm7TnRSInOQgMw4bxmsGvNyJif5jL7ZKg3dAyqdAfE
         zsdBKSY5dx12MrG6VAtifQK+dXQSO0ySnoubXG1B7fDquViZxFNdUJklYAykpIL+NIiw
         6HK3bWZ+uoFKrT2XUTrueqqHWpDjF7LlJb9lC0YdCWKMjcHdKMMpa1ktsc/BRsn8rwBm
         gX6WjiHeiGN+oQtQjA5A0IJ1/bUeoYdqEc7GrHekxJWcLcISK8gt5zf9qFM6uh9X3+7F
         u9NslqP2DzhU9CWpAQxuRtfPIfbOE8QU0gODtv6rvaQY+oYqVX95tfw7Au1OxWoQrw6H
         T56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5VvVCs/6Tkh6FhkUSWTQr57bYZI7XNe/o2Rd7gl/Zo=;
        b=U5Kx9SHMr/XZBJEWVKaX3qO6O1sTWRWaq0vWf3AFlaiYDIecMMVz+4DcNPbPK27jvr
         h5ggLp2HsotmvcNPMbiLsO05CAXgAH3+KAf/R4GOoIIaGI22lHhbOEqne4ogpE/XKyT6
         McmzT7lwjNyMPPoXUPfhXNMA4FAusWoQyuGdsIHSf5mZslphkndubohIrk9sPu5VWp48
         T8JWe+6bcY+9yYP4ezURRjnZqvDVq6V7ywaWFVrwR2ffwufDD2MFTDy7VEQi5Q+MpvqZ
         dn4gpnwlazLXW3vvqlGGsb3L8G5cDMVO9QK+xpXaErDZ4bMUau5zCZ0gsipHMpiH0A3M
         yEkg==
X-Gm-Message-State: AOAM531ssBnhCk/yYwB9hlkt/xuG4GrqVHVvfO1SgA/m5cZOU8rlRnoC
        /cFpakO4bmtT+9+e/Ip6vErgK8GnESbnFxdc
X-Google-Smtp-Source: ABdhPJwJjKOTB2nyqmoYyRBmE++6IIbzjgkBOS8Zl+5eekzF+qTgYvxysQFayurK3aF/aq/IVJ01/Q==
X-Received: by 2002:a63:eb41:: with SMTP id b1mr682744pgk.236.1632330438116;
        Wed, 22 Sep 2021 10:07:18 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([219.137.143.72])
        by smtp.gmail.com with ESMTPSA id q29sm3069782pfn.206.2021.09.22.10.07.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Sep 2021 10:07:17 -0700 (PDT)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH] clear_bit BTRFS_DEV_STATE_MISSING if the device->bdev is not NULL During mount.
Date:   Thu, 23 Sep 2021 01:06:30 +0800
Message-Id: <1632330390-29793-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

reference to:
https://github.com/kdave/btrfs-progs/issues/389
If a device offline somehow, but after a moment, it is back
online, btrfs filesystem only mark the device is missing, but
don't mark it right.

However, Although filesystem mark device presented, in my
case the /dev/loop2 is come back, the generation of this
/dev/loop2 super block  is not right.Because the device's
data is not up-to-date.  So the info of status of scrubs
would list as following.:

$ losetup /dev/loop1 test1
$ losetup /dev/loop2 test2
$ losetup -d /dev/loop2
$ mount -o degraded /dev/loop1 /mnt/1
$ touch /mnt/1/file1.txt
$ umount /mnt/1
$ losetup /dev/loop2 test2
$ mount /dev/loop1 /mnt/1
$ btrfs scrub start /mnt/1
scrub started on /mnt/1, fsid 88a3295f-c052-4208-9b1f-7b2c5074c20a (pid=2477)
$ WARNING: errors detected during scrubbing, corrected

$btrfs scrub status /mnt/1
UUID:             88a3295f-c052-4208-9b1f-7b2c5074c20a
Scrub started:    Thu Sep 23 00:34:55 2021
Status:           finished
Duration:         0:00:01
Total to scrub:   272.00KiB
Rate:             272.00KiB/s
Error summary:    super=2 verify=5
  Corrected:      5
  Uncorrectable:  0
  Unverified:     0

And if we umount and mount again everything would be all right.

In my opinion, we could improve this scrub in the following
way, i personally vote the second method

1) Sync all data immediately during mounting, but it waste IO
resource.

2) In scrub, we should give detailed information of every device
instead of a single filesystem, since scrub is launching a number
of thread to scanning each device instead scan whole filesystem.
Futher more we should give user hint about how to fix it, in my
case, user should umount filesystem and mount it again. But if
data is corrupt, the repair program might be called,  in case of
further damage, user should replace a device and reconstruct
ata using raid1, raid6 and so on.

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 fs/btrfs/volumes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 464485a..99fdbaa 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7198,6 +7198,11 @@ static int read_one_dev(struct extent_buffer *leaf,
 			set_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
 		}
 
+		if (device->bdev && test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state) && device->fs_devices->missing_devices > 0) {
+			device->fs_devices->missing_devices--;
+			clear_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
+		}
+
 		/* Move the device to its own fs_devices */
 		if (device->fs_devices != fs_devices) {
 			ASSERT(test_bit(BTRFS_DEV_STATE_MISSING,
-- 
1.8.3.1

