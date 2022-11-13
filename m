Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F46626D70
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Nov 2022 03:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiKMCNb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Nov 2022 21:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiKMCNa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Nov 2022 21:13:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE07317
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Nov 2022 18:13:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7040322CF7
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 02:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668305606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1lvHr60wEJBGzLl/5Dnk6WC02H/OQOTimpWCUqGiXAo=;
        b=RRRHRc83QPyesHJ7amnRiQEG1rB4R+o8z9z/7qURPMV5Hhsr2l4KaMVYt/pggbCVxUPDZX
        kKx8fZ2D8fwSCFcno9FCnYeJhnqSAPrkAu2L424qyPGuNVciy6f0qxslrDxwQYD/L1zNTF
        T5+4cYg9HiguT9aDCHnmd3KJL88Gi0g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3264139C6
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 02:13:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DLbqIsVScGOsYgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 02:13:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fix the wrong log level of "filesystem defrag"
Date:   Sun, 13 Nov 2022 10:13:08 +0800
Message-Id: <4633d2fd0b1518238e9800b0e7a8939991ef5500.1668305578.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Test case fstests:btrfs/021 will fail with v6.0 btrfs-progs, with the
extra output:

     QA output created by 021
    +/mnt/scratch/padding-0
    +/mnt/scratch/padding-1
    +/mnt/scratch/padding-2
    +/mnt/scratch/padding-3
    +/mnt/scratch/padding-4
    +/mnt/scratch/padding-5
    ...

[CAUSE]
Commit db2f85c8751c ("btrfs-progs: fi defrag: add global verbose
option") changed the default message level to 1.

But the original code uses a different log level than the global verbose
level (previously log level 1 is not outputed by default).

Thus this increased the output level by default.

[FIX]
Don't use immediate number, and use LOG_INFO instead.

Fixes: db2f85c8751c ("btrfs-progs: fi defrag: add global verbose option")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/filesystem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 7c8323d9db8a..22f7bf7daeb7 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -878,7 +878,7 @@ static int defrag_callback(const char *fpath, const struct stat *sb,
 	int fd = 0;
 
 	if ((typeflag == FTW_F) && S_ISREG(sb->st_mode)) {
-		pr_verbose(1, "%s\n", fpath);
+		pr_verbose(LOG_INFO, "%s\n", fpath);
 		fd = open(fpath, defrag_open_mode);
 		if (fd < 0) {
 			goto error;
@@ -1050,7 +1050,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 			/* errors are handled in the callback */
 			ret = 0;
 		} else {
-			pr_verbose(1, "%s\n", argv[i]);
+			pr_verbose(LOG_INFO, "%s\n", argv[i]);
 			ret = ioctl(fd, BTRFS_IOC_DEFRAG_RANGE,
 					&defrag_global_range);
 			defrag_err = errno;
-- 
2.38.1

