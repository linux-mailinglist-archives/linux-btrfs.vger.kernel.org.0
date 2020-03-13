Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEB1B1850F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgCMVXq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:23:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34856 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbgCMVXp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:23:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id v15so8905665qto.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xUvBswjML/4+Dx341tUBSu6yL8oEwj7QbCZkK/CEvjg=;
        b=Hmk06ZL5NprUSqt+pQKc/zzuXRzh5qxUZWcceBeD2YXrMtH4nFuehdpIL/+cFgHMq+
         5lzIdb8DQH/bQprrMSFrUOoj6mNNTrzvwjBwjN7FP5wIIxA2FPpLEYHrb5Z2QnLOYTks
         g0CwadSrAofLxPVApUP4N0jj1zD+Yg2Xw0JXVdAOo/0fCFfNF14xMzyJdVRJ6TUHwUfe
         lWeSEP1F0tuGai99lmDPZevK/rlUTmru6Hm+2+jiynHLxtarCx1wREP/m0N/1LH8Q83k
         /br/XQ5aiITMR8vnI+DItpvDQVVrDFp9wcvqfqu7axkAU+wtp48RpSbFKIXQ+I6lYd59
         BBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xUvBswjML/4+Dx341tUBSu6yL8oEwj7QbCZkK/CEvjg=;
        b=N9d9KXYM+X0/0D2PLxB/KmPmDEoxrMgv6gm1iAwXyqzEW1qMsFsc5/k5L3SzM8i9Wq
         LOWzCENzeBuA9SMm2EKaPcMELcUFOOT38wGj6taS/3tRcJ+tCGiAzTxcWa6v2kRZ2QPD
         8daWi1Rv6om4Omv5daXNIXILYRHe9uwTNZF1fL/rpBvD4NQOs+R62GIIUhFm7xWVmsfm
         zNmwnV7frYUyWf1ASSYGjcdeT9orebmYk+ygT0sHnKyLHp+y1+Cdpkrt6pUrmkBV4073
         wBfsVseMQeKuNjiw/yecajC866I2jswl8dpSmKr3T/UQ0DFYKzx3vHiP/ff7K6s40EDa
         C2fw==
X-Gm-Message-State: ANhLgQ1x9ISM+TQvkRcx0qY7V21kPOIqDSvKJt66ZZl150yXj/cvrjii
        L8++g4hK3lcuIT8/C6hpU6vthohAE+ffRA==
X-Google-Smtp-Source: ADFU+vv+zBHU7w+8vhicxE3w0Q1uxXWkLQQ0pTBA6MVoNOCOUwMhZRYT6sfDByeG5llZ7TQyptNRfg==
X-Received: by 2002:ac8:3694:: with SMTP id a20mr14676274qtc.362.1584134623146;
        Fri, 13 Mar 2020 14:23:43 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r207sm8263145qke.136.2020.03.13.14.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:23:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/13] btrfs: add a mode for delayed ref time based throttling
Date:   Fri, 13 Mar 2020 17:23:23 -0400
Message-Id: <20200313212330.149024-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313212330.149024-1-josef@toxicpanda.com>
References: <20200313212330.149024-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we only use btrfs_should_throttle_delayed_refs in the case
where we want to pre-emptively stop what we're doing and throttle
delayed refs in some way.  However we're going to use this function for
all transaction ending, so add a flag so we can toggle between the
maximum theoretical runtime and our "maybe we should start flushing"
runtime.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 9 +++++----
 fs/btrfs/delayed-ref.h | 3 ++-
 fs/btrfs/inode.c       | 3 ++-
 fs/btrfs/transaction.c | 2 +-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index e28565dc4288..6e9fa03be87d 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -50,7 +50,8 @@ bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
-bool btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans)
+bool btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans,
+					bool for_throttle)
 {
 	u64 num_entries =
 		atomic_read(&trans->transaction->delayed_refs.num_entries);
@@ -62,9 +63,9 @@ bool btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans)
 	val = num_entries * avg_runtime;
 	if (val >= NSEC_PER_SEC)
 		return true;
-	if (val >= NSEC_PER_SEC / 2)
-		return true;
-	return false;
+	if (!for_throttle)
+		return false;
+	return (val >= NSEC_PER_SEC / 2);
 }
 
 /**
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 9a07480b497b..c0ae440434af 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -371,7 +371,8 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
 				       struct btrfs_block_rsv *src,
 				       u64 num_bytes);
-bool btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans);
+bool btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans,
+					bool for_throttle);
 bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
 
 /*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d3e75e04a0a0..ad0f0961a711 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4349,7 +4349,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				break;
 			}
 			if (be_nice) {
-				if (btrfs_should_throttle_delayed_refs(trans) ||
+				if (btrfs_should_throttle_delayed_refs(trans,
+								       true) ||
 				    btrfs_check_space_for_delayed_refs(fs_info))
 					should_throttle = true;
 			}
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f6eecb402f5b..b0d82e1a6a6e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -865,7 +865,7 @@ int btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
 	    cur_trans->delayed_refs.flushing)
 		return 1;
 
-	if (btrfs_should_throttle_delayed_refs(trans) ||
+	if (btrfs_should_throttle_delayed_refs(trans, true) ||
 	    btrfs_check_space_for_delayed_refs(fs_info))
 		return 1;
 
-- 
2.24.1

