Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0A2776EBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 05:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjHJDsz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 23:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjHJDsy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 23:48:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764772103;
        Wed,  9 Aug 2023 20:48:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 98e67ed59e1d1-268030e1be7so280936a91.3;
        Wed, 09 Aug 2023 20:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691639333; x=1692244133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a6fjyFtan3bq/wFT/Yckkpe7Z7dQtrqMIfKgmPiHogI=;
        b=QeQM5RcI0eUCVm6KcwGNOhcR6eLCARxjVTahLZWKFIgIoWN3UJf2tsI45IicXqpdpQ
         3cJ76sMUDnTsSxrQsjcRqDxfVmRuMG++P3FIRAbtN/uKM3AWvwg9La04Uc4FJy9mvWga
         idN89cgPw5sYiT4qzkwA2K46MpSbfOjgnvjsBAX6DlnOnIK0Ysn+0LUcgDWbyasic7ua
         dr9tVJ+jlBNlDILfR0KNNVCjGzcu9dREBrSY/I9YbXmaicg9eytK3lWzDl2ZNsL9q1Bu
         DSN/s2+SQh29BaJZQudkuGvmcbchHWDvoTb2mTEKdWWHohNyrsay9iz6fRvVInQNVO74
         Fasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691639333; x=1692244133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6fjyFtan3bq/wFT/Yckkpe7Z7dQtrqMIfKgmPiHogI=;
        b=knP32teZn15I1BjpMsYDtcFWZArJx+XNRmPLhqypLbpXiDvIHcc6YPKTBF7SIzZ5na
         qjOgVIZ44ACNz9vc+n0Dow+hTNPCEQqGtL6PaBMhJrPG1w8ycHuD5T688xOz89CQLDCY
         ju8KIOemP7nsslgqXf85udf41N5/OigDSXRgQ7LNesNeGY6hewb1F9euvm8ccGEZ0A0S
         Y0MUcZpwBLsWY+DhboKT0QxF0FqRbTz8hXxyInLl33Qfi82pjjg4vUcjjBOouYU3e1rE
         OYQzmyFlZopQjQVauiGhFcez7NnzKddMU9azCO8VA4t5nhR5Jqk9AjIOWsyXdMb6MhOM
         77ag==
X-Gm-Message-State: AOJu0Yyjr7X1uNB44GgqTq2yWKsmYYfBygfznSchGc/IQdMoQZJMox97
        4YfEXjrmTKzntdDR8ufgiOIEQ2kWN9AYVBLmTPI=
X-Google-Smtp-Source: AGHT+IFNHOSLJPgj+cJW2LdvBWijtuzPfZvEf9GWRogHiR5q9J4NTrUKNB+OOkFXZaWdBi4jLH1QTQ==
X-Received: by 2002:a17:90b:4a0b:b0:268:2500:b17e with SMTP id kk11-20020a17090b4a0b00b002682500b17emr928610pjb.23.1691639332851;
        Wed, 09 Aug 2023 20:48:52 -0700 (PDT)
Received: from localhost.localdomain ([218.66.91.195])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090a678600b002641a9faa01sm2220531pjj.52.2023.08.09.20.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 20:48:52 -0700 (PDT)
From:   xiaoshoukui <xiaoshoukui@gmail.com>
To:     josef@toxicpanda.com, dsterba@suse.com, clm@fb.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui <xiaoshoukui@gmail.com>,
        xiaoshoukui <xiaoshoukui@ruijie.com.cn>
Subject: [PATCH] btrfs: fix return value when race occur between balance and cancel/pause
Date:   Wed,  9 Aug 2023 23:48:10 -0400
Message-Id: <20230810034810.23934-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Issue a pause or cancel IOCTL request after judging that there is no
pause or cancel request on the path of __btrfs_balance to return 0,
which will mislead the user that the pause or cancel requests are
successful.In fact, the balance request has not been paused or canceled.

On that race condition, a non-zero errno should be returned to the user.

Signed-off-by: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
---
 fs/btrfs/fs.h      |  6 ++++++
 fs/btrfs/volumes.c | 14 +++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 203d2a267828..c27def881922 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -93,6 +93,12 @@ enum {
 	 */
 	BTRFS_FS_BALANCE_RUNNING,
 
+	/* Indicate that balance has been paused. */
+	BTRFS_FS_BALANCE_PAUSED,
+
+	/* Indicate that balance has been canceled. */
+	BTRFS_FS_BALANCE_CANCELED,
+
 	/*
 	 * Indicate that relocation of a chunk has started, it's set per chunk
 	 * and is toggled between chunks.
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2ecb76cf3d91..839ce1808f23 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4267,7 +4267,6 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	u64 num_devices;
 	unsigned seq;
 	bool reducing_redundancy;
-	bool paused = false;
 	int i;
 
 	if (btrfs_fs_closing(fs_info) ||
@@ -4390,6 +4389,8 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	ASSERT(!test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
 	set_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags);
 	describe_balance_start_or_resume(fs_info);
+	clear_bit(BTRFS_FS_BALANCE_PAUSED, &fs_info->flags);
+	clear_bit(BTRFS_FS_BALANCE_CANCELED, &fs_info->flags);
 	mutex_unlock(&fs_info->balance_mutex);
 
 	ret = __btrfs_balance(fs_info);
@@ -4398,7 +4399,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req)) {
 		btrfs_info(fs_info, "balance: paused");
 		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
-		paused = true;
+		set_bit(BTRFS_FS_BALANCE_PAUSED, &fs_info->flags);
 	}
 	/*
 	 * Balance can be canceled by:
@@ -4415,8 +4416,10 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	 *
 	 * So here we only check the return value to catch canceled balance.
 	 */
-	else if (ret == -ECANCELED || ret == -EINTR)
+	else if (ret == -ECANCELED || ret == -EINTR) {
 		btrfs_info(fs_info, "balance: canceled");
+		set_bit(BTRFS_FS_BALANCE_CANCELED, &fs_info->flags);
+	}
 	else
 		btrfs_info(fs_info, "balance: ended with status: %d", ret);
 
@@ -4428,7 +4431,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	}
 
 	/* We didn't pause, we can clean everything up. */
-	if (!paused) {
+	if (!test_bit(BTRFS_FS_BALANCE_PAUSED, &fs_info->flags)) {
 		reset_balance_state(fs_info);
 		btrfs_exclop_finish(fs_info);
 	}
@@ -4587,6 +4590,7 @@ int btrfs_pause_balance(struct btrfs_fs_info *fs_info)
 		/* we are good with balance_ctl ripped off from under us */
 		BUG_ON(test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
 		atomic_dec(&fs_info->balance_pause_req);
+		ret = test_bit(BTRFS_FS_BALANCE_PAUSED, &fs_info->flags) ? 0 : -EINVAL;
 	} else {
 		ret = -ENOTCONN;
 	}
@@ -4642,7 +4646,7 @@ int btrfs_cancel_balance(struct btrfs_fs_info *fs_info)
 		test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
 	atomic_dec(&fs_info->balance_cancel_req);
 	mutex_unlock(&fs_info->balance_mutex);
-	return 0;
+	return test_bit(BTRFS_FS_BALANCE_CANCELED, &fs_info->flags) ? 0 : -EINVAL;
 }
 
 int btrfs_uuid_scan_kthread(void *data)
-- 
2.20.1

