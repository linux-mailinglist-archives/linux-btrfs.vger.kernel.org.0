Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3477FB3F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 15:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436510AbfHBNjp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 09:39:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:60076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436507AbfHBNjo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 09:39:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D70FAFA4
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2019 13:39:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52239DADC0; Fri,  2 Aug 2019 15:40:17 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 07/13] btrfs: sysfs: replace direct access to feature set names with a helper
Date:   Fri,  2 Aug 2019 15:40:17 +0200
Message-Id: <529bed53ab10da67c0f5c61646390298629ea6af.1564752900.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564752900.git.dsterba@suse.com>
References: <cover.1564752900.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In order to unexport the feature type array, add a helper for the
enum-to-string conversion.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 2 +-
 fs/btrfs/sysfs.c | 7 ++++++-
 fs/btrfs/sysfs.h | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ccac62d40dd2..fa091b6cc0ba 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5258,7 +5258,7 @@ static int check_feature_bits(struct btrfs_fs_info *fs_info,
 			      u64 change_mask, u64 flags, u64 supported_flags,
 			      u64 safe_set, u64 safe_clear)
 {
-	const char *type = btrfs_feature_set_names[set];
+	const char *type = btrfs_feature_set_name(set);
 	char *names;
 	u64 disallowed, unsupported;
 	u64 set_mask = flags & change_mask;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 90822cdbf59e..0d37403a4733 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -655,12 +655,17 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 	btrfs_sysfs_rm_device_link(fs_info->fs_devices, NULL);
 }
 
-const char * const btrfs_feature_set_names[FEAT_MAX] = {
+static const char * const btrfs_feature_set_names[FEAT_MAX] = {
 	[FEAT_COMPAT]	 = "compat",
 	[FEAT_COMPAT_RO] = "compat_ro",
 	[FEAT_INCOMPAT]	 = "incompat",
 };
 
+const char * const btrfs_feature_set_name(enum btrfs_feature_set set)
+{
+	return btrfs_feature_set_names[set];
+}
+
 char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags)
 {
 	size_t bufsize = 4096; /* safe max, 64 names * 64 bytes */
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 0550358eb24e..f17faa5d5264 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -84,7 +84,7 @@ attr_to_btrfs_feature_attr(struct attribute *attr)
 }
 
 char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags);
-extern const char * const btrfs_feature_set_names[FEAT_MAX];
+const char * const btrfs_feature_set_name(enum btrfs_feature_set set);
 int btrfs_sysfs_add_device_link(struct btrfs_fs_devices *fs_devices,
 		struct btrfs_device *one_device);
 int btrfs_sysfs_rm_device_link(struct btrfs_fs_devices *fs_devices,
-- 
2.22.0

