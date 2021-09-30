Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8F641D953
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 14:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350704AbhI3MIY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 08:08:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58184 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350687AbhI3MIW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 08:08:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 320F020028;
        Thu, 30 Sep 2021 12:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633003599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TyUEU64sOaFKW+NCtgoltJ608SSindgEXrkV+f+Bma0=;
        b=igCbgSlcxqvUACHUfK2WBNfjtENrxX9VVYcOpYyiHen0E50KhzRt0bQaNUUXoR6sBDKi6f
        PqeaSXjwEoG1kixBAphEF7y0FBQjiz6oOHdjcFRIjcp7E4Tt5IbRPWRV9GHVhCqoCbkft7
        2xClpz5FWEqNShcwfXA28G3bUvHT4Cw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04BA813B05;
        Thu, 30 Sep 2021 12:06:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QPlKOk6oVWHDLwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 30 Sep 2021 12:06:38 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 3/3] btrfs-progs: Add fallback code for path device ignore for static build
Date:   Thu, 30 Sep 2021 15:06:34 +0300
Message-Id: <20210930120634.632946-4-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930120634.632946-1-nborisov@suse.com>
References: <20210930120634.632946-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since libudev doesn't provide a static version of the library for static
build btrfs-progs will have to provide manual fallback. This change does
this by parsing the udev database files hosted at /run/udev/data/.
Under that directory every block device should have a file with the
following name: bMAJ:MIN. So implement the bare minimum code necessary
to parse this file and search for the presence of DM_MULTIPATH_DEVICE_PATH
udev attribute. This could likely be racy since access to the udev
database is done outside of libudev but that's the best that can be
done when implementing this manually.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 common/device-scan.c | 55 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/common/device-scan.c b/common/device-scan.c
index a1fd9f38b9df..bcfd36fade2c 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -29,6 +29,7 @@
 #include <dirent.h>
 #include <blkid/blkid.h>
 #include <uuid/uuid.h>
+#include <sys/sysmacros.h>
 #ifdef HAVE_LIBUDEV
 #include <sys/stat.h>
 #include <libudev.h>
@@ -372,23 +373,54 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_hash[])
 	}
 }
 
-#ifdef HAVE_LIBUDEV
-static bool is_path_device(char *device_path)
+#ifdef STATIC_BUILD
+static bool is_path_device(dev_t device)
+{
+	FILE *file;
+	char *line = NULL;
+	size_t len = 0;
+	ssize_t nread;
+	bool ret = false;
+	int ret2;
+	char path[PATH_MAX];
+
+	ret2 = snprintf(path, 100, "/run/udev/data/b%u:%u", major(device),
+			minor(device));
+
+	if (ret2 < 0)
+		return false;
+
+	file = fopen(path, "r");
+	if (file == NULL)
+		return false;
+
+	while ((nread = getline(&line, &len, file)) != -1) {
+		if (strstr(line, "DM_MULTIPATH_DEVICE_PATH=1")) {
+			ret = true;
+			break;
+		}
+	}
+
+	if (line)
+		free(line);
+
+	fclose(file);
+
+	return ret;
+}
+#elif defined(HAVE_LIBUDEV)
+static bool is_path_device(dev_t device)
 {
 	struct udev *udev = NULL;
 	struct udev_device *dev = NULL;
-	struct stat dev_stat;
 	const char *val;
 	bool ret = false;
 
-	if (stat(device_path, &dev_stat) < 0)
-		return false;
-
 	udev = udev_new();
 	if (!udev)
 		goto out;
 
-	dev = udev_device_new_from_devnum(udev, 'b', dev_stat.st_rdev);
+	dev = udev_device_new_from_devnum(udev, 'b', device);
 	if (!dev)
 		goto out;
 
@@ -402,7 +434,7 @@ static bool is_path_device(char *device_path)
 	return ret;
 }
 #else
-static bool is_path_device(char *device_path)
+static bool is_path_device(dev_t device)
 {
 	return false;
 }
@@ -432,13 +464,18 @@ int btrfs_scan_devices(int verbose)
 	iter = blkid_dev_iterate_begin(cache);
 	blkid_dev_set_search(iter, "TYPE", "btrfs");
 	while (blkid_dev_next(iter, &dev) == 0) {
+		struct stat dev_stat;
+
 		dev = blkid_verify(cache, dev);
 		if (!dev)
 			continue;
 		/* if we are here its definitely a btrfs disk*/
 		strncpy_null(path, blkid_dev_devname(dev));
 
-		if (is_path_device(path))
+		if (stat(path, &dev_stat) < 0)
+			continue;
+
+		if (is_path_device(dev_stat.st_rdev))
 			continue;
 
 		fd = open(path, O_RDONLY);
-- 
2.17.1

