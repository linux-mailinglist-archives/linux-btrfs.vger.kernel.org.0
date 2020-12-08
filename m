Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFFC2D2F74
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgLHQZ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbgLHQZ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:29 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51236C061257
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:25 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q22so16437567qkq.6
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1hxcsJJMk0pDGd/bRGloTbtUHmPw3bnputB8RyBCEY=;
        b=XsVLAHo4jSbB+2k+HFNoWPed6VhWtVHX3QNHy14f+Eols/1RiA1w8VF2VO+nXp3Z9o
         NWoh0/mzT9m3/SSZ7GOtbZgdycjjZGjWbJqfGxLfbGFjntTZdzo+yRSz6axgyRdGRWOQ
         PUmjxqTMS6+6WbrHe6TnDcE94vzNH1IfBqhVR0DpWo0Ppe3uCFazyNPhBeHlI3kct2/G
         GuY6HB5VJrWWdxlm/n+SGvFb9R/6IIBpYyhzaBz327rPvCYpNpjvBdfUVwK/pnI8ZtrB
         nsrW+dzQHjJo9sMNG4UkwvpZzN45awfG/Jmkh+tWKbQehe+37sfn4wukmue8Ifib9qgV
         HTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1hxcsJJMk0pDGd/bRGloTbtUHmPw3bnputB8RyBCEY=;
        b=KmlQcxxBLhLPGUUYFrBqSwVRmAWWkdvjJMu0oYuNbaoq3xLyStUJuptbtQGTDig0DI
         l+im7I9nHHPF2LlR7U+KZWv0YDXKaZQHPB+mH4744HXxSJdt3WFtbbFwcQQDSfEBX5YG
         WzizyJpLFV22UzHpuaQ4vt/vcpNePbdhzqWNMl+TcD2lSL9iY3/VOva6FXGTS9pD40V4
         RHYvSznkYHZE7r87bw41u3/n6sJydlzr++Ov9pzVQ80c043U8uXInoku8g+loqc6G+F9
         +ByeU5ahmFzQQ/Av/45GTtqGxVnsu6zXVZ9bVS+PYw5hsL/VCk8Q7X9AVwvPbs1jvAMC
         PNyg==
X-Gm-Message-State: AOAM533s1XsnqHIenr+kx0tB6ZYmZc+PpeZjG1fiwHFVYD5k3jZlFdtp
        E/ljd41nBc+Ze8dh2XCJJIMPn60FT5vuJuB/
X-Google-Smtp-Source: ABdhPJw8SmvUpL/OsvnSJl5xnloluHz5ZByzrPRfOrfzY2Yw95ElZCgGzbspEPRC7LQMUNulNdaRZQ==
X-Received: by 2002:a05:620a:22ab:: with SMTP id p11mr8257704qkh.237.1607444664234;
        Tue, 08 Dec 2020 08:24:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 131sm13516391qkg.69.2020.12.08.08.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 10/52] btrfs: convert some BUG_ON()'s to ASSERT()'s in do_relocation
Date:   Tue,  8 Dec 2020 11:23:17 -0500
Message-Id: <428478482260461d4960bf798f163fe5195e347b.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
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

