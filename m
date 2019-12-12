Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8876A11CBBE
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfLLLCT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:02:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44245 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfLLLCT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:02:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id az3so432953plb.11
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8AIHIwYWl7e/QhoTB8ocdp1XdiU5kIZiWIADqz3lybQ=;
        b=Q3gA68GaL0sgrRvGq+C9kI/SwJbx5zMSO+tiEHKZ9NyMf246+K3O4hrrj8qkbqbYpn
         puzAB+5go948C0IWZ210EP4w0Vz2lwbzfvnwKf/Su4YWwnKlomuBlQKccnrqLay6zsGv
         S98W4adtqgQYH5bNsgYZ/jXZG3OHSWgelMK+vxQOC/eJLlbmpkt+UE4xVdSSaSIERsO+
         UJE1tBI4pU7LyX1uiW7KxcxWjpE9kflvJasHyMQuDgZjo6WKhGTaSW0wJAW2gU61IFYC
         c5G34phwB0S8bL+DYmVctp6gqOYGm5e20qCYM+b060x0VFy8xnWeCu1VKa1xxGuTcLG8
         mwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8AIHIwYWl7e/QhoTB8ocdp1XdiU5kIZiWIADqz3lybQ=;
        b=op0xazDQ/OmNZt/IYqAv33yGN8+pTb6KVLR3muVAwI2uEeXCUU9vCTtLA+XQKE7i2i
         BRrTX4C40SEeXjXMXm9ABkJGkaz9ootR73kSOmWLXuKum8IZHFFbNFuBYaRrQLos9jwy
         geP1j0elMAA68t2CsVRwVBeYGPZBCsIx+clmPfOlmgDuWXXsyuXJbmQX+FXTDnxCIfHF
         T/NsGLByCIWX6Lw31xJgyfxR2B3mKXnXBhsHMPbqfZKAOpJdgFJBJoZ/GkW3/y/I2lj2
         pkGoWC/+ZYgG5JAexqSmd0P/SNhqSnojC3wNXSjGC8QGfSh4nOFc3HHWju2o+ciLLnGN
         QXuw==
X-Gm-Message-State: APjAAAUjKhJwKioHMHvFS5ck1BWdpO0wtPAT5KORQZmO1SK35SBdoYmc
        nXpzjPj0jmXQ/FBdTt6c1yK/zQ+vwXo=
X-Google-Smtp-Source: APXvYqzNXwfY3uyTTxAjE+sHz65hA0c/4k67iEZAbRXkblzG0Rts2jRxivdHeAvpH4Krk2QV1N620Q==
X-Received: by 2002:a17:902:67:: with SMTP id 94mr8964696pla.241.1576148538514;
        Thu, 12 Dec 2019 03:02:18 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id e20sm6587857pff.96.2019.12.12.03.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:02:18 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 04/11] btrfs-progs: handle split-brain scenario for scanned changing device without INCOMPAT_METADATA_UUID
Date:   Thu, 12 Dec 2019 19:01:57 +0800
Message-Id: <20191212110204.11128-5-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191212110204.11128-1-Damenly_Su@gmx.com>
References: <20191212110204.11128-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

For a scanned changing device without INCOMPAT_METADATA_UUID, the
situation may be
a) The scanned failed to be pull into disk, and there are successful
synced devices which is already in fs_devices->devices. So their
fsid and metadata_uuid must differ. Also since the scanned device is
without INCOMPAT_METADATA_UUID, so fs_device->metadata_uuid must equals
disk_super->fs_id.

b) The scanned device is in the newest state. There are some old
devices failed to be with CHANGING_FSID_V2 or some devices just like
the device.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 volumes.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/volumes.c b/volumes.c
index 88e926e98d5b..bc1726975ce4 100644
--- a/volumes.c
+++ b/volumes.c
@@ -205,18 +205,46 @@ static struct btrfs_fs_devices *find_fsid(u8 *fsid, u8 *metadata_uuid)
 	return NULL;
 }
 
+/*
+ * Handle scanned device which has CHANGING_FSID_V2 set, it might belong to
+ * either a filesystem which has disks with completed fsid change or it might
+ * belong to fs with no UUID changes in effect, handle both.
+ */
+static struct btrfs_fs_devices *find_fsid_inprogress(
+					struct btrfs_super_block *disk_super)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	list_for_each_entry(fs_devices, &fs_uuids, list) {
+		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
+			   BTRFS_FSID_SIZE) != 0 &&
+		    memcmp(fs_devices->metadata_uuid, disk_super->fsid,
+			   BTRFS_FSID_SIZE) == 0 && !fs_devices->fsid_change) {
+			return fs_devices;
+		}
+	}
+
+	return find_fsid(disk_super->fsid, NULL);
+}
+
 static int device_list_add(const char *path,
 			   struct btrfs_super_block *disk_super,
 			   u64 devid, struct btrfs_fs_devices **fs_devices_ret)
 {
 	struct btrfs_device *device;
-	struct btrfs_fs_devices *fs_devices;
+	struct btrfs_fs_devices *fs_devices = NULL;
 	u64 found_transid = btrfs_super_generation(disk_super);
 	bool metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
 	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
 					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
-	if (metadata_uuid)
+
+	if (fsid_change_in_progress) {
+		if (!metadata_uuid)
+			fs_devices = find_fsid_inprogress(disk_super);
+	}
+
+	if (metadata_uuid && !fs_devices)
 		fs_devices = find_fsid(disk_super->fsid,
 				       disk_super->metadata_uuid);
 	else
-- 
2.21.0 (Apple Git-122.2)

