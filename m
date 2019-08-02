Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 442597FB45
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 15:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436521AbfHBNj6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 09:39:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:60218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436519AbfHBNj6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 09:39:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 579D2B62C
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2019 13:39:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3BE9BDADC0; Fri,  2 Aug 2019 15:40:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 13/13] btrfs: sysfs: move type conversion helpers to sysfs.c
Date:   Fri,  2 Aug 2019 15:40:31 +0200
Message-Id: <cfe92f777eb72d5f2e8d13f565c222d54f0bc682.1564752900.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564752900.git.dsterba@suse.com>
References: <cover.1564752900.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c | 17 +++++++++++++++++
 fs/btrfs/sysfs.h | 18 ------------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e306e6e173cf..335450ad9d2d 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -69,6 +69,23 @@ static struct btrfs_feature_attr btrfs_attr_features_##_name = {	     \
 static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj);
 static inline struct btrfs_fs_devices *to_fs_devs(struct kobject *kobj);
 
+/* convert from attribute */
+static struct btrfs_feature_attr *to_btrfs_feature_attr(struct kobj_attribute *a)
+{
+	return container_of(a, struct btrfs_feature_attr, kobj_attr);
+}
+
+static struct kobj_attribute *attr_to_btrfs_attr(struct attribute *attr)
+{
+	return container_of(attr, struct kobj_attribute, attr);
+}
+
+static struct btrfs_feature_attr *attr_to_btrfs_feature_attr(
+		struct attribute *attr)
+{
+	return to_btrfs_feature_attr(attr_to_btrfs_attr(attr));
+}
+
 static u64 get_features(struct btrfs_fs_info *fs_info,
 			enum btrfs_feature_set set)
 {
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index ab0ea53b7d4b..b8513c5fb2b0 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -17,24 +17,6 @@ enum btrfs_feature_set {
 	FEAT_MAX
 };
 
-/* convert from attribute */
-static inline struct btrfs_feature_attr *
-to_btrfs_feature_attr(struct kobj_attribute *a)
-{
-	return container_of(a, struct btrfs_feature_attr, kobj_attr);
-}
-
-static inline struct kobj_attribute *attr_to_btrfs_attr(struct attribute *attr)
-{
-	return container_of(attr, struct kobj_attribute, attr);
-}
-
-static inline struct btrfs_feature_attr *
-attr_to_btrfs_feature_attr(struct attribute *attr)
-{
-	return to_btrfs_feature_attr(attr_to_btrfs_attr(attr));
-}
-
 char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags);
 const char * const btrfs_feature_set_name(enum btrfs_feature_set set);
 int btrfs_sysfs_add_device_link(struct btrfs_fs_devices *fs_devices,
-- 
2.22.0

