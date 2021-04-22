Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB59367F48
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Apr 2021 13:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhDVLKB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Apr 2021 07:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhDVLKA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Apr 2021 07:10:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A3526144A
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Apr 2021 11:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619089764;
        bh=ts5c5Dcbah4VBsFUJwxC3KRuVkcl7cSjaYqHFcpH9jI=;
        h=From:To:Subject:Date:From;
        b=tqWfuBdoXhQgXrw+DxGzJYgYEvFItXmMq8SYzq7//JcCAOT4FvRTWAFx/o3szDZxq
         BELtn9MHsisdaiCXuYMHuUAFeQvioR8RPth3rB+Y+lLS30SudIbPk5CTjNyICb6dzH
         2pAXn3kgKk9znOP9KZ+v5Ea7CKv0Y2OBGHcXFtEk85FaXEo93vB+2iMP87bzPnq96S
         Bw02f9C/8iuUzNCoX7ygGl0d72CsY0rEtyTbaYQAafgJBO8CtHmqiIAzLtITYpnCqT
         XHkUHxXhN2eckhh33AQkRMyGbWxP4CN0iOX/H092W2PFJjrzsyJUFs8O2Lfktqv4/u
         RFet51U6Uj5cw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not consider send context as valid when trying to flush qgroups
Date:   Thu, 22 Apr 2021 12:09:21 +0100
Message-Id: <1020602e269415d91c713afdfb9a11921a3ceda6.1619087848.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At qgroup.c:try_flush_qgroup() we are asserting that current->journal_info
is either NULL or has the value BTRFS_SEND_TRANS_STUB.

However allowing for BTRFS_SEND_TRANS_STUB makes no sense because:

1) It is misleading, because send operations are read-only and do not
   ever need to reserve qgroup space;

2) We already assert that current->journal_info != BTRFS_SEND_TRANS_STUB
   at transaction.c:start_transaction();

3) On a kernel without CONFIG_BTRFS_ASSERT=y set, it would result in
   a crash if try_flush_qgroup() is ever called in a send context, because
   at transaction.c:start_transaction we cast current->journal_info into
   a struct btrfs_trans_handle pointer and then dereference it.

So just do allow a send context at try_flush_qgroup() and update the
comment about it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 366a6a289796..3ded812f522c 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3545,11 +3545,15 @@ static int try_flush_qgroup(struct btrfs_root *root)
 	struct btrfs_trans_handle *trans;
 	int ret;
 
-	/* Can't hold an open transaction or we run the risk of deadlocking */
-	ASSERT(current->journal_info == NULL ||
-	       current->journal_info == BTRFS_SEND_TRANS_STUB);
-	if (WARN_ON(current->journal_info &&
-		    current->journal_info != BTRFS_SEND_TRANS_STUB))
+	/*
+	 * Can't hold an open transaction or we run the risk of deadlocking,
+	 * and can't either be under the context of a send operation (where
+	 * current->journal_info is set to BTRFS_SEND_TRANS_STUB), as that
+	 * would result in a crash when starting a transaction and does not
+	 * make sense either (send is a read-only operation).
+	 */
+	ASSERT(current->journal_info == NULL);
+	if (WARN_ON(current->journal_info))
 		return 0;
 
 	/*
-- 
2.28.0

