Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4194132213D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 22:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhBVVUE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 16:20:04 -0500
Received: from smtp-34.italiaonline.it ([213.209.10.34]:53760 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231313AbhBVVUE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 16:20:04 -0500
Received: from venice.bhome ([78.12.28.43])
        by smtp-34.iol.local with ESMTPA
        id EIbml5cmb5WrZEIbwlGlog; Mon, 22 Feb 2021 22:19:20 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1614028760; bh=qQewU0/qKVrHX9ZBXxFult5WZxS86t1rXfQqT4vE/oc=;
        h=From;
        b=RTbx9KpOocL5N1yaxMxl5HIrYzqMZS0YGeK0bnaOs+TGpWzxq5d41YUBaeln65ViL
         syI01sQGA8xlEgQgrfJGa5sbqpxe9eGZPSK+p1JGpyPIChRS+AADgdLXtNhVN9a38q
         XS3E+R1RtEiYjxHIiD3MQs7YVDzrQC4fDNvQbmE0My5vJCNf9g1eoRNJv+aHio7EUM
         +OskL1A5gZXMaAJACEBu0oDYb9qKXWz4GWrsjdlav5do4QMh14wvOh+sOpqcRaIsYH
         4dCoXOkMN7/538WhIqA+0xaKWDbGio4fkLmTTcs9ei0S/9yImPGU6NwwMoFOwx/Evw
         DnllCGxmFdC+A==
X-CNFS-Analysis: v=2.4 cv=W4/96Tak c=1 sm=1 tr=0 ts=60341fd8 cx=a_exe
 a=Q5/16X4GlyvtzKxRBiE+Uw==:117 a=Q5/16X4GlyvtzKxRBiE+Uw==:17
 a=1s11hCFB_oFSRyqhbgYA:9 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 3/4] btrfs: export dev_item.type in /sys/fs/btrfs/<uuid>/devinfo/<devid>/type
Date:   Mon, 22 Feb 2021 22:19:08 +0100
Message-Id: <58bc129a69ff0e2d1f9f047e79bfb5b404b5b1cd.1614028083.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1614028083.git.kreijack@inwind.it>
References: <cover.1614028083.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCal3Sg7EakDGjxUtmmyvugb4nbwuNm54g/5a4Vt9sSbXly5L+cLCw97fO2acXZ4iHdEn+wPavqxIliwAmfOQweVtSUB1iExoEJv6Usn/OsZ3iaQHfb/
 HpFLYRd5FZUFPTJ+Mp0Iw8wcoXwa4CVjjn2L9a90GpX4sg1WrG8PE9E8iwE9+aH7LmYxQ6rz0eaGVmxjz/D7Gt8H1/P4V6Kol+b9ssFwWW7lu98EiogB84Xy
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/sysfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 6eb1c50fa98c..9b2a18911de6 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1418,11 +1418,22 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
 }
 BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
 
+static ssize_t btrfs_devinfo_type_show(struct kobject *kobj,
+					    struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%08llx\n", device->type);
+}
+BTRFS_ATTR(devid, type, btrfs_devinfo_type_show);
+
 static struct attribute *devid_attrs[] = {
 	BTRFS_ATTR_PTR(devid, in_fs_metadata),
 	BTRFS_ATTR_PTR(devid, missing),
 	BTRFS_ATTR_PTR(devid, replace_target),
 	BTRFS_ATTR_PTR(devid, writeable),
+	BTRFS_ATTR_PTR(devid, type),
 	NULL
 };
 ATTRIBUTE_GROUPS(devid);
-- 
2.30.0

