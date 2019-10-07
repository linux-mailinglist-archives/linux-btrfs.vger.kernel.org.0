Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 081A4CDE03
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 11:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfJGJLK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 05:11:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:38388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727472AbfJGJLJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 05:11:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 72D78B19B;
        Mon,  7 Oct 2019 09:11:07 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 3/4] btrfs: sysfs: export supported checksums
Date:   Mon,  7 Oct 2019 11:11:03 +0200
Message-Id: <20191007091104.18095-4-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191007091104.18095-1-jthumshirn@suse.de>
References: <20191007091104.18095-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.com>

Export supported checksum algorithms via sysfs.

Co-developed-by: David Sterba <dsterba@suse.com> 
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/ctree.c |  5 +++++
 fs/btrfs/ctree.h |  2 ++
 fs/btrfs/sysfs.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index b66509ee62eb..5debd74dc61c 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -53,6 +53,11 @@ const char *btrfs_super_csum_name(u16 csum_type)
 	return btrfs_csums[csum_type].name;
 }
 
+size_t btrfs_get_num_csums(void)
+{
+	return ARRAY_SIZE(btrfs_csums);
+}
+
 struct btrfs_path *btrfs_alloc_path(void)
 {
 	return kmem_cache_zalloc(btrfs_path_cachep, GFP_NOFS);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d17e79a40930..0180554f6970 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2165,6 +2165,8 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
 
 int btrfs_super_csum_size(const struct btrfs_super_block *s);
 const char *btrfs_super_csum_name(u16 csum_type);
+size_t btrfs_get_num_csums(void);
+
 
 /*
  * The leaf data grows from end-to-front in the node.
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index f6d3c80f2e28..aeebbdfe1a98 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -246,6 +246,28 @@ static umode_t btrfs_feature_visible(struct kobject *kobj,
 	return mode;
 }
 
+static ssize_t btrfs_supported_checksums_show(struct kobject *kobj,
+					      struct kobj_attribute *a,
+					      char *buf)
+{
+	ssize_t ret = 0;
+	int i;
+
+	for (i = 0; i < btrfs_get_num_csums(); i++) {
+		/*
+		 * This "trick" only works as long as 'enum btrfs_csum_type' has
+		 * no holes in it
+		 */
+		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
+				(i == 0 ? "" : ", "),
+				btrfs_super_csum_name(i));
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
@@ -259,6 +281,14 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
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
@@ -272,6 +302,9 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
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

