Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 066E5136CC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 13:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgAJMLl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 07:11:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:35292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgAJMLj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 07:11:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EE2DDAE8C;
        Fri, 10 Jan 2020 12:11:37 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/4] btrfs: Factor out metadata_uuid code from find_fsid.
Date:   Fri, 10 Jan 2020 14:11:33 +0200
Message-Id: <20200110121135.7386-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110121135.7386-1-nborisov@suse.com>
References: <20200110121135.7386-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

find_fsid became rather hairy with the introduction of metadata uuid
changing feature. Alleviate this by factoring out the metadata uuid
specific code in a dedicated function which deals with finding
correct fsid for a device with changed uuid.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 77 +++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0bac8a31edff..90e5ed5f5364 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -440,39 +440,6 @@ static noinline struct btrfs_fs_devices *find_fsid(

 	ASSERT(fsid);

-	if (metadata_fsid) {
-		/*
-		 * Handle scanned device having completed its fsid change but
-		 * belonging to a fs_devices that was created by first scanning
-		 * a device which didn't have its fsid/metadata_uuid changed
-		 * at all and the CHANGING_FSID_V2 flag set.
-		 */
-		list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-			if (fs_devices->fsid_change &&
-			    memcmp(metadata_fsid, fs_devices->fsid,
-				   BTRFS_FSID_SIZE) == 0 &&
-			    memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
-				   BTRFS_FSID_SIZE) == 0) {
-				return fs_devices;
-			}
-		}
-		/*
-		 * Handle scanned device having completed its fsid change but
-		 * belonging to a fs_devices that was created by a device that
-		 * has an outdated pair of fsid/metadata_uuid and
-		 * CHANGING_FSID_V2 flag set.
-		 */
-		list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-			if (fs_devices->fsid_change &&
-			    memcmp(fs_devices->metadata_uuid,
-				   fs_devices->fsid, BTRFS_FSID_SIZE) != 0 &&
-			    memcmp(metadata_fsid, fs_devices->metadata_uuid,
-				   BTRFS_FSID_SIZE) == 0) {
-				return fs_devices;
-			}
-		}
-	}
-
 	/* Handle non-split brain cases */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
 		if (metadata_fsid) {
@@ -488,6 +455,47 @@ static noinline struct btrfs_fs_devices *find_fsid(
 	return NULL;
 }

+static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
+				struct btrfs_super_block *disk_super)
+{
+
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Handle scanned device having completed its fsid change but
+	 * belonging to a fs_devices that was created by first scanning
+	 * a device which didn't have its fsid/metadata_uuid changed
+	 * at all and the CHANGING_FSID_V2 flag set.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
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
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (fs_devices->fsid_change &&
+		    memcmp(fs_devices->metadata_uuid,
+			   fs_devices->fsid, BTRFS_FSID_SIZE) != 0 &&
+		    memcmp(disk_super->metadata_uuid, fs_devices->metadata_uuid,
+			   BTRFS_FSID_SIZE) == 0) {
+			return fs_devices;
+		}
+	}
+
+	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
+}
+
+
 static int
 btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 		      int flush, struct block_device **bdev,
@@ -743,8 +751,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		else
 			fs_devices = find_fsid_changed(disk_super);
 	} else if (has_metadata_uuid) {
-		fs_devices = find_fsid(disk_super->fsid,
-				       disk_super->metadata_uuid);
+		fs_devices = find_fsid_with_metadata_uuid(disk_super);
 	} else {
 		fs_devices = find_fsid(disk_super->fsid, NULL);
 	}
--
2.17.1

