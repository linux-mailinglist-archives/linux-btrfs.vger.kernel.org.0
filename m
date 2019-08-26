Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58AE09CE7C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 13:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfHZLsj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 07:48:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:39100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727348AbfHZLsj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 07:48:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2FD92AFDD
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 11:48:38 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 4/4] btrfs: sysfs: export supported checksums
Date:   Mon, 26 Aug 2019 13:48:34 +0200
Message-Id: <20190826114834.14789-5-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190826114834.14789-1-jthumshirn@suse.de>
References: <20190826114834.14789-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.com>

Export supported checksum algorithms via sysfs.

Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

---
Changes to v2:
- Prevent possible overflow of sysfs attribute
Changes to v1:
- Removed btrfs_checksums_store() function (Nik)
- Renamed sysfs file to supported_checksums
---
 fs/btrfs/sysfs.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index f6d3c80f2e28..cae9c99253c7 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -246,6 +246,24 @@ static umode_t btrfs_feature_visible(struct kobject *kobj,
 	return mode;
 }
 
+static ssize_t btrfs_supported_checksums_show(struct kobject *kobj,
+					      struct kobj_attribute *a,
+					      char *buf)
+{
+	ssize_t ret = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(btrfs_csums); i++) {
+		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
+				(i == 0 ? "" : ", "),
+				btrfs_csums[i].name);
+
+	}
+
+	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	return ret;
+}
+
 BTRFS_FEAT_ATTR_INCOMPAT(mixed_backref, MIXED_BACKREF);
 BTRFS_FEAT_ATTR_INCOMPAT(default_subvol, DEFAULT_SUBVOL);
 BTRFS_FEAT_ATTR_INCOMPAT(mixed_groups, MIXED_GROUPS);
@@ -259,6 +277,14 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 
+static struct btrfs_feature_attr btrfs_attr_features_checksums_name = {
+	.kobj_attr = __INIT_KOBJ_ATTR(supported_checksums, S_IRUGO,
+				      btrfs_supported_checksums_show,
+				      NULL),
+	.feature_set	= FEAT_INCOMPAT,
+	.feature_bit	= 0,
+};
+
 static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(mixed_backref),
 	BTRFS_FEAT_ATTR_PTR(default_subvol),
@@ -272,6 +298,9 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(no_holes),
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
+
+	&btrfs_attr_features_checksums_name.kobj_attr.attr,
+
 	NULL
 };
 
-- 
2.16.4

