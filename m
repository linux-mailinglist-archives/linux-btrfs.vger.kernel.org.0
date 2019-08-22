Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B26599F54
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390392AbfHVTDJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:03:09 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35055 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731910AbfHVTDJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:03:09 -0400
Received: by mail-yw1-f68.google.com with SMTP id g19so2846667ywe.2
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2yhcalcO46fpfNDyxdD+0q3fJKu8Fzb8zmEgrpZ4TD8=;
        b=nS7fv5RncGX3Jo1yRZCTHw7Bh4IePORHFN9DYY95qWwsnLkcoEsk+SweR7oTewCfdd
         1evxUJGMRW4D1W7XJ6Caeb/GL6Ud8CAjLyusAuQySYt3zbgykOaK0Ee+DzKzSqtijfmk
         i+wMZYdC8b6G58EgO7f5aO5gYq70i1UUhskMHxLRYvNG+cj4EsCQuG4CKXTfDTO4hkb7
         yG7h9/lU6JQWmu+Jp2YemfN0KhGOBvo4MMbP1d2l9JW8/BxgxS1LttjR4YJF95khnF8U
         Av6+oaOXOJrEl+YBRTYD3iK/RoVgvdRHHKyrfaEcA0JNoh/ZalMt9vnqsLDMUBaiFmQQ
         WevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2yhcalcO46fpfNDyxdD+0q3fJKu8Fzb8zmEgrpZ4TD8=;
        b=bsFML5srF9LsqjrrMQUJI5IzzLRr14pAAkXS+vRpidWCPx6DRwA24IWG+6bvwkNsl6
         tXi8eoAJ7i7HUfRIF93b+chwB5UYEMDZhqH05bwH8WhUtfs3dApJ9ipJHFCJWU2xJ2sf
         Rkt5dFItMBJQYVoBH6mkaXewe6/flM6OfYVwRagX+WCNzB/aqAR9caySmYW7JbhbBaU5
         IEvE0msRL3MIL+sQIzXQB23xocvY6TR8LYNEnGzEXR/FOi3SVLOugtsTSAiGMtxwfk9u
         gUJlOD0AkJl2KrHANl8nL6yVzcmr1Q2+U3gEjUlJwGTuvWoVRVPfLsJBEWVi3ezHzqzj
         QsUQ==
X-Gm-Message-State: APjAAAUQqU15EhRO5yPu/7pzZWSv0AWi+t2c8X8+1CrSkYUnqIzgEcee
        EHxnnQd6SF4KbOPSd/or5JUJRIo1XYZZuA==
X-Google-Smtp-Source: APXvYqyfSUK7Zs2aFVc9c4CqgLO288Mf1wFoW5r3Nc7u1lgpAzJuucR6BVXDALs6aNg+SVbnJe1/YA==
X-Received: by 2002:a81:350b:: with SMTP id c11mr639646ywa.123.1566500588113;
        Thu, 22 Aug 2019 12:03:08 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b202sm113612ywb.78.2019.08.22.12.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:03:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][RESEND] btrfs: add a force_chunk_alloc to space_info's sysfs
Date:   Thu, 22 Aug 2019 15:03:05 -0400
Message-Id: <20190822190305.13673-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In testing various things such as the btrfsck patch to detect over
allocation of chunks, empty block group deletion, and balance I've had
various ways to force chunk allocations for debug purposes.  Add a sysfs
file to enable forcing of chunk allocation for the owning space info in
order to enable us to add testcases in the future to test these various
features easier.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/sysfs.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index f6d3c80f2e28..c290a0cd37d2 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -68,6 +68,7 @@ static struct btrfs_feature_attr btrfs_attr_features_##_name = {	     \
 
 static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj);
 static inline struct btrfs_fs_devices *to_fs_devs(struct kobject *kobj);
+static inline struct kobject *get_btrfs_kobj(struct kobject *kobj);
 
 static struct btrfs_feature_attr *to_btrfs_feature_attr(struct kobj_attribute *a)
 {
@@ -405,6 +406,58 @@ static struct kobj_type btrfs_raid_ktype = {
 	.default_groups = raid_groups,
 };
 
+static ssize_t btrfs_space_info_force_chunk_alloc_show(struct kobject *kobj,
+						       struct kobj_attribute *a,
+						       char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0\n");
+}
+
+static ssize_t btrfs_space_info_force_chunk_alloc(struct kobject *kobj,
+						  struct kobj_attribute *a,
+						  const char *buf, size_t len)
+{
+	struct btrfs_space_info *space_info = to_space_info(kobj);
+	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
+	struct btrfs_trans_handle *trans;
+	unsigned long val;
+	int ret;
+
+	if (!fs_info) {
+		printk(KERN_ERR "couldn't get fs_info\n");
+		return -EPERM;
+	}
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (sb_rdonly(fs_info->sb))
+		return -EROFS;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	/*
+	 * We don't really care, but if we echo 0 > force it seems silly to do
+	 * anything.
+	 */
+	if (val == 0)
+		return -EINVAL;
+
+	trans = btrfs_start_transaction(fs_info->extent_root, 0);
+	if (!trans)
+		return PTR_ERR(trans);
+	ret = btrfs_force_chunk_alloc(trans, space_info->flags);
+	btrfs_end_transaction(trans);
+	if (ret == 1)
+		return len;
+	return -ENOSPC;
+}
+BTRFS_ATTR_RW(space_info, force_chunk_alloc,
+	      btrfs_space_info_force_chunk_alloc_show,
+	      btrfs_space_info_force_chunk_alloc);
+
 #define SPACE_INFO_ATTR(field)						\
 static ssize_t btrfs_space_info_show_##field(struct kobject *kobj,	\
 					     struct kobj_attribute *a,	\
@@ -447,6 +500,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
 	BTRFS_ATTR_PTR(space_info, total_bytes_pinned),
+	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
 	NULL,
 };
 ATTRIBUTE_GROUPS(space_info);
@@ -641,6 +695,16 @@ static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj)
 	return to_fs_devs(kobj)->fs_info;
 }
 
+static inline struct kobject *get_btrfs_kobj(struct kobject *kobj)
+{
+	while (kobj) {
+		if (kobj->ktype == &btrfs_ktype)
+			return kobj;
+		kobj = kobj->parent;
+	}
+	return NULL;
+}
+
 #define NUM_FEATURE_BITS 64
 #define BTRFS_FEATURE_NAME_MAX 13
 static char btrfs_unknown_feature_names[FEAT_MAX][NUM_FEATURE_BITS][BTRFS_FEATURE_NAME_MAX];
-- 
2.21.0

