Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DC62CC712
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgLBTwr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgLBTwr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:52:47 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0C5C061A4B
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:32 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id x13so1300403qvk.8
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cpU9buN2VEPJop1moRM5Z3zZpcBVRel/YpPKkoDWtA4=;
        b=a+kWQNR6xzHlfsguOXl5KOvr3wxuaD3IMWR6q2OKMKRFlVL//QvSaSOU9+ElXPw9B3
         1fXdj/ZChdnRzTAp/8eDqo+AUhgcN69jIpBIEdKF1hxvvUMGaF2/CMeN9WnCtimWXuob
         /N+IA0wJ+R0ewCbiZc9SvB8nod7F74NGu+Gx0KjfIUAaXFh8gL8JQlCGLEICUft5R89C
         7qVBr88U1S1E1vgRGrpddmmNyCw2Dj7pLMHkgQL1GkjiBzeH6k2XMb/k5/bMBXtqH5A+
         9458iRdIZC8yd5dTY6WQ2xiMcEiSu/V1/YsH/990cREYfCfwLPiIqnoJp2RSVX8R71S/
         6V7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cpU9buN2VEPJop1moRM5Z3zZpcBVRel/YpPKkoDWtA4=;
        b=m9ebPFU2STlN+N6sCMeKZFiORioztcwhtKZ0//FXAGJdhaEubFTwJG0D+Ec+RJ8LKE
         q4V/+1zXS+MzWU/G95cDj1PcydKYrxjkWKNBaXQ7aIUgEsctICyotRSdVluZ/zifNvXB
         GZz7o5rIejzuBOLHzbY3+IV6TNo2jgELZhFMUy8+DBECP2BhbUT9zHNkEpz/rPfE7z8A
         ysZsv0mPpKLVcDb3wYt+LKmPmE3YzH23kKltriRfg82HXuaL8bM1J87OvVGyXHKby6eN
         W4blVmISeMXSMlKgm/JNDibTgN/i6Xrv3LMEikt08hL0yq03wWDbWFqLYYo6ZWpfY0ML
         jW2A==
X-Gm-Message-State: AOAM5310jaIjXR72Mj+23eLTCserMthQ1hANztp4mBJ0H5xltgrXkOBH
        8jChwMgV+LZPAs0wodr8CmVMVJKwvo1UxA==
X-Google-Smtp-Source: ABdhPJyuLLua7gS4HkjXx/O7YqFFlQvKk6PyxihBvmDFhb05efqHuQYcSnipvlN2tqbjSpNI2O3RyA==
X-Received: by 2002:a0c:9e6b:: with SMTP id z43mr4516015qve.6.1606938691410;
        Wed, 02 Dec 2020 11:51:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k15sm2685081qke.75.2020.12.02.11.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 10/54] btrfs: convert some BUG_ON()'s to ASSERT()'s in do_relocation
Date:   Wed,  2 Dec 2020 14:50:28 -0500
Message-Id: <416807404fa65b6f122249f7c9d76834248be5ee.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
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

