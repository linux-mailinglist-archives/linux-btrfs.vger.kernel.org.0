Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0062B0FEE
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgKLVTT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgKLVTS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:18 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EFBC0617A6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:18 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id r12so3548724qvq.13
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vNPpTKp6c6BXRh7PbiDw5UpyJhq+RfdEvBBUR78rbdQ=;
        b=ihbHkZj2d7ttFfGD5SXuAzR6JwnEBfTznOhMmmj53vMKpeNfwnS+FmU4PgIUwhJTcE
         sDkjLEC2mlpUAnW6KxKMc6mPDJGcyIJQ2tnBuagllquQdQ+eMFEUtxOHWCqJK1HQBBMz
         AZq+3YJm4EcMSmCHDqOLoW1z5jHePlCKfaufXL+02vbYUkTCvkViUVk8ZOUQ8ivRa/bu
         c334ymsWvsLjB5dhMmn30ytobuRNHfS7qydAhxWllPQXZolH06647y8WWwv1NkbqdcUE
         7FDNxKlk3tp39Hj2LD6XB38BQsWvAeACHxJDAGnP/tsDzQE7vNbCW3l2sSmdbiG/QfEO
         3DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vNPpTKp6c6BXRh7PbiDw5UpyJhq+RfdEvBBUR78rbdQ=;
        b=czyn2M9y9WZLJs7jN/wGGxloUJrxZsP7FCyW9uK8e540WmqWp6zgaRVXL9HkeWtyvQ
         L+jZszWIsWzXQCosVXw9lla+6ODScMyxb1jmmRdYQs2eZ9u/jE7vD2tTnynxK7noTlU1
         6eJZ1AdLrnQcoL4k07g32ngLSgu3kztbEQkdac6f+PATQNfAIdLK6kfz4vLddZuMVfBb
         2sweo9ceEifwOdhjMFwjryY/aJXUR9mB1PaLdD2KUWM85mLlhToNdSta60bf0PFz1L9L
         KaIsIlmVFsb/z4gBbIwD4Jly7QOxh4Ypmfb8rFJqfEcgZGar7bPo2y18VamHRwjvYB/a
         xsdw==
X-Gm-Message-State: AOAM5336rlnerLRJ+vmHJKvRXK2J6iY/41gc7XO/xjxtLYMYr530vTet
        3Oe8SYJABK6BGe2G5Ut9Aq9EFDLem1xbpg==
X-Google-Smtp-Source: ABdhPJwNXqk5pgND7FZUSQd/yOdcXdzH8K5vLNyjgDJi/1bWnXW0G+PurA39s1JW0KrdiRLO2pimwg==
X-Received: by 2002:a0c:e2cc:: with SMTP id t12mr1655569qvl.61.1605215957512;
        Thu, 12 Nov 2020 13:19:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b197sm5316510qkg.65.2020.11.12.13.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/42] btrfs: convert some BUG_ON()'s to ASSERT()'s in do_relocation
Date:   Thu, 12 Nov 2020 16:18:30 -0500
Message-Id: <52f1533d5f879aabc06d4680f528c98f460ce2e3.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
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
index 0b3ccf464c3d..6c9bba61bfde 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2215,7 +2215,11 @@ static int do_relocation(struct btrfs_trans_handle *trans,
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
@@ -2316,7 +2320,11 @@ static int do_relocation(struct btrfs_trans_handle *trans,
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
@@ -2352,7 +2360,12 @@ static int do_relocation(struct btrfs_trans_handle *trans,
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

