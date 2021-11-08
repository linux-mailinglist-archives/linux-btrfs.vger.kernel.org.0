Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E4B4481BE
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 15:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbhKHObK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 09:31:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56528 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239522AbhKHObI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 09:31:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 80CAD1FDB6;
        Mon,  8 Nov 2021 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636381703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L6xs2wLH0r0UAIMTSm8Kb//o/4vlbi2dlvBaG5IkaRg=;
        b=oeBMphw2U3/Z+TQliMOSWMWa7QlP6pwqbS+im3daUAgxeu8uxe+v93Tq419S0OWD4SNd9L
        inB5RuO9iTX/1dwBuM3gS/P4YUQvJM/81160Eu+ivbCz+iqNuJOn7LJAlSR6YUUv4SnAuc
        G/Lbfb+bzoe5AWjC5q2aa9AolpgcBw8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 518BE13BA0;
        Mon,  8 Nov 2021 14:28:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QC5TEQc0iWGSJgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 08 Nov 2021 14:28:23 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 3/3] btrfs: allow device add if balance is paused
Date:   Mon,  8 Nov 2021 16:28:20 +0200
Message-Id: <20211108142820.1003187-4-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211108142820.1003187-1-nborisov@suse.com>
References: <20211108142820.1003187-1-nborisov@suse.com>
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
index ad460dc38786..0e77b538a17c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3159,13 +3159,25 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
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
@@ -3181,7 +3193,10 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 
 	kfree(vol_args);
 out:
-	btrfs_exclop_finish(fs_info);
+	if (restore_op)
+		btrfs_exclop_pause_balance(fs_info);
+	else
+		btrfs_exclop_finish(fs_info);
 	return ret;
 }
 
-- 
2.25.1

