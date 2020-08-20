Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B130024C200
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgHTPTS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbgHTPSo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:18:44 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDBCC061385
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:18:44 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id t23so1439873qto.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NfZip0B6HrwzL7mhLNkjgPcjRjrbeHtA73GtQi3tDOY=;
        b=KKPe77sEhXxTWvZmpF2TxQnf45icXA4f6aN6m7A/Tye+Ig2MUvkO/FpGUTjh4rfNtB
         BtHopxFBLusW6ab7vMvzZqOq2qdxTYdiyCyYR7atzxtuN3pmlge0rmPMb60qJlPRpWuA
         G07Gjlb1euf+lfULayLHPMbLQYUPwFHyGFWUKMeZxh7enA49jpplAMd5vg40c2psPRfj
         jaK3pciZpZXKSQjP4n0rCTxP1JN59DJ/vj2d4fW6543FNXKoI9ZOw6izmT65S+d5X5Kq
         lXil3BNaz9y8OxF0O6f+pVs9XPANrUwuvLaYQ6JQ6Wt4MDP3xYtsjhIRHgzaZL3mzWRv
         U9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NfZip0B6HrwzL7mhLNkjgPcjRjrbeHtA73GtQi3tDOY=;
        b=t459LMb9DvNLpdEf4EML+io4yln/Lw9psbal4+PKb4h0AlQ7IJZlNvDWGyKRcJmz9O
         Ah5uG05++ef4zF25csb+FSTUJ+PbNUjBNZ6SJKNHzc0THMlz42fsJU86BiX05ZsY91Il
         04WOMic0hK5Hh0r5q2iNxtt4lNm8BEtDTJHdVSMXxQreyTqFb1QqxHkAJxincVNiFZmG
         1aoyipzep+hhdbKqE/VNbgGbC1NBv5MYOsxaFbXlrMMkPyasg9U2f6b24LzH3G3T0HSG
         jwPOG8Nd4rEChDK/houN8btEjjDQrFGka2e2fTwJ8PnBL515qQKB3/J1FRSAg43jT4ju
         WXqA==
X-Gm-Message-State: AOAM530fDu2l87Peh0t14R71lkoQ3OEGqeJxIRkbJxxgPb0nMQ1dANC3
        8KXkowLdCv5zLzGEGYtIQowlHj2QaO7myKMe
X-Google-Smtp-Source: ABdhPJwnnjtoL/ZEb9nrcKEw6X9/nuplKCbZcTNnt9j1ixCpSxgV1eTUQm1XH9zfPjAuc0ShIEUumQ==
X-Received: by 2002:ac8:387b:: with SMTP id r56mr3115848qtb.353.1597936722220;
        Thu, 20 Aug 2020 08:18:42 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u39sm3558021qtc.54.2020.08.20.08.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:18:41 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/8] btrfs: move btrfs_rm_dev_replace_free_srcdev outside of all locks
Date:   Thu, 20 Aug 2020 11:18:27 -0400
Message-Id: <2dff3bfc2d268096b2e2a3df854e683d741f2038.1597936173.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597936173.git.josef@toxicpanda.com>
References: <cover.1597936173.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When closing and freeing the source device we could end up doing our
final blkdev_put() on the bdev, which will grab the bd_mutex.  As such
we want to be holding as few locks as possible, so move this call
outside of the dev_replace->lock_finishing_cancel_unmount lock.  Since
we're modifying the fs_devices we need to make sure we're holding the
uuid_mutex here, so take that as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/dev-replace.c | 3 ++-
 fs/btrfs/volumes.c     | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index cd240714a7af..580e60fe07d0 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -748,7 +748,6 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &src_device->dev_state))
 		btrfs_scratch_superblocks(fs_info, src_device->bdev,
 					  src_device->name->str);
-	btrfs_rm_dev_replace_free_srcdev(src_device);
 
 	/* write back the superblocks */
 	trans = btrfs_start_transaction(root, 0);
@@ -757,6 +756,8 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 
 	mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
 
+	btrfs_rm_dev_replace_free_srcdev(src_device);
+
 	return 0;
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 33ecfcb472a8..4247ac0ebb71 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2223,6 +2223,8 @@ void btrfs_rm_dev_replace_free_srcdev(struct btrfs_device *srcdev)
 	struct btrfs_fs_info *fs_info = srcdev->fs_info;
 	struct btrfs_fs_devices *fs_devices = srcdev->fs_devices;
 
+	mutex_lock(&uuid_mutex);
+
 	btrfs_close_bdev(srcdev);
 	synchronize_rcu();
 	btrfs_free_device(srcdev);
@@ -2251,6 +2253,7 @@ void btrfs_rm_dev_replace_free_srcdev(struct btrfs_device *srcdev)
 		close_fs_devices(fs_devices);
 		free_fs_devices(fs_devices);
 	}
+	mutex_unlock(&uuid_mutex);
 }
 
 void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
-- 
2.24.1

