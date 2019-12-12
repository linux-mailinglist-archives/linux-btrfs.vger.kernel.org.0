Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C62711CBC0
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfLLLCY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:02:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39154 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfLLLCY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:02:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so971860pga.6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s6RfplAOYpdeeS/qL+EYY/6ygvavVHjtqB/z4E+QHdk=;
        b=Pxpoer3+kae/lgjrafAI0RDu6KgBuZhZFxXcPwadPSDrip+ZAWpOQfAssl8oJGl71c
         vkYbPSV+GE52cW/eo+HrX8ATK/ruqK/d4YLbVNRotYka+u8sRLT+fJCpvlnPw74y+diz
         VQCa6PBe+ADiwP5TcnfRCTI5GZLo+vCLMOk4os5EieJ3QjjsKLPiEy8ttXwQaUZfL4Cg
         JlHKf4tGoFIF+8lDzX+OBCXT5z+ohRco0o9jUbk9xDHUqp5lEux7RfRSL2lD9MrEO/ew
         PJwVlKvoTk2UJelqPzTaAedQY5vneT+IFj28pmG4D/5r4KPxerYR0fOvmS09atpR1k3G
         NIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s6RfplAOYpdeeS/qL+EYY/6ygvavVHjtqB/z4E+QHdk=;
        b=lD1Hg5JruV7qGW4EjepVLcZSDpvZYOeQ+jlri+EEMzR/sZzNiuGEEbf3V4VH1EfbQF
         7O1k+5Dqz4WmNnfxsq0bPvqMA85plcbXJTmocLkk/wec7UWtJpeEJ0Rjd1hhOG7SwTO4
         PTP8eMNoPhp3aqnU/7L2tHQ2WPY3TuqfYUK9e56dlsgi0V9udOZQJHJaz64NtAdKI79H
         t8up4w3TWi7JurueQcE5YbCiUTiDDlpbSBWIqlIrkuUhapfM6srHMAC5os667DNwaHYn
         mYm8FuGC1HJoMp9qo2aI5tjMIUBFQnIXMxMY4zi8BNN/aJGUalQMbQcDfau3vC+pVBFF
         iIqA==
X-Gm-Message-State: APjAAAWOaZSM0bKXErI4bIQtKSc8XouAF/GQhUJdiLnt4TKZhkngur1S
        m1wG/r+5qw7rrr/bEiWCR+y2gdD60pg=
X-Google-Smtp-Source: APXvYqz3XM7k1sFKSk7aEgobdigRjLI7D8MYQda/2pQaQ/yhWtWFuQLONSjgOcfNTus2xOe2xdgHcg==
X-Received: by 2002:a63:d94b:: with SMTP id e11mr9712807pgj.79.1576148543189;
        Thu, 12 Dec 2019 03:02:23 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id e20sm6587857pff.96.2019.12.12.03.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:02:22 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 06/11] btrfs-progs: handle split-brain scenario for scanned changed/unchanged device with INCOMPAT_METADATA_UUID
Date:   Thu, 12 Dec 2019 19:01:59 +0800
Message-Id: <20191212110204.11128-7-Damenly_Su@gmx.com>
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

For the unchanged/changed device, just need to fs_devices in changing
state, or devices with same status:

a) The scanned device succeeded to sync into disk. The fs_devices
can be with INCOMPAT_METADATA_UUID. So their fsid and metadata_uuid
differs, and metadata_uuid is same as its metada_uuid.

b) The scanned device succeeded to sync into disk. The fs_devices
can be without INCOMPAT_METADATA_UUID. So their fsid and metadata_uuid
be same, and fsid is same as its metadata_uuid.

c) The scanned device failed to be into changing state. There
are some devices whose fsids and metadata_uuids are same as the
device's.

d) The above cases all are missed, only unchanged devices are same
as the device.

Case c and d can be merged into one that both fsid and metadata
requirements are meet.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 volumes.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/volumes.c b/volumes.c
index 0fd41186c54a..d094f85999d4 100644
--- a/volumes.c
+++ b/volumes.c
@@ -275,6 +275,50 @@ static struct btrfs_fs_devices *find_fsid_changed(
 	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
 }
 
+static struct btrfs_fs_devices *find_fsid_changing_metadata_uuid(
+					struct btrfs_super_block *disk_super)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Handle scanned device having completed its fsid change but
+	 * belonging to a fs_devices that was created by first scanning
+	 * a device which didn't have its fsid/metadata_uuid changed
+	 * at all and the CHANGING_FSID_V2 flag set.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, list) {
+		if (fs_devices->fsid_change &&
+		    memcmp(disk_super->metadata_uuid, fs_devices->fsid,
+			   BTRFS_FSID_SIZE) == 0 &&
+		    memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
+			   BTRFS_FSID_SIZE) == 0) {
+			return fs_devices;
+		}
+	}
+	/*
+	 * Handle scanned device having completed its fsid change but
+	 * belonging to a fs_devices that was created by a device that
+	 * has an outdated pair of fsid/metadata_uuid and
+	 * CHANGING_FSID_V2 flag set.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, list) {
+		if (fs_devices->fsid_change &&
+		    memcmp(fs_devices->metadata_uuid,
+			   fs_devices->fsid, BTRFS_FSID_SIZE) != 0 &&
+		    memcmp(disk_super->metadata_uuid,
+			   fs_devices->metadata_uuid, BTRFS_FSID_SIZE) == 0) {
+			return fs_devices;
+		}
+	}
+
+	/*
+	 * The scanned device is unchanged. Try to find devices which are
+	 * successful in changing stage. Or old devices failed to be
+	 * changeing liked current device.
+	 */
+	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
+}
+
 static int device_list_add(const char *path,
 			   struct btrfs_super_block *disk_super,
 			   u64 devid, struct btrfs_fs_devices **fs_devices_ret)
@@ -292,6 +336,8 @@ static int device_list_add(const char *path,
 			fs_devices = find_fsid_inprogress(disk_super);
 		else
 			fs_devices = find_fsid_changed(disk_super);
+	} else if (metadata_uuid) {
+		fs_devices = find_fsid_changing_metadata_uuid(disk_super);
 	}
 
 	if (metadata_uuid && !fs_devices)
-- 
2.21.0 (Apple Git-122.2)

