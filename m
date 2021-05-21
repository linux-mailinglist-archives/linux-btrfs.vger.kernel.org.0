Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C28238C645
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 14:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhEUMKm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 08:10:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:58334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235058AbhEUMKj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 08:10:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621598955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LOuql89VYFJt7NMkEfsfHbI4f0OoYS0eumEjAKvGA1M=;
        b=uEGwy3vZxr0QV4lonF2GhsVDIBDNfogyAHaTIOGxkzuweedMsz4llieUII8jY6kq3RCl63
        WHrciZ0ncGjIxQlWy7fxOFSYghz9Zv1CYXZqwXylXbemee70SM4HTF8ddoVtHSai7iRhMV
        LKIRCfOe0VAtESiUsTl21MZcJji5Rbo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 559AEAAFD;
        Fri, 21 May 2021 12:09:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0F4C4DA725; Fri, 21 May 2021 14:06:41 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs-progs: device remove: add support for cancel
Date:   Fri, 21 May 2021 14:06:41 +0200
Message-Id: <20210521120641.16933-1-dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1621526221.git.dsterba@suse.com>
References: <cover.1621526221.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Recognize special name 'cancel' for device deletion, that will request
kernel to stop running device deletion. This needs support in kernel,
otherwise this will fail due to another exclusive operation running
(though could be the same one).

The command returns after kernel finishes any work that got interrupted,
but this should not take long in kernels 5.10+ that allow interruptible
relocation. The waiting inside kernel is interruptible so this command
(and the waiting stage) can be interrupted.

The device size is restored when deletion does not finish but it's
recommended to review the filesystem state.

Note: in kernels 5.10+ sending a fatal signal (TERM, KILL, Ctrl-C) to
the process running the device deletion will cancel it too.

Example:

    $ btrfs device delete /dev/sdx /mnt
    ...
    $ btrfs device delete cancel /mnt

Signed-off-by: David Sterba <dsterba@suse.com>
---
 cmds/device.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/cmds/device.c b/cmds/device.c
index 4d1276b949b9..48067101fa7d 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -194,6 +194,7 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 	int i, fdmnt, ret = 0;
 	DIR	*dirstream = NULL;
 	bool enqueue = false;
+	bool cancel = false;
 
 	optind = 0;
 	while (1) {
@@ -225,12 +226,30 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 	if (fdmnt < 0)
 		return 1;
 
-	ret = check_running_fs_exclop(fdmnt, BTRFS_EXCLOP_DEV_REMOVE, enqueue);
-	if (ret != 0) {
-		if (ret < 0)
-			error("unable to check status of exclusive operation: %m");
-		close_file_or_dir(fdmnt, dirstream);
-		return 1;
+	/* Scan device arguments for 'cancel', that must be the only "device" */
+	for (i = optind; i < argc - 1; i++) {
+		if (cancel) {
+			error("cancel requested but another device specified: %s\n",
+				argv[i]);
+			close_file_or_dir(fdmnt, dirstream);
+			return 1;
+		}
+		if (strcmp("cancel", argv[i]) == 0) {
+			cancel = true;
+			printf("Request to cancel running device deletion\n");
+		}
+	}
+
+	if (!cancel) {
+		ret = check_running_fs_exclop(fdmnt, BTRFS_EXCLOP_DEV_REMOVE,
+					      enqueue);
+		if (ret != 0) {
+			if (ret < 0)
+				error(
+			"unable to check status of exclusive operation: %m");
+			close_file_or_dir(fdmnt, dirstream);
+			return 1;
+		}
 	}
 
 	for(i = optind; i < argc - 1; i++) {
@@ -243,8 +262,9 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 			argv2.devid = arg_strtou64(argv[i]);
 			argv2.flags = BTRFS_DEVICE_SPEC_BY_ID;
 			is_devid = 1;
-		} else if (path_is_block_device(argv[i]) == 1 ||
-				strcmp(argv[i], "missing") == 0) {
+		} else if (strcmp(argv[i], "missing") == 0 ||
+			   cancel ||
+			   path_is_block_device(argv[i]) == 1) {
 			strncpy_null(argv2.name, argv[i]);
 		} else {
 			error("not a block device: %s", argv[i]);
@@ -303,7 +323,11 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 	"the device.",								\
 	"If 'missing' is specified for <device>, the first device that is",	\
 	"described by the filesystem metadata, but not present at the mount",	\
-	"time will be removed. (only in degraded mode)"
+	"time will be removed. (only in degraded mode)",			\
+	"If 'cancel' is specified as the only device to delete, request cancelation", \
+	"of a previously started device deletion and wait until kernel finishes", \
+	"any pending work. This will not delete the device and the size will be", \
+	"restored to previous state. When deletion is not running, this will fail."
 
 static const char * const cmd_device_remove_usage[] = {
 	"btrfs device remove <device>|<devid> [<device>|<devid>...] <path>",
-- 
2.29.2

