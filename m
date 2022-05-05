Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4ED51B86F
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 09:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbiEEHMP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 03:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiEEHMO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 03:12:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A9A39B93
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 00:08:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C670D1F461;
        Thu,  5 May 2022 07:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651734513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7NeCP3H7LDbuKPJtWf4EWH7god/TdBi+pmuiZsAijr0=;
        b=KGrMhK8hkbLgTINguxhufMN9EPti+6zCk1DhHwv8xzAx5lS06E0OuWT+4VrMUTjsOQ7hgQ
        JhvkkUoAUDpxy1my54bEg6KR+817LvO7qlGjJve4FQxjTu/79tPB6DzpCWPZHQm0XunFhZ
        /Ln2xQPAODe/cAy1MXVseK853rIogHU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CE5613A65;
        Thu,  5 May 2022 07:08:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zXTIG/F3c2LKZwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 05 May 2022 07:08:33 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] btrfs: Use btrfs_try_lock_balance in btrfs_ioctl_balance
Date:   Thu,  5 May 2022 10:08:25 +0300
Message-Id: <20220505070825.1218337-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504152501.GQ18596@twin.jikos.cz>
References: <20220504152501.GQ18596@twin.jikos.cz>
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

This eliminates 2 labels and makes the code generally more streamlined.
Also rename the 'out_bargs' label to 'out_unlock' since bargs is going
to be freed under the 'out' label. This also fixes a memory leak since
bargs wasn't correctly freed in one of the condition which are now moved
in btrfs_try_lock_balance.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---

V2:
 * Removed extra call to kfree(bargs) which resulted in a double free

 fs/btrfs/ioctl.c | 51 +++++-------------------------------------------
 1 file changed, 5 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8e0cc17d5f81..9ac07eb7531c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4406,7 +4406,7 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_ioctl_balance_args *bargs;
 	struct btrfs_balance_control *bctl;
-	bool need_unlock; /* for mut. excl. ops lock */
+	bool need_unlock = true; /* for mut. excl. ops lock */
 	int ret;

 	if (!capable(CAP_SYS_ADMIN))
@@ -4423,53 +4423,12 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 		goto out;
 	}

-again:
-	if (btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
-		mutex_lock(&fs_info->balance_mutex);
-		need_unlock = true;
-		goto locked;
-	}
-
-	/*
-	 * mut. excl. ops lock is locked.  Three possibilities:
-	 *   (1) some other op is running
-	 *   (2) balance is running
-	 *   (3) balance is paused -- special case (think resume)
-	 */
-	mutex_lock(&fs_info->balance_mutex);
-	if (fs_info->balance_ctl) {
-		/* this is either (2) or (3) */
-		if (!test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
-			mutex_unlock(&fs_info->balance_mutex);
-			/*
-			 * Lock released to allow other waiters to continue,
-			 * we'll reexamine the status again.
-			 */
-			mutex_lock(&fs_info->balance_mutex);
-
-			if (fs_info->balance_ctl &&
-			    !test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
-				/* this is (3) */
-				need_unlock = false;
-				goto locked;
-			}
-
-			mutex_unlock(&fs_info->balance_mutex);
-			goto again;
-		} else {
-			/* this is (2) */
-			mutex_unlock(&fs_info->balance_mutex);
-			ret = -EINPROGRESS;
-			goto out;
-		}
-	} else {
-		/* this is (1) */
-		mutex_unlock(&fs_info->balance_mutex);
-		ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
+	ret = btrfs_try_lock_balance(fs_info, &need_unlock);
+	if (ret)
 		goto out;
-	}

-locked:
+	lockdep_assert_held(&fs_info->balance_mutex);
+
 	if (bargs->flags & BTRFS_BALANCE_RESUME) {
 		if (!fs_info->balance_ctl) {
 			ret = -ENOTCONN;
--
2.25.1

