Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0133CDE00
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 11:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfJGJLJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 05:11:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:38394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727473AbfJGJLJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 05:11:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B4BBB1A4;
        Mon,  7 Oct 2019 09:11:07 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 4/4] btrfs: show used checksum driver per filesystem in sysfs
Date:   Mon,  7 Oct 2019 11:11:04 +0200
Message-Id: <20191007091104.18095-5-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191007091104.18095-1-jthumshirn@suse.de>
References: <20191007091104.18095-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Show the used driver for the checksum algorithm for the filesystem in
sysfs.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/sysfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index aeebbdfe1a98..11a3cf7f563e 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -9,6 +9,7 @@
 #include <linux/spinlock.h>
 #include <linux/completion.h>
 #include <linux/bug.h>
+#include <crypto/hash.h>
 
 #include "ctree.h"
 #include "disk-io.h"
@@ -637,6 +638,19 @@ static ssize_t btrfs_metadata_uuid_show(struct kobject *kobj,
 
 BTRFS_ATTR(, metadata_uuid, btrfs_metadata_uuid_show);
 
+static ssize_t btrfs_checksum_show(struct kobject *kobj,
+				   struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+	u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
+
+	return snprintf(buf, PAGE_SIZE, "%s (%s)\n",
+			btrfs_super_csum_name(csum_type),
+			crypto_shash_driver_name(fs_info->csum_shash));
+}
+
+BTRFS_ATTR(, checksum, btrfs_checksum_show);
+
 static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, label),
 	BTRFS_ATTR_PTR(, nodesize),
@@ -644,6 +658,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, clone_alignment),
 	BTRFS_ATTR_PTR(, quota_override),
 	BTRFS_ATTR_PTR(, metadata_uuid),
+	BTRFS_ATTR_PTR(, checksum),
 	NULL,
 };
 
-- 
2.16.4

