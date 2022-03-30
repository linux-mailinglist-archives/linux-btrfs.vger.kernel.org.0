Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650094EBD66
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 11:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244673AbiC3JQC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 05:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244669AbiC3JQB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 05:16:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133D125290
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 02:14:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BB0841F7AD;
        Wed, 30 Mar 2022 09:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648631653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p64M8RfjhuB5vi2SCl88S0v+8f1QkZjBLyi49rc7s2s=;
        b=EQ+ogU57fG/hvqplZ/01YBbLNG8e5qzkK/GUi1dKksMSzk76DC7GYuO5SwqzQGRMlzqGgs
        T9/8SmgzXs53wymzDYRs8NMVD9TTa9IibTuWaSqMc6TergOfdJaQfhuKr/pDVFQSaHmDdw
        8e4gDFJUSfj49enFavIRWUOVcGD2eXI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83C2113A60;
        Wed, 30 Mar 2022 09:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kPRJHWUfRGKiVQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 30 Mar 2022 09:14:13 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs: remove checks for arg argument in btrfs_ioctl_balance
Date:   Wed, 30 Mar 2022 12:14:06 +0300
Message-Id: <20220330091407.1319454-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220330091407.1319454-1-nborisov@suse.com>
References: <20220330091407.1319454-1-nborisov@suse.com>
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

With the removal of balance v1 ioctl the 'arg' argument is guaranteed to
be present so simply remove all conditional code which checks for its
presence.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ioctl.c | 55 ++++++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index fe00dd88c281..95e47e6f8d41 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4346,10 +4346,6 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 	bool need_unlock; /* for mut. excl. ops lock */
 	int ret;
 
-	if (!arg)
-		btrfs_warn(fs_info,
-	"IOC_BALANCE ioctl (v1) is deprecated and will be removed in kernel 5.18");
-
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
@@ -4405,29 +4401,25 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 
 locked:
 
-	if (arg) {
-		bargs = memdup_user(arg, sizeof(*bargs));
-		if (IS_ERR(bargs)) {
-			ret = PTR_ERR(bargs);
-			goto out_unlock;
-		}
+	bargs = memdup_user(arg, sizeof(*bargs));
+	if (IS_ERR(bargs)) {
+		ret = PTR_ERR(bargs);
+		goto out_unlock;
+	}
 
-		if (bargs->flags & BTRFS_BALANCE_RESUME) {
-			if (!fs_info->balance_ctl) {
-				ret = -ENOTCONN;
-				goto out_bargs;
-			}
+	if (bargs->flags & BTRFS_BALANCE_RESUME) {
+		if (!fs_info->balance_ctl) {
+			ret = -ENOTCONN;
+			goto out_bargs;
+		}
 
-			bctl = fs_info->balance_ctl;
-			spin_lock(&fs_info->balance_lock);
-			bctl->flags |= BTRFS_BALANCE_RESUME;
-			spin_unlock(&fs_info->balance_lock);
-			btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE);
+		bctl = fs_info->balance_ctl;
+		spin_lock(&fs_info->balance_lock);
+		bctl->flags |= BTRFS_BALANCE_RESUME;
+		spin_unlock(&fs_info->balance_lock);
+		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE);
 
-			goto do_balance;
-		}
-	} else {
-		bargs = NULL;
+		goto do_balance;
 	}
 
 	if (fs_info->balance_ctl) {
@@ -4441,16 +4433,11 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 		goto out_bargs;
 	}
 
-	if (arg) {
-		memcpy(&bctl->data, &bargs->data, sizeof(bctl->data));
-		memcpy(&bctl->meta, &bargs->meta, sizeof(bctl->meta));
-		memcpy(&bctl->sys, &bargs->sys, sizeof(bctl->sys));
+	memcpy(&bctl->data, &bargs->data, sizeof(bctl->data));
+	memcpy(&bctl->meta, &bargs->meta, sizeof(bctl->meta));
+	memcpy(&bctl->sys, &bargs->sys, sizeof(bctl->sys));
 
-		bctl->flags = bargs->flags;
-	} else {
-		/* balance everything - no filters */
-		bctl->flags |= BTRFS_BALANCE_TYPE_MASK;
-	}
+	bctl->flags = bargs->flags;
 
 	if (bctl->flags & ~(BTRFS_BALANCE_ARGS_MASK | BTRFS_BALANCE_TYPE_MASK)) {
 		ret = -EINVAL;
@@ -4469,7 +4456,7 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 	ret = btrfs_balance(fs_info, bctl, bargs);
 	bctl = NULL;
 
-	if ((ret == 0 || ret == -ECANCELED) && arg) {
+	if (ret == 0 || ret == -ECANCELED) {
 		if (copy_to_user(arg, bargs, sizeof(*bargs)))
 			ret = -EFAULT;
 	}
-- 
2.25.1

