Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6DA3B1221
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 17:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfILPbs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 11:31:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:49226 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733001AbfILPbs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 11:31:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02245AC7F;
        Thu, 12 Sep 2019 15:31:47 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Add assert to catch nested transaction commit
Date:   Thu, 12 Sep 2019 18:31:44 +0300
Message-Id: <20190912153144.26638-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A recent patch to btrfs showed that there was at least 1 case where a
nesed transaction was committed. Nested transaction in this case  means
a code which has a transaction handle calls some function which in turn
obtains a copy of the same transaction handle. In such cases the correct
thing to do is for the lower callee to call btrfs_end_transaction which
contains appropriate checks so as to not commit the transaction which
will result in stale trans handler for the caller.

To catch such cases add an assert in btrfs_commit_transaction ensuring
btrfs_trans_handle::use_count is always 1.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

A full xfs test run didn't trigger this assert. 

 fs/btrfs/transaction.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8624bdee8c5b..8b75426c349e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1949,6 +1949,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	struct btrfs_transaction *prev_trans = NULL;
 	int ret;
 
+	ASSERT(refcount_read(&trans->use_count) == 1);
+
 	/* Stop the commit early if ->aborted is set */
 	if (unlikely(READ_ONCE(cur_trans->aborted))) {
 		ret = cur_trans->aborted;
-- 
2.17.1

