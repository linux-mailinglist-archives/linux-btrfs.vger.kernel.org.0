Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C91049D379
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 21:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiAZUc0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 15:32:26 -0500
Received: from michael.mail.tiscali.it ([213.205.33.246]:59470 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230423AbiAZUcW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 15:32:22 -0500
Received: from venice.bhome ([78.14.151.50])
        by michael.mail.tiscali.it with 
        id nYYG2600e15VSme01YYLMa; Wed, 26 Jan 2022 20:32:21 +0000
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
Subject: [PATCH 6/7] btrfs: add major and minor to sysfs
Date:   Wed, 26 Jan 2022 21:32:13 +0100
Message-Id: <7a8017203cb85da33302c9b9eb85c921251a31f8.1643228177.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643228177.git.kreijack@inwind.it>
References: <cover.1643228177.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1643229141; bh=UXy9HFCKUTueYPHP7sdmquri+adSS+j82PaE/CGO1+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=rcrO3IEVx8oyzek9dkjeosVzOOmfG8uAfqO20T324Fhi2OF/7H4T7URRflPIqI2un
         Vr45j4+6wbA+X828Cs61kRtZ+8N1MZ0ffdNnR6EwxoVk5xmJTdmDcdmk2QDwiTWFnm
         /4q2bGHJEf8KoBddJMvG3bj3IjGKOKWD1nTdJGq8=
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

