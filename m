Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD6136CC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 13:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgAJMLk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 07:11:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:35300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbgAJMLj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 07:11:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3502BAE92;
        Fri, 10 Jan 2020 12:11:38 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/4] btrfs: Handle another split brain scenario with metadata uuid feature
Date:   Fri, 10 Jan 2020 14:11:34 +0200
Message-Id: <20200110121135.7386-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110121135.7386-1-nborisov@suse.com>
References: <20200110121135.7386-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is one more cases which isn't handled by the original metadata
uuid work. Namely, when a filesystem has METADATA_UUID incompat bit and
the user decides to change the FSID to the original one e.g. have
metadata_uuid and fsid match. In case of power failure while this
operation is in progress we could end up in a situation where some of
the disks have the incompat bit removed and the other half have both
METADATA_UUID_INCOMPAT and FSID_CHANGING_IN_PROGRESS flags.

This patch handles the case where a disk that has successfully changed
its FSID such that it equals METADATA_UUID is scanned first.
Subsequently when a disk with both
METADATA_UUID_INCOMPAT/FSID_CHANGING_IN_PROGRESS flags is scanned
find_fsid_changed won't be able to find an appropriate btrfs_fs_devices.
This is done by extending find_fsid_changed to correctly find
btrfs_fs_devices whose metadata_uuid/fsid are the same and they match
the metadata_uuid of the currently scanned device.

Fixes: cc5de4e70256 ("btrfs: Handle final split-brain possibility during fsid change")
Reported-by: Su Yue <Damenly_Su@gmx.com>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 90e5ed5f5364..7739d40939bf 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -709,17 +709,26 @@ static struct btrfs_fs_devices *find_fsid_changed(
 	/*
 	 * Handles the case where scanned device is part of an fs that had
 	 * multiple successful changes of FSID but curently device didn't
-	 * observe it. Meaning our fsid will be different than theirs.
+	 * observe it. Meaning our fsid will be different than theirs. We need
+	 * to handle two subcases :
+	 *  1 - The fs still continues to have different METADATA/FSID uuids.
+	 *  2 - The fs is switched back to its original FSID (METADATA/FSID
+	 *  are equal).
 	 */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
-			   BTRFS_FSID_SIZE) != 0 &&
-		    memcmp(fs_devices->metadata_uuid, disk_super->metadata_uuid,
-			   BTRFS_FSID_SIZE) == 0 &&
-		    memcmp(fs_devices->fsid, disk_super->fsid,
-			   BTRFS_FSID_SIZE) != 0) {
+		bool changed_fsdevices =
+			memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
+			       BTRFS_FSID_SIZE) != 0 &&
+			memcmp(fs_devices->metadata_uuid,
+			       disk_super->metadata_uuid, BTRFS_FSID_SIZE) == 0 &&
+			memcmp(fs_devices->fsid, disk_super->fsid, BTRFS_FSID_SIZE) != 0;
+
+		bool unchanged_fsdevices =
+			memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
+						  BTRFS_FSID_SIZE) == 0 &&
+			memcmp(fs_devices->fsid, disk_super->metadata_uuid, BTRFS_FSID_SIZE) == 0;
+		if (changed_fsdevices || unchanged_fsdevices)
 			return fs_devices;
-		}
 	}

 	return NULL;
--
2.17.1
find_fsid_changed
