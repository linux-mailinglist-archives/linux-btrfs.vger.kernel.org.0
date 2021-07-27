Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398023D819A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 23:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhG0VTi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 17:19:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45978 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhG0VSA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 17:18:00 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD3882017E;
        Tue, 27 Jul 2021 21:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627420678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEyIH/bOS8Bn4awUHidr6TSJf8z50TURL1HGFB7wI8k=;
        b=XHQs5X3Q32kOVSgi22PHq4NvhB3oU4IQEezyaKjf4Yy24nNhlP2hVjrGXs1sYOHhrqLv3o
        7b9L0OgW0uQeriD5FMov6uCrYkaMjxkkdFTVq1l2pUV4Wb9cJA7EykewsbWda/B2rsrPPZ
        ODp4DhmDGtkyDun0USqJQ0B56MuQhrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627420678;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEyIH/bOS8Bn4awUHidr6TSJf8z50TURL1HGFB7wI8k=;
        b=XZrILikg2renP7pQUQrtP9XbDwdEs7c0Bu2qS/mlzac+53X/MTp22uKy/iBKdnZhfyUZtC
        fwOHOqDvATyb0LDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6FAAF133DE;
        Tue, 27 Jul 2021 21:17:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id pCOkBwZ4AGGBdQAAGKfGzw
        (envelope-from <rgoldwyn@suse.de>); Tue, 27 Jul 2021 21:17:58 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 4/7] btrfs: Allocate btrfs_ioctl_balance_args on stack
Date:   Tue, 27 Jul 2021 16:17:28 -0500
Message-Id: <320216bed8e0c28e9235571db1962cbb1e18366a.1627418762.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627418762.git.rgoldwyn@suse.com>
References: <cover.1627418762.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Instead of using kmalloc() to allocate btrfs_ioctl_balance_args, allocate
btrfs_ioctl_balance_args on stack.

sizeof(btrfs_ioctl_balance_args) = 1024

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ioctl.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 90b134b5a653..9c3acc539052 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4141,7 +4141,7 @@ static long btrfs_ioctl_balance_ctl(struct btrfs_fs_info *fs_info, int cmd)
 static long btrfs_ioctl_balance_progress(struct btrfs_fs_info *fs_info,
 					 void __user *arg)
 {
-	struct btrfs_ioctl_balance_args *bargs;
+	struct btrfs_ioctl_balance_args bargs = {0};
 	int ret = 0;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -4153,18 +4153,11 @@ static long btrfs_ioctl_balance_progress(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
-	bargs = kzalloc(sizeof(*bargs), GFP_KERNEL);
-	if (!bargs) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	btrfs_update_ioctl_balance_args(fs_info, bargs);
+	btrfs_update_ioctl_balance_args(fs_info, &bargs);
 
-	if (copy_to_user(arg, bargs, sizeof(*bargs)))
+	if (copy_to_user(arg, &bargs, sizeof(bargs)))
 		ret = -EFAULT;
 
-	kfree(bargs);
 out:
 	mutex_unlock(&fs_info->balance_mutex);
 	return ret;
-- 
2.32.0

