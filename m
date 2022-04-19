Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6E506B30
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351855AbiDSLl7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 07:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351729AbiDSLlt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 07:41:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395BF33364
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 04:36:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A20DF21118;
        Tue, 19 Apr 2022 11:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650368202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lisvwZelW1mLDnJIQ8frS17TX5aN/ztzbA59sEq4MoQ=;
        b=mIvunYUWT3c1jQICFnqndA+b3Vt59uO4PVvY8pzuyUl4Oz2sYIkI2F5NI2mAYFhiQnwUfG
        kk+cpH3C4PWZSv+WwqX//Hk1KeRCIhyXh2NyrLRSzt/PuDQeu18QQxVP5Jrgun0ruuY+zw
        Gljc30kGXU04dE6n44ZbwWsDe+n14sg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7209E132E7;
        Tue, 19 Apr 2022 11:36:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MM1EDsmeXmK8UQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 19 Apr 2022 11:36:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 1/2] btrfs-progs: do not allow setting seed flag on fs with dirty log
Date:   Tue, 19 Apr 2022 19:36:21 +0800
Message-Id: <a1a0b1461fe27e809717797573c7454e0059983e.1650368004.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1650368004.git.wqu@suse.com>
References: <cover.1650368004.git.wqu@suse.com>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 btrfstune.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/btrfstune.c b/btrfstune.c
index c9a92349a44c..3824a3d9d8ff 100644
--- a/btrfstune.c
+++ b/btrfstune.c
@@ -59,6 +59,10 @@ static int update_seeding_flag(struct btrfs_root *root, int set_flag)
 						device);
 			return 1;
 		}
+		if (btrfs_super_log_root(disk_super)) {
+			error("filesystem with dirty log detected, not setting seed flag");
+			return 1;
+		}
 		super_flags |= BTRFS_SUPER_FLAG_SEEDING;
 	} else {
 		if (!(super_flags & BTRFS_SUPER_FLAG_SEEDING)) {
-- 
2.35.1

