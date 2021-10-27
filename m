Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B957243CB33
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 15:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbhJ0N4E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 09:56:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35488 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbhJ0N4D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 09:56:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B7D0B21964;
        Wed, 27 Oct 2021 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635342817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=i4nh4gOFURy5swkgAI4JwIjsumBhO8KS+UEitADUwFU=;
        b=EDAJn32HuobYrqQBWQXqAnGIYYrCDUUm//nW+TbGJ3+f07fze8FMCdIO4gMaBjMUve6TSa
        TKwIEEA5FAEDcNgfdfo/HpphmiZca+obIBeReadYJBWsWN1ciJF61Rz8eK5ebs3LySUxPh
        1gfUEWDOwWd+s/zXZKNqX8Q/MdiVPog=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79F3713C71;
        Wed, 27 Oct 2021 13:53:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HRz2GuFZeWGINwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 27 Oct 2021 13:53:37 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Don't set balance as a running exclusive op in case of skip_balance
Date:   Wed, 27 Oct 2021 16:53:34 +0300
Message-Id: <20211027135334.19880-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently balance is set as a running exclusive op in
btrfs_recover_balance in case of remount and a paused balance. That's a
bit eager because btrfs_recover_balance executes always and is not
affected by the 'skip_balance' mount option. This can lead to cases in
which a user has mounted the filesystem with 'skip_balance' due to
running out of space yet is unable to add a device to rectify the ENOSPC
because balance is set as a running exclusive op.

Fix this by setting balance in btrfs_resume_balance_async which takes
into consideration whether 'skip_balance' has been added or not.

Fixes:
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

I'm inclined to put a Fixes: ed0fb78fb6aa ("Btrfs: bring back balance pause/resume logic")
tag since this is the commit that moved the exclusive op tracking of
resume_balance_async to btrfs_recover_balance. However that's far too back in the 
past and given the commit message of that commit I wonder if doing this 
re-arrangement in older kernels is correct. David what's your take on this, 
perhahps just a stable tag would be sufficient? 


 fs/btrfs/volumes.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 546bf1146b2d..bff52fa1b255 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4432,6 +4432,20 @@ int btrfs_resume_balance_async(struct btrfs_fs_info *fs_info)
 		return 0;
 	}
 
+	/*
+	 * This should never happen, as the paused balance state is recovered
+	 * during mount without any chance of other exclusive ops to collide.
+	 *
+	 * This gives the exclusive op status to balance and keeps in paused
+	 * state until user intervention (cancel or umount). If the ownership
+	 * cannot be assigned, show a message but do not fail. The balance
+	 * is in a paused state and must have fs_info::balance_ctl properly
+	 * set up.
+	 */
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
+		btrfs_warn(fs_info,
+	"balance: cannot set exclusive op status, resume manually");
+
 	/*
 	 * A ro->rw remount sequence should continue with the paused balance
 	 * regardless of who pauses it, system or the user as of now, so set
@@ -4490,20 +4504,6 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
 	btrfs_balance_sys(leaf, item, &disk_bargs);
 	btrfs_disk_balance_args_to_cpu(&bctl->sys, &disk_bargs);
 
-	/*
-	 * This should never happen, as the paused balance state is recovered
-	 * during mount without any chance of other exclusive ops to collide.
-	 *
-	 * This gives the exclusive op status to balance and keeps in paused
-	 * state until user intervention (cancel or umount). If the ownership
-	 * cannot be assigned, show a message but do not fail. The balance
-	 * is in a paused state and must have fs_info::balance_ctl properly
-	 * set up.
-	 */
-	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
-		btrfs_warn(fs_info,
-	"balance: cannot set exclusive op status, resume manually");
-
 	btrfs_release_path(path);
 
 	mutex_lock(&fs_info->balance_mutex);
-- 
2.17.1

