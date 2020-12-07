Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCCA2D12C5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 14:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgLGN7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgLGN7V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:21 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C64C061A55
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:08 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id 4so6514755qvh.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1hxcsJJMk0pDGd/bRGloTbtUHmPw3bnputB8RyBCEY=;
        b=yG3IBtJFWeHhx+5OO4sG+bJ7jFhJXUiIHOczFUzt7C5BGLJ8PI/M+NvQyIVhbQaQOm
         YlpYSBkzk5zFHVOU/QNnxm5KPdob0x1MrZVxkJlzEgLj0E72JlW0/B4M1ahB1jBBaWgU
         m2jwoTT2DForGag/aBunPC1W7qLUvY9XMsK7ihpFdiwHVAcGVCV2+PJDoxc5r9FvbPAP
         HJ2xT/5PB7P9hCTwiTT3zuIDrB6YvHaqdTJHB320/Mfy+lBGh64RpjSRCaAhdGWeqgU1
         MDuQ0DAdEfEgZKLSqOdswFW7hlFM9yLUHy9GalVFkQjrpAvnd9fsBKpDBkWXcQiALM75
         zuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1hxcsJJMk0pDGd/bRGloTbtUHmPw3bnputB8RyBCEY=;
        b=ZBZAhBd32yFRJF5qKjqB3xv2DTNP86ueCXyA0H1Rp3GG3kYHp+tEtB9zX7TBPpiSRg
         2gqwRSVPTfcLXWczvzKlQS5BWHpbCZA2tALI7ygBCJa/fnoVbCAW/Y5LtzA4JQ5JF6wn
         2q3vyx4L5r8fcN+U/wmfwPPi8GXI92TdM+rrzMEvca5DLoMgcf1GOW/HNdEZcG4QweQN
         nDSaClGKR90ostTAy8miugxrTEunrYfgc5GQcMz/1LUbsrd4ulsglG37tEuwCdPmSYAK
         OYtXgEjF1vm+aSYPioP/jDrZPmmsa0mg/p4ZeV9MKsMk/lyB0cZiGourylvSNLXcRkP4
         2NgQ==
X-Gm-Message-State: AOAM531zpzh6Kgde1k816Uw3uIUK5IDl50L1Cv6S7Mgul2OIjXtDWAqs
        d1jAfyA3N3yaRNN6n54Yk02zIEGqHh4o6dIC
X-Google-Smtp-Source: ABdhPJxWTVCHpb43Re3IT5uf2YNJzQSW+FEe68nEPzIeETjUoX3O/RXp3/gMzLSfm/J/ZJWKcKG1YQ==
X-Received: by 2002:ad4:5043:: with SMTP id m3mr21233944qvq.45.1607349487012;
        Mon, 07 Dec 2020 05:58:07 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y6sm2570960qkj.60.2020.12.07.05.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 10/52] btrfs: convert some BUG_ON()'s to ASSERT()'s in do_relocation
Date:   Mon,  7 Dec 2020 08:57:02 -0500
Message-Id: <66145512ba8e3681458bfd2fd6223dbeeb40252c.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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

