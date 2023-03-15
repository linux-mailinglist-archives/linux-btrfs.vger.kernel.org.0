Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386976BA762
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 06:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCOFxC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 01:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCOFxB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 01:53:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B004B7A8E
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 22:52:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 654C01FD6C
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 05:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678859577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=g/47ItAgHMyr63Yw9mLWU+2C4qozm7p3NgINSp6YPaU=;
        b=rjaet2nrLDIEfTHkddR1hlY+07OZHoYKPknCejzGEHb76HdXntxNHR/wDq3TXNIO4eDbHM
        id1TY+r+6G58bu82NBq58PIL7OHaGpuzcJQz10cE7YR0aY1gvKgS4vWr3t3e8H7ZHuVxBI
        ADtZaA1C8KSIj91hS1Q/lfomEhP9dh8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C62501329E
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 05:52:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TIPxJDhdEWTcQgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 05:52:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fix race window during mkfs
Date:   Wed, 15 Mar 2023 13:52:39 +0800
Message-Id: <ba38fd54e4003e8b8bb6cdb7bf51bb4d4ac7d0cb.1678859548.git.wqu@suse.com>
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
There is an internal bug report that, after mkfs.btrfs there is a chance
that no /dev/disk/by-uuid/<uuid> soft link is not created at all.

[CAUSE]
That uuid soft link is created by udev, which listens inotify
IN_CLOSE_WRITE events from all block devices.

After such IN_CLOSE_WRITE event is triggered, udev would *disable*
inotify for that block device, and do a blkid scan on it.
After the blkid scan is done, re-enable the inotify listening.

This means normally mkfs tools should open the fd, do all the writes,
and close the fd after everything is done.

But unfortunately for mkfs.btrfs, it's not the case, we have a lot of
phases seperated by different close() calls:

  open_ctree() would open fds of each involved device
  and close them at close_ctree()
  Only after close_ctree() we have a valid superblock -\
                                                       |
|<------- A -------->|<--------- B --------->|<------- C ------->|
          |                      |
          |                      `- open a new fd for make_btrfs()
          |                         and close it before open_ctree()
          |                         The device contains invalid sb.
          |
          `- open a new fd for each device, then call
             btrfs_prepare_device(), then close the fd.
             The device would contain no valid superblock.

If at the close() of phase A udev event is triggered, while doing udev
scan we go into phase C (but before the new valid super blocks written),
udev would only see no superblock or invalid superblock.

Then phase C finished, udev resume its inotify listening, but at this
timing mkfs is finished, while udev only see the premature data from
phase A, and missed the IN_CLOSE_WRITE events from phase C.

[FIX]
Instead of open and close a new fd for each device, re-use the fd opened
during prepare_one_device(), and close all the fds until close_ctree()
is called.

By this, although we may still have race between close_ctree() and
explicit close() calls, at least udev can always see the properly
written super blocks.

To compensate the change, some extra cleanups are made:

- Do not touch @device_count
  Which makes later prepare_ctx iteration much easier.

- Remove top-level @fd variable
  Instead go with prepare_ctx[i].fd.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/main.c | 65 +++++++++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index f5e34cbda612..2595100d800b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -72,6 +72,7 @@ static bool opt_zoned = true;
 static int opt_oflags = O_RDWR;
 
 struct prepare_device_progress {
+	int fd;
 	char *file;
 	u64 dev_block_count;
 	u64 block_count;
@@ -965,23 +966,21 @@ fail:
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
+	prepare_ctx->ret = btrfs_prepare_device(prepare_ctx->fd,
+				prepare_ctx->file,
 				&prepare_ctx->dev_block_count,
 				prepare_ctx->block_count,
 				(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
 				(opt_zero_end ? PREP_DEVICE_ZERO_END : 0) |
 				(opt_discard ? PREP_DEVICE_DISCARD : 0) |
 				(opt_zoned ? PREP_DEVICE_ZONED : 0));
-	close(fd);
-
 	return NULL;
 }
 
@@ -992,7 +991,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_trans_handle *trans;
 	struct open_ctree_flags ocf = { 0 };
-	int fd = -1;
 	int ret = 0;
 	int close_ret;
 	int i;
@@ -1244,8 +1242,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 	}
 
