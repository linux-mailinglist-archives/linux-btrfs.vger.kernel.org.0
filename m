Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465A51A70C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 04:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403925AbgDNCCh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Apr 2020 22:02:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:50582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgDNCCg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Apr 2020 22:02:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B4900AD81
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Apr 2020 02:02:34 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: Do proper error handling in add_cache_extent()
Date:   Tue, 14 Apr 2020 10:02:31 +0800
Message-Id: <20200414020231.50670-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have memory allocation failure in add_cache_extent(), it will
simply exit with one error message.

That's definitely not proper, especially when all but one call sites
have handled the error.

This patch will return -ENOMEM for add_cache_extent(), and fix the only
call site which doesn't handle error from it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c   | 12 +++++++++++-
 extent-cache.c |  6 ++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/check/main.c b/check/main.c
index a41117fe79f9..c51dad8f2c89 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4924,7 +4924,17 @@ static int add_pending(struct cache_tree *pending,
 	ret = add_cache_extent(seen, bytenr, size);
 	if (ret)
 		return ret;
-	add_cache_extent(pending, bytenr, size);
+	ret = add_cache_extent(pending, bytenr, size);
+	if (ret) {
+		struct cache_extent *entry;
+
+		entry = lookup_cache_extent(seen, bytenr, size);
+		if (entry && entry->start == bytenr && entry->size == size) {
+			remove_cache_extent(seen, entry);
+			free(entry);
+		}
+		return ret;
+	}
 	return 0;
 }
 
diff --git a/extent-cache.c b/extent-cache.c
index 4065522aafcf..927597b31978 100644
--- a/extent-cache.c
+++ b/extent-cache.c
@@ -111,10 +111,8 @@ int add_cache_extent(struct cache_tree *tree, u64 start, u64 size)
 	struct cache_extent *pe = alloc_cache_extent(start, size);
 	int ret;
 
-	if (!pe) {
-		fprintf(stderr, "memory allocation failed\n");
-		exit(1);
-	}
+	if (!pe)
+		return -ENOMEM;
 
 	ret = insert_cache_extent(tree, pe);
 	if (ret)
-- 
2.26.0

