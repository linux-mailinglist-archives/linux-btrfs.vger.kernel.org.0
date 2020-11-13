Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB832B2057
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgKMQY6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgKMQY5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:57 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41769C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:57 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id l2so9313938qkf.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sNfVJmY3c4cBbgnyu6LdD2dStUbWvlmIgNIpsaCucGI=;
        b=kVoln4pYSxHT6xhbPqXhUM4BUB07Zah8QnQ4m8kw6eQ2lBM5nf4OKB86CDU5Vd1LeY
         smnDN4nnifbPBXb8c2dQ+Oj8XUN/NkyaSb2CeI/cDMz2IkUWDGnXMUAmqC1RcWtHDOrp
         jxTtKpyL17kKk8vXpw6zemOT+x2d/FzXgWpAYvILqMHFpu3a0iEsAWkjhuQ5bFr0ghgK
         fVRjGldG9ermsoZAu1OWEmVL69iYptndopYeXZV+nipLRUgOrtpG48y2z3zEw8i1iFZu
         //3TAkx/ANnLb12klYbGmtiQnGSft47X+i8OIzSCkS+YyxxDAjPxCcua2oN7EPjK4ljZ
         EuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sNfVJmY3c4cBbgnyu6LdD2dStUbWvlmIgNIpsaCucGI=;
        b=mZ+iRojAzmzPDXl6O8ibXl4Pc++G5J0ihu9rEevqJlLKMUvWsWey21bPiKjFwMTTKS
         xlR6Nd8xA4GJQkZmK7AlrPoyF/6l7pFMjUK+VN0Jm6ChjZ0Eve0HJxyvvjuNAYSVgo0O
         izGPmihMohlRbOYEeY/2PiBMSXCg3OHLgcuPGfPY8l9yes+72W0DP+48gAKxQEBN4n37
         hTtWmhaI6eofhJt+9+8ZaOkrZpOl/Z6J/fA2HbMKHmVSGaEmzGZL0V9kQeG9BQWVkjeY
         T/GDOkJrMXvfp99X8lnVNLdwIEUQ+xsQ8fblxCayTYjPpTOzmdwR2rJGFs58c+HvNq0B
         Girw==
X-Gm-Message-State: AOAM532a6vgvDIHxaps1BaOQAJp9ov1GqpG2JcRVp5N00tfoq/wiiIYD
        ZHHIzr4HHzo/wJBdBvlQvrZGMFB5iCgnHQ==
X-Google-Smtp-Source: ABdhPJwZoHcRAlFujsFW1UdLZACUdPJz0PsNlKqf3DWg6SJF1Rn2hXLaPvkH7rWYgV/N+fwdCJYvwA==
X-Received: by 2002:a37:951:: with SMTP id 78mr2736738qkj.47.1605284690779;
        Fri, 13 Nov 2020 08:24:50 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y24sm6434053qtv.76.2020.11.13.08.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 41/42] btrfs: do proper error handling in merge_reloc_roots
Date:   Fri, 13 Nov 2020 11:23:31 -0500
Message-Id: <039435791305a25cbff53040babe177884d5a9d5.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a BUG_ON() if we get an error back from btrfs_get_fs_root().
This honestly should never fail, as at this point we have a solid
coordination of fs root to reloc root, and these roots will all be in
memory.  But in the name of killing BUG_ON()'s remove this one and
handle the error properly.  Change the remaining BUG_ON() to an
ASSERT().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 12b4955f2ab2..97c1d967b528 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1961,9 +1961,18 @@ void merge_reloc_roots(struct reloc_control *rc)
 
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 					 false);
+		if (IS_ERR(root)) {
+			/*
+			 * This likely won't happen, since we would have failed
+			 * at a higher level.  However for correctness sake
+			 * handle the error anyway.
+			 */
+			ret = PTR_ERR(root);
+			goto out;
+		}
+
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
-			BUG_ON(IS_ERR(root));
-			BUG_ON(root->reloc_root != reloc_root);
+			ASSERT(root->reloc_root == reloc_root);
 			ret = merge_reloc_root(rc, root);
 			btrfs_put_root(root);
 			if (ret) {
-- 
2.26.2

