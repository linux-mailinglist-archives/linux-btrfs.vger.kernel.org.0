Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC26016F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 21:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJQTJl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 15:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiJQTJd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 15:09:33 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803CDE82
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:30 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i12so8013946qvs.2
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIPZ9UOjvk2gRUyzeQTAQLyHf8+XHrgFBnj+8ZbKSj0=;
        b=dyGo727uYGV4s0bsRIXke6cIl1gBwolu883DZkt2SDnzUrXWgvFFNzR10cLFNFFRge
         l9C2BDVMPT1uuAt+7YhoF/wOExyquTPkqKxKWl76N/ZXespHDQ7A2UHIc3E1LqVVkBn/
         qY4gn+3orWZYHsaKILdjXkJNOCbdbcXR3KLn4LBiC5d9uY/SotAaeDh0QGaZQCYR2LGL
         PtPDEvAYfRJ4qWAB0pS+oGxX4xu08rVR6tlRMgFoscz1IEuui2QyaQ6YqXXlGBZnKFza
         jjMHYU9e0OINiCYMPOm7UEya6iLq07A+Yh3hl+AL5ujxdQsoxegnOjUKGe+RicisHpIm
         9ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIPZ9UOjvk2gRUyzeQTAQLyHf8+XHrgFBnj+8ZbKSj0=;
        b=BqSVudxAZDnKOUi1AYTMJUdwS6ugaZ20SLvWmSYkRg+iO9iGEKShUI96cVztrxjslx
         8i1BhgS2OVWXF0FPaePkxUAssicggJrrFx9dm8jY9leP0BXYYzV1+iZbVSrNISxPPWwh
         KyNeoQS2luLTAbP4bCF11SGsCXM+G6gBUDiqsSrdPeiQvVVeDiePE5kf2Vumd2fMwoxh
         kH3UniC/f1u4pilTz0u+OPPjIWDTdc2neFwaoxR5T4Qp6XZzC5NOcWi80tiAYTDYnkJp
         7obNMp/DPC0oulKkC/nkxn117ZgKqSoQXATTieVHatFBr0VeI7OCQ63oY1ijU/7bRYEP
         Rk8g==
X-Gm-Message-State: ACrzQf0DEMKi/+RGLBfnIlUz7onKanYczRcoOdF9rpmdLb6+5sry5ZkH
        i5ovjzWq0j0vrqdoc0x87Lqv+m/8HVsZJw==
X-Google-Smtp-Source: AMsMyM4u7OmO0jW5ZiHTySTsHLphgqoeexouLpIahZbnDSQPzcaoQM7B9xwrdxe3urGp8nEJySUyHA==
X-Received: by 2002:a05:6214:2483:b0:4b3:99ff:87a4 with SMTP id gi3-20020a056214248300b004b399ff87a4mr9717338qvb.18.1666033769100;
        Mon, 17 Oct 2022 12:09:29 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a24cd00b006ce76811a07sm415855qkn.75.2022.10.17.12.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:09:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 10/16] btrfs: add a BTRFS_FS_NEED_TRANS_COMMIT flag
Date:   Mon, 17 Oct 2022 15:09:07 -0400
Message-Id: <243a33d43e7c4cf294762fff62a9dfa45c64fe6c.1666033501.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666033501.git.josef@toxicpanda.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we are only using fs_info->pending_changes to indicate that we
need a transaction commit.  The original users for this were removed
years ago, so this is the only remaining reason to have this field.  Add
a flag so we can remove this code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/fs.h          | 3 +++
 fs/btrfs/super.c       | 3 ++-
 fs/btrfs/sysfs.c       | 4 ++--
 fs/btrfs/transaction.c | 2 ++
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 2d06add70695..7b221d37ad0e 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -90,6 +90,9 @@ enum {
 	/* Indicate we have to finish a zone to do next allocation. */
 	BTRFS_FS_NEED_ZONE_FINISH,
 
+	/* Indicate that we want to commit the transaction. */
+	BTRFS_FS_NEED_TRANS_COMMIT,
+
 #if BITS_PER_LONG == 32
 	/* Indicate if we have error/warn message printed on 32bit systems */
 	BTRFS_FS_32BIT_ERROR,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6d67d7ae99e9..0ec69466dfbc 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1534,7 +1534,8 @@ int btrfs_sync_fs(struct super_block *sb, int wait)
 			 * Exit unless we have some pending changes
 			 * that need to go through commit
 			 */
-			if (fs_info->pending_changes == 0)
+			if (!test_bit(BTRFS_FS_NEED_TRANS_COMMIT,
+				      &fs_info->flags))
 				return 0;
 			/*
 			 * A non-blocking test if the fs is frozen. We must not
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 0d98984af0e9..eb1a98991ec3 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -250,7 +250,7 @@ static ssize_t btrfs_feature_attr_store(struct kobject *kobj,
 	/*
 	 * We don't want to do full transaction commit from inside sysfs
 	 */
-	btrfs_set_pending(fs_info, COMMIT);
+	set_bit(BTRFS_FS_NEED_TRANS_COMMIT, &fs_info->flags);
 	wake_up_process(fs_info->transaction_kthread);
 
 	return count;
@@ -961,7 +961,7 @@ static ssize_t btrfs_label_store(struct kobject *kobj,
 	/*
 	 * We don't want to do full transaction commit from inside sysfs
 	 */
-	btrfs_set_pending(fs_info, COMMIT);
+	set_bit(BTRFS_FS_NEED_TRANS_COMMIT, &fs_info->flags);
 	wake_up_process(fs_info->transaction_kthread);
 
 	return len;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index bae77fb05e2b..7b6b68ab089a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2104,6 +2104,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	ASSERT(refcount_read(&trans->use_count) == 1);
 	btrfs_trans_state_lockdep_acquire(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_START);
 
+	clear_bit(BTRFS_FS_NEED_TRANS_COMMIT, &fs_info->flags);
+
 	/* Stop the commit early if ->aborted is set */
 	if (TRANS_ABORTED(cur_trans)) {
 		ret = cur_trans->aborted;
-- 
2.26.3

