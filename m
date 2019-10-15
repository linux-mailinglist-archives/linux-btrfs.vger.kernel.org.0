Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030BAD7633
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 14:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfJOMOJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 08:14:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:34692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727339AbfJOMOJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 08:14:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F711AD46
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2019 12:14:07 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>
Subject: [RFC PATCH 2/2] btrfs: rename btrfs_parse_device_options back to btrfs_parse_early_options
Date:   Tue, 15 Oct 2019 14:14:05 +0200
Message-Id: <20191015121405.19066-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191015121405.19066-1-jthumshirn@suse.de>
References: <20191015121405.19066-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As btrfs_parse_device_options() now doesn't only parse the -o device mount
option but -o auth_key as well, it makes sense to rename it back to
btrfs_parse_early_options().

This reverts commit fa59f27c8c35bbe00af8eff23de446a7f4b048b0.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/super.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 313ef7fc2bdf..3708264a7335 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -470,8 +470,9 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		case Opt_subvolrootid:
 		case Opt_device:
 			/*
-			 * These are parsed by btrfs_parse_subvol_options or
-			 * btrfs_parse_device_options and can be ignored here.
+			 * These are parsed by btrfs_parse_subvol_options
+			 * and btrfs_parse_early_options
+			 * and can be happily ignored here.
 			 */
 			break;
 		case Opt_nodatasum:
@@ -893,7 +894,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
  * All other options will be parsed on much later in the mount process and
  * only when we need to allocate a new super block.
  */
-static int btrfs_parse_device_options(struct btrfs_fs_info *info,
+static int btrfs_parse_early_options(struct btrfs_fs_info *info,
 				      const char *options, fmode_t flags,
 				      void *holder)
 {
@@ -975,7 +976,7 @@ static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
 
 	/*
 	 * strsep changes the string, duplicate it because
-	 * btrfs_parse_device_options gets called later
+	 * btrfs_parse_early_options gets called later
 	 */
 	opts = kstrdup(options, GFP_KERNEL);
 	if (!opts)
@@ -1532,7 +1533,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	}
 
 	mutex_lock(&uuid_mutex);
-	error = btrfs_parse_device_options(fs_info, data, mode, fs_type);
+	error = btrfs_parse_early_options(fs_info, data, mode, fs_type);
 	if (error) {
 		mutex_unlock(&uuid_mutex);
 		goto error_fs_info;
-- 
2.16.4

