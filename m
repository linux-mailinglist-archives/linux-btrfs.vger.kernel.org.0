Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499104C56BF
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Feb 2022 17:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiBZQEQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Feb 2022 11:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiBZQEO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Feb 2022 11:04:14 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26184B3E4D
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Feb 2022 08:03:40 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id c9so7292473pll.0
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Feb 2022 08:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QIEhPB83qYc8Eyj33boB2cVATa+lgYef4lJiclxhrP4=;
        b=iVdLkU0cBUTRQ53o1ASNq3aonFSeMRa9aDiDcrcf4HIHuwAtkkx+VDLCUFLSwCzDt+
         ZywrTKbV2xK7OXCnRPYFGquJ6+ih4bpDPFnmNkN/mbXLuYrscm6ifr4ul/b65pHXfoMh
         MZfoEfKi+p3xlDvYR+hVcHg3062SD59aUCgTUPteBZ6dQUZ1onTbSzFiBDIWl0bdQPEO
         iZ1gOU24btQYmhFgExWHsRxKB+Xu6nQcAWqfWaazQ2foUcdnScAXliUL1LcYmNFWTRrB
         1Dl7hbRV8oGzt/0dEtveoRnYa8YPvid1xTMfknOsmZf1O1WIg/7ySOnZigU6GqV1LgRK
         eNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QIEhPB83qYc8Eyj33boB2cVATa+lgYef4lJiclxhrP4=;
        b=SutC4fuanEBvv5pfYISDOvxBJPRf0naIVVrv6Uhp3tNO60lG/tiKySNqwdohOBbBYb
         TczJIrllBJ98EeyxWucYXLFuDvp+WF+GJYx41BGVOLrjSEi38DhitcfvjwuF+mB0woGp
         1oGEAU//yeZD9mkY0dtuC3eJc4ZfIeqGy1DJ2RtTmrnI7f+bAH+urv/uFSqAMVatNtoY
         eez4QC61ucN5wpYJbz38Zt2kfqy40inVHKg9sIMNTvpaedlxygx7idCXf+TF8k1XNH7G
         bqOyKW6nwoG1hRxM5aFOQ9KX6enQuxBHlLO7uMqDr2wfJqGgC8T6frtAG0blCjXf3Vcf
         B/gw==
X-Gm-Message-State: AOAM5325Iije0+tvLG3DClkv4Su5wOglW32Cg1FTzezQ1J3YyfjQlHxq
        zv/bZTwBIPNVOCSSpkAU2/c=
X-Google-Smtp-Source: ABdhPJyM+0jx2H9cBwr/UPHtIctk7VXoIkUt02CC0TZKmuPNprqu7ueLE3DNsSBeyHm9Jn5g3smz/w==
X-Received: by 2002:a17:90a:4383:b0:1bc:f9da:f339 with SMTP id r3-20020a17090a438300b001bcf9daf339mr7169892pjg.160.1645891419575;
        Sat, 26 Feb 2022 08:03:39 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a910400b001bd171c7fd4sm2139915pjo.25.2022.02.26.08.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 08:03:38 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     Filipe Manana <fdmanana@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3] btrfs: qgroup: fix deadlock between rescan worker and remove qgroup
Date:   Sat, 26 Feb 2022 16:03:30 +0000
Message-Id: <20220226160330.19122-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The commit e804861bd4e6 ("btrfs: fix deadlock between quota disable and
qgroup rescan worker") by Kawasaki resolves deadlock between quota
disable and qgroup rescan worker. but also there is a deadlock case like
it. It's about enabling or disabling quota and creating or removing
qgroup. It can be reproduced in simple script below.

for i in {1..100}
do
    btrfs quota enable /mnt &
    btrfs qgroup create 1/0 /mnt &
    btrfs qgroup destroy 1/0 /mnt &
    btrfs quota disable /mnt &
done

Here's why the deadlock happens:

1) The quota rescan task is running.

2) Task A calls btrfs_quota_disable(), locks the qgroup_ioctl_lock
   mutex, and then calls btrfs_qgroup_wait_for_completion(), to wait for
   the quota rescan task to complete.

3) Task B calls btrfs_remove_qgroup() and it blocks when trying to lock
   the qgroup_ioctl_lock mutex, because it's being held by task A. At that
   To  resolve this issue, The thread disabling quota should unlock
   int task B is holding a transaction handle for the current transaction.

4) The quota rescan task calls btrfs_commit_transaction(). This results
   in it waiting for all other tasks to release their handles on the
   transaction, but task B is blocked on the qgroup_ioctl_lock mutex
   while holding a handle on the transaction, and that mutex is being held
   by task A, which is waiting for the quota rescan task to complete,
   resulting in a deadlock between these 3 tasks.

To resolve this issue, The thread disabling quota should unlock
qgroup_ioctl_lock before waiting rescan completion. This patch moves
btrfs_qgroup_wait_for_completion() after qgroup_ioctl_lock().

Fixes: e804861bd4e6 ("btrfs: fix deadlock between quota disable and
qgroup rescan worker")
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v3: fix comments, typos, changelog.
v2: add comments, move locking before clear_bit.
---
 fs/btrfs/qgroup.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 2c0dd6b8a80c..1866b1f0da01 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1213,6 +1213,14 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	if (!fs_info->quota_root)
 		goto out;
 
+	/*
+	 * Unlock the qgroup_ioctl_lock mutex before waiting for the rescan worker to
+	 * complete. Otherwise we can deadlock because btrfs_remove_qgroup() needs
+	 * to lock that mutex while holding a transaction handle and the rescan
+	 * worker needs to commit a transaction.
+	 */
+	mutex_unlock(&fs_info->qgroup_ioctl_lock);
+
 	/*
 	 * Request qgroup rescan worker to complete and wait for it. This wait
 	 * must be done before transaction start for quota disable since it may
@@ -1220,7 +1228,6 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	 */
 	clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
 	btrfs_qgroup_wait_for_completion(fs_info, false);
-	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 
 	/*
 	 * 1 For the root item
-- 
2.25.1

