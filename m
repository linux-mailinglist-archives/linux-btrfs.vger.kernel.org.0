Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD68339833
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhCLU0G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbhCLUZj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:39 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EA8C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:38 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id a9so25667247qkn.13
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJaeunyVJzcV15aBU0izNkv5ehGMAXv98+Ns4qkme24=;
        b=oi6U4upaDceMCPRoG9qGoyCFDVTh/KrUvtdqdCXR+g7JzwlQnSImHRnukrzUY9AzAX
         saniQCPvXg/fm/gaPXHonGC/8Te1K7tpLGS9RZ1vOW2tilQuBtWI5sCIHOl/q3Ldf3PP
         rlAsKu+D552JsvyV2X3LpR6qS6IetgNdg5BEVZuWwwzmxLpI2duq9I1Nc157OBUd7p47
         VDzsU5kzBe3H0jrtt31MIbFXFuGzL71M7YlwvYAxWzjVScHAsDUr+YxUE0eFUwIymNrd
         a0rsc/6tOHTWnmkbAtYKWTYi/eccp7Wq8d9Km0lwmdysnB45rA6PzllMjnrUxP7xH+pS
         bO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJaeunyVJzcV15aBU0izNkv5ehGMAXv98+Ns4qkme24=;
        b=RFao5zENTEexSerwG/2RSBqAsIq8MPgbIuEVlNqFMwS+2x53fY0k6n038kGc4R+7Me
         U66bSvRRU/Oq6uZBjP0wZhvGEZIbeCpVoOlWEKld/YYLpXbhrHM3fMghv+G7HKBhAgfH
         vatyp6PAJi6DMvYeVPWjl7CrOrHGXBTckBOrrPha+HngfMw6GNKXLrIswGX1cjgbWJg4
         SK+rRv8I0pBJuMmTOgsDC5g8ibtXIvPP6PDHkKV9UGSCgSB3OgHZwFX83KtYGcNMGFJl
         /d+OKLdLfIw+j2GBwC3GStkdt3/fJZnhIpXllHaJUu3PJLP1xBDGC1o2C8fv36ieYdpq
         cExw==
X-Gm-Message-State: AOAM530qDHr3lAFuz9qo3Xq2kaIlbWnFhAxz00YtmbjafHikpC0Fhct5
        E1sDjXf9+b1m25edAb/sNBIEcCzURwZpRFAp
X-Google-Smtp-Source: ABdhPJzO4fJlh6xWuRKpZWK2aKVDuE9Iblg78XHCql1W4iFs919M4RBgPlyAVScD4zRUhiC6NOQiWA==
X-Received: by 2002:a05:620a:806:: with SMTP id s6mr13594950qks.50.1615580737878;
        Fri, 12 Mar 2021 12:25:37 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f2sm5079672qkb.50.2021.03.12.12.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 01/39] btrfs: convert some BUG_ON()'s to ASSERT()'s in do_relocation
Date:   Fri, 12 Mar 2021 15:24:56 -0500
Message-Id: <7311ecd8203021a84eceaec06afc0b49217032c9.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
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
index 232d5da7b7be..63e416ac79ae 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2181,7 +2181,11 @@ static int do_relocation(struct btrfs_trans_handle *trans,
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
@@ -2266,7 +2270,11 @@ static int do_relocation(struct btrfs_trans_handle *trans,
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
@@ -2302,7 +2310,12 @@ static int do_relocation(struct btrfs_trans_handle *trans,
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

