Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23275B8E0E
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 19:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiINRSo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 13:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiINRSb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 13:18:31 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04CF8169E
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:29 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id f26so9195622qto.11
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=mphGSGLEXcugkoP/KR0+n/oMBENnVxrhrdS3oehj72s=;
        b=mZU9gEqkQqJz0sBqngOfTH9xYCfb3iWtk+W1W3q8bYRg9wTmM6M8ZTv1EmxRXy1fVs
         TpXfMSeUT07TUdFBFa4+5ed7bvce8df5Rkg+RhnAamhwuSMNDYrbkQAg9GjQ21stnAMi
         1HJUq5lW/DQTtvY65PMJvm9NoZWL1ldyhZq1tGttyJaT5NhYRPfKo0l1Ct4HJsLK90Lr
         BXFlHLkpyRbfQT1erRyLYdQu/YMYz0MsmKpcyWNAYnNTfIREusGKk8pAJ+L2eSzHT3+6
         3ZSseh+BE81jCbzn/zU6+KUNhNUgUqEdGIsQWfMroPauJ3JMdzBv1c7MV5xWVC03STaa
         8cRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mphGSGLEXcugkoP/KR0+n/oMBENnVxrhrdS3oehj72s=;
        b=OvtcLCNGVrVZFogjfPwKpiDwSbvI4g10Kk9zJePuln3sH/WzGaU0JuiF9vHAO52/Su
         9ad77eHyidQmJhzC0tWwCFN9mlefTSQy4E5QvhXXHswSCr2N/aGmMNTRFdejhPMIioG9
         UdR/uuE5P6qMArXJ9oSpJOAeQ5xjtdKB+SOBRalR0879ELoAw6JH69nThk7LQcdwelLw
         i5Cay8koCZDOww6b6AdfHae82ui106lOpOqcZbJAyDjUWpSmBeuVoENE2ThwCm81mmwQ
         6aqwlInGi+2iELrp+m609769H5dJTd0MaAG9YIPupshkm+TQazvDrfuPdq0iwSFKHeTy
         WCeg==
X-Gm-Message-State: ACgBeo36ttpuRiioJPaTqkptfEhTcHeZtPB7OKGQSAdyflRKib/QN8fw
        w06VUmLRTFrhJcnnvZaC5nUN1GUmsTqSyw==
X-Google-Smtp-Source: AA6agR6LZR+fLWxnBMAeFsH73bXmU2KrjtjE7JAVnLeV2Qpbw0cQOIOmRdPuhOzsaIpwrHcQ64oT3Q==
X-Received: by 2002:a05:622a:134f:b0:35b:aeb2:ef69 with SMTP id w15-20020a05622a134f00b0035baeb2ef69mr17436714qtk.631.1663175909067;
        Wed, 14 Sep 2022 10:18:29 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b9-20020ac812c9000000b0035a6f972f84sm1828138qtj.62.2022.09.14.10.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:18:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/16] btrfs: push extra checks into __btrfs_abort_transaction
Date:   Wed, 14 Sep 2022 13:18:09 -0400
Message-Id: <6a4275319be8321bf3d87c2259a427ebdfa6d7cf.1663175597.git.josef@toxicpanda.com>
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

The btrfs_abort_transaction() macro uses quite a bit of flags and such
that aren't local to btrfs-printk.h.  Push this code down into
__btrfs_abort_transaction to allow for a cleaner header file.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs-printk.h | 24 +++---------------------
 fs/btrfs/super.c        | 17 +++++++++++++++--
 2 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/btrfs-printk.h b/fs/btrfs/btrfs-printk.h
index dd7a9fd4791c..7fd7c547c935 100644
--- a/fs/btrfs/btrfs-printk.h
+++ b/fs/btrfs/btrfs-printk.h
@@ -206,32 +206,14 @@ const char * __attribute_const__ btrfs_decode_error(int errno);
 __cold
 void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
 			       const char *function,
-			       unsigned int line, int errno, bool first_hit);
+			       unsigned int line, int errno);
 
 /*
  * Call btrfs_abort_transaction as early as possible when an error condition is
  * detected, that way the exact line number is reported.
  */
-#define btrfs_abort_transaction(trans, errno)		\
-do {								\
-	bool first = false;					\
-	/* Report first abort since mount */			\
-	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
-			&((trans)->fs_info->fs_state))) {	\
-		first = true;					\
-		if ((errno) != -EIO && (errno) != -EROFS) {		\
-			WARN(1, KERN_DEBUG				\
-			"BTRFS: Transaction aborted (error %d)\n",	\
-			(errno));					\
-		} else {						\
-			btrfs_debug((trans)->fs_info,			\
-				    "Transaction aborted (error %d)", \
-				  (errno));			\
-		}						\
-	}							\
-	__btrfs_abort_transaction((trans), __func__,		\
-				  __LINE__, (errno), first);	\
-} while (0)
+#define btrfs_abort_transaction(trans, errno)				\
+	__btrfs_abort_transaction((trans), __func__, __LINE__, (errno))
 
 #ifdef CONFIG_PRINTK_INDEX
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1b713c75ca08..6d5e161d94e1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -349,13 +349,26 @@ void __cold btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info)
 __cold
 void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
 			       const char *function,
-			       unsigned int line, int errno, bool first_hit)
+			       unsigned int line, int errno)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
+	bool first = false;
+
+	/* Report first abort since mount */
+	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,
+			      &fs_info->fs_state)) {
+		first = true;
+		if (errno != -EIO && errno != -EROFS)
+			WARN(1, KERN_DEBUG
+			     "BTRFS: Transaction aborted (error %d)\n", errno);
+		else
+			btrfs_debug(fs_info, "Transaction aborted (error %d)",
+				    errno);
+	}
 
 	WRITE_ONCE(trans->aborted, errno);
 	WRITE_ONCE(trans->transaction->aborted, errno);
-	if (first_hit && errno == -ENOSPC)
+	if (first && errno == -ENOSPC)
 		btrfs_dump_space_info_for_trans_abort(fs_info);
 	/* Wake up anybody who may be waiting on this transaction */
 	wake_up(&fs_info->transaction_wait);
-- 
2.26.3

