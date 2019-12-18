Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02002123ECA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 06:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLRFTD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 00:19:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34175 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRFTD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 00:19:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so615569pgf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 21:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKFBRoUmGmnpd/QGnFxxXu5em8+IvZnQ3qhGfNNQGEM=;
        b=tP4R8UgYo75uQ+olNK/50WpRMu2I0Y03frnyZijqEWTYBtynxWehMrBPNJflgdX8Ko
         sFa9a3BSL0KMJRH1C1xOS0YqF+D0byp5sNhyVaOzjBxXg565GztcPvu8ruf4dYZtpaHj
         Iu7lgogtrnCxHLLkan8/k+uVpAfUiIcqmVpXne55A6Re3vQxwHMEwkmehBvpvHH2a4Gj
         ThkAGQ2kc1QAYNAeI50pC1juld/qValOSTvTbPr//X81+0gOd35wFMUPUiAUPJ5XZbkR
         Ja9vMQqktFH9LIwvr1pZpDLqjIrrFxiXqq/w9BzWQAHPqTinywmPtMEPynKF4CScHbjY
         ZhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKFBRoUmGmnpd/QGnFxxXu5em8+IvZnQ3qhGfNNQGEM=;
        b=lGzME/dS7Xz+GNdrG4j0e0OwTCyjrkka192QzMV78xZDBqyo7c5c5FhJ2qG/bMYEN3
         3aA+ARpRgvBGo/VelPPJUDeMyVIYd/xMAxYPbXXchnPMCcKZ1RYq/aH4R8zRtzC8G1cV
         x0o7mg+b/5QEeYrW5rulCbEnX6IDtIpRnOdayNoZxdsxv/4FHcniqzFBnj/4hNxArQdE
         wt66gn2iJRe/t3Mp5XLXkHeDf/0etQiCL7oaZVdQFIL+Ll8ctyYDKdwB0UfYzRl2jZPn
         a/WHhOMB58ZdJ/pQC6hUxNqHi3NmE+4xapq+CpFxNu1HmnJR3JI8WQhAPTwOXHysFwfN
         L6zw==
X-Gm-Message-State: APjAAAUqrjNrL3SY9YbEWaKGDeBZesxkh/NL7CFu+U3sLFj5kcbfjCCA
        7rTqJysnmGiFYeGVEswk+UAu04NPcQ8=
X-Google-Smtp-Source: APXvYqy1ShYpAz+jyF2YatLzHJjFEMNuI4mGxDUos5MvkZr2CHm/HMlC/yyODcpwSQTnd9So3u6/oQ==
X-Received: by 2002:a63:2949:: with SMTP id p70mr827281pgp.191.1576646342051;
        Tue, 17 Dec 2019 21:19:02 -0800 (PST)
Received: from p.lan (81.249.92.34.bc.googleusercontent.com. [34.92.249.81])
        by smtp.gmail.com with ESMTPSA id e2sm1014781pfh.84.2019.12.17.21.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 21:19:01 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH V2 04/10] btrfs-progs: reform the function block_group_cache_tree_search()
Date:   Wed, 18 Dec 2019 13:18:43 +0800
Message-Id: <20191218051849.2587-5-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191218051849.2587-1-Damenly_Su@gmx.com>
References: <20191218051849.2587-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

Change @cotnains to @next of block_group_cache_tree_search().
Now, the function will try to search the block group containing
the @bytenr. If not found, return NULL if @next is zero. Or
It will return the next block group.

Will be used in the later commit.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 extent-tree.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/extent-tree.c b/extent-tree.c
index ab576f8732a2..fdfa29a2409f 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -196,11 +196,15 @@ static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 }
 
 /*
- * This will return the block group at or after bytenr if contains is 0, else
- * it will return the block group that contains the bytenr
+ * This will return the block group which contains @bytenr if it exists.
+ * If found nothing, the return depends on @next.
+ *
+ * @next:
+ *   if 0, return NULL if there's no block group containing the bytenr.
+ *   if 1, return the block group which starts after @bytenr.
  */
 static struct btrfs_block_group_cache *block_group_cache_tree_search(
-		struct btrfs_fs_info *info, u64 bytenr, int contains)
+		struct btrfs_fs_info *info, u64 bytenr, int next)
 {
 	struct btrfs_block_group_cache *cache, *ret = NULL;
 	struct rb_node *n;
@@ -215,11 +219,11 @@ static struct btrfs_block_group_cache *block_group_cache_tree_search(
 		start = cache->key.objectid;
 
 		if (bytenr < start) {
-			if (!contains && (!ret || start < ret->key.objectid))
+			if (next && (!ret || start < ret->key.objectid))
 				ret = cache;
 			n = n->rb_left;
 		} else if (bytenr > start) {
-			if (contains && bytenr <= end) {
+			if (bytenr <= end) {
 				ret = cache;
 				break;
 			}
@@ -229,6 +233,7 @@ static struct btrfs_block_group_cache *block_group_cache_tree_search(
 			break;
 		}
 	}
+
 	return ret;
 }
 
-- 
2.21.0 (Apple Git-122.2)

