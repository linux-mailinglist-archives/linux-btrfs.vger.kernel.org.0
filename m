Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2E245D6F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 10:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345335AbhKYJTw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 04:19:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42476 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347563AbhKYJR6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 04:17:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4E1C221B38;
        Thu, 25 Nov 2021 09:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637831687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=smjA6uES24/MmPGSfL7ngqCZHNcgOquxNzhWi67V9Gk=;
        b=I4R2hefFpx6IMDrr12wcPmJwYhM2iDdatt67C8tJO+b5dBo1fGkqUgmWEgRLngFjLzDElP
        Ww/ptd2yoefRwYmzS53JpqYNeimbC+hQIUSbDtowIcxCfLtbixhHrFxSc0Wr6IzseTC7Qv
        H8WCJV+s1/T+4kgilfKGlWcEgzM4dIQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E99113F62;
        Thu, 25 Nov 2021 09:14:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aLj4BAdUn2EOHAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 25 Nov 2021 09:14:47 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 2/3] btrfs: make device add compatible with paused balance in btrfs_exclop_start_try_lock
Date:   Thu, 25 Nov 2021 11:14:42 +0200
Message-Id: <20211125091443.762092-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125091443.762092-1-nborisov@suse.com>
References: <20211125091443.762092-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is needed to enable device add to work in cases when a file system
has been mounted with 'skip_balance' mount option.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ioctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ffe33e853bfa..ab05319854f8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -387,6 +387,7 @@ bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
  *
  * Compatibility:
  * - the same type is already running
+ * - when trying to add a device and balance has been paused
  * - not BTRFS_EXCLOP_NONE - this is intentionally incompatible and the caller
  *   must check the condition first that would allow none -> @type
  */
@@ -394,7 +395,9 @@ bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
 				 enum btrfs_exclusive_operation type)
 {
 	spin_lock(&fs_info->super_lock);
-	if (fs_info->exclusive_operation == type)
+	if (fs_info->exclusive_operation == type ||
+	    (fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED &&
+	     type == BTRFS_EXCLOP_DEV_ADD))
 		return true;
 
 	spin_unlock(&fs_info->super_lock);
-- 
2.25.1

