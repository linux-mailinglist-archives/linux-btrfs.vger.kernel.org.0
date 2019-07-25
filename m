Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3654E749F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 11:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403764AbfGYJeK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 05:34:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:52318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390581AbfGYJeK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 05:34:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C627AE65
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2019 09:34:09 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [RFC PATCH 4/4] btrfs: sysfs: export supported checksums
Date:   Thu, 25 Jul 2019 11:33:51 +0200
Message-Id: <e377ded65e4f2799776596ead308658710e4c8c1.1564046812.git.jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1564046812.git.jthumshirn@suse.de>
References: <cover.1564046812.git.jthumshirn@suse.de>
In-Reply-To: <cover.1564046812.git.jthumshirn@suse.de>
References: <cover.1564046812.git.jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.com>

Export supported checksum algorithms via sysfs.

Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/sysfs.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 9539f8143b7a..920282a3452b 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -182,6 +182,30 @@ static umode_t btrfs_feature_visible(struct kobject *kobj,
 	return mode;
 }
 
+static ssize_t btrfs_checksums_show(struct kobject *kobj,
+				       struct kobj_attribute *a, char *buf)
+{
+	ssize_t ret = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(btrfs_csums); i++) {
+		ret += snprintf(buf + ret, PAGE_SIZE, "%s%s",
+				(i == 0 ? "" : ", "),
+				btrfs_csums[i].name);
+
+	}
+
+	ret += snprintf(buf + ret, PAGE_SIZE, "\n");
+	return ret;
+}
+
+static ssize_t btrfs_checksums_store(struct kobject *kobj,
+					struct kobj_attribute *a,
+					const char *buf, size_t count)
+{
+	return -EPERM;
+}
+
 BTRFS_FEAT_ATTR_INCOMPAT(mixed_backref, MIXED_BACKREF);
 BTRFS_FEAT_ATTR_INCOMPAT(default_subvol, DEFAULT_SUBVOL);
 BTRFS_FEAT_ATTR_INCOMPAT(mixed_groups, MIXED_GROUPS);
@@ -195,6 +219,14 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 
+static struct btrfs_feature_attr btrfs_attr_features_checksums_name = {
+	.kobj_attr = __INIT_KOBJ_ATTR(checksums, S_IRUGO,
+				      btrfs_checksums_show,
+				      btrfs_checksums_store),
+	.feature_set	= FEAT_INCOMPAT,
+	.feature_bit	= 0,
+};
+
 static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(mixed_backref),
 	BTRFS_FEAT_ATTR_PTR(default_subvol),
@@ -208,6 +240,9 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
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

