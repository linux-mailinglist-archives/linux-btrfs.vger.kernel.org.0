Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A40D475AF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 15:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbhLOOqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 09:46:42 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42256 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhLOOqm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 09:46:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 169011F387;
        Wed, 15 Dec 2021 14:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639579601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ez1qCWjqZje11RxowGHNFV13SvOeN5KvUL7KdTGG3mA=;
        b=WxsJ7EsofNPw4C0aZHWHTqRZTzKjGh36KZCI5e3CqYntfQUChqVE1zht8vkHGYh+TSs+9b
        rRGgnpmEbVX++1gjN1GvlmPsG11bGNUu8mdj9opGz7iulK5WipgAYe1ItlGHvvXtlT2GGR
        6SZp4wIP0cwEPyTtA4uHg3ewKANzZRY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA7B31330B;
        Wed, 15 Dec 2021 14:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ETPQMtD/uWH9cQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 15 Dec 2021 14:46:40 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Create sysfs entries only for non-stale devices
Date:   Wed, 15 Dec 2021 16:46:39 +0200
Message-Id: <20211215144639.876776-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently /sys/fs/btrfs/<uuid>/devinfo/<devid> entry is always created
for a device present in btrfs_fs_devices on the other hand
/sys/fs/btrfs/<uuid>/devices/<devname> sysfs link is created only when
the given btrfs_device::bdisk member is populated. This can lead to
cases where a filesystem consisting of 2 device, one of which is stale
ends up having 2 entries under /sys/fs/btrfs/<uuid>/devinfo/<devid>
but only one under /sys/fs/btrfs/<uuid>/devices/<devname>.

Another case that occurs is if a filesystem initially occupied 2
devices, then got unmounted, and a new filesystem is created, which
occupies a single device but with the same UUID as the one occupying 2
devices. In this case /sys/fs/btrfs/<uuid>/devices/<devname> will
correctly have 1 entry but /sys/fs/btrfs/<uuid>/devices/<devname> will
incorrectly has 2. This behavior is demonstrated by the following
script:

    UUID=292afefb-6e8c-4fb3-9d12-8c4ecb1f2374
    rm /tmp/d1
    rm /tmp/d2
    truncate -s 1G /tmp/d1
    truncate -s 1G /tmp/d2
    sudo losetup /dev/loop1 /tmp/d1
    sudo losetup /dev/loop2 /tmp/d2
    sudo mkfs.btrfs -U $UUID /dev/loop1 /dev/loop2
    sudo mount /dev/loop1 /mnt/btrfs1
    sudo umount /dev/loop1
    sudo losetup -d /dev/loop2
    sudo losetup -d /dev/loop1

    # create a new filesystem with only ONE loop-device; mount it
    rm /tmp/d1
    truncate -s 1G /tmp/d1
    sudo losetup /dev/loop1 /tmp/d1
    sudo mkfs.btrfs -U $UUID /dev/loop1
    sudo mount /dev/loop1 /mnt/btrfs1

Fix this by ensuring that device sysfs attributes are only added for
devices which are actually present at the time of mount.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/sysfs.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index beb7f72d50b8..e2e110d7798a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -12,6 +12,7 @@
 #include <crypto/hash.h>
 
 #include "ctree.h"
+#include "rcu-string.h"
 #include "discard.h"
 #include "disk-io.h"
 #include "send.h"
@@ -1611,9 +1612,13 @@ int btrfs_sysfs_add_device(struct btrfs_device *device)
 {
 	int ret;
 	unsigned int nofs_flag;
+	struct kobject *disk_kobj;
 	struct kobject *devices_kobj;
 	struct kobject *devinfo_kobj;
 
+	if (!device->bdev)
+		return 0;
+
 	/*
 	 * Make sure we use the fs_info::fs_devices to fetch the kobjects even
 	 * for the seed fs_devices
@@ -1625,16 +1630,14 @@ int btrfs_sysfs_add_device(struct btrfs_device *device)
 
 	nofs_flag = memalloc_nofs_save();
 
-	if (device->bdev) {
-		struct kobject *disk_kobj = bdev_kobj(device->bdev);
+	disk_kobj = bdev_kobj(device->bdev);
 
-		ret = sysfs_create_link(devices_kobj, disk_kobj, disk_kobj->name);
-		if (ret) {
-			btrfs_warn(device->fs_info,
-				"creating sysfs device link for devid %llu failed: %d",
-				device->devid, ret);
-			goto out;
-		}
+	ret = sysfs_create_link(devices_kobj, disk_kobj, disk_kobj->name);
+	if (ret) {
+		btrfs_warn(device->fs_info,
+			   "creating sysfs device link for devid %llu failed: %d",
+			   device->devid, ret);
+		goto out;
 	}
 
 	init_completion(&device->kobj_unregister);
-- 
2.25.1

