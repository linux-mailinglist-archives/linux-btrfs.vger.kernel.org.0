Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C386AAE4C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 09:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbfIJHk2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 03:40:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:36536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733236AbfIJHk2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 03:40:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0ED11B01D
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2019 07:40:27 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: ctree: Remove stalled comment of setting up path lock
Date:   Tue, 10 Sep 2019 15:40:19 +0800
Message-Id: <20190910074019.23158-4-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190910074019.23158-1-wqu@suse.com>
References: <20190910074019.23158-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following comment shows up in btrfs_search_slot() with out much
sense:

	/*
	 * setup the path here so we can release it under lock
	 * contention with the cow code
	 */
	if (cow) {
		/* code touching path->lock[] is far away from here */
	}

It turns out that just some stalled comment which is not cleaned up
properly.

The original code is introduced in commit 65b51a009e29
("btrfs_search_slot: reduce lock contention by cowing in two stages"):
+
+               /*
+                * setup the path here so we can release it under lock
+                * contention with the cow code
+                */
+               p->nodes[level] = b;
+               if (!p->skip_locking)
+                       p->locks[level] = 1;
+

But in current code base, we have different timing modifying path lock,
so just remove that stalled comment.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3be8b32c0d37..a2e264190eee 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2764,10 +2764,6 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		int dec = 0;
 		level = btrfs_header_level(b);
 
-		/*
-		 * setup the path here so we can release it under lock
-		 * contention with the cow code
-		 */
 		if (cow) {
 			bool last_level = (level == (BTRFS_MAX_LEVEL - 1));
 
-- 
2.23.0

