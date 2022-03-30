Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F384EBD65
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 11:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244675AbiC3JQD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 05:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244672AbiC3JQB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 05:16:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655B624F0F
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 02:14:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1140D1F869;
        Wed, 30 Mar 2022 09:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648631654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+579GB3bO1XjdDo8ll7aKrXFnRMRr87ztY9PEQDUsU=;
        b=AtaRvfBCTi7G+zZHWjWAjdL50m2H7KdBcZMRS2ZrEgi92kzk7Qa7xEYagd3NmaY3d6ZvYM
        xVsXS5TsJgO3WxMH8hv/Km1UJTOtecP6Wa1D9j8eB7lfi2upNz9dpOTiwX58k+d/bCfyw9
        S6QXcB6klAKky9xsl+lyGQyJqyWdCd0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE1BF13A60;
        Wed, 30 Mar 2022 09:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WIZgL2UfRGKiVQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 30 Mar 2022 09:14:13 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/3] btrfs: simplify codeflow in btrfs_ioctl_balance
Date:   Wed, 30 Mar 2022 12:14:07 +0300
Message-Id: <20220330091407.1319454-4-nborisov@suse.com>
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

Move code in btrfs_ioctl_balance to simplify its code flow. This is
possible thanks to the removal of balance v1 ioctl and ensuring 'arg'
argument is always present. First move the code duplicating the userspace
arg to the kernel 'barg'. This makes the out_unlock label redundant.
Secondly, check the validity of bargs::flags before copying to the
dynamically allocated 'bctl'. This removes the need for the out_bctl
label.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ioctl.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 95e47e6f8d41..a5484a098b92 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4353,6 +4353,12 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 	if (ret)
 		return ret;
 
+	bargs = memdup_user(arg, sizeof(*bargs));
+	if (IS_ERR(bargs)) {
+		ret = PTR_ERR(bargs);
+		goto out;
+	}
+
 again:
 	if (btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
 		mutex_lock(&fs_info->balance_mutex);
@@ -4400,13 +4406,6 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 	}
 
 locked:
-
-	bargs = memdup_user(arg, sizeof(*bargs));
-	if (IS_ERR(bargs)) {
-		ret = PTR_ERR(bargs);
-		goto out_unlock;
-	}
-
 	if (bargs->flags & BTRFS_BALANCE_RESUME) {
 		if (!fs_info->balance_ctl) {
 			ret = -ENOTCONN;
@@ -4422,6 +4421,11 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 		goto do_balance;
 	}
 
+	if (bargs->flags & ~(BTRFS_BALANCE_ARGS_MASK | BTRFS_BALANCE_TYPE_MASK)) {
+		ret = -EINVAL;
+		goto out_bargs;
+	}
+
 	if (fs_info->balance_ctl) {
 		ret = -EINPROGRESS;
 		goto out_bargs;
@@ -4438,12 +4442,6 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 	memcpy(&bctl->sys, &bargs->sys, sizeof(bctl->sys));
 
 	bctl->flags = bargs->flags;
-
-	if (bctl->flags & ~(BTRFS_BALANCE_ARGS_MASK | BTRFS_BALANCE_TYPE_MASK)) {
-		ret = -EINVAL;
-		goto out_bctl;
-	}
-
 do_balance:
 	/*
 	 * Ownership of bctl and exclusive operation goes to btrfs_balance.
@@ -4461,11 +4459,9 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 			ret = -EFAULT;
 	}
 
-out_bctl:
 	kfree(bctl);
 out_bargs:
 	kfree(bargs);
-out_unlock:
 	mutex_unlock(&fs_info->balance_mutex);
 	if (need_unlock)
 		btrfs_exclop_finish(fs_info);
-- 
2.25.1

