Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A13C574919
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 10:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbfGYI1c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 04:27:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:58908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389624AbfGYI1c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 04:27:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8F037AFBE
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2019 08:27:31 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs: Fix deadlock caused by missing memory barrier
Date:   Thu, 25 Jul 2019 11:27:29 +0300
Message-Id: <20190725082729.14109-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725082729.14109-1-nborisov@suse.com>
References: <20190725082729.14109-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 06297d8cefca ("btrfs: switch extent_buffer blocking_writers from atomic to int")
changed the type of blocking_writers but forgot to adjust relevant code
in btrfs_tree_unlock by converting the smp_mb__after_atomic to smp_mb.
This opened up the possibility of a deadlock due to re-ordering of
setting blocking_writers and checking/waking up the  waiter. This
particular lockup is explained in a comment above waitqueue_active()
function.

Fix it by converting the memory barrier to a full smp_mb, accounting
for the fact that blocking_writers is a simple integer.

Fixes: 06297d8cefca ("btrfs: switch extent_buffer blocking_writers from atomic to int")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Johannes Thumshirn <jthumshirn@suse.com>
---
 fs/btrfs/locking.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index ceb23690b89b..5e867720df88 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -310,9 +310,12 @@ void btrfs_tree_unlock(struct extent_buffer *eb)
 	if (blockers) {
 		btrfs_assert_no_spinning_writers(eb);
 		eb->blocking_writers--;
-		/* Use the lighter barrier after atomic */
-		smp_mb__after_atomic();
-		cond_wake_up_nomb(&eb->write_lock_wq);
+		/*
+		 * We need to order modifying blocking_writers above with
+		 * actually waking up the sleepers to ensure they see the
+		 * updated value of blocking_writers
+		 */
+		cond_wake_up(&eb->write_lock_wq);
 	} else {
 		btrfs_assert_spinning_writers_put(eb);
 		write_unlock(&eb->lock);
-- 
2.17.1

