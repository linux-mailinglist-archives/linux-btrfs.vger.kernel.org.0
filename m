Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C032033384E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 10:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhCJJIq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 04:08:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:34620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231492AbhCJJIm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 04:08:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615367321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhxYry9B7c4mBcS/1AHL4IzReTFn42XjEB3MOL9i5d0=;
        b=IaNgxMX+++M9AVEEPh5+R6gDheFynfK8P4HhqVbeDolHv5aBcf/E3UFExGQ9k0OySlHRys
        gjQjCcL/HymTTxlr0kcC5GVhkeKAiuBuGDeNrVmM29WaD8jvVNvQjG/IV63hg+S+U9mWF7
        3Bz6SlYD3Gmyst/xzy3bGAPLQLPVts0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5181DAD74
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 09:08:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 01/15] btrfs: add sysfs interface for supported sectorsize
Date:   Wed, 10 Mar 2021 17:08:19 +0800
Message-Id: <20210310090833.105015-2-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210310090833.105015-1-wqu@suse.com>
References: <20210310090833.105015-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add extra sysfs interface features/supported_ro_sectorsize and
features/supported_rw_sectorsize to indicate subpage support.

Currently for supported_rw_sectorsize all architectures only have their
PAGE_SIZE listed.

While for supported_ro_sectorsize, for systems with 64K page size, 4K
sectorsize is also supported.

This new sysfs interface would help mkfs.btrfs to do more accurate
warning.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/sysfs.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 6eb1c50fa98c..3ef419899472 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -360,11 +360,45 @@ static ssize_t supported_rescue_options_show(struct kobject *kobj,
 BTRFS_ATTR(static_feature, supported_rescue_options,
 	   supported_rescue_options_show);
 
+static ssize_t supported_ro_sectorsize_show(struct kobject *kobj,
+					    struct kobj_attribute *a,
+					    char *buf)
+{
+	ssize_t ret = 0;
+	int i = 0;
+
+	/* For 64K page size, 4K sector size is supported */
+	if (PAGE_SIZE == SZ_64K) {
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%u", SZ_4K);
+		i++;
+	}
+	/* Other than above subpage, only support PAGE_SIZE as sectorsize yet */
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%lu\n",
+			 (i ? " " : ""), PAGE_SIZE);
+	return ret;
+}
+BTRFS_ATTR(static_feature, supported_ro_sectorsize,
+	   supported_ro_sectorsize_show);
+
+static ssize_t supported_rw_sectorsize_show(struct kobject *kobj,
+					    struct kobj_attribute *a,
+					    char *buf)
+{
+	ssize_t ret = 0;
+
+	/* Only PAGE_SIZE as sectorsize is supported */
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%lu\n", PAGE_SIZE);
+	return ret;
+}
+BTRFS_ATTR(static_feature, supported_rw_sectorsize,
+	   supported_rw_sectorsize_show);
 static struct attribute *btrfs_supported_static_feature_attrs[] = {
 	BTRFS_ATTR_PTR(static_feature, rmdir_subvol),
 	BTRFS_ATTR_PTR(static_feature, supported_checksums),
 	BTRFS_ATTR_PTR(static_feature, send_stream_version),
 	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
+	BTRFS_ATTR_PTR(static_feature, supported_ro_sectorsize),
+	BTRFS_ATTR_PTR(static_feature, supported_rw_sectorsize),
 	NULL
 };
 
-- 
2.30.1

