Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1E7549EFC
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 22:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbiFMUZ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 16:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345141AbiFMUZs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 16:25:48 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DE8E1E
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 12:09:55 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d128so4762075qkg.8
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 12:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=L3HmWojr2JmTxSUewu7GkimDGqJGcPi0k5W/20qRvYQ=;
        b=RGg25Lo1EyLrtMgrkK4DdX+C0VboDmfL/35s48HHcxxXV9y4cWdg8rASK9KtLzDSy0
         XRCzbCRDD0dal8EuUB79TPs630GhZGVkl6wq9YlfvgFP649kdnfqwyfChM6cLuBaQuV6
         RhYRnZkIrI+1LB8Ktg8YKtw0wEHsJPP7QlR7a75vF2SV/jTJiKBuo8AnSsuzXiGH/YqS
         epiekHeNR2JAMTtgqUqrScJbdPGX4INBZU3kVqxzPvvIBz2RlPk5E3CoZdUFuyd2WYj+
         FtnnsdX4mxWngeQ5zi+LxqIuslP9DvHXQRUTwc7j62qAoJFDK7ZTyIEtr3e+uJrNxujW
         CCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3HmWojr2JmTxSUewu7GkimDGqJGcPi0k5W/20qRvYQ=;
        b=KTdi6JFm2suDjN12SFON0Bb3k0a53BUkngZqgYDpmH1Y+4prm4fQIxaqr49zWAzQIA
         crd/dUxGm/ubwOYtvj+wpjHWxIIly++9GhYaNIg3oRyv5EJ+rhw6xPk3VVqG72yDksZz
         FsUrHLnG178fxDTkbw/a7ZWXTM3I/qa4ceVxODT9RF+k11LVaGRqmZStBe+VcoEro3mE
         j83LkI0qq9nq7zSEhpvp4LqsD66NqbrVDRCKgCM7x1eUoH2d5vbQ/E6a2JySqNU/Ak1k
         JHZ+HrS5HiuDQx+e+R5NjO7jwOvfQrrwifYEH86sVcbZLVMvLHMpy7AYnjeli3FtXAcV
         5JoA==
X-Gm-Message-State: AOAM533vszsYPcaWcBgfJIkrCEg60U/W8yu2dMTyRgMQJXCsDQMpr7+3
        9M0j+GM6vIKBD1YPEVp9+/zFamsv7aoGww==
X-Google-Smtp-Source: ABdhPJwdVr2KVVX7C9F6nUvOBCavTtWIV+NsJPZJDuMidKb2NvCW/WQYABVbqQRAThLIwdor0gMrFw==
X-Received: by 2002:a05:620a:1b8c:b0:6a6:cb62:98fb with SMTP id dv12-20020a05620a1b8c00b006a6cb6298fbmr1207465qkb.511.1655147394044;
        Mon, 13 Jun 2022 12:09:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k19-20020a05620a415300b006a6ad90a117sm7731029qko.105.2022.06.13.12.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:09:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/2] btrfs: fix deadlock with fsync+fiemap+transaction commit
Date:   Mon, 13 Jun 2022 15:09:49 -0400
Message-Id: <ab07b2566b325add9edb0e63b4ddfc3b4a7aee29.1655147296.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1655147296.git.josef@toxicpanda.com>
References: <cover.1655147296.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are hitting the following deadlock in production occasionally

Task 1		Task 2		Task 3		Task 4		Task 5
		fsync(A)
		 start trans
						start commit
				falloc(A)
				 lock 5m-10m
				 start trans
				  wait for commit
fiemap(A)
 lock 0-10m
  wait for 5m-10m
   (have 0-5m locked)

		 have btrfs_need_log_full_commit
		  !full_sync
		  wait_ordered_extents
								finish_ordered_io(A)
								lock 0-5m
								DEADLOCK

We have an existing dependency of file extent lock -> transaction.
However in fsync if we tried to do the fast logging, but then had to
fall back to committing the transaction, we will be forced to call
btrfs_wait_ordered_range() to make sure all of our extents are updated.

This creates a dependency of transaction -> file extent lock, because
btrfs_finish_ordered_io() will need to take the file extent lock in
order to run the ordered extents.

Fix this by stopping the transaction if we have to do the full commit
and we attempted to do the fast logging.  Then attach to the transaction
and commit it if we need to.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 67 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 157cf60b635a..33affa388fa4 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2323,25 +2323,62 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 
-	if (ret != BTRFS_NO_LOG_SYNC) {
+	if (ret == BTRFS_NO_LOG_SYNC) {
+		ret = btrfs_end_transaction(trans);
+		goto out;
+	}
+
+	/* We successfully logged the inode, attempt to sync the log. */
+	if (!ret) {
+		ret = btrfs_sync_log(trans, root, &ctx);
 		if (!ret) {
-			ret = btrfs_sync_log(trans, root, &ctx);
-			if (!ret) {
-				ret = btrfs_end_transaction(trans);
-				goto out;
-			}
-		}
-		if (!full_sync) {
-			ret = btrfs_wait_ordered_range(inode, start, len);
-			if (ret) {
-				btrfs_end_transaction(trans);
-				goto out;
-			}
+			ret = btrfs_end_transaction(trans);
+			goto out;
 		}
-		ret = btrfs_commit_transaction(trans);
-	} else {
+	}
+
+	/*
+	 * At this point we need to commit the transaction because we had
+	 * btrfs_need_log_full_commit() or some other error.
+	 *
+	 * If we didn't do a full sync we have to stop the trans handle, wait on
+	 * the ordered extents, start it again and commit the transaction.  If
+	 * we attempt to wait on the ordered extents here we could deadlock with
+	 * something like fallocate() that is holding the extent lock trying to
+	 * start a transaction while some other thread is trying to commit the
+	 * transaction while we (fsync) are currently holding the transaction
+	 * open.
+	 */
+	if (!full_sync) {
 		ret = btrfs_end_transaction(trans);
+		if (ret)
+			goto out;
+		ret = btrfs_wait_ordered_range(inode, start, len);
+		if (ret)
+			goto out;
+
+		/*
+		 * This is safe to use here because we're only interested in
+		 * making sure the transaction that had the ordered extents is
+		 * committed.  We aren't waiting on anything past this point,
+		 * we're purely getting the transaction and committing it.
+		 */
+		trans = btrfs_attach_transaction_barrier(root);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+
+			/*
+			 * We committed the transaction and there's no currently
+			 * running transaction, this means everything we care
+			 * about made it to disk and we are done.
+			 */
+			if (ret == -ENOENT)
+				ret = 0;
+			goto out;
+		}
 	}
+
+	ret = btrfs_commit_transaction(trans);
 out:
 	ASSERT(list_empty(&ctx.list));
 	err = file_check_and_advance_wb_err(file);
-- 
2.26.3

