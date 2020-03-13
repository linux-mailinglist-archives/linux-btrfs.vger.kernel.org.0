Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C50351850FA
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgCMVXt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:23:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36599 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgCMVXt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:23:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id m33so8889890qtb.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3bzkhfqzWMmAJ4gZzV7IJCBqN4f9yRHKvpdAmjxOuo0=;
        b=BMoVIvEe0ocuIqilqDRxVSRlmD19zINsNZoYBfA+jFNGFiHp1cX/FaW0qb0k97e/at
         BISLeu+IONIy3KJ+4N8wpFmb8Y1xqoPvwIE/j1aVTUEGVWeZ8FE2LlQKaWEC91PKzgxR
         jLRiZPcxXgIxFwbcq4RnKZ7MM8eFPKwmzudbrwwN47nS+R+2dxkMfrbOCdN0CQSxZNM1
         b5gmA2Eg4iHjsTMFwwe/mFiLWe21o5y8IbH4dxmlIG5/zZcvcEceRFgrs0c3Imw/4JdB
         FtIIQANa0GB/GXp6w3AngDou3L1Vfw4GCAlIqbdSQwLVo0+5/fq+SqnFONJ0Jd6/cK8F
         GBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bzkhfqzWMmAJ4gZzV7IJCBqN4f9yRHKvpdAmjxOuo0=;
        b=BoAeqy0UNTvn1oFI9lQQB52L/Gz7MD9KBoHxnGVoYBW2JKoZVN6X126tFXhNLUspcc
         SIGcawaGu3ZXpQeKOJD4qWwY1quLBL6Y+MDqD2Sde+WJ7YtIalEtjuaE3XLHhJIDVPgL
         YOGnKccB5852Ts9/7hS5dq18dJ7kUCDDZ15cyvU7ozrqcXd9bVapNY4iHaZ3Y7Az9/2T
         bDPv0E+6RBfPDsovABXpElSQ+UwdiJKyEAISNhWqlXliEHWt9JD1DrGX1tgA3w9PaCpt
         B39WXOGnoRJGIx8sZmzkQwRbAjgYW+VmcJqUcSPx9CMathv4Lj0xC1Jo9M2vklquOpGp
         Q46g==
X-Gm-Message-State: ANhLgQ3wGJx9hv654CVSzbcfIWbv3IaQOauGOITLPsKHlcjx3bIV05r4
        96uRIinq3Nvc8YZ8RI3szMZG0KTKWEUMKg==
X-Google-Smtp-Source: ADFU+vtE/UfM/B/0fY5DsdJ+0dzpp0MezafE2mwh7Upj3qxcb3aTjXeWDhTRB0WpdIDmnqUcAFnZnw==
X-Received: by 2002:aed:3ed0:: with SMTP id o16mr14566678qtf.3.1584134626561;
        Fri, 13 Mar 2020 14:23:46 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l60sm9335970qtd.35.2020.03.13.14.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:23:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/13] btrfs: adjust the arguments for btrfs_should_throttle_delayed_refs
Date:   Fri, 13 Mar 2020 17:23:25 -0400
Message-Id: <20200313212330.149024-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313212330.149024-1-josef@toxicpanda.com>
References: <20200313212330.149024-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We want to be able to call this without a trans handle being open, so
adjust the arguments to be the fs_info and the delayed_ref_root instead
of the trans handle.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 8 ++++----
 fs/btrfs/delayed-ref.h | 3 ++-
 fs/btrfs/extent-tree.c | 2 +-
 fs/btrfs/inode.c       | 5 +++--
 fs/btrfs/transaction.c | 5 +++--
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 6e9fa03be87d..e709f051320a 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -50,16 +50,16 @@ bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
-bool btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans,
+bool btrfs_should_throttle_delayed_refs(struct btrfs_fs_info *fs_info,
+					struct btrfs_delayed_ref_root *delayed_refs,
 					bool for_throttle)
 {
-	u64 num_entries =
-		atomic_read(&trans->transaction->delayed_refs.num_entries);
+	u64 num_entries = atomic_read(&delayed_refs->num_entries);
 	u64 avg_runtime;
 	u64 val;
 
 	smp_mb();
-	avg_runtime = trans->fs_info->avg_delayed_ref_runtime;
+	avg_runtime = fs_info->avg_delayed_ref_runtime;
 	val = num_entries * avg_runtime;
 	if (val >= NSEC_PER_SEC)
 		return true;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index c0ae440434af..3ea3a1627d26 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -371,7 +371,8 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
 				       struct btrfs_block_rsv *src,
 				       u64 num_bytes);
-bool btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans,
+bool btrfs_should_throttle_delayed_refs(struct btrfs_fs_info *fs_info,
+					struct btrfs_delayed_ref_root *delayed_refs,
 					bool for_throttle);
 bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0e81990b57e0..b9b96e4db65f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2272,7 +2272,7 @@ static void btrfs_async_run_delayed_refs(struct work_struct *work)
 		}
 
 		/* No longer over our threshold, lets bail. */
-		if (!btrfs_should_throttle_delayed_refs(trans, true)) {
+		if (!btrfs_should_throttle_delayed_refs(fs_info, &trans->transaction->delayed_refs, true)) {
 			btrfs_end_transaction(trans);
 			break;
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ad0f0961a711..c9815ed03d21 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4349,8 +4349,9 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				break;
 			}
 			if (be_nice) {
-				if (btrfs_should_throttle_delayed_refs(trans,
-								       true) ||
+				if (btrfs_should_throttle_delayed_refs(fs_info,
+					&trans->transaction->delayed_refs,
+					true) ||
 				    btrfs_check_space_for_delayed_refs(fs_info))
 					should_throttle = true;
 			}
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 7f994ab73b0b..cf8fab22782f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -865,7 +865,7 @@ int btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
 	    cur_trans->delayed_refs.flushing)
 		return 1;
 
-	if (btrfs_should_throttle_delayed_refs(trans, true) ||
+	if (btrfs_should_throttle_delayed_refs(fs_info, &cur_trans->delayed_refs, true) ||
 	    btrfs_check_space_for_delayed_refs(fs_info))
 		return 1;
 
@@ -907,7 +907,8 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 		return 0;
 	}
 
-	if (btrfs_should_throttle_delayed_refs(trans, true))
+	if (btrfs_should_throttle_delayed_refs(info,
+					       &cur_trans->delayed_refs, true))
 		run_async = true;
 
 	btrfs_trans_release_metadata(trans);
-- 
2.24.1

