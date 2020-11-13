Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD222B202B
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgKMQXq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgKMQXq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:23:46 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0892AC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:46 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 199so9270462qkg.9
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=g6s31t2b6C+WkWpGcPNA4kML6UgtAiC7aEfq0l5x8tQ=;
        b=sB6fsPB3HXnXnA+y86crr0TlF+ngWOhZtTaGjs+w1308Z8LiT+YQpis3KrHbnElhL/
         Bk62RvyGhNyIV2xi4tPooyTDE1bmxtxxTGhS4ChE/9IEzMx6fba/SB2mLXJ0hCGOrY8Y
         6fpAHfh7XVfCJMrb91Z9EAiR1Aeu1+t3V8M0Nl1Tk9uO8yO9h39+/PvzJtyrsERe48ni
         DTW+dM/tuCr0Fxlz1gb84MJrRGdrh2LNLnfM30qAPxKfdtMwmQJTT3FQSIRozLd7c8R6
         QisIpDaDYzuo7mEUGf9hmYL8vZVQDSzw/ksJnk+/28gCil7y07lFCMM8cw4xDGuy+dzn
         vQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g6s31t2b6C+WkWpGcPNA4kML6UgtAiC7aEfq0l5x8tQ=;
        b=dHvlQxvoOrq5w9cfwyQGaLY/9r/MvXGjQu9CLbi4PbmN2Rk/KMPF2OFYm8+6GOIvN0
         V77USpYKhWBeyn6tK2VUx5e72tfCgz5iPWHgBB6Xi4wzkVTzMUwa3r+iYc8WS5zmuGf6
         7XuwQAiC/DLTvy6yZ5lzHTE4JKUSIlzgfyMc9ToqJ4HAAJliw2RQmQR5KT6fJWxodIHJ
         FT/Kl1NEs3sbcaDIdM0VaLILM9z+GA6r3yjM/eO3oleMVx1I83VS+ZlCT9b9QxttAonc
         UuQrSxiypMcszp6PpUvVaUtlb9OJwHznz151Tx0qnNC91+ON1O2b6z2bdzqkg/ih+lPD
         ImKw==
X-Gm-Message-State: AOAM531NXOmZrd5uU1DsmPquYHVHDRyZELVDO27DWSMVIVj59ay4NV9w
        KUhmV0dK22mOLcwAG1kL3z7RwbDYePqU+w==
X-Google-Smtp-Source: ABdhPJznDDgFByB0S97FRfqW5dQzR17jG6kSCTU1aWHx6ZCk2n6/HzGJehlKOwhmw4l1BiLRbu/+pA==
X-Received: by 2002:a37:8984:: with SMTP id l126mr2609336qkd.443.1605284619980;
        Fri, 13 Nov 2020 08:23:39 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k11sm7167825qtu.45.2020.11.13.08.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:23:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 03/42] btrfs: convert some BUG_ON()'s to ASSERT()'s in do_relocation
Date:   Fri, 13 Nov 2020 11:22:53 -0500
Message-Id: <229db2e4721b54d83e34728cb4c610b4574563ab.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few of these are checking for correctness, and won't be triggered by
corrupted file systems, so convert them to ASSERT() instead of BUG_ON()
and add a comment explaining their existence.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c5774a8e6ff7..d4cf982c78ff 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2194,7 +2194,11 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 	int ret;
 	int err = 0;
 
-	BUG_ON(lowest && node->eb);
+	/*
+	 * If we are lowest then this is the first time we're processing this
+	 * block, and thus shouldn't have an eb associated with it yet.
+	 */
+	ASSERT(!lowest || !node->eb);
 
 	path->lowest_level = node->level + 1;
 	rc->backref_cache.path[node->level] = node;
@@ -2287,7 +2291,11 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 				err = ret;
 				goto next;
 			}
-			BUG_ON(node->eb != eb);
+			/*
+			 * We've just cow'ed this block, it should have updated
+			 * the correct backref node entry.
+			 */
+			ASSERT(node->eb == eb);
 		} else {
 			btrfs_set_node_blockptr(upper->eb, slot,
 						node->eb->start);
@@ -2323,7 +2331,12 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 	}
 
 	path->lowest_level = 0;
-	BUG_ON(err == -ENOSPC);
+
+	/*
+	 * We should have allocated all of our space in the block rsv and thus
+	 * shouldn't ENOSPC.
+	 */
+	ASSERT(err != -ENOSPC);
 	return err;
 }
 
-- 
2.26.2

