Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1631CE283E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 04:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408244AbfJXCet (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 22:34:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38438 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406435AbfJXCes (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 22:34:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id o25so22104149qtr.5;
        Wed, 23 Oct 2019 19:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1L1UVsmiwS+xpUQ80FyogftbcKebcBOXiHqKTRmdfys=;
        b=Cv7pU5xfEyazZq4rtFmyhGGV/JDnvLrY5ZBPrdMhsThU1kW9tVd+q3mo0j39/Ax6xX
         BsHDoKUkFTuKg7YJsROonKRghvjq9hcDBFeUpuZrRdUkoftuTskGF2kP3gaXLyrTdeRv
         RShH24YqW7QtFKTd7AKK2HHAzUNlhKrSeSKc10vS069uz1zuzcWMjElHaigApnob23Za
         j7ZU1eTqEfvEL+kaSoPnZhivG+92r+CqODYn1gL6Qu77SG2N7+4vXwBQ1pWDGGgjrB8P
         /2E/+KcFUFOmGSaF8b0UNPeoAEuHmjBlPvc2dob6t58rql52IRMkszhpQChgoyAd341A
         54MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1L1UVsmiwS+xpUQ80FyogftbcKebcBOXiHqKTRmdfys=;
        b=AM2FK77I1hobN/wi1x7Xv4Z3XmNsWfwmH9xCDleY3JdGMPTv7sBQIzVCkvQjhYpzsv
         j8sGt3Qu5sFXlmMb5IEzSaHtDZf9l80OR0aoW60+gcD91ZvfTsMC7OVqJke/oSkW+tKJ
         c+ih1bP6cW9D+l4xcl3J8oIjnkhLTzFwoATUeS2fXVdUH3zWDKQxxqG0Mw34ms8Jrph2
         KM/2N+GWm4tlH+lz5XZJoMCmZz0ovw+kj82h40TNNs8DRLZKoEM1/+HVylu8tGYJaaun
         C3v9IKpadZj+BAF/MMIeTilzgfEVs51gRJdn73p0wP81ASnTpvKAeuCIIXdZVmXRcoNt
         uB6w==
X-Gm-Message-State: APjAAAUj08aFkT5xpvEOWfEfsBZrCL9oSvqYwshRoyIAMkeONefFZNns
        WGIph4Do4RZJWtmEfC196oW/Z0Xv
X-Google-Smtp-Source: APXvYqyGh3Q3xNuyJhPQoKMQuBcsiCj7m78zlKwZgmxWt0su0O9TT06hf1G6ahDkhxleUjCVXLNTTA==
X-Received: by 2002:ac8:768e:: with SMTP id g14mr1939571qtr.378.1571884486842;
        Wed, 23 Oct 2019 19:34:46 -0700 (PDT)
Received: from localhost.localdomain ([186.212.94.31])
        by smtp.gmail.com with ESMTPSA id q16sm10252495qke.22.2019.10.23.19.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 19:34:46 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, mpdesouza@suse.com
Subject: [PATCH 3/5] btrfs: ioctl: Call btrfs_vol_uevent on subvol creation
Date:   Wed, 23 Oct 2019 23:36:34 -0300
Message-Id: <20191024023636.21124-4-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024023636.21124-1-marcos.souza.org@gmail.com>
References: <20191024023636.21124-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

btrfs_vol_uevent will export two environment variables to udev:
BTRFS_VOL_NAME: containing the name of the volume being created
BTRFS_VOL_ADD: will signalize that a subvol was created

One can create a udev rule and check for BTRFS_VOL_ADD being sent,
these values one could detect whenever a subvolume is created, and
take any action based on the subvolume name contained in BTRFS_VOL_NAME.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/ioctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 174cbe71d6be..c538d3648195 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -980,6 +980,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 {
 	struct inode *dir = d_inode(parent->dentry);
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct block_device *bdev = fs_info->fs_devices->latest_bdev;
 	struct dentry *dentry;
 	int error;
 
@@ -1018,8 +1019,12 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 		error = create_subvol(dir, dentry, name, namelen,
 				      async_transid, inherit);
 	}
-	if (!error)
+	if (!error) {
+		if (!snap_src)
+			btrfs_vol_uevent(bdev, true, name);
+
 		fsnotify_mkdir(dir, dentry);
+	}
 out_up_read:
 	up_read(&fs_info->subvol_sem);
 out_dput:
-- 
2.23.0

