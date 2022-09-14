Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257B95B8E09
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 19:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiINRSw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 13:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiINRSk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 13:18:40 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D475F8169E
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:39 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id w4so12271930qvp.2
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=GkdnwvIYrOtFCJaszOI17lTbLCO1Ks+MN60VBWmLwjk=;
        b=W60yIoWtQNKzA1RJOkH5NgyXR+y8URRUtr5ieaig1n0hhS0tKyUDUnRAoSy75w+aGn
         3iPSNJF+4XHj6AfWcVPpSH7kSkm7ltwjtIuEFKRxc3GeJcxOvz7WKmoOB7xycttNroRx
         uphi/HUvLOPmmJe1TAbWBWc/X/bhAC1Y8KC3od4FXoMOJ3l5j8QONehLALU7FBIKzQUl
         RZ5UB4Fv2NBBwqNmEDHHA0bGybYW2D26+gfWB5LlxKjeENkhU0ozJTIrzK8odGXH4X8P
         REUzwHvAYVe7qHqmrkXHjudtExBZZK1mztUVLpW8sGjaVEerqhffSJWXn5yGw6LFE6By
         UTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GkdnwvIYrOtFCJaszOI17lTbLCO1Ks+MN60VBWmLwjk=;
        b=6iw5sTaYIWfD93eTz2SqXlhkl+43RkIwVckThUGsHqUCfeEcNRPlx2JN3U1GqhANyH
         gdLDv+Oq1kc4HSgMnQl4Shc1TUOVYCY20senGZz2rILvNQmt9hN16P7EC/gomuTo1y3w
         WT+SDDiXrfVrFeQf8Dh+mwZoG/lJBePE0/6P2uYUo5OJgyz3U4MjTzT+Np0SiLp1Nqco
         r0lmLAAReyccKblvrlidXU41s1Y6QsewdFzP8yFBggGFIhQN37MP7ZHPvJmQ2lmQ9N0r
         MijSk5xzbNl8oJsHOx0xDfrtIqgC/I/5Nclo94zBxZQvplK9oT8Xm7KOqQSkX2gfQmeV
         JGsg==
X-Gm-Message-State: ACgBeo3R9GoDLVZw2aWZSJO5AeZSuwFEznwID2uK47Kh1l6nmHpnV4jg
        aYbdUAp2CllukT0LAglywUxE1j0eOMhJ7w==
X-Google-Smtp-Source: AA6agR67OnVhlybgh6PpKiZ9QVinYqsxr0OcxnxqaDIvKb/yl7ZsDeOhO64YSMZpE7nh5ium9yo6xw==
X-Received: by 2002:a05:6214:242a:b0:4aa:9c94:5d77 with SMTP id gy10-20020a056214242a00b004aa9c945d77mr32336896qvb.99.1663175918599;
        Wed, 14 Sep 2022 10:18:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id fc13-20020a05622a488d00b0035a6b89412bsm1952578qtb.46.2022.09.14.10.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:18:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/16] btrfs: add a BTRFS_FS_NEED_TRANS_COMMIT flag
Date:   Wed, 14 Sep 2022 13:18:16 -0400
Message-Id: <14fb62f9388bc8f8a129a74f82abe5e7978d41fe.1663175597.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663175597.git.josef@toxicpanda.com>
References: <cover.1663175597.git.josef@toxicpanda.com>
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
index c7eb21768b66..6181657bdc90 100644
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
index 2865676b8327..63a639056882 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1547,7 +1547,8 @@ int btrfs_sync_fs(struct super_block *sb, int wait)
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
index 4acff123fe66..6a7ab762a543 100644
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

