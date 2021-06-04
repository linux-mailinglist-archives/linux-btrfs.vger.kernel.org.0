Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB7239B9C9
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 15:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhFDNZ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 09:25:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35384 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhFDNZ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 09:25:29 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 29B741FD4C;
        Fri,  4 Jun 2021 13:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622813021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ykwsvsj/4UD9pvJSW85ivXi5KhSAEHnBeHTDNsukGcQ=;
        b=c2VRykmCZfbTYrADK0JWwlhf0qe03kUbc053rdARL8VPBaU4BacISh9GbWdlcXvMKNEQvR
        WYaJ2vMg9768jpUPhi6lwB6dkNhFEbUQUMv4mN+zV3mdGk63DHQTRsFW4Dk98MCeeJBHRP
        LNfdO1Lop87/EXvtJBLdcSMhqGzMfFI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 23DA1A3B87;
        Fri,  4 Jun 2021 13:23:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9335FDB228; Fri,  4 Jun 2021 15:20:59 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: sysfs: export dev stats in devinfo directory
Date:   Fri,  4 Jun 2021 15:20:58 +0200
Message-Id: <20210604132058.11334-1-dsterba@suse.com>
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
after initializing the device, but in any case also print the validity
status.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 4b508938e728..3d4c806c4f73 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1495,11 +1495,39 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
 }
 BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
 
+static ssize_t btrfs_devinfo_stats_show(struct kobject *kobj,
+		struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	/*
+	 * Print all at once so we get a snapshot of all values from the same
+	 * time. Keep them in sync and in order of definition of
+	 * btrfs_dev_stat_values.
+	 */
+	return scnprintf(buf, PAGE_SIZE,
+		"stats_valid %d\n",
+		"write_errs %d\n"
+		"read_errs %d\n"
+		"flush_errs %d\n"
+		"corruption_errs %d\n"
+		"generation_errs %d\n",
+		!!(device->dev_stats_valid),
+		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_WRITE_ERRS),
+		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_READ_ERRS),
+		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_FLUSH_ERRS),
+		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_CORRUPTION_ERRS),
+		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_GENERATION_ERRS));
+}
+BTRFS_ATTR(devid, stats, btrfs_devinfo_stats_show);
+
 static struct attribute *devid_attrs[] = {
 	BTRFS_ATTR_PTR(devid, in_fs_metadata),
 	BTRFS_ATTR_PTR(devid, missing),
 	BTRFS_ATTR_PTR(devid, replace_target),
 	BTRFS_ATTR_PTR(devid, scrub_speed_max),
+	BTRFS_ATTR_PTR(devid, stats),
 	BTRFS_ATTR_PTR(devid, writeable),
 	NULL
 };
-- 
2.31.1

