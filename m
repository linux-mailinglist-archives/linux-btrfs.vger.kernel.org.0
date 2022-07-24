Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE2D57F5E3
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 17:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiGXPsG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jul 2022 11:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiGXPsF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jul 2022 11:48:05 -0400
X-Greylist: delayed 944 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Jul 2022 08:48:03 PDT
Received: from smtpq3.tb.ukmail.iss.as9143.net (smtpq3.tb.ukmail.iss.as9143.net [212.54.57.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92105E0F3
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 08:48:03 -0700 (PDT)
Received: from [212.54.57.96] (helo=smtpq1.tb.ukmail.iss.as9143.net)
        by smtpq3.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mike.fleetwood@googlemail.com>)
        id 1oFdad-00086Q-DB
        for linux-btrfs@vger.kernel.org; Sun, 24 Jul 2022 17:32:19 +0200
Received: from [212.54.57.105] (helo=csmtp1.tb.ukmail.iss.as9143.net)
        by smtpq1.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mike.fleetwood@googlemail.com>)
        id 1oFdab-0002Bi-Ao
        for linux-btrfs@vger.kernel.org; Sun, 24 Jul 2022 17:32:17 +0200
Received: from rockover.duckdns.org ([82.18.143.172])
        by cmsmtp with ESMTP
        id FdaboHlWu2CkpFdaboMFsV; Sun, 24 Jul 2022 17:32:17 +0200
X-SourceIP: 82.18.143.172
X-Authenticated-Sender: 
X-Spam: 0
X-Authority: v=2.4 cv=S5fKfagP c=1 sm=1 tr=0 ts=62dd6601 cx=a_exe
 a=sf9uXwBI4K/vBKiXuhgC7Q==:117 a=sf9uXwBI4K/vBKiXuhgC7Q==:17
 a=RgO8CyIxsXoA:10 a=x7bEGLp0ZPQA:10 a=AtKE3pWXn8QA:10 a=mK_AVkanAAAA:8
 a=A32VDEbvp05V50FcH1IA:9 a=Uz9EnhuHEG25YKoRyM-d:22 a=3gWm3jAn84ENXaBijsEo:22
Received: from rockover.localdomain (localhost [127.0.0.1])
        by rockover.duckdns.org (Postfix) with ESMTP id 13E93202FCBD;
        Sun, 24 Jul 2022 16:32:17 +0100 (BST)
From:   Mike Fleetwood <mike.fleetwood@googlemail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Mike Fleetwood <mike.fleetwood@googlemail.com>
Subject: [PATCH] btrfs-progs: exit with failure when printing bad superblock
Date:   Sun, 24 Jul 2022 16:32:14 +0100
Message-Id: <1658676734-15294-1-git-send-email-mike.fleetwood@googlemail.com>
X-Mailer: git-send-email 1.8.3.1
X-CMAE-Envelope: MS4xfGsczMjFmR9dspZmhkrL9lRCA6UUkMJW67ivJa5BQAoK1tFQSZpDKrniM6x+4R5EBDn6TN7Thwntnp4P/bAW1pmkSkPSdIVt1/uJ7WqdOvub4DE/g5VJ
 pPjkz5ISUbtEgNM2loEFI2hcbG3RhXTMH/nSbGb8SvmBCbrfJy3XgRcARhXoF8USIkFtfSDwLpCZaBBublBm6UXTbmwHGWQVYGBYHj0kgw+M6Kf9031zasOR
 zbeGmC6WHxlbwPKeH+LRs0+JWxsYX55+kzYY9PrvuLU=
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Attempting to dump a bad btrfs superblock returns successful exit status
zero.  According to the manual page non-zero should be returned on
failure.  Fix this.
    $ btrfs inspect-internal dump-super /dev/zero
    superblock: bytenr=65536, device=/dev/zero
    ---------------------------------------------------------
    ERROR: bad magic on superblock on /dev/zero at 65536

    $ echo $?
    0

Signed-off-by: Mike Fleetwood <mike.fleetwood@googlemail.com>
---
 cmds/inspect-dump-super.c                       | 11 ++++++++---
 tests/misc-tests/015-dump-super-garbage/test.sh |  6 +++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index d843562..4187da8 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -52,9 +52,9 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 	if (btrfs_super_magic(&sb) != BTRFS_MAGIC && !force) {
 		error("bad magic on superblock on %s at %llu",
 				filename, (unsigned long long)sb_bytenr);
-	} else {
-		btrfs_print_superblock(&sb, full);
+		return 1;
 	}
+	btrfs_print_superblock(&sb, full);
 	return 0;
 }
 
@@ -177,7 +177,12 @@ static int cmd_inspect_dump_super(const struct cmd_struct *cmd,
 				putchar('\n');
 			}
 		} else {
-			load_and_dump_sb(filename, fd, sb_bytenr, full, force);
+			if (load_and_dump_sb(filename, fd,
+						sb_bytenr, full, force)) {
+				close(fd);
+				ret = 1;
+				goto out;
+			}
 			putchar('\n');
 		}
 		close(fd);
diff --git a/tests/misc-tests/015-dump-super-garbage/test.sh b/tests/misc-tests/015-dump-super-garbage/test.sh
index b346945..1e6afa1 100755
--- a/tests/misc-tests/015-dump-super-garbage/test.sh
+++ b/tests/misc-tests/015-dump-super-garbage/test.sh
@@ -6,9 +6,9 @@ source "$TEST_TOP/common"
 
 check_prereq btrfs
 
-run_check "$TOP/btrfs" inspect-internal dump-super /dev/urandom
-run_check "$TOP/btrfs" inspect-internal dump-super -a /dev/urandom
-run_check "$TOP/btrfs" inspect-internal dump-super -fa /dev/urandom
+run_mustfail "attempt to print bad superblock without force" "$TOP/btrfs" inspect-internal dump-super /dev/urandom
+run_mustfail "attempt to print bad superblock without force" "$TOP/btrfs" inspect-internal dump-super -a /dev/urandom
+run_mustfail "attempt to print bad superblock without force" "$TOP/btrfs" inspect-internal dump-super -fa /dev/urandom
 run_check "$TOP/btrfs" inspect-internal dump-super -Ffa /dev/urandom
 run_check "$TOP/btrfs" inspect-internal dump-super -Ffa /dev/urandom
 run_check "$TOP/btrfs" inspect-internal dump-super -Ffa /dev/urandom
-- 
1.8.3.1

