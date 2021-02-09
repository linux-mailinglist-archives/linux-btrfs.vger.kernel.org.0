Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D0A3157D1
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 21:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhBIUjl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 15:39:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:45416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233712AbhBIUgg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 15:36:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49802B146;
        Tue,  9 Feb 2021 20:31:27 +0000 (UTC)
From:   Michal Rostecki <mrostecki@suse.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     Michal Rostecki <mrostecki@suse.com>
Subject: [PATCH RFC 5/6] btrfs: sysfs: Add directory for read policies
Date:   Tue,  9 Feb 2021 21:30:39 +0100
Message-Id: <20210209203041.21493-6-mrostecki@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209203041.21493-1-mrostecki@suse.de>
References: <20210209203041.21493-1-mrostecki@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Michal Rostecki <mrostecki@suse.com>

Before this change, raid1 read policy could be selected by using the
/sys/fs/btrfs/[fsid]/read_policy file.

Change it to /sys/fs/btrfs/[fsid]/read_policies/policy.

The motivation behing creating the read_policies directory is that the
next changes and new read policies are going to intruduce settings
specific to read policies.

Signed-off-by: Michal Rostecki <mrostecki@suse.com>
---
 fs/btrfs/sysfs.c   | 51 +++++++++++++++++++++++++++++++++-------------
 fs/btrfs/volumes.h |  1 +
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 19b9fffa2c9c..a8f528eb4e50 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -896,6 +896,19 @@ static ssize_t btrfs_generation_show(struct kobject *kobj,
 }
 BTRFS_ATTR(, generation, btrfs_generation_show);
 
+static const struct attribute *btrfs_attrs[] = {
+	BTRFS_ATTR_PTR(, label),
+	BTRFS_ATTR_PTR(, nodesize),
+	BTRFS_ATTR_PTR(, sectorsize),
+	BTRFS_ATTR_PTR(, clone_alignment),
+	BTRFS_ATTR_PTR(, quota_override),
+	BTRFS_ATTR_PTR(, metadata_uuid),
+	BTRFS_ATTR_PTR(, checksum),
+	BTRFS_ATTR_PTR(, exclusive_operation),
+	BTRFS_ATTR_PTR(, generation),
+	NULL,
+};
+
 /*
  * Look for an exact string @string in @buffer with possible leading or
  * trailing whitespace
@@ -920,7 +933,7 @@ static const char * const btrfs_read_policy_name[] = { "pid" };
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
 {
-	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj->parent);
 	ssize_t ret = 0;
 	int i;
 
@@ -944,7 +957,7 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 				       struct kobj_attribute *a,
 				       const char *buf, size_t len)
 {
-	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj->parent);
 	int i;
 
 	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
@@ -961,19 +974,10 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 
 	return -EINVAL;
 }
-BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
+BTRFS_ATTR_RW(read_policies, policy, btrfs_read_policy_show, btrfs_read_policy_store);
 
-static const struct attribute *btrfs_attrs[] = {
-	BTRFS_ATTR_PTR(, label),
-	BTRFS_ATTR_PTR(, nodesize),
-	BTRFS_ATTR_PTR(, sectorsize),
-	BTRFS_ATTR_PTR(, clone_alignment),
-	BTRFS_ATTR_PTR(, quota_override),
-	BTRFS_ATTR_PTR(, metadata_uuid),
-	BTRFS_ATTR_PTR(, checksum),
-	BTRFS_ATTR_PTR(, exclusive_operation),
-	BTRFS_ATTR_PTR(, generation),
-	BTRFS_ATTR_PTR(, read_policy),
+static const struct attribute *read_policies_attrs[] = {
+	BTRFS_ATTR_PTR(read_policies, policy),
 	NULL,
 };
 
@@ -1112,6 +1116,12 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 
 	sysfs_remove_link(fsid_kobj, "bdi");
 
+	if (fs_info->fs_devices->read_policies_kobj) {
+		sysfs_remove_files(fs_info->fs_devices->read_policies_kobj,
+				   read_policies_attrs);
+		kobject_del(fs_info->fs_devices->read_policies_kobj);
+		kobject_put(fs_info->fs_devices->read_policies_kobj);
+	}
 	if (fs_info->space_info_kobj) {
 		sysfs_remove_files(fs_info->space_info_kobj, allocation_attrs);
 		kobject_del(fs_info->space_info_kobj);
@@ -1658,6 +1668,19 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 	if (error)
 		goto failure;
 
+	fs_devs->read_policies_kobj = kobject_create_and_add("read_policies",
+							     fsid_kobj);
+
+	if (!fs_devs->read_policies_kobj) {
+		error = -ENOMEM;
+		goto failure;
+	}
+
+	error = sysfs_create_files(fs_devs->read_policies_kobj,
+				   read_policies_attrs);
+	if (error)
+		goto failure;
+
 	return 0;
 failure:
 	btrfs_sysfs_remove_mounted(fs_info);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 594f1207281c..ee050fd48042 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -287,6 +287,7 @@ struct btrfs_fs_devices {
 	struct kobject fsid_kobj;
 	struct kobject *devices_kobj;
 	struct kobject *devinfo_kobj;
+	struct kobject *read_policies_kobj;
 	struct completion kobj_unregister;
 
 	enum btrfs_chunk_allocation_policy chunk_alloc_policy;
-- 
2.30.0

