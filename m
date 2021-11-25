Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E2B45D6FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 10:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353836AbhKYJTx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 04:19:53 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42484 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347685AbhKYJR7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 04:17:59 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8DD2421B39;
        Thu, 25 Nov 2021 09:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637831687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=55RQXfjL2PwDPBEAeMS+u9YVOnNsKeSaDTvXAIx/7N8=;
        b=mrvkOEwBgFLoYyXOPhcZyooWjSKLtaNYKR1p9SLE7J3jpB1YQLj8sI1nP7ji7bfcG01gW+
        Dc3Sjlkgv8WRrWeQh7cAkOifCyEGuqwzUbEaVyNW1OkZiDO7xnFW7STrQ7uhKfP+n9V348
        ohPBemUAZTst3KRcyzLZ5ADiE/RNvNY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EB9713F62;
        Thu, 25 Nov 2021 09:14:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OMaXFAdUn2EOHAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 25 Nov 2021 09:14:47 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 3/3] btrfs: allow device add if balance is paused
Date:   Thu, 25 Nov 2021 11:14:43 +0200
Message-Id: <20211125091443.762092-4-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125091443.762092-1-nborisov@suse.com>
References: <20211125091443.762092-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently paused balance precludes adding a device since they are both
considered exclusive ops and we can have at most 1 running at a time.
This is problematic in case a filesystem encounters an ENOSPC situation
while balance is running, in this case the only thing the user can do
is mount the fs with "skip_balance" which pauses balance and delete some
data to free up space for balance. However, it should be possible to add
a new device when balance is paused.

Fix this by allowing device add to proceed when balance is paused.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ioctl.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ab05319854f8..6d617d2d5fa2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3172,13 +3172,25 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 {
 	struct btrfs_ioctl_vol_args *vol_args;
+	bool restore_op = false;
 	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD))
-		return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD)) {
+		if (!btrfs_exclop_start_try_lock(fs_info, BTRFS_EXCLOP_DEV_ADD))
+			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
+
+		/*
+		 * We can do the device add because we have a paused balanced,
+		 * change the exclusive op type and remember we should bring
+		 * back the paused balance
+		 */
+		fs_info->exclusive_operation = BTRFS_EXCLOP_DEV_ADD;
+		btrfs_exclop_start_unlock(fs_info);
+		restore_op = true;
+	}
 
 	vol_args = memdup_user(arg, sizeof(*vol_args));
 	if (IS_ERR(vol_args)) {
@@ -3194,7 +3206,10 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 
 	kfree(vol_args);
 out:
-	btrfs_exclop_finish(fs_info);
+	if (restore_op)
+		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
+	else
+		btrfs_exclop_finish(fs_info);
 	return ret;
 }
 
-- 
2.25.1