-	while (device_count-- > 0) {
+	for (i = 0; i < device_count; i++) {
 		file = argv[optind++];
+
 		if (source_dir_set && path_exists(file) == 0)
 			ret = 0;
 		else if (path_is_block_device(file) == 1)
@@ -1391,6 +1390,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (source_dir_set) {
 		int oflags = O_RDWR;
 		struct stat statbuf;
+		int fd;
 
 		if (path_exists(file) == 0)
 			oflags |= O_CREAT;
@@ -1521,12 +1521,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
-	device_count--;
-	fd = open(file, opt_oflags);
-	if (fd < 0) {
-		error("unable to open %s: %m", file);
-		goto error;
-	}
 	dev_block_count = prepare_ctx[0].dev_block_count;
 	if (block_count && block_count > dev_block_count) {
 		error("%s is smaller than requested size, expected %llu, found %llu",
@@ -1567,7 +1561,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	else
 		mkfs_cfg.zone_size = 0;
 
-	ret = make_btrfs(fd, &mkfs_cfg);
+	ret = make_btrfs(prepare_ctx[0].fd, &mkfs_cfg);
 	if (ret) {
 		errno = -ret;
 		error("error during mkfs: %m");
@@ -1581,8 +1575,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		error("open ctree failed");
 		goto error;
 	}
-	close(fd);
-	fd = -1;
+
 	root = fs_info->fs_root;
 
 	ret = create_metadata_block_groups(root, mixed, &allocation);
@@ -1635,36 +1628,29 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (device_count == 0)
 		goto raid_groups;
 
-	while (device_count-- > 0) {
-		int dev_index = argc - saved_optind - device_count - 1;
-		file = argv[optind++];
-
-		fd = open(file, opt_oflags);
-		if (fd < 0) {
-			error("unable to open %s: %m", file);
-			goto error;
-		}
-		ret = btrfs_device_already_in_root(root, fd,
+	for (i = 1; i < device_count; i++) {
+		ret = btrfs_device_already_in_root(root, prepare_ctx[i].fd,
 						   BTRFS_SUPER_INFO_OFFSET);
 		if (ret) {
 			error("skipping duplicate device %s in the filesystem",
 				file);
-			close(fd);
 			continue;
 		}
-		dev_block_count = prepare_ctx[dev_index].dev_block_count;
+		dev_block_count = prepare_ctx[i].dev_block_count;
 
-		if (prepare_ctx[dev_index].ret) {
-			errno = -prepare_ctx[dev_index].ret;
+		if (prepare_ctx[i].ret) {
+			errno = -prepare_ctx[i].ret;
 			error("unable to prepare device %s: %m",
-					prepare_ctx[dev_index].file);
+					prepare_ctx[i].file);
 			goto error;
 		}
 
-		ret = btrfs_add_to_fsid(trans, root, fd, file, dev_block_count,
+		ret = btrfs_add_to_fsid(trans, root, prepare_ctx[i].fd,
+					prepare_ctx[i].file, dev_block_count,
 					sectorsize, sectorsize, sectorsize);
 		if (ret) {
-			error("unable to add %s to filesystem: %d", file, ret);
+			error("unable to add %s to filesystem: %d",
+			      prepare_ctx[i].file, ret);
 			goto error;
 		}
 		if (bconf.verbose >= 2) {
@@ -1838,6 +1824,10 @@ out:
 	}
 
 	btrfs_close_all_devices();
+	if (prepare_ctx) {
+		for (i = 0; i < device_count; i++)
+			close(prepare_ctx[i].fd);
+	}
 	free(t_prepare);
 	free(prepare_ctx);
 	free(label);
@@ -1846,9 +1836,10 @@ out:
 	return !!ret;
 
 error:
-	if (fd > 0)
-		close(fd);
-
+	if (prepare_ctx) {
+		for (i = 0; i < device_count; i++)
+			close(prepare_ctx[i].fd);
+	}
 	free(t_prepare);
 	free(prepare_ctx);
 	free(label);
-- 
2.39.2

