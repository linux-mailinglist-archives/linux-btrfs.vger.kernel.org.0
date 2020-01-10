Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8B6136CC1
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 13:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgAJMLj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 07:11:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:35280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgAJMLj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 07:11:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B0B3EAE61;
        Fri, 10 Jan 2020 12:11:37 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/4] btrfs: Call find_fsid from find_fsid_inprogress
Date:   Fri, 10 Jan 2020 14:11:32 +0200
Message-Id: <20200110121135.7386-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110121135.7386-1-nborisov@suse.com>
References: <20200110121135.7386-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

Since find_fsid_inprogress should also handle the case in which an fs
didn't change its FSID make it call find_fsid directly. This makes the
code in device_list_add simpler by eliminating a conditional call of
find_fsid. No functional changes.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fa48589bd924..0bac8a31edff 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -671,7 +671,9 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,

 /*
  * Handle scanned device having its CHANGING_FSID_V2 flag set and the fs_devices
- * being created with a disk that has already completed its fsid change.
+ * being created with a disk that has already completed its fsid change. Such
+ * disk can belong to an fs which has its FSID changed or to one which doesn't.
+ * Handle both cases here.
  */
 static struct btrfs_fs_devices *find_fsid_inprogress(
 					struct btrfs_super_block *disk_super)
@@ -687,7 +689,7 @@ static struct btrfs_fs_devices *find_fsid_inprogress(
 		}
 	}

-	return NULL;
+	return find_fsid(disk_super->fsid, NULL);
 }


@@ -736,19 +738,10 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);

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
 		fs_devices = find_fsid(disk_super->fsid,
 				       disk_super->metadata_uuid);
--
2.17.1

