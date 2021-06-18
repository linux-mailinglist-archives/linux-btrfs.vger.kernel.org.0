Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1438A3ACE0D
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 16:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhFRO5a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 10:57:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48756 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbhFRO53 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 10:57:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EFBC321B0D;
        Fri, 18 Jun 2021 14:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624028118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=91Rr/E/5R6I18ISVo+VgdT12J4lHou79LqXmaL64BU0=;
        b=BZNz7kyu7P4Z0Mg8kderpGTYoWXWU9epCHb2pDfVEd7ypq8Ckp6U8ulKGglqiChzs/VRM+
        EDCYC+/w6am2xeewIm463f7h002R8n+goAxqrww6wd6frgW7TN1TXXpSrRIhzAwDcbcukR
        8Jxh7vNHLZ6EAdyBZSKeZi3ES8/T860=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E99AAA3B99;
        Fri, 18 Jun 2021 14:55:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5FC4EDA7B0; Fri, 18 Jun 2021 16:52:30 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: shorten integrity checker extent data mount option
Date:   Fri, 18 Jun 2021 16:52:30 +0200
Message-Id: <4caf7228626fb21eecac55d22ddbfbf9bff8b219.1624027617.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624027617.git.dsterba@suse.com>
References: <cover.1624027617.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Subjectively, CHECK_INTEGRITY_INCLUDING_EXTENT_DATA is quite long and
calling it CHECK_INTEGRITY_DATA still keeps the meaning and matches the
mount option name.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h   | 2 +-
 fs/btrfs/disk-io.c | 3 +--
 fs/btrfs/super.c   | 5 ++---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e0f6aa6e8bd2..4d156d9e8050 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1405,7 +1405,7 @@ enum {
 	BTRFS_MOUNT_USEBACKUPROOT		= (1UL << 17),
 	BTRFS_MOUNT_SKIP_BALANCE		= (1UL << 18),
 	BTRFS_MOUNT_CHECK_INTEGRITY		= (1UL << 19),
-	BTRFS_MOUNT_CHECK_INTEGRITY_INCLUDING_EXTENT_DATA = (1UL << 20),
+	BTRFS_MOUNT_CHECK_INTEGRITY_DATA	= (1UL << 20),
 	BTRFS_MOUNT_PANIC_ON_FATAL_ERROR	= (1UL << 21),
 	BTRFS_MOUNT_RESCAN_UUID_TREE		= (1UL << 22),
 	BTRFS_MOUNT_FRAGMENT_DATA		= (1UL << 23),
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 544bb7a82e57..6eb0010f9c7e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3598,8 +3598,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (btrfs_test_opt(fs_info, CHECK_INTEGRITY)) {
 		ret = btrfsic_mount(fs_info, fs_devices,
 				    btrfs_test_opt(fs_info,
-					CHECK_INTEGRITY_INCLUDING_EXTENT_DATA) ?
-				    1 : 0,
+					CHECK_INTEGRITY_DATA) ? 1 : 0,
 				    fs_info->check_integrity_print_mask);
 		if (ret)
 			btrfs_warn(fs_info,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index bc613218c8c5..d07b18b2b250 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -934,8 +934,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		case Opt_check_integrity_including_extent_data:
 			btrfs_info(info,
 				   "enabling check integrity including extent data");
-			btrfs_set_opt(info->mount_opt,
-				      CHECK_INTEGRITY_INCLUDING_EXTENT_DATA);
+			btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY_DATA);
 			btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY);
 			break;
 		case Opt_check_integrity:
@@ -1516,7 +1515,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	if (btrfs_test_opt(info, SKIP_BALANCE))
 		seq_puts(seq, ",skip_balance");
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-	if (btrfs_test_opt(info, CHECK_INTEGRITY_INCLUDING_EXTENT_DATA))
+	if (btrfs_test_opt(info, CHECK_INTEGRITY_DATA))
 		seq_puts(seq, ",check_int_data");
 	else if (btrfs_test_opt(info, CHECK_INTEGRITY))
 		seq_puts(seq, ",check_int");
-- 
2.31.1

