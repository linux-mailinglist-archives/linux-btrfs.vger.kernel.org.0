Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1483F11CBB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfLLLBv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:01:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35945 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfLLLBv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:01:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id k3so979822pgc.3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59UI6eXW81Pq8dMMDIyUGxde96zaKk4qTYtmTH4SICs=;
        b=Gimf+KjZ+x2I3hrDKRvjL9NRVBeQeaEXfxY005vBVTE9sf7Dee71oWm5N6XgQpajPv
         lyY+vzkh2H+bbxZS++Ikle670+JkGwGxqz2P79/F5rowGpkzkEgvmuMOAyxZFgyFBVLj
         8wmthCB8cwfc92qP04PNIF0dXmGh1qOhhP8vGwM8nmm+DmllCyTdbaCzlCcp36gdDZWG
         5kZLFQBXJ4QBcRJYxO8NtJyGya+zzwB6xQIZw182Jy4n3GgeohrlxcEDYZm9OKBk8tPA
         tHSWev7aovRMgH231SBbwyIYjLKBFHoQt5SPjn1t/WcfP8NCQcW6lojHGJiD51i9iHUW
         oCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59UI6eXW81Pq8dMMDIyUGxde96zaKk4qTYtmTH4SICs=;
        b=uXEx31KGwfJGsTB5V38ltHQkZD/ZeNzN0L+vcmcB+L+b1uQIIw+rPvamEudRbuw+9u
         m26Id3S+Qxb5YWlYE0tyJ4KBEr5LaZCZfH/5d22+ccd9b5QDo/tWxEEJ8YEOPaVltpLB
         tIcqG3X/ZHJhWLKMHy9BlGq72ogZPX7TiZtsNafbbQLpBzZqJJIZFnpDoueM7HgLUrgw
         bt+IfwO8X8OJxMHDQlcH0eTE1jFcTUbWtE+N04/3SHmfW80pEfEORhmC9TdcPUM2Hy+H
         giBfpg1ZUzlEheEdKGE38JtXIRl4C07p6MimpykIme4GftRaohBKHvXnK4DDp0Vj8ER4
         vbMA==
X-Gm-Message-State: APjAAAUBIasJmwOe3iXpXJaapXJnpsVqljWknS/uNiU27OvxtdFM4pZw
        1yh2YnSTOv3lrt40yRiGdcfxax1nMWA=
X-Google-Smtp-Source: APXvYqzJFIsCU5dSuniUvj9qrK3GehpBE0E5sfw79LtvBWztALgOcgQknjXnTPh51x1CEF2MLaglEA==
X-Received: by 2002:a63:fa04:: with SMTP id y4mr9785836pgh.413.1576148510307;
        Thu, 12 Dec 2019 03:01:50 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id w11sm6682387pfn.4.2019.12.12.03.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:01:49 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 6/6] btrfs: metadata_uuid: move partly logic into find_fsid_inprogress()
Date:   Thu, 12 Dec 2019 19:01:32 +0800
Message-Id: <20191212110132.11063-7-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191212110132.11063-1-Damenly_Su@gmx.com>
References: <20191212110132.11063-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

The partly logic can be moved into find_fsid_inprogress() to
make code for fs_devices finding looks more elegant.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 fs/btrfs/volumes.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b21ab45e76a0..7e05f96b1575 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -636,6 +636,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 /*
  * Handle scanned device having its CHANGING_FSID_V2 flag set and the fs_devices
  * being created with a disk that has already completed its fsid change.
+ * Or it might belong to fs with no UUID changes in effect, handle both.
  */
 static struct btrfs_fs_devices *find_fsid_inprogress(
 					struct btrfs_super_block *disk_super)
@@ -651,7 +652,7 @@ static struct btrfs_fs_devices *find_fsid_inprogress(
 		}
 	}
 
-	return NULL;
+	return find_fsid(disk_super->fsid, NULL);
 }
 
 static struct btrfs_fs_devices *find_fsid_changed(
@@ -795,19 +796,10 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	*new_device_added = false;
 
 	if (fsid_change_in_progress) {
-		if (!has_metadata_uuid) {
-			/*
-			 * When we have an image which has CHANGING_FSID_V2 set
-			 * it might belong to either a filesystem which has
-			 * disks with completed fsid change or it might belong
-			 * to fs with no UUID changes in effect, handle both.
-			 */
+		if (!has_metadata_uuid)
 			fs_devices = find_fsid_inprogress(disk_super);
-			if (!fs_devices)
-				fs_devices = find_fsid(disk_super->fsid, NULL);
-		} else {
+		else
 			fs_devices = find_fsid_changed(disk_super);
-		}
 	} else if (has_metadata_uuid) {
 		fs_devices = find_fsid_changing_metada_uuid(disk_super);
 	} else {
-- 
2.21.0 (Apple Git-122.2)

