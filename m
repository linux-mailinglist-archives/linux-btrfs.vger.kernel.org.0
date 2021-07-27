Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740593D8198
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 23:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhG0VTh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 17:19:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45986 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbhG0VSD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 17:18:03 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0BBD82017F;
        Tue, 27 Jul 2021 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627420682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6EM0oWVPxmOcyDguIStTCYKUhiSMxP/xNZbOx6mKJYg=;
        b=BC8+Rgr54jp0o8JDzSsaZ2+DdH1siopwwNFkVQi9EPLcs9UJS9ctWySsbm1H1XvbzZRfL2
        kV7chgPGMkOT3YK7cIdLiDQptu63b1uEHerBFt7kPsifRr87vpJS5Xz04hErJkMdJLE3Lm
        dJM9TqB2+8H+/iIKe9Un7wP2FBdW1u4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627420682;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6EM0oWVPxmOcyDguIStTCYKUhiSMxP/xNZbOx6mKJYg=;
        b=GjapjOeP7YDU1tWip16HSRPNPxs3o39PJNt4BReEukclkUBi/yhr6FXdz2lzZ1khhsYtcZ
        mS6WDi5TNMF1GcBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9CA97133DE;
        Tue, 27 Jul 2021 21:18:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id zub8HAl4AGGJdQAAGKfGzw
        (envelope-from <rgoldwyn@suse.de>); Tue, 27 Jul 2021 21:18:01 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 5/7] btrfs: Allocate btrfs_ioctl_quota_rescan_args on stack
Date:   Tue, 27 Jul 2021 16:17:29 -0500
Message-Id: <4bfd049f4d8956c6b257e2cf2a69373c90a0f35e.1627418762.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627418762.git.rgoldwyn@suse.com>
References: <cover.1627418762.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Instead of using kmalloc() to allocate btrfs_ioctl_quota_rescan_args,
allocate btrfs_ioctl_quota_rescan_args on stack.

sizeof(btrfs_ioctl_quota_rescan_args) = 64

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ioctl.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9c3acc539052..291c16d8576b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4390,25 +4390,20 @@ static long btrfs_ioctl_quota_rescan(struct file *file, void __user *arg)
 static long btrfs_ioctl_quota_rescan_status(struct btrfs_fs_info *fs_info,
 						void __user *arg)
 {
-	struct btrfs_ioctl_quota_rescan_args *qsa;
+	struct btrfs_ioctl_quota_rescan_args qsa = {0};
 	int ret = 0;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	qsa = kzalloc(sizeof(*qsa), GFP_KERNEL);
-	if (!qsa)
-		return -ENOMEM;
-
 	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
-		qsa->flags = 1;
-		qsa->progress = fs_info->qgroup_rescan_progress.objectid;
+		qsa.flags = 1;
+		qsa.progress = fs_info->qgroup_rescan_progress.objectid;
 	}
 
-	if (copy_to_user(arg, qsa, sizeof(*qsa)))
+	if (copy_to_user(arg, &qsa, sizeof(qsa)))
 		ret = -EFAULT;
 
-	kfree(qsa);
 	return ret;
 }
 
-- 
2.32.0

