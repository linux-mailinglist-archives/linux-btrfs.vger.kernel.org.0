Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD60EEB3AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2019 16:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfJaPNn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Oct 2019 11:13:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:50800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728322AbfJaPNm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Oct 2019 11:13:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4A73B70C;
        Thu, 31 Oct 2019 15:13:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 23221DA783; Thu, 31 Oct 2019 16:13:50 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 3/4] btrfs: add incompat for raid1 with 3, 4 copies
Date:   Thu, 31 Oct 2019 16:13:50 +0100
Message-Id: <4871131c7f011b3936ee9a046f1a6dfee74e0878.1572534591.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572534591.git.dsterba@suse.com>
References: <cover.1572534591.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new raid1c3 and raid1c4 profiles are backward incompatible and the
name shall be 'raid1c34', the status can be found in the global
supported features in /sys/fs/btrfs/features or in the per-filesystem
directory.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h           | 3 ++-
 fs/btrfs/sysfs.c           | 2 ++
 fs/btrfs/volumes.c         | 9 +++++++++
 include/uapi/linux/btrfs.h | 1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 923a8804ae94..e76b3cda13e3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -292,7 +292,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
-	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34)
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 4a78bc4ec62e..1725578c5464 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -259,6 +259,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(skinny_metadata, SKINNY_METADATA);
 BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
+BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
 
 /*
 static struct btrfs_feature_attr btrfs_attr_features_checksums_name = {
@@ -283,6 +284,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(no_holes),
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
+	BTRFS_FEAT_ATTR_PTR(raid1c34),
 	NULL
 };
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 238d814f83a1..a674a960c7be 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4717,6 +4717,14 @@ static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
 	btrfs_set_fs_incompat(info, RAID56);
 }
 
+static void check_raid1c34_incompat_flag(struct btrfs_fs_info *info, u64 type)
+{
+	if (!(type & (BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4)))
+		return;
+
+	btrfs_set_fs_incompat(info, RAID1C34);
+}
+
 static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			       u64 start, u64 type)
 {
@@ -4983,6 +4991,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 
 	free_extent_map(em);
 	check_raid56_incompat_flag(info, type);
+	check_raid1c34_incompat_flag(info, type);
 
 	kfree(devices_info);
 	return 0;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index a2b761275bba..7a8bc8b920f5 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -270,6 +270,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
+#define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.23.0

