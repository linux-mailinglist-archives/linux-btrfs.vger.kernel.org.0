Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F2D604A22
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 16:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiJSO6S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiJSO5j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 10:57:39 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4358C008
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:15 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c23so11794833qtw.8
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkAvfWsQfIHZLrhEGYk8sZRr6xjLwMSH76B471+Zzis=;
        b=hbm8xzUZKsY6cvWr+Tu7QXK7uYWZI93GsyP5tZeapQCa+8ckrIq4LYf4ryZ7Edo6Qf
         gFrPHkVvJ2BptCq/7UIeQdobULszsfLBFbjKh/SFLwMEmKxU1NCQqNz3pM5ddAcSdMER
         Q29VlcQqtuigOs0kU86PRFxPxQ5cjRN+XVqZTeJFaYtJ8VpfXYBBA7Ni6vA8pbWSuI3h
         zMnnO3nXTs2+xwIkmuxzkLzFImQG6Q/UqRQsfgXhlWAEt7ErIIqnBRsb7RFbWV2q36C0
         sbh50pC1IEJD3cr/JYGTKeYq1QCnsczkX3YANxsIaJkPkTU9mnjOx9731RPcKzTiH5TD
         4qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkAvfWsQfIHZLrhEGYk8sZRr6xjLwMSH76B471+Zzis=;
        b=rGkgNDp+vu+fpszZoIJgwwnngi5rYVYV6OXeRp/NV5yEtITaK+baTobWy9VXSPvHw5
         hH8zYm4SsRhsQH0yJUwi5atkfyxIbMbEKYSGZZ+1LgD6NNzq+PNebbal1FQlr6fZ5/hi
         X1DQXqduigS0D+0BcELkiAl2oCv81C3hF4g+35BaKP04XKd4pByqWEVYSo8o/rgTwMW/
         68UzT81ohbRxt4hPjqb8b6kp+nO+WpdzrNqyIrCJP5GE5tyMExe3DruauCXCL7iJfk6e
         w2tRLQ9QGgyPzwbQbx+ZwfO+Er8WeqhRLdlYtpGxXL+dx5PJfUpSJP8y9hY1o2CUdTbc
         wntw==
X-Gm-Message-State: ACrzQf3L85SI507CLAgnuuYwZvatjF/v2t5JpYWWqiOw7Lx4Sz1+41A/
        mTJMRQMgGMVIOrF7jtE4Wx8FlNsz4QMYAg==
X-Google-Smtp-Source: AMsMyM712GT96VQtED6NAlf2gggsbYys3O/ebIQt3J+wHd+/BeyWS5/evw2InPGonBFAuNQK0vvjxw==
X-Received: by 2002:ac8:5b06:0:b0:39c:f518:d275 with SMTP id m6-20020ac85b06000000b0039cf518d275mr6849568qtw.598.1666191075126;
        Wed, 19 Oct 2022 07:51:15 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bw15-20020a05622a098f00b0035d08c1da35sm4186924qtb.45.2022.10.19.07.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:51:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 09/15] btrfs: add a BTRFS_FS_NEED_TRANS_COMMIT flag
Date:   Wed, 19 Oct 2022 10:50:55 -0400
Message-Id: <9c3c50c6a36b7d56e3bc9bb883f5f0209d0dbcd8.1666190849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666190849.git.josef@toxicpanda.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
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

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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
index daab56b6a582..7e9c1bff2fd6 100644
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

