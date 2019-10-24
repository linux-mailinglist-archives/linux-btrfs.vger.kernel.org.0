Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 228DFE2837
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 04:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406438AbfJXCen (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 22:34:43 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46202 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfJXCem (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 22:34:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id u22so35440803qtq.13;
        Wed, 23 Oct 2019 19:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xn5B/vWX4/5/L633ZiUXRAOXf5Sfp3irsNXPi/hnTvY=;
        b=HOaQy1e/F3vF9ZWEaNhz8sCI0vRcsUXdW7RONBuzVK00TZUTAKWZH8MkD3KfuuStzp
         Uz95XSOBtaiN68JEtliuneain+XrpA81jZbOaATHZFRjqeFzVgCnFYHV06tjjKgMr1wh
         8nDK44TY0Gs4eWdg4h1mIMxoIUE4Yu5FvulkH/9aqfIG3N/Z759rknSez0n6uRVqj1Up
         QiXdTqYlNgYrMoqL1NlWIpZ4MwZ9bUfIZJkGoU1tVvyrj2+mfHZk1dOwIzUZuR2SNV3+
         xCuCEfHYi5w9FDXICUBxxCPvcMa9K7hkyIJuH0EsUPE8rHbW/9rfoPz8Vg2RlOv4lh+f
         oHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xn5B/vWX4/5/L633ZiUXRAOXf5Sfp3irsNXPi/hnTvY=;
        b=IbrsgI0u0BUzesWifVoWtrQIEUlUbB4+kOKD+cNcdVr0r1G7qCuL30FSBf4SZ4vI01
         mzoPkYsgSEsnTIUKkYaIh2QUQ1kk6C1mNxGJUTsKiSSJNLwY9M345O+JiCeqhhXusWO6
         VHOv5tYGxK8adYq4q3DjgTiHD7wf2Y3DNpUtIQy5mqwi+4yXtt6buXsVL/El8aXhFESu
         JbsqktcDKgYXyxGJWEnwnQDEurhMwXML/z1M6crxiaT3Naks4K5cYl/JO57WWioQfKdk
         l9AJruhBlN4Zd0qmagthOCnxp4XlBgHeLfuT8KI9FT/EFUcJngXpFmNAsB2QORwoJChg
         0Mkw==
X-Gm-Message-State: APjAAAV7qozmpsYIzZvnThK3niEzP7P1slBBd9LMWmw/3yV25eYby9YN
        Pez+2tj/dbSkUnFXORLXlTiQKSk2
X-Google-Smtp-Source: APXvYqyNhJNo3RvCu1gy5NnJCBx/ex4BCCEqhW4R3CurPNNM6c120p8qNKcvY2Peu6iiPMSuGqSQ1Q==
X-Received: by 2002:aed:2088:: with SMTP id 8mr1948861qtb.295.1571884481019;
        Wed, 23 Oct 2019 19:34:41 -0700 (PDT)
Received: from localhost.localdomain ([186.212.94.31])
        by smtp.gmail.com with ESMTPSA id q16sm10252495qke.22.2019.10.23.19.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 19:34:40 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, mpdesouza@suse.com
Subject: [PATCH 1/5] btrfs: sysfs: Add envp argument to btrfs_kobject_uevent
Date:   Wed, 23 Oct 2019 23:36:32 -0300
Message-Id: <20191024023636.21124-2-marcos.souza.org@gmail.com>
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

This new argument will be used by the next patches for sending uevents
related to subvolumes being added/removed. These uevents will contain
environment data that will be sent to userspace, making it possible to
take actions once these events arrive.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/sysfs.c   | 7 +++++--
 fs/btrfs/sysfs.h   | 3 ++-
 fs/btrfs/volumes.c | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index f6d3c80f2e28..93a8ed9e4fe8 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -998,11 +998,14 @@ int btrfs_sysfs_add_device_link(struct btrfs_fs_devices *fs_devices,
 	return error;
 }
 
-void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
+void btrfs_kobject_uevent(struct block_device *bdev,
+				enum kobject_action action,
+				char *envp[])
 {
 	int ret;
 
-	ret = kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, action);
+	ret = kobject_uevent_env(&disk_to_dev(bdev->bd_disk)->kobj,
+				action, envp);
 	if (ret)
 		pr_warn("BTRFS: Sending event '%d' to kobject: '%s' (%p): failed\n",
 			action, kobject_name(&disk_to_dev(bdev->bd_disk)->kobj),
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 610e9c36a94c..5be3953074ad 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -26,7 +26,8 @@ void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
 				    const u8 *fsid);
 void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
 		u64 bit, enum btrfs_feature_set set);
-void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action);
+void btrfs_kobject_uevent(struct block_device *bdev,
+			enum kobject_action action, char *env[]);
 
 int __init btrfs_init_sysfs(void);
 void __cold btrfs_exit_sysfs(void);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bdfe4493e43a..7a7a9cae9b80 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7580,7 +7580,7 @@ void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_pat
 	}
 
 	/* Notify udev that device has changed */
-	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
+	btrfs_kobject_uevent(bdev, KOBJ_CHANGE, NULL);
 
 	/* Update ctime/mtime for device path for libblkid */
 	update_dev_time(device_path);
-- 
2.23.0

