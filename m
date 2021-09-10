Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34613406886
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 10:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhIJIe5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 04:34:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57138 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhIJIe5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 04:34:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 195661FE4F;
        Fri, 10 Sep 2021 08:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631262826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ILNKz9uaAjD4xSPLXcZSb3C2P17URGYLyZwyT/6Q1kM=;
        b=CwClGyxulD599XoQa619UzQwleNeQB89oXV72NJ3EZyqaYcvhs4Q/RaJ9DHQ2tmjJ17ejX
        z2u2L9Y4PFGPJGoEWL6Vxlv/AnX69nUPUtRwJfgR9G8YTfxH7xLxQqaxQn6N59Ec7WR1X6
        lp6u2IngN3sa6QGP1SxXWGkc8HdmpB0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD74213D15;
        Fri, 10 Sep 2021 08:33:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id skCHM2kYO2EBVAAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 10 Sep 2021 08:33:45 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 1/2] btrfs-progs: fi show: Print missing device for a mounted file system
Date:   Fri, 10 Sep 2021 11:33:43 +0300
Message-Id: <20210910083344.1876661-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently when a device is missing for a mounted filesystem the output
that is produced is unhelpful:

Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
	Total devices 2 FS bytes used 128.00KiB
	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
	*** Some devices missing

While the context which prints this is perfectly capable of showing
which device exactly is missing, like so:

Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
	Total devices 2 FS bytes used 128.00KiB
	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
	devid    2 size 0 used 0 path /dev/loop1 MISSING

This is a lot more usable output as it presents the user with the id
of the missing device and its path.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

V2:
 * Removed stars around MISSING
 cmds/filesystem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index db8433ba3542..dadd4c82a9b0 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -295,7 +295,6 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
 {
 	int i;
 	int fd;
-	int missing = 0;
 	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
 	struct btrfs_ioctl_dev_info_args *tmp_dev_info;
 	int ret;
@@ -325,8 +324,10 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
 		/* Add check for missing devices even mounted */
 		fd = open((char *)tmp_dev_info->path, O_RDONLY);
 		if (fd < 0) {
-			missing = 1;
+			printf("\tdevid %4llu size 0 used 0 path %s MISSING\n",
+					tmp_dev_info->devid, tmp_dev_info->path);
 			continue;
+
 		}
 		close(fd);
 		canonical_path = path_canonicalize((char *)tmp_dev_info->path);
@@ -339,8 +340,6 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
 		free(canonical_path);
 	}

-	if (missing)
-		printf("\t*** Some devices missing\n");
 	printf("\n");
 	return 0;
 }
--
2.17.1

