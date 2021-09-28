Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481F041AF21
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 14:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbhI1MjP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 08:39:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54910 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbhI1MjP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 08:39:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 67CF220213;
        Tue, 28 Sep 2021 12:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632832652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/2Y1khj2rbBB6FR0MyshfdnpoQEpNPcfGag2w1vcBEU=;
        b=DUpl9mgNG7P0N9YGP1aGOTTIQveRV6kfoZj0mWCvou+dTqSHSE9asgp8qu5OAtNTLrS7aZ
        qPpC7Pdy8c4OWevdoWQxZu1bJ/DVUIm2Lj/D540puvpFIHCXteertRPFJY+NZykgYUFzGg
        2+PvIGiGJaXCmD40UobVPXJfSlvp7x0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 399EA13A82;
        Tue, 28 Sep 2021 12:37:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yHStC4wMU2GLCwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 28 Sep 2021 12:37:32 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs-progs: Ignore path devices during scan - static build support
Date:   Tue, 28 Sep 2021 15:37:30 +0300
Message-Id: <20210928123730.393551-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210928123730.393551-1-nborisov@suse.com>
References: <20210928123730.393551-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since libudev doesn't provide a static version of the library for static
build btrfs-progs will have to provide manual fallback. THis change does
exactly this by parsing the udev database files hosted /run/udev/data/.
Under that directory every block device should have a file with the
following name: bMAJ:MIN. So implement the bare minimum code necessary
to parse this file and search for the presence of DM_MULTIPATH_DEVICE_PATH
udev attribute. This could likely be racy since access to the udev
database is done outside of libudev but that's the best that can be
done when implementing this manually.

To reduce duplication of code also factor out the specifics of
is_path_device to __is_path_device which will contain the appropriate
implementation according to the build mode (i.e relying on libudev in
case of normal build or manual fall back code in case of static build)
or simply utilize the old logic (in case of a normal build and libudev
missing).

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 common/device-scan.c | 66 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 9 deletions(-)

diff --git a/common/device-scan.c b/common/device-scan.c
index 2ed0e34d3664..9779dd1aedf3 100644
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
@@ -372,23 +373,56 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_hash[])
 	}
 }
 
-#ifdef HAVE_LIBUDEV
-static bool is_path_device(char *device_path)
+#ifdef STATIC_BUILD
+static bool __is_path_device(dev_t dev)
+{
+	FILE *file;
+	char *line = NULL;
+	size_t len = 0;
+	ssize_t nread;
+	bool ret = false;
+	int ret2;
+	struct stat dev_stat;
+	char path[100];
+
+	ret2 = snprintf(path, 100, "/run/udev/data/b%u:%u", major(dev_stat.st_rdev),
+			minor(dev_stat.st_rdev));
+
+	if (ret2 >= 100 || ret2 < 0)
+		return false;
+
+	file = fopen(path, "r");
+	if (file == NULL)
+		return false;
+
+	while ((nread = getline(&line, &len, file)) != -1) {
+		if (strstr(line, "DM_MULTIPATH_DEVICE_PATH=1")) {
+			ret = true;
+			printf("found dm multipath line: %s\n", line);
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
+static bool __is_path_device(dev_t device)
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
 
@@ -401,8 +435,24 @@ static bool is_path_device(char *device_path)
 
 	return ret;
 }
+#else
+static bool __is_path_device(dev_t device)
+{
+	return false;
+}
 #endif
 
+static bool is_path_device(char *device_path)
+{
+	struct stat dev_stat;
+
+	if (stat(device_path, &dev_stat) < 0)
+		return false;
+
+	return __is_path_device(dev_stat.st_rdev);
+
+}
+
 int btrfs_scan_devices(int verbose)
 {
 	int fd = -1;
@@ -433,10 +483,8 @@ int btrfs_scan_devices(int verbose)
 		/* if we are here its definitely a btrfs disk*/
 		strncpy_null(path, blkid_dev_devname(dev));
 
-#ifdef HAVE_LIBUDEV
 		if (is_path_device(path))
 			continue;
-#endif
 
 		fd = open(path, O_RDONLY);
 		if (fd < 0) {
-- 
2.17.1

