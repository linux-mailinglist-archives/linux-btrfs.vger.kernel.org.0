Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA941D952
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 14:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350701AbhI3MIX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 08:08:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34522 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350686AbhI3MIW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 08:08:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E8809223C3;
        Thu, 30 Sep 2021 12:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633003598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PUakvmvd2rNC9BcBSMOI+MDbQHENL3m/7XsL0+Y/Yi0=;
        b=YPhQ2cs6xSzExxJCb3UUeH6XD5K6wCpCTzxgItg1rbFDdtRM7mw/YDpGbDkR8bKjy0AhH3
        StfTDXAaQuwB073wOIeIexkJLH0Y1ETuc8+9N4JZCy/IhX6TXXPP9Zpb+hMK6lsfQ7PSK+
        6MNvCGnk6WryOAYtRng7/kPGKWT424M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BABDB13B05;
        Thu, 30 Sep 2021 12:06:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OEE4K06oVWHDLwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 30 Sep 2021 12:06:38 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 2/3] btrfs-progs: Ignore devices representing paths in multipath
Date:   Thu, 30 Sep 2021 15:06:33 +0300
Message-Id: <20210930120634.632946-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930120634.632946-1-nborisov@suse.com>
References: <20210930120634.632946-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs-progs will happily enumerate any device which has a
btrfs filesystem on it irrespective of its type. For the majority of
use cases that's fine and there haven't been any problems with that.
However, there was a recent report that in multipath scenario when
running "btrfs fi show" after a path flap (path going down and then
coming back up) instead of the multipath device being show the device
which represents the flapped path is shown. So a multipath filesystem
might look like:

Label: none  uuid: d3c1261f-18be-4015-9fef-6b35759dfdba
        Total devices 1 FS bytes used 192.00KiB
        devid    1 size 10.00GiB used 536.00MiB path /dev/mapper/3600140501cc1f49e5364f0093869c763

/dev/mapper/xxx is actually backed by an arbitrary number of paths,
which in turn are presented to the system as ordinary scsi devices i.e
/dev/sdX. If a path flaps and a user re-runs 'btrfs fi show' the output
would look like:

Label: none  uuid: d3c1261f-18be-4015-9fef-6b35759dfdba
        Total devices 1 FS bytes used 192.00KiB
        devid    1 size 10.00GiB used 536.00MiB path /dev/sdd

This only occurs on unmounted filesystems as those are enumerated by
btrfs-progs, for mounted filesystem the kernel properly deals only with
the actual multipath device.

Turns out the output of this command is consumed by libraries and the
presence of a path device rather than the actual multipath causes
issues.

Fix this by checking for the presence of DM_MULTIPATH_DEVICE_PATH
udev attribute as multipath path devices are tagged with this attribute
by the multipath udev scripts.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

David,

I haven't renamed is_path_device to is_multipath_device as per our chat offline,
in my mind multipath is the actual /dev/mapper/XXXXX device which precisely the
device we want scanned and individual paths are what I call path devices (don't
know if this is official nomenclature) and is what we want to ignore.

 common/device-scan.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/common/device-scan.c b/common/device-scan.c
index b5bfe844104b..a1fd9f38b9df 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -14,6 +14,10 @@
  * Boston, MA 021110-1307, USA.
  */

+#ifdef STATIC_BUILD
+#undef HAVE_LIBUDEV
+#endif
+
 #include "kerncompat.h"
 #include <sys/ioctl.h>
 #include <stdlib.h>
@@ -25,6 +29,10 @@
 #include <dirent.h>
 #include <blkid/blkid.h>
 #include <uuid/uuid.h>
+#ifdef HAVE_LIBUDEV
+#include <sys/stat.h>
+#include <libudev.h>
+#endif
 #include "kernel-lib/overflow.h"
 #include "common/path-utils.h"
 #include "common/device-scan.h"
@@ -364,6 +372,42 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_hash[])
 	}
 }

+#ifdef HAVE_LIBUDEV
+static bool is_path_device(char *device_path)
+{
+	struct udev *udev = NULL;
+	struct udev_device *dev = NULL;
+	struct stat dev_stat;
+	const char *val;
+	bool ret = false;
+
+	if (stat(device_path, &dev_stat) < 0)
+		return false;
+
+	udev = udev_new();
+	if (!udev)
+		goto out;
+
+	dev = udev_device_new_from_devnum(udev, 'b', dev_stat.st_rdev);
+	if (!dev)
+		goto out;
+
+	val = udev_device_get_property_value(dev, "DM_MULTIPATH_DEVICE_PATH");
+	if (val && atoi(val) > 0)
+		ret = true;
+out:
+	udev_device_unref(dev);
+	udev_unref(udev);
+
+	return ret;
+}
+#else
+static bool is_path_device(char *device_path)
+{
+	return false;
+}
+#endif
+
 int btrfs_scan_devices(int verbose)
 {
 	int fd = -1;
@@ -394,6 +438,9 @@ int btrfs_scan_devices(int verbose)
 		/* if we are here its definitely a btrfs disk*/
 		strncpy_null(path, blkid_dev_devname(dev));

+		if (is_path_device(path))
+			continue;
+
 		fd = open(path, O_RDONLY);
 		if (fd < 0) {
 			error("cannot open %s: %m", path);
--
2.17.1

