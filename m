Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC344C60B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 02:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiB1Bot (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 20:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiB1Bos (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 20:44:48 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327091C90C
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 17:44:11 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i21so9620655pfd.13
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 17:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Mok+Xgf2uNHp71rOnRGYOG3FLhvu99pbyqqdGns38Q=;
        b=fEbmmKCKoLcldVZ1SWLwcaWcEx2PYAhV1EB51ybUkayY2ctv+MLuuvxtVkUlb0E+iT
         bkdmWR4y26wPxthIc0ovdig+5toPy20oBBWo4dPsbvD1wIj42PWQJk1+gLiQVyIInx2G
         aQLKUsZ8Ei+FE7bAypIsTq8QEVAJY+nHcJOl4xeqEaRvuuR44Ic2b9isRqJhV4HIR7+o
         NqEUlGEtsEm/H31LHJzut6sunAblSpnaqi8o3xC3bv6zaqXUYTypYXOtMbpqOsYJLuhh
         XTQ4CnlXtJLIBuX4il8MV3em1KthyJxalofSSBz1+B6Vjfe6tCAl4BckI+ZWZN5doRGh
         mwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Mok+Xgf2uNHp71rOnRGYOG3FLhvu99pbyqqdGns38Q=;
        b=5/y5UGzcb22mQe/ADN8MjiVy+HKBCeF0O0kXL0ua2JYqwfOgF65hA19qojDQt/vEAP
         hom+1i/X+F0t1rLS63Zr5gQWA4bnexo0K8Wipi0ZSeHm+ZCgZCi7sI29IJmlhWZATVJh
         YHfakjGKJ7J+Ub8kKqpYA67CFccmp4DTg4gLTsE6x/aLPYkV6Uc4xHjQACkPFvfi8UfF
         TfqDy6HgRFkKaB7kn7/3Txmy6geT4bQEbaXIMX7obJr4ybNSzycJJzyBXHdr9IzxsNtG
         GlRU4Heps/CIAyrT38tCme323MCHq9E1f42lVPgkzFpkvMAGi2NSNOAy/5emUdCqP9z0
         ZTlQ==
X-Gm-Message-State: AOAM531cXnHrTNuccfqGULvCj6ydP0e1Vdt2yl4F0s/7Tqmjrab1O5W6
        xWkBc+XfCxE/LR/5dWQYTP4=
X-Google-Smtp-Source: ABdhPJwJBiQ8Wn/5i7hPy+4szg/70Xl6GefkEKkwIxdjmy/Kz1r+UPCi6SPpfm/4EZNAs+PKaRS72A==
X-Received: by 2002:a63:344d:0:b0:365:4b07:1270 with SMTP id b74-20020a63344d000000b003654b071270mr15052522pga.482.1646012650755;
        Sun, 27 Feb 2022 17:44:10 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id u19-20020a056a00099300b004e16e381696sm10961022pfg.195.2022.02.27.17.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 17:44:10 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Filipe Manana <fdmanana@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v4] btrfs: qgroup: fix deadlock between rescan worker and remove qgroup
Date:   Mon, 28 Feb 2022 01:43:40 +0000
Message-Id: <20220228014340.21309-1-realwakka@gmail.com>
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
disable and qgroup rescan worker. But also there is a deadlock case like
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
   point task B is holding a transaction handle for the current transaction.

4) The quota rescan task calls btrfs_commit_transaction(). This results
   in it waiting for all other tasks to release their handles on the
   transaction, but task B is blocked on the qgroup_ioctl_lock mutex
   while holding a handle on the transaction, and that mutex is being held
   by task A, which is waiting for the quota rescan task to complete,
   resulting in a deadlock between these 3 tasks.

To resolve this issue, the thread disabling quota should unlock
qgroup_ioctl_lock before waiting rescan completion. Move
btrfs_qgroup_wait_for_completion() after unlock of qgroup_ioctl_lock.

Fixes: e804861bd4e6 ("btrfs: fix deadlock between quota disable and
qgroup rescan worker")
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v4: fix typos, changelog.
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

