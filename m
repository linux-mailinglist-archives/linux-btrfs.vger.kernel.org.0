Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031CE11CBBF
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfLLLCW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:02:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37415 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfLLLCW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:02:22 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so978358pga.4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gRbLyKi3H9G0lv79P5y0hQtzSz2uUw0jMqN2LdizlCY=;
        b=jD2mpEzN14MLzulB4ar0SPobl1qIyT5JyNb+mb/yam+dTnskF0GF/YsA39wIeIWMWn
         Wka8EFB7yxaJvcdhcO3V9yDbqIC5FgdxWTp7we/SKIXl4+luncP2cZsGq2EOAymvDt41
         zMiksfIqOK15RCqM64teAgDkFiQXNdq2xW0XkvFx+h6JobkfYyEkg9R6TZWcoU1dPQVZ
         roeCGHLhuktjw7brvn4yIAWFK30AMySB1rSidUI28tUdcpgeuCfDtnCSGBEO0blpjTJY
         o+QJ4Tn/OFw1LV1/nRTpr1blDOfb2sfX2WSSaZgpbbid1ZiZY9BWOywZcFZ8bZGtjykg
         mGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRbLyKi3H9G0lv79P5y0hQtzSz2uUw0jMqN2LdizlCY=;
        b=g3skNEHxbOxOu+lsChXlJCaQNjIKr/XO/WZxVIOSZptFMg+mynsPrtoZ71/kaKSnTF
         /gUxxTdHrcp3NrBYtk1Xt/3EV+Fizx8+/8kBzXo49aex7C1ReYlcTC2YfAXcQgqt8fMZ
         +PW0EyzgOii2Mafy1ztaZS7hGCboXePDE9IOIpLiyKZ+f08XnC/b3QFFx9xR9X1lnKr3
         kiurNzQfu3m9vnURWOLb0kW/RCfsTpCw1EVMrMp2KRL4GAgR6DQNzmklkxOzxBo4GK+0
         yDaHTR7nq9ecN+su3h2wVMrSBP4jxg979rJlzXgwjkZc5ucJ66ZfRrQOPBDcsNFId/vo
         TbjA==
X-Gm-Message-State: APjAAAVeweUYgKh465628wRYyXyKyhOoNb4ddlfeT+yTL8E/LuVtYwWy
        vh+WiFTwc+P6J29pBknqcGg/lhUV508=
X-Google-Smtp-Source: APXvYqwWPsvCuqAr9Egt5TW0gXvbJFStm/xrgKESI8t2qTvOEMelyv9s1P13AxycIBFgKQDqoqaLUQ==
X-Received: by 2002:a65:644b:: with SMTP id s11mr9456243pgv.332.1576148541037;
        Thu, 12 Dec 2019 03:02:21 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id e20sm6587857pff.96.2019.12.12.03.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:02:20 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 05/11] btrfs-progs: handle split-brain scenario for scanned changing device with INCOMPAT_METADATA_UUID
Date:   Thu, 12 Dec 2019 19:01:58 +0800
Message-Id: <20191212110204.11128-6-Damenly_Su@gmx.com>
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

For a scanned changing device with INCOMPAT_METADATA_UUID, which means
its fsid and metadata_uuid differs, then situation can be

a) The final changed devices are still own the INCOMPAT_METADATA_UUID
feature. So their metadata_uuid is same as the device's, but fsids must
differ.

b) The new fsid to be changing is same as the scanned device's
metadata_uuid. So the successful synced devices are like some never
changed. fs_devices's fsid is same with their metadata_uuid in memory.
In disk, those synced device's fsid differ from their metadata_uuid,
because the later member is full zero bytes.

c) The device is the newest device, there are old devices with
INCOMPAT_METADATA_UUID or scanned changing devices.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 volumes.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/volumes.c b/volumes.c
index bc1726975ce4..0fd41186c54a 100644
--- a/volumes.c
+++ b/volumes.c
@@ -227,6 +227,54 @@ static struct btrfs_fs_devices *find_fsid_inprogress(
 	return find_fsid(disk_super->fsid, NULL);
 }
 
+static struct btrfs_fs_devices *find_fsid_changed(
+					struct btrfs_super_block *disk_super)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Handles the case where scanned device is part of an fs that had
+	 * multiple successful changes of FSID but currently device didn't
+	 * observe it.
+	 *
+	 * Case 1: the devices already changed still owns the feature, their
+	 * fsid must differ from the disk_super->fsid.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, list) {
+		if (fs_devices->fsid_change)
+			continue;
+		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
+			   BTRFS_FSID_SIZE) != 0 &&
+		    memcmp(fs_devices->metadata_uuid, disk_super->metadata_uuid,
+			   BTRFS_FSID_SIZE) == 0 &&
+		    memcmp(fs_devices->fsid, disk_super->fsid,
+			   BTRFS_FSID_SIZE) != 0) {
+			return fs_devices;
+		}
+	}
+
+	/*
+	 * Case 2: the synced devices doesn't have the metadata_uuid feature.
+	 * NOTE: the fs_devices has same metadata_uuid and fsid in memory, but
+	 * they differs in disk, because fs_id is copied to
+	 * fs_devices->metadata_id while alloc_fs_devices if no metadata
+	 * feature.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, list) {
+		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
+			   BTRFS_FSID_SIZE) == 0 &&
+		    memcmp(fs_devices->fsid, disk_super->metadata_uuid,
+			   BTRFS_FSID_SIZE) == 0 && !fs_devices->fsid_change)
+			return fs_devices;
+	}
+
+	/*
+	 * Okay, can't found any fs_devices already synced, back to
+	 * search devices unchanged or changing like the device.
+	 */
+	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
+}
+
 static int device_list_add(const char *path,
 			   struct btrfs_super_block *disk_super,
 			   u64 devid, struct btrfs_fs_devices **fs_devices_ret)
@@ -242,6 +290,8 @@ static int device_list_add(const char *path,
 	if (fsid_change_in_progress) {
 		if (!metadata_uuid)
 			fs_devices = find_fsid_inprogress(disk_super);
+		else
+			fs_devices = find_fsid_changed(disk_super);
 	}
 
 	if (metadata_uuid && !fs_devices)
-- 
2.21.0 (Apple Git-122.2)

