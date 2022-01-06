Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B467B48692D
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 18:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbiAFRtq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 12:49:46 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:56256 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242424AbiAFRtf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 12:49:35 -0500
Received: from venice.bhome ([84.220.25.125])
        by santino.mail.tiscali.it with 
        id fVpV2600Z2hwt0401VpaWQ; Thu, 06 Jan 2022 17:49:34 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 6/6] btrfs: add major and minor to sysfs
Date:   Thu,  6 Jan 2022 18:49:23 +0100
Message-Id: <cfa9f1dff99cedc19524c66c0e2b83efb9a5e381.1641486794.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641486794.git.kreijack@inwind.it>
References: <cover.1641486794.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1641491374; bh=UXy9HFCKUTueYPHP7sdmquri+adSS+j82PaE/CGO1+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=ssC/Ml08fuv8gBRhgjObvLCXqCO29aRtsJWjrxrIjD6fR6doj2z/X+32zl1yB0Alr
         auo882ELLTDleyyq2OZxhTvbJ0XkAnHDPHqIYTCyt2NY9AgK/9b3637XThBNCGKGuW
         OdnyEk9EJXhykSFbtdFttVgp27DDVugt2ub4hs0I=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Add the following property to btrfs sysfs

/sysfs/fs/btrfs/<UUID>/devinfo/<devid>/major_minor

This would help to figure out which block device is involved in
which filesystem.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/sysfs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 42921432c9dc..dee23669a00f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1647,6 +1647,22 @@ BTRFS_ATTR_RW(devid, allocation_hint, btrfs_devinfo_allocation_hint_show,
 				      btrfs_devinfo_allocation_hint_store);
 
 
+static ssize_t btrfs_devinfo_major_minor_show(struct kobject *kobj,
+					struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	if (device->bdev)
+		return scnprintf(buf, PAGE_SIZE, "%d:%d\n",
+			MAJOR(device->bdev->bd_dev),
+			MINOR(device->bdev->bd_dev));
+	else
+		return scnprintf(buf, PAGE_SIZE, "N/A\n");
+}
+
+BTRFS_ATTR(devid, major_minor, btrfs_devinfo_major_minor_show);
+
 /*
  * Information about one device.
  *
@@ -1661,6 +1677,7 @@ static struct attribute *devid_attrs[] = {
 	BTRFS_ATTR_PTR(devid, scrub_speed_max),
 	BTRFS_ATTR_PTR(devid, writeable),
 	BTRFS_ATTR_PTR(devid, allocation_hint),
+	BTRFS_ATTR_PTR(devid, major_minor),
 	NULL
 };
 ATTRIBUTE_GROUPS(devid);
-- 
2.34.1

