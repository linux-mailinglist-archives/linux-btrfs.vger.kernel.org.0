Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1663D93BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 18:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhG1Q73 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 12:59:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48782 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhG1Q73 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 12:59:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 899351FFD7;
        Wed, 28 Jul 2021 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627491566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PcT3ZzNiip2yLBapLReAqcWEO90rGxKPtOkXENaDVoE=;
        b=qmLCrJFFnN+LwmvZ//iYHvzM+HgdUBd4nFqd6hBf70DpWNBWq+V6RKZsVhDy4y5MiGKyCp
        9KKRzQV2erfDb6fGtFg6cyYuH2HHGtmG8W2UJuPzciqttAegbRgbvMMRcWM4WpAzE03+A8
        SLuibH3aqe87NTnNQen6U0bcSGZ/wrE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 57AE3A3B83;
        Wed, 28 Jul 2021 16:59:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6CA03DA8A7; Wed, 28 Jul 2021 18:56:41 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, johannes.thumshirn@wdc.com,
        damien.lemoal@wdc.com, naohiro.aota@wdc.com
Subject: [PATCH] btrfs: sysfs: advertise zoned support among features
Date:   Wed, 28 Jul 2021 18:56:32 +0200
Message-Id: <20210728165632.11813-1-dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We've hidden the zoned support in sysfs under debug config for the first
releases but now the stability is reasonable, though not all features
have been implemented.

As this depends on a config option, the per-filesystem feature won't
exist as such filesystem can't be mounted. The static feature will print
1 when the support is built-in, 0 otherwise.

Signed-off-by: David Sterba <dsterba@suse.com>
---

The merge target is not set, depends if everybody thinks it's the time
even though there are still known bugs. We're also waiting for
util-linux support (blkid, wipefs), so that needs to be synced too.

 fs/btrfs/sysfs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index bfe5e27617b0..7ad8f802ab88 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -263,8 +263,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
-/* Remove once support for zoned allocation is feature complete */
-#ifdef CONFIG_BTRFS_DEBUG
+#ifdef CONFIG_BLK_DEV_ZONED
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 #endif
 #ifdef CONFIG_FS_VERITY
@@ -285,7 +284,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
-#ifdef CONFIG_BTRFS_DEBUG
+#ifdef CONFIG_BLK_DEV_ZONED
 	BTRFS_FEAT_ATTR_PTR(zoned),
 #endif
 #ifdef CONFIG_FS_VERITY
@@ -384,12 +383,19 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
 BTRFS_ATTR(static_feature, supported_sectorsizes,
 	   supported_sectorsizes_show);
 
+static ssize_t zoned_show(struct kobject *kobj, struct kobj_attribute *a, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%d\n", IS_ENABLED(CONFIG_BLK_DEV_ZONED));
+}
+BTRFS_ATTR(static_feature, zoned, zoned_show);
+
 static struct attribute *btrfs_supported_static_feature_attrs[] = {
 	BTRFS_ATTR_PTR(static_feature, rmdir_subvol),
 	BTRFS_ATTR_PTR(static_feature, supported_checksums),
 	BTRFS_ATTR_PTR(static_feature, send_stream_version),
 	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
 	BTRFS_ATTR_PTR(static_feature, supported_sectorsizes),
+	BTRFS_ATTR_PTR(static_feature, zoned),
 	NULL
 };
 
-- 
2.31.1

