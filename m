Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A8E517FDA
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 10:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiECIkR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 04:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiECIkN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 04:40:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D0F340F1
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 01:36:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7F451210EB;
        Tue,  3 May 2022 08:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651567000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xmfvhxTdXDlArRzJO+HR0nLVeo4BO8y+yeK8ecmjCTg=;
        b=DA5MSeeNGRYfFq6X0EUVn9D0khnfRybIEx387tH0c2V2B5nbIO0BINV2yPrphuVLGaGKsK
        OtGuNvr+70yC1boMQDlq/2SLn/CsS2QjpAsDDQNkoZ0qX5RC0xmBHkVLR+VpAjCrPn5Z2Q
        4N5jXsqaqgXvhIs2/L9yVWoBmZpIt8w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28AAE13ABE;
        Tue,  3 May 2022 08:36:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eBE4B5jpcGIQPgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 03 May 2022 08:36:40 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs: Use btrfs_try_lock_balance in btrfs_ioctl_balance
Date:   Tue,  3 May 2022 11:36:37 +0300
Message-Id: <20220503083637.1051023-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503083637.1051023-1-nborisov@suse.com>
References: <20220503083637.1051023-1-nborisov@suse.com>
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
---
 fs/btrfs/ioctl.c | 52 ++++++------------------------------------------
 1 file changed, 6 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8e0cc17d5f81..f2cfbce9bec4 100644
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
@@ -4529,6 +4488,7 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 	if (need_unlock)
 		btrfs_exclop_finish(fs_info);
 out:
+	kfree(bargs);
 	mnt_drop_write_file(file);
 	kfree(bargs);
 	return ret;
-- 
2.25.1

