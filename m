Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E53517FD9
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 10:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiECIkO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 04:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiECIkM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 04:40:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63037340F0
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 01:36:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 176F4210EA;
        Tue,  3 May 2022 08:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651567000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kj4sB7GY1v9BtXZqfU2Vq/eUw/5wtc7IXEhC7fep08c=;
        b=Be91MW39k+BtBbm3oxuLiULBOLUwKxHfWMaE59/J4ZqlycdYjfy98wbU/ARyPlF0p1nv2o
        usp1ZaGffb0qoW3ARVijV4zRtQAy2RI39gshZUIJC7hQpjlJKO7sEJfEhnAPRH31EWDclN
        7D3f/YG5ditoOhKjercapajxhWTX+rc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7F9C13ABE;
        Tue,  3 May 2022 08:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OMoMMpfpcGIQPgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 03 May 2022 08:36:39 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs: Introduce btrfs_try_lock_balance
Date:   Tue,  3 May 2022 11:36:36 +0300
Message-Id: <20220503083637.1051023-2-nborisov@suse.com>
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

This function contains the factored out locking sequence
btrfs_ioctl_balance. Having this piece of code separate helps to
simplify btrfs_ioctl_balance which has turned into a boiling pile of
spaghetti. This will be used in the next patch to streamline the logic
in btrfs_ioctl_balance.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ioctl.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9d8e46815ee4..8e0cc17d5f81 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4334,6 +4334,72 @@ void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
 	spin_unlock(&fs_info->balance_lock);
 }
 
+/**
+ * Try to acquire fs_info::balance_Mutex as well as set BTRFS_EXLCOP_BALANCE as
+ * required.
+ *
+ * @fs_info:       context of the filesystem
+ * @excl_acquired: ptr to boolean value which is set to 'false' in case balance
+ * is being resumed.
+ *
+ * Returns 0 on success in which case both fs_info::balance is acquired as well
+ * as exclusive ops are blocked. In case of failure returns an error code.
+ *
+ */
+static int btrfs_try_lock_balance(struct btrfs_fs_info *fs_info, bool *excl_acquired)
+{
+	int ret;
+	/*
+	 * mut. excl. ops lock is locked.  Three possibilities:
+	 *   (1) some other op is running
+	 *   (2) balance is running
+	 *   (3) balance is paused -- special case (think resume)
+	 */
+	while (1) {
+		if (btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
+			*excl_acquired = true;
+			mutex_lock(&fs_info->balance_mutex);
+			return 0;
+		}
+
+		mutex_lock(&fs_info->balance_mutex);
+		if (fs_info->balance_ctl) {
+			/* this is either (2) or (3) */
+			if (test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
+				/* this is (2) */
+				ret = -EINPROGRESS;
+				goto out_failure;
+
+			} else {
+				mutex_unlock(&fs_info->balance_mutex);
+				/*
+				 * Lock released to allow other waiters to continue,
+				 * we'll reexamine the status again.
+				 */
+				mutex_lock(&fs_info->balance_mutex);
+
+				if (fs_info->balance_ctl &&
+				    !test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
+					/* this is (3) */
+					*excl_acquired = false;
+					return 0;
+				}
+			}
+		} else {
+			/* this is (1) */
+			ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
+			goto out_failure;
+		}
+
+		mutex_unlock(&fs_info->balance_mutex);
+	}
+
+out_failure:
+	mutex_unlock(&fs_info->balance_mutex);
+	*excl_acquired = false;
+	return ret;
+}
+
 static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 {
 	struct btrfs_root *root = BTRFS_I(file_inode(file))->root;
-- 
2.25.1

