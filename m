Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88816136CC3
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 13:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgAJMLl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 07:11:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:35308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbgAJMLk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 07:11:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 70692AEA2;
        Fri, 10 Jan 2020 12:11:38 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/4] btrfs: Fix split-brain handling when changing FSID to metadata uuid
Date:   Fri, 10 Jan 2020 14:11:35 +0200
Message-Id: <20200110121135.7386-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110121135.7386-1-nborisov@suse.com>
References: <20200110121135.7386-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Current code doesn't correctly handle the situation which arises when
a file system that has METADATA_UUID_INCOMPAT flag set  has its FSID
changed to the one in metadata uuid. This causes the incompat flag to
disappear. In case of a power failure we could end up in a situation
where part of the disks in a multi-disk filesystem are correctly
reverted to METADATA_UUID_INCOMPAT flag unset state, while others have
METADATA_UUID_INCOMPAT set and CHANGING_FSID_V2_IN_PROGRESS.

This patch corrects the behavior required to handle the case where a
disk of the second type is scanned first, creating the necessary
btrfs_fs_devices. Subsequently, when a disk which has already completed
the transition is scanned it should overwrite the data in
btrfs_fs_devices.

Reported-by: Su Yue <Damenly_Su@gmx.com>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7739d40939bf..871e163d1252 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -733,6 +733,32 @@ static struct btrfs_fs_devices *find_fsid_changed(

 	return NULL;
 }
+
+static struct btrfs_fs_devices *find_fsid_reverted_metadata(
+				struct btrfs_super_block *disk_super)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Handles the case where the scanned device is part of an fs whose last
+	 * metadata uuid change reverted it to the original FSID. At the same time
+	 * fs_devices was first created by another constitutent device which didn't
+	 * fully observer the operation. This results in an btrfs_fs_devices
+	 * created with metadata/fsid different AND btrfs_fs_devices::fsid_change
+	 * set AND the metadata_uuid of the fs_devices equal to the FSID of the
+	 * disk.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
+			   BTRFS_FSID_SIZE) != 0 &&
+		    memcmp(fs_devices->metadata_uuid, disk_super->fsid,
+			   BTRFS_FSID_SIZE) == 0 &&
+		    fs_devices->fsid_change)
+			return fs_devices;
+	}
+
+	return NULL;
+}
 /*
  * Add new device to list of registered devices
  *
@@ -762,7 +788,9 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	} else if (has_metadata_uuid) {
 		fs_devices = find_fsid_with_metadata_uuid(disk_super);
 	} else {
-		fs_devices = find_fsid(disk_super->fsid, NULL);
+		fs_devices = find_fsid_reverted_metadata(disk_super);
+		if (!fs_devices)
+			fs_devices = find_fsid(disk_super->fsid, NULL);
 	}


@@ -792,12 +820,17 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		 * a device which had the CHANGING_FSID_V2 flag then replace the
 		 * metadata_uuid/fsid values of the fs_devices.
 		 */
-		if (has_metadata_uuid && fs_devices->fsid_change &&
+		if (fs_devices->fsid_change &&
 		    found_transid > fs_devices->latest_generation) {
 			memcpy(fs_devices->fsid, disk_super->fsid,
 					BTRFS_FSID_SIZE);
-			memcpy(fs_devices->metadata_uuid,
-					disk_super->metadata_uuid, BTRFS_FSID_SIZE);
+
+			if (has_metadata_uuid)
+				memcpy(fs_devices->metadata_uuid,
+				       disk_super->metadata_uuid, BTRFS_FSID_SIZE);
+			else
+				memcpy(fs_devices->metadata_uuid,
+				       disk_super->fsid, BTRFS_FSID_SIZE);

 			fs_devices->fsid_change = false;
 		}
--
2.17.1

