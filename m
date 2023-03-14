Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396386B874A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 01:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCNA6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Mar 2023 20:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCNA6P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Mar 2023 20:58:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298552A999
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 17:58:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F0151F74B
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 00:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678755492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=A4+CBLrajFU3kBEzDjbRfgvOVcw+v1h3voRcaPGJEiM=;
        b=ibhdbnhGL8zkJrSRhBE359O1PVhjBGzVCWveLDDlF4UiYkcn13NvTGBT4IzPtc9X4RYGTF
        GIY5QI6yB3NVqWHqTF2fNuYGTf3eGK5lY0sc8+CNDhSGsZt1PHpEuB/ffMB9mqmmpf9xXJ
        lOGQUwbzB4X99f8BtBk/J3ztaNaEK10=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E279013582
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 00:58:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fgDyK6PGD2SrfwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 00:58:11 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: mkfs: use flock to prevent udev race
Date:   Tue, 14 Mar 2023 08:57:52 +0800
Message-Id: <61a44fa98c640d93a77c14a7f617f5d68f166002.1678755426.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is an internal bug report that, after mkfs.btrfs there is some
random cases where the uuid soft link (/dev/disk/by-uuid) is not
created.

[CAUSE]
The soft link is created by udev, which monitor those block devices by
listening to the inotify.

But during the scan for filesystems, inotify would be temporarily
disabled until the scan is done.

However btrfs split the mkfs into several parts, leaving a window for
udev to got half backed result:

- Disk prepare
  This involves discarding the whole disk (by defualt) or previous
  superblock (-k option).

  After the prepare is done, we close the fd of each device, which would
  trigger udev scan on the block device, without any btrfs superblock
  signature.

- Temporary btrfs creation
  Here we create an initial btrfs image on the first device, using
  the first device, and then close the fd.

  This would also trigger udev scan, but the temporary superblock
  contains an invalid magic number.

- Real btrfs creation
  Here we call open_ctree() on the initial btrfs, and make it to be
  a proper btrfs.
  Then we call close_ctree() to finalize the fs, writing back the real
  super blocks and close the devices.

  This is the normal even triggering udev to detect new btrfs and create
  the soft link.

However if the first two steps triggered a long enough scan that covers
the last step, the last step itself can not trigger a scan, thus udev
only got an empty or invalid btrfs super block, and won't create the
uuid soft link.

[FIX]
To address the problem, follow the advice from systemd
[BLOCK_DEVICE_LOCKING] section, using flock() to lock an fd of each
device.

And only close the locked fd after all operation is done.

Here we re-use the prepare_ctx[] array, and saves the fd until the end
of mkfs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/main.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index f5e34cbda612..e91311bf6eb4 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -18,6 +18,7 @@
 
 #include "kerncompat.h"
 #include <sys/stat.h>
+#include <sys/file.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <fcntl.h>
@@ -75,6 +76,7 @@ struct prepare_device_progress {
 	char *file;
 	u64 dev_block_count;
 	u64 block_count;
+	int fd;
 	int ret;
 };
 
@@ -965,22 +967,26 @@ fail:
 static void *prepare_one_device(void *ctx)
 {
 	struct prepare_device_progress *prepare_ctx = ctx;
-	int fd;
 
-	fd = open(prepare_ctx->file, opt_oflags);
-	if (fd < 0) {
+	prepare_ctx->fd = open(prepare_ctx->file, opt_oflags);
+	if (prepare_ctx->fd < 0) {
 		error("unable to open %s: %m", prepare_ctx->file);
 		prepare_ctx->ret = -errno;
 		return NULL;
 	}
-	prepare_ctx->ret = btrfs_prepare_device(fd, prepare_ctx->file,
+	/*
+	 * Take flock() to prevent udev got a half backed scan.
+	 * This is only an advisory operation, thus no need to handle
+	 * its failure.
+	 */
+	flock(prepare_ctx->fd, LOCK_EX | LOCK_NB);
+	prepare_ctx->ret = btrfs_prepare_device(prepare_ctx->fd, prepare_ctx->file,
 				&prepare_ctx->dev_block_count,
 				prepare_ctx->block_count,
 				(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
 				(opt_zero_end ? PREP_DEVICE_ZERO_END : 0) |
 				(opt_discard ? PREP_DEVICE_DISCARD : 0) |
 				(opt_zoned ? PREP_DEVICE_ZONED : 0));
-	close(fd);
 
 	return NULL;
 }
@@ -1002,6 +1008,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	u64 min_dev_size;
 	u64 shrink_size;
 	int device_count = 0;
+	int orig_device_count;
 	int saved_optind;
 	pthread_t *t_prepare = NULL;
 	struct prepare_device_progress *prepare_ctx = NULL;
@@ -1217,6 +1224,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	stripesize = sectorsize;
 	saved_optind = optind;
 	device_count = argc - optind;
+	orig_device_count = device_count;
 	if (device_count == 0)
 		usage(&mkfs_cmd, 1);
 
@@ -1498,6 +1506,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 
 	/* Start threads */
 	for (i = 0; i < device_count; i++) {
+		prepare_ctx[i].fd = -1;
 		prepare_ctx[i].file = argv[optind + i - 1];
 		prepare_ctx[i].block_count = block_count;
 		prepare_ctx[i].dev_block_count = block_count;
@@ -1838,6 +1847,8 @@ out:
 	}
 
 	btrfs_close_all_devices();
+	for (i = 0; i < orig_device_count; i++)
+		close(prepare_ctx[i].fd);
 	free(t_prepare);
 	free(prepare_ctx);
 	free(label);
@@ -1849,6 +1860,9 @@ error:
 	if (fd > 0)
 		close(fd);
 
+	if (prepare_ctx)
+		for (i = 0; i < orig_device_count; i++)
+			close(prepare_ctx[i].fd);
 	free(t_prepare);
 	free(prepare_ctx);
 	free(label);
-- 
2.39.2

