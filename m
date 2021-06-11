Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8623A4322
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 15:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhFKNlH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 09:41:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39894 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhFKNlG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 09:41:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F26E82199C;
        Fri, 11 Jun 2021 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623418747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2bZT0Yp1evBZn7l5BsX4NdOcO+PvrvPSJN3LNN9+C04=;
        b=J+0OzaYVOIqPJ4cWpBFTX8sYiNQ/ZqXi44JHLw94gyCxt1yqr7fJTY+zryLV5Dm/CyD/ws
        zDur1LvuvjdkArRwh4D0NGPcbLBUjNj9CGpmWLXxDzpoxQUGaMIOowKdPanCSeaMzgpAue
        EZcUnzjXUwFTQ5y080Pe3sjfPkzySWE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E74DDA3BBB;
        Fri, 11 Jun 2021 13:39:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E1EE0DA77B; Fri, 11 Jun 2021 15:36:22 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, anand.jain@oracle.com,
        osandov@osandov.com
Subject: [PATCH v2] btrfs: sysfs: export dev stats in devinfo directory
Date:   Fri, 11 Jun 2021 15:36:22 +0200
Message-Id: <20210611133622.12282-1-dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The device stats can be read by ioctl, wrapped by command 'btrfs device
stats'. Provide another source where to read the information in
/sys/fs/btrfs/FSID/devinfo/DEVID/stats . The format is a list of
'key value' pairs one per line, which is common in other stat files.
The names are the same as used in other device stat outputs.

The stats are all in one file as it's the snapshot of all available
stats. The 'one value per file' is not very suitable here. The stats
should be valid right after the stats item is read from disk, shortly
after initializing the device.

In case the stats are not yet valid, print just 'invalid' as the file
contents.

Signed-off-by: David Sterba <dsterba@suse.com>
---

v2:
- print 'invalid' separtely and not among the values
- rename file name to 'error_stats' to leave 'stats' available for any
  other kind of stats we'd like in the future

 fs/btrfs/sysfs.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 4b508938e728..ebde1d09e686 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1495,7 +1495,36 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
 }
 BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
 
+static ssize_t btrfs_devinfo_error_stats_show(struct kobject *kobj,
+		struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	if (!device->dev_stats_valid)
+		return scnprintf(buf, PAGE_SIZE, "invalid\n");
+
+	/*
+	 * Print all at once so we get a snapshot of all values from the same
+	 * time. Keep them in sync and in order of definition of
+	 * btrfs_dev_stat_values.
+	 */
+	return scnprintf(buf, PAGE_SIZE,
+		"write_errs %d\n"
+		"read_errs %d\n"
+		"flush_errs %d\n"
+		"corruption_errs %d\n"
+		"generation_errs %d\n",
+		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_WRITE_ERRS),
+		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_READ_ERRS),
+		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_FLUSH_ERRS),
+		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_CORRUPTION_ERRS),
+		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_GENERATION_ERRS));
+}
+BTRFS_ATTR(devid, error_stats, btrfs_devinfo_error_stats_show);
+
 static struct attribute *devid_attrs[] = {
+	BTRFS_ATTR_PTR(devid, error_stats),
 	BTRFS_ATTR_PTR(devid, in_fs_metadata),
 	BTRFS_ATTR_PTR(devid, missing),
 	BTRFS_ATTR_PTR(devid, replace_target),
-- 
2.31.1

