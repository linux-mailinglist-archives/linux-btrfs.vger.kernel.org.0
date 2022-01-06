Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B75048692C
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 18:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242466AbiAFRtq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 12:49:46 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:56282 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242406AbiAFRtd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 12:49:33 -0500
Received: from venice.bhome ([84.220.25.125])
        by santino.mail.tiscali.it with 
        id fVpV2600Z2hwt0401VpYUn; Thu, 06 Jan 2022 17:49:33 +0000
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
Subject: [PATCH 2/6] btrfs: export the device allocation_hint property in sysfs
Date:   Thu,  6 Jan 2022 18:49:19 +0100
Message-Id: <f288e56ad6ea20f864826ba1c8f57b4f224607bd.1641486794.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641486794.git.kreijack@inwind.it>
References: <cover.1641486794.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1641491373; bh=w00/BdbSia/2z7YnoS/DYr9Oxygds2jIgIPTDlJo5yQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=mQJVS1T8r8ALdikG2T0xJrJpUSyoda8PFNTIV1GKYWrNDcnUQCSxUa7eWe28kDJfE
         wkmQwCAvd+/dqx5KpEGQggJ3rdwRr0J2Oqc9VUJOHyDNFpHVW5tLPV2lmOZsfthS4K
         jWi/Vmzz17TbQBijINn9SIqsipf8migZ5pTx5Yyk=
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
index beb7f72d50b8..c1c903187e19 100644
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
+		device->type & BTRFS_DEV_ALLOCATION_HINT_MASK);
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

