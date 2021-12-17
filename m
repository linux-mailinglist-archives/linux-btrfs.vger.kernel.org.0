Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB1F479458
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 19:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhLQSwW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 13:52:22 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:52998 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240501AbhLQSwV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 13:52:21 -0500
Received: from venice.bhome ([78.12.25.242])
        by santino.mail.tiscali.it with 
        id XWnP2601f5DQHji01WnRqE; Fri, 17 Dec 2021 18:47:25 +0000
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
        Paul Jones <paul@pauljones.id.au>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 2/6] btrfs: export the device allocation_hint property in sysfs
Date:   Fri, 17 Dec 2021 19:47:18 +0100
Message-Id: <9a3c5371722ab7d10e2eb974c53d07eba53400a5.1639766364.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1639766364.git.kreijack@inwind.it>
References: <cover.1639766364.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1639766845; bh=/QHeyDz0Pq3haR9fuw3N6nrUgmQ9LDw+7pDkGvAZe7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=SwmVV3RiVe7r0umSVPHhyhVkaB30Apn8RZgyEGYjCybfckYpeG5KS4h3ivWOL+3Hr
         nSnfDdj8oWinJLs0nUW4ikyo455P/A7zINIGpMC5/SQfF7zPFqqlnpbwmQqNvqEn8U
         GmPvk5c4ikkCUo/Ra3UwBN5RzlgcXY8mJxauIgvE=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Eport the device allocation_hint property via
/sys/fs/btrfs/<uuid>/devinfo/<devid>/allocation_hint

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/sysfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index beb7f72d50b8..a8d918700d2b 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1575,6 +1575,17 @@ static ssize_t btrfs_devinfo_error_stats_show(struct kobject *kobj,
 }
 BTRFS_ATTR(devid, error_stats, btrfs_devinfo_error_stats_show);
 
+static ssize_t btrfs_devinfo_allocation_hint_show(struct kobject *kobj,
+					struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%08llx\n",
+		device->type & BTRFS_DEV_ALLOCATION_HINT_MASK );
+}
+BTRFS_ATTR(devid, allocation_hint, btrfs_devinfo_allocation_hint_show);
+
 /*
  * Information about one device.
  *
@@ -1588,6 +1599,7 @@ static struct attribute *devid_attrs[] = {
 	BTRFS_ATTR_PTR(devid, replace_target),
 	BTRFS_ATTR_PTR(devid, scrub_speed_max),
 	BTRFS_ATTR_PTR(devid, writeable),
+	BTRFS_ATTR_PTR(devid, allocation_hint),
 	NULL
 };
 ATTRIBUTE_GROUPS(devid);
-- 
2.34.1

