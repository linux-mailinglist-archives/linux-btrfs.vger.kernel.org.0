Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9422CDD5C
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbgLCSYb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgLCSYb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:31 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E1CC08E861
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:21 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id z3so2040619qtw.9
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1hxcsJJMk0pDGd/bRGloTbtUHmPw3bnputB8RyBCEY=;
        b=kOh5ya8vHdJpMJOrJ3HCpEmhF064utkPXo/V1Wi9lWSCspMEDWWqvLghvsyaerclt+
         PxR1F1VArM0gVKMkkushzZTM/cPV7bYYeSgwKFwHJBBNAaHrHC1grt3j26IWae6bn8i2
         6shni9QacACIBvycZuDs2Eh4tlsy84Oe2u4CPzK8lpKYpmLWcW9a+LOCI2iJJLhpKHpc
         Bwvxx5llQBGP83ISF9mlx6+Cg086NO0cs7h9KAgA8e/ic4xkN3WjTy9veSknWYMQkwFb
         M7tACzmcOok6qfnYbleEBSePFvoVOyvY2lz9DUpMGzEDqLWbu9cdD8KCM2AYdEr4z52t
         d1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1hxcsJJMk0pDGd/bRGloTbtUHmPw3bnputB8RyBCEY=;
        b=NZEV1Ifuw6yeX7zC6/u+dlAF5JSmQ5sXkoXCDlvwmMglg28spSOXlVCuwcaHmqN3zm
         vY3sQl3rMOADbNGxqtkwqGSuPNEJVzQbVl+3sWl1FKfComS/X99qza0lku1qGi+XTYSS
         rbzrdYw3/lsez2pLpdhkQylsy2YljDFtmSzDb1XmB4qa1XrhSLtKYEPUDRQMGqqpslef
         EBCb+6K0gXB/h9s36blO+2v+Q9WBpT+0c/EZDArkrQEXGi8+5PVGnm7Y+6EpE2+8nAIN
         rTV5EJXt/HnboaHC7KZN60Qf/qzpb1UDGLIFIMtLEBLNwlQVCSfQOVnX/VRCzVq4Htrw
         759g==
X-Gm-Message-State: AOAM530zGCIfkhpy4377Cern3hM39wNIlMioCHZ+nT6D39/XJPCjWPD9
        Zq/Ta2VlU2ryidYO5klXcNjVQSov3tzXGNaC
X-Google-Smtp-Source: ABdhPJyKpQscEC7PLXTaR31UflR6CxpRI5PDfj/izD6UUheC6XP/T9tbk52VQ5AnJ8MQNTLHqa4HOA==
X-Received: by 2002:ac8:5a04:: with SMTP id n4mr4689843qta.21.1607019800401;
        Thu, 03 Dec 2020 10:23:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i84sm1962571qke.33.2020.12.03.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 11/53] btrfs: convert some BUG_ON()'s to ASSERT()'s in do_relocation
Date:   Thu,  3 Dec 2020 13:22:17 -0500
Message-Id: <75c7203dee9bda02d57b197d78689fdbb2598f23.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few of these are checking for correctness, and won't be triggered by
corrupted file systems, so convert them to ASSERT() instead of BUG_ON()
and add a comment explaining their existence.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ce935139d87b..d0ce771a2a8d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2183,7 +2183,11 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 	int slot;
 	int ret = 0;
 
-	BUG_ON(lowest && node->eb);
+	/*
+	 * If we are lowest then this is the first time we're processing this
+	 * block, and thus shouldn't have an eb associated with it yet.
+	 */
+	ASSERT(!lowest || !node->eb);
 
 	path->lowest_level = node->level + 1;
 	rc->backref_cache.path[node->level] = node;
@@ -2268,7 +2272,11 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			free_extent_buffer(eb);
 			if (ret < 0)
 				goto next;
-			BUG_ON(node->eb != eb);
+			/*
+			 * We've just cow'ed this block, it should have updated
+			 * the correct backref node entry.
+			 */
+			ASSERT(node->eb == eb);
 		} else {
 			btrfs_set_node_blockptr(upper->eb, slot,
 						node->eb->start);
@@ -2304,7 +2312,12 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 	}
 
 	path->lowest_level = 0;
-	BUG_ON(ret == -ENOSPC);
+
+	/*
+	 * We should have allocated all of our space in the block rsv and thus
+	 * shouldn't ENOSPC.
+	 */
+	ASSERT(ret != -ENOSPC);
 	return ret;
 }
 
-- 
2.26.2

