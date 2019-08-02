Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF447FB44
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 15:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436517AbfHBNj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 09:39:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:60168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404226AbfHBNj4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 09:39:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C63AB62C
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2019 13:39:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DD1EEDADC0; Fri,  2 Aug 2019 15:40:28 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 12/13] btrfs: sysfs: move helper macros to sysfs.c
Date:   Fri,  2 Aug 2019 15:40:28 +0200
Message-Id: <70d63845f687c17b9e152f4d7f9aa9b7f2a08293.1564752900.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564752900.git.dsterba@suse.com>
References: <cover.1564752900.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

None of the macros is used outside of sysfs.c.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/sysfs.h | 50 ------------------------------------------------
 2 files changed, 49 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 624ab9e29e21..e306e6e173cf 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -17,6 +17,55 @@
 #include "volumes.h"
 #include "space-info.h"
 
+struct btrfs_feature_attr {
+	struct kobj_attribute kobj_attr;
+	enum btrfs_feature_set feature_set;
+	u64 feature_bit;
+};
+
+/* For raid type sysfs entries */
+struct raid_kobject {
+	u64 flags;
+	struct kobject kobj;
+	struct list_head list;
+};
+
+#define __INIT_KOBJ_ATTR(_name, _mode, _show, _store)			\
+{									\
+	.attr	= { .name = __stringify(_name), .mode = _mode },	\
+	.show	= _show,						\
+	.store	= _store,						\
+}
+
+#define BTRFS_ATTR_RW(_prefix, _name, _show, _store)			\
+	static struct kobj_attribute btrfs_attr_##_prefix##_##_name =	\
+			__INIT_KOBJ_ATTR(_name, 0644, _show, _store)
+
+#define BTRFS_ATTR(_prefix, _name, _show)				\
+	static struct kobj_attribute btrfs_attr_##_prefix##_##_name =	\
+			__INIT_KOBJ_ATTR(_name, 0444, _show, NULL)
+
+#define BTRFS_ATTR_PTR(_prefix, _name)					\
+	(&btrfs_attr_##_prefix##_##_name.attr)
+
+#define BTRFS_FEAT_ATTR(_name, _feature_set, _feature_prefix, _feature_bit)  \
+static struct btrfs_feature_attr btrfs_attr_features_##_name = {	     \
+	.kobj_attr = __INIT_KOBJ_ATTR(_name, S_IRUGO,			     \
+				      btrfs_feature_attr_show,		     \
+				      btrfs_feature_attr_store),	     \
+	.feature_set	= _feature_set,					     \
+	.feature_bit	= _feature_prefix ##_## _feature_bit,		     \
+}
+#define BTRFS_FEAT_ATTR_PTR(_name)					     \
+	(&btrfs_attr_features_##_name.kobj_attr.attr)
+
+#define BTRFS_FEAT_ATTR_COMPAT(name, feature) \
+	BTRFS_FEAT_ATTR(name, FEAT_COMPAT, BTRFS_FEATURE_COMPAT, feature)
+#define BTRFS_FEAT_ATTR_COMPAT_RO(name, feature) \
+	BTRFS_FEAT_ATTR(name, FEAT_COMPAT_RO, BTRFS_FEATURE_COMPAT_RO, feature)
+#define BTRFS_FEAT_ATTR_INCOMPAT(name, feature) \
+	BTRFS_FEAT_ATTR(name, FEAT_INCOMPAT, BTRFS_FEATURE_INCOMPAT, feature)
+
 static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj);
 static inline struct btrfs_fs_devices *to_fs_devs(struct kobject *kobj);
 
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index ab5e39b5496a..ab0ea53b7d4b 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -17,56 +17,6 @@ enum btrfs_feature_set {
 	FEAT_MAX
 };
 
-#define __INIT_KOBJ_ATTR(_name, _mode, _show, _store)			\
-{									\
-	.attr	= { .name = __stringify(_name), .mode = _mode },	\
-	.show	= _show,						\
-	.store	= _store,						\
-}
-
-#define BTRFS_ATTR_RW(_prefix, _name, _show, _store)			\
-	static struct kobj_attribute btrfs_attr_##_prefix##_##_name =	\
-			__INIT_KOBJ_ATTR(_name, 0644, _show, _store)
-
-#define BTRFS_ATTR(_prefix, _name, _show)				\
-	static struct kobj_attribute btrfs_attr_##_prefix##_##_name =	\
-			__INIT_KOBJ_ATTR(_name, 0444, _show, NULL)
-
-#define BTRFS_ATTR_PTR(_prefix, _name)					\
-	(&btrfs_attr_##_prefix##_##_name.attr)
-
-
-struct btrfs_feature_attr {
-	struct kobj_attribute kobj_attr;
-	enum btrfs_feature_set feature_set;
-	u64 feature_bit;
-};
-
-/* For raid type sysfs entries */
-struct raid_kobject {
-	u64 flags;
-	struct kobject kobj;
-	struct list_head list;
-};
-
-#define BTRFS_FEAT_ATTR(_name, _feature_set, _feature_prefix, _feature_bit)  \
-static struct btrfs_feature_attr btrfs_attr_features_##_name = {	     \
-	.kobj_attr = __INIT_KOBJ_ATTR(_name, S_IRUGO,			     \
-				      btrfs_feature_attr_show,		     \
-				      btrfs_feature_attr_store),	     \
-	.feature_set	= _feature_set,					     \
-	.feature_bit	= _feature_prefix ##_## _feature_bit,		     \
-}
-#define BTRFS_FEAT_ATTR_PTR(_name)					     \
-	(&btrfs_attr_features_##_name.kobj_attr.attr)
-
-#define BTRFS_FEAT_ATTR_COMPAT(name, feature) \
-	BTRFS_FEAT_ATTR(name, FEAT_COMPAT, BTRFS_FEATURE_COMPAT, feature)
-#define BTRFS_FEAT_ATTR_COMPAT_RO(name, feature) \
-	BTRFS_FEAT_ATTR(name, FEAT_COMPAT_RO, BTRFS_FEATURE_COMPAT_RO, feature)
-#define BTRFS_FEAT_ATTR_INCOMPAT(name, feature) \
-	BTRFS_FEAT_ATTR(name, FEAT_INCOMPAT, BTRFS_FEATURE_INCOMPAT, feature)
-
 /* convert from attribute */
 static inline struct btrfs_feature_attr *
 to_btrfs_feature_attr(struct kobj_attribute *a)
-- 
2.22.0

