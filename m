Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97DF4EA941
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 10:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiC2Ic3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 04:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiC2Ic2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 04:32:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A796B47048
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 01:30:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E61AB1FD46;
        Tue, 29 Mar 2022 08:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648542643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/n1gwH4ZY6/0M9Asni/zbJwZi04ikJOaT8z+RPPKWjA=;
        b=udB+eT3DAD+tFnmb6R6pDC41QxqaCxTllWk0BxpTaoNXC8G7GnRD3tAw0X242MUN+/B/2I
        VVsVajlNCuCn1KiVDjCfBRnDWritZ7ZAUusgpAYLy5dmE4pWIjWJ+UBaA4mF8MMsff9f0x
        DDP/G9Y7RkbTB5pnmY5vq3WKbLe/o90=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A37E313AB1;
        Tue, 29 Mar 2022 08:30:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jyvVJLPDQmLbLAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 29 Mar 2022 08:30:43 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a mounted file system
Date:   Tue, 29 Mar 2022 11:30:41 +0300
Message-Id: <20220329083042.1248264-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
	devid    2 size 0 used 0 path /dev/loop1 ***MISSING***

This is a lot more usable output as it presents the user with the id
of the missing device and its path.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

Resending this series as it seems to have fallen through the cracks.


 cmds/filesystem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 7cd08fcd5f62..fe32838a25bf 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -296,7 +296,6 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
 {
 	int i;
 	int fd;
-	int missing = 0;
 	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
 	struct btrfs_ioctl_dev_info_args *tmp_dev_info;
 	int ret;
@@ -326,8 +325,10 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
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
@@ -340,8 +341,6 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
 		free(canonical_path);
 	}

-	if (missing)
-		printf("\t*** Some devices missing\n");
 	printf("\n");
 	return 0;
 }
--
2.17.1

