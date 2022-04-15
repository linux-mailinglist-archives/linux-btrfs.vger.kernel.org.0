Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FA45028E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 13:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbiDOLkc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 07:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiDOLkb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 07:40:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700A95DE59
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 04:38:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 183BF210E6
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 11:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650022682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Sb0r/WPgE7lQpaM+jpUY+vq5fZK8jR7Ky0Wamx/WI8I=;
        b=u6z/AY8obrh4ovlq1uk/S43gbtFXr3lC48SE32vWLRiXJA2j3Io44CMHS6aekRhjS994C4
        844XEOFSUwFsjWI486ClXkabNDzCUJvOVr8IfbiNT88q3kXCPEJNufSU5FOWkoG2zymWaz
        /Xm9gb2Ds3tOeKr89ypges0s3wAxzgE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54F1013A9B
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 11:38:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jylGBhlZWWJkQgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 11:38:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: do not allow setting seed flag on fs with dirty log
Date:   Fri, 15 Apr 2022 19:37:43 +0800
Message-Id: <4022d9f87067124c26bb83d4bba1970c954cdf50.1650022504.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
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

[BUG]
The following sequence operation can lead to a seed fs rejected by
kernel:

 # Generate a fs with dirty log
 mkfs.btrfs -f $file
 mount $dev $mnt
 xfs_io -f -c "pwrite 0 16k" -c fsync $mnt/file
 cp $file $file.backup
 umount $mnt
 mv $file.backup $file

 # now $file has dirty log, set seed flag on it
 btrfstune -S1 $file

 # mount will fail
 mount $file $mnt

The mount failure with the following dmesg:

[  980.363667] loop0: detected capacity change from 0 to 262144
[  980.371177] BTRFS info (device loop0): flagging fs with big metadata feature
[  980.372229] BTRFS info (device loop0): using free space tree
[  980.372639] BTRFS info (device loop0): has skinny extents
[  980.375075] BTRFS info (device loop0): start tree-log replay
[  980.375513] BTRFS warning (device loop0): log replay required on RO media
[  980.381652] BTRFS error (device loop0): open_ctree failed

[CAUSE]
Although btrfs will replay its dirty log even with RO mount, but kernel
will treat seed device as RO device, and dirty log can not be replayed
on RO device.

This rejection is already the better end, just imagine if we don't treat
seed device as RO, and replayed the dirty log.
The filesystem relying on the seed device will be completely screwed up.

[FIX]
Just add extra check on log tree in btrfstune to reject setting seed
flag on filesystems with dirty log.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfstune.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/btrfstune.c b/btrfstune.c
index 33c83bf16291..7e4ad30a1cbd 100644
--- a/btrfstune.c
+++ b/btrfstune.c
@@ -59,6 +59,10 @@ static int update_seeding_flag(struct btrfs_root *root, int set_flag)
 						device);
 			return 1;
 		}
+		if (btrfs_super_log_root(disk_super)) {
+			error("this filesystem has dirty log, can not set seed flag");
+			return 1;
+		}
 		super_flags |= BTRFS_SUPER_FLAG_SEEDING;
 	} else {
 		if (!(super_flags & BTRFS_SUPER_FLAG_SEEDING)) {
-- 
2.35.1

