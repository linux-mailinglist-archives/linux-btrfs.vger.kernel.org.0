Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6F323AE2B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 22:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgHCUad (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 16:30:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:51896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgHCUac (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Aug 2020 16:30:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92A37AC94;
        Mon,  3 Aug 2020 20:30:46 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 3/4] btrfs-progs: Check for exclusive operation before issuing ioctl
Date:   Mon,  3 Aug 2020 15:30:14 -0500
Message-Id: <20200803203015.24562-3-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200803203015.24562-1-rgoldwyn@suse.de>
References: <20200803202913.15913-1-rgoldwyn@suse.de>
 <20200803203015.24562-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Check if an exclusive operation is running and if it is, err with the
name of the exclusive operation running.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 cmds/device.c     | 14 ++++++++++++++
 cmds/filesystem.c |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/cmds/device.c b/cmds/device.c
index 99ceed93..6acd4ae6 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -61,6 +61,7 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 	int discard = 1;
 	int force = 0;
 	int last_dev;
+	char exop[BTRFS_SYSFS_EXOP_SIZE];
 
 	optind = 0;
 	while (1) {
@@ -96,6 +97,12 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 	if (fdmnt < 0)
 		return 1;
 
+	if (get_exclusive_operation(fdmnt, exop) > 0 && strcmp(exop, "none")) {
+		error("unable to add device: %s in progress", exop);
+		close_file_or_dir(fdmnt, dirstream);
+		return 1;
+	}
+
 	for (i = optind; i < last_dev; i++){
 		struct btrfs_ioctl_vol_args ioctl_args;
 		int	devfd, res;
@@ -155,6 +162,7 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 	char	*mntpnt;
 	int i, fdmnt, ret = 0;
 	DIR	*dirstream = NULL;
+	char exop[BTRFS_SYSFS_EXOP_SIZE];
 
 	clean_args_no_options(cmd, argc, argv);
 
@@ -167,6 +175,12 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 	if (fdmnt < 0)
 		return 1;
 
+	if (get_exclusive_operation(fdmnt, exop) > 0 && strcmp(exop, "none")) {
+		error("unable to remove device: %s in progress", exop);
+		close_file_or_dir(fdmnt, dirstream);
+		return 1;
+	}
+
 	for(i = optind; i < argc - 1; i++) {
 		struct	btrfs_ioctl_vol_args arg;
 		struct btrfs_ioctl_vol_args_v2 argv2 = {0};
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 6c1b6908..c3efb405 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1079,6 +1079,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	char	*amount, *path;
 	DIR	*dirstream = NULL;
 	struct stat st;
+	char exop[BTRFS_SYSFS_EXOP_SIZE];
 
 	clean_args_no_options_relaxed(cmd, argc, argv);
 
@@ -1110,6 +1111,12 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	if (fd < 0)
 		return 1;
 
+	if (get_exclusive_operation(fd, exop) > 0 && strcmp(exop, "none")) {
+		error("unable to resize: %s in progress", exop);
+		close_file_or_dir(fd, dirstream);
+		return 1;
+	}
+
 	printf("Resize '%s' of '%s'\n", path, amount);
 	memset(&args, 0, sizeof(args));
 	strncpy_null(args.name, amount);
-- 
2.26.2

