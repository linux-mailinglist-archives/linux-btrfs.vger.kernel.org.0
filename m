Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE618116140
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2019 10:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfLHJa7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 04:30:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34409 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfLHJa7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Dec 2019 04:30:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so5576611pgf.1
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2019 01:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ambroffkao-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4myM6M9D7nnaCJGqGdPJH+pjA3ljbGqKvrICB31hv2o=;
        b=khB5yDJNoeeuUhtTwhix1r2ooukiGMaCe92Qi6xgwjqQ7PqCJ11Db+ADzzpim20SmN
         YBie/c832bEJP2tckpFP2yWlzhfcVyZO80/NCek8+XEB8GGpqxkXcLdaPloLIEk8GLeJ
         HjD6Vx7PKO+m9BlJgSC2Ms5d9MCoDO8d/sLKDGPWVgyoJEkiipi6fVND71aQ5nMYA4n5
         fEZrz/wYQSpv1EAEfeMZ/ZkKxqAqNjjSTEjTifpCEgZ8+C+M8dgOraNuXNUr3TeZYQSR
         lIjHUC9OwK/qdFY7Cechb3XX1TXWnMpkCf57ZP4uQTf0crY3/sXj7jZqcOSPNV344gjS
         14JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4myM6M9D7nnaCJGqGdPJH+pjA3ljbGqKvrICB31hv2o=;
        b=Af3LleoOEElF/RfNCSwr6d/+b/NsGRLam8ZXvmsxsO89ScmrhO15NIYeq42osoCvJ2
         s5kfinaVPjAPIbqVIGJ/V6lZATMNWAvvG861P9pZophKz/zqvLZVa2zPNt8MWCX1mHEw
         m73u7Am6Zww+p7vVV6+5/9KToPvLtG1qDJy6pacMKnq4srIskMQR/Y4nB6z/u346/Vur
         JPCoTiNETT4TRZOz1tl/bemgwIgM1Ha5vaVftn6p6NjU+G9f5IkpeGXt48Uv3gx5YrkW
         qKP9Pk9N4GMuXuMWG78uH9i43aimlHAu9GKYFhst4Oo7Wnogi1InlNEx8qlp3caD5Jkr
         BFLQ==
X-Gm-Message-State: APjAAAWabmFax/qNFge2xBOnSmPgfHmsWiTT3dT8e0+hfWCAnNld915T
        N0OzPq9MN3BxsAwu9kb5rUNsd0CBrKCpCg==
X-Google-Smtp-Source: APXvYqwwOOTGYRXJVsaFahfvRCpJ9+5cUYHs8uqBGnD8TCGx3eeS4AMH5HBfbBdGH/H2SDe+28b9qw==
X-Received: by 2002:a63:3484:: with SMTP id b126mr12719681pga.17.1575797457824;
        Sun, 08 Dec 2019 01:30:57 -0800 (PST)
Received: from localhost.localdomain ([66.234.200.130])
        by smtp.gmail.com with ESMTPSA id m127sm9077978pfm.167.2019.12.08.01.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 01:30:57 -0800 (PST)
From:   Kyle Ambroff-Kao <kyle@ambroffkao.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Kyle Ambroff-Kao <kyle@ambroffkao.com>
Subject: [PATCH 1/1] btrfs: Allow replacing device with a smaller one if possible
Date:   Sun,  8 Dec 2019 01:30:45 -0800
Message-Id: <20191208093045.43433-2-kyle@ambroffkao.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191208093045.43433-1-kyle@ambroffkao.com>
References: <20191208093045.43433-1-kyle@ambroffkao.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As long as the target device has enough capacity for the total bytes
of the source device, allow the replacement to occur.

Just changing the size validation isn't enough though, since the
rest of the replacement code just assumes that the source device is
identical to the target device. The current code just blindly
copies the total disk size from the source to the target.

A btrfs resize <devid>:max could be performed, but we might as well
just set the disk size for the new target device correctly in the
first place before initiating a scrub, which is what this patch does.

When initializing the target device, the size in bytes is calculated
in the same way that btrfs_init_new_device does it.

When the replace operation completes, btrfs_dev_replace_finishing no
longer clobbers the target device size with the source device size.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=112741
Signed-off-by: Kyle Ambroff-Kao <kyle@ambroffkao.com>
---
 fs/btrfs/dev-replace.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f639dde2a679..6a7a83ccab56 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -216,7 +216,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 
 
 	if (i_size_read(bdev->bd_inode) <
-	    btrfs_device_get_total_bytes(srcdev)) {
+	    btrfs_device_get_bytes_used(srcdev)) {
 		btrfs_err(fs_info,
 			  "target device is smaller than source device!");
 		ret = -EINVAL;
@@ -243,8 +243,10 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	device->io_width = fs_info->sectorsize;
 	device->io_align = fs_info->sectorsize;
 	device->sector_size = fs_info->sectorsize;
-	device->total_bytes = btrfs_device_get_total_bytes(srcdev);
-	device->disk_total_bytes = btrfs_device_get_disk_total_bytes(srcdev);
+	device->total_bytes = round_down(
+		i_size_read(bdev->bd_inode),
+		fs_info->sectorsize);
+	device->disk_total_bytes = device->total_bytes;
 	device->bytes_used = btrfs_device_get_bytes_used(srcdev);
 	device->commit_total_bytes = srcdev->commit_total_bytes;
 	device->commit_bytes_used = device->bytes_used;
@@ -671,9 +673,6 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	memcpy(uuid_tmp, tgt_device->uuid, sizeof(uuid_tmp));
 	memcpy(tgt_device->uuid, src_device->uuid, sizeof(tgt_device->uuid));
 	memcpy(src_device->uuid, uuid_tmp, sizeof(src_device->uuid));
-	btrfs_device_set_total_bytes(tgt_device, src_device->total_bytes);
-	btrfs_device_set_disk_total_bytes(tgt_device,
-					  src_device->disk_total_bytes);
 	btrfs_device_set_bytes_used(tgt_device, src_device->bytes_used);
 	tgt_device->commit_bytes_used = src_device->bytes_used;
 
-- 
2.20.1

