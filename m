Return-Path: <linux-btrfs+bounces-19637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E61CB4C74
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 06:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D21AB3011ECF
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 05:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51796286897;
	Thu, 11 Dec 2025 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="McFqgjzR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89081DF27F
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 05:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765431585; cv=none; b=XfnJ8jhWQAZwd0YrctcQq32Q9t1KpWLNT/pb5NN/tJp/h3rvEA53Hw2BHDIeyi8Rx3MA01jd4JySVnScpMJ+tpfCrWdAS3a5m6AihZm+3WofJwvYzGA/WFwsGdQTzULu3ktegtr3SmgjddZ+i02VVWt0GiptCxX/EUWPrSSvFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765431585; c=relaxed/simple;
	bh=5LBFJ4/Qvgd+IBGRlamZa71p6AaisHQhTmOIQSDEX5M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lVHexNN6ktpocUQLtir0sV0g1dbsXaEgaS90poVOsihobl+KepQcF2tR+LmhY3hdl/fN8ZHmWlhOOnuWRRIX8GNpifCYZ55rrDpKxSY0XYHky4/P6jkzlIGAX/V7UBFPdUjsT29BQtMGQgfyr48KCH3nOM7Jhini8TGQ52xfATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=McFqgjzR; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
From: robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1765431036; bh=5LBFJ4/Qvgd+IBGRlamZa71p6AaisHQhTmOIQSDEX5M=;
	h=From:To:Cc:Subject:Date;
	b=McFqgjzRYKHLZViJJOF98gLI68POp/v0QcA7D4IvujImFpzTr/i6WNeGSHa6lluiq
	 EohiKy4qjGgdDWtyqctvOBez0w5KcMT0RzYmwWwEFLoLtjCEzZ2ZTFVAuH7ZBwW2dq
	 /0H3oAQfSXV29XMLMQqwwah/u5Qk2cw+qlPx9uN8=
To: linux-btrfs@vger.kernel.org
Cc: Robbie Ko <robbieko@synology.com>
Subject: [PATCH] btrfs: fix deadlock in wait_current_trans() due to ignored transaction type
Date: Thu, 11 Dec 2025 13:30:33 +0800
Message-Id: <20251211053033.31566-1-robbieko@synology.com>
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Robbie Ko <robbieko@synology.com>

When wait_current_trans() is called during start_transaction(), it
currently waits for a blocked transaction without considering whether
the given transaction type actually needs to wait for that particular
transaction state. The btrfs_blocked_trans_types[] array already defines
which transaction types should wait for which transaction states, but
this check was missing in wait_current_trans().

This can lead to a deadlock scenario involving two transactions and
pending ordered extents:
  1. Transaction A is in TRANS_STATE_COMMIT_DOING state
  2. A worker processing an ordered extent calls start_transaction()
     with TRANS_JOIN
  3. join_transaction() returns -EBUSY because Transaction A is in
     TRANS_STATE_COMMIT_DOING
  4. Transaction A moves to TRANS_STATE_UNBLOCKED and completes
  5. A new Transaction B is created (TRANS_STATE_RUNNING)
  6. The ordered extent from step 2 is added to Transaction B's
     pending ordered extents
  7. Transaction B immediately starts commit by another task and
     enters TRANS_STATE_COMMIT_START
  8. The worker finally reaches wait_current_trans(), sees Transaction B
     in TRANS_STATE_COMMIT_START (a blocked state), and waits
     unconditionally
  9. However, TRANS_JOIN should NOT wait for TRANS_STATE_COMMIT_START
     according to btrfs_blocked_trans_types[]
  10. Transaction B is waiting for pending ordered extents to complete
  11. Deadlock: Transaction B waits for ordered extent, ordered extent
      waits for Transaction B

This can be illustrated by the following call stacks:
  CPU0                              CPU1
                                    btrfs_finish_ordered_io()
                                      start_transaction(TRANS_JOIN)
                                        join_transaction()
                                          # -EBUSY (Transaction A is
                                          # TRANS_STATE_COMMIT_DOING)
  # Transaction A completes
  # Transaction B created
  # ordered extent added to
  # Transaction B's pending list
  btrfs_commit_transaction()
    # Transaction B enters
    # TRANS_STATE_COMMIT_START
    # waiting for pending ordered
    # extents
                                        wait_current_trans()
                                          # waits for Transaction B
                                          # (should not wait!)

Task bstore_kv_sync in btrfs_commit_transaction waiting for ordered
extents:
  __schedule+0x2e7/0x8a0
  schedule+0x64/0xe0
  btrfs_commit_transaction+0xbf7/0xda0 [btrfs]
  btrfs_sync_file+0x342/0x4d0 [btrfs]
  __x64_sys_fdatasync+0x4b/0x80
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Task kworker in wait_current_trans waiting for transaction commit:
  Workqueue: btrfs-syno_nocow btrfs_work_helper [btrfs]
  __schedule+0x2e7/0x8a0
  schedule+0x64/0xe0
  wait_current_trans+0xb0/0x110 [btrfs]
  start_transaction+0x346/0x5b0 [btrfs]
  btrfs_finish_ordered_io.isra.0+0x49b/0x9c0 [btrfs]
  btrfs_work_helper+0xe8/0x350 [btrfs]
  process_one_work+0x1d3/0x3c0
  worker_thread+0x4d/0x3e0
  kthread+0x12d/0x150
  ret_from_fork+0x1f/0x30

Fix this by passing the transaction type to wait_current_trans() and
checking btrfs_blocked_trans_types[cur_trans->state] against the given
type before deciding to wait. This ensures that transaction types which
are allowed to join during certain blocked states will not unnecessarily
wait.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/transaction.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 05ee4391c83a..a8988e5af730 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -520,13 +520,14 @@ static inline int is_transaction_blocked(struct btrfs_transaction *trans)
  * when this is done, it is safe to start a new transaction, but the current
  * transaction might not be fully on disk.
  */
-static void wait_current_trans(struct btrfs_fs_info *fs_info)
+static void wait_current_trans(struct btrfs_fs_info *fs_info, unsigned int type)
 {
 	struct btrfs_transaction *cur_trans;
 
 	spin_lock(&fs_info->trans_lock);
 	cur_trans = fs_info->running_transaction;
-	if (cur_trans && is_transaction_blocked(cur_trans)) {
+	if (cur_trans && is_transaction_blocked(cur_trans) &&
+		(btrfs_blocked_trans_types[cur_trans->state] & type)) {
 		refcount_inc(&cur_trans->use_count);
 		spin_unlock(&fs_info->trans_lock);
 
@@ -701,12 +702,12 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		sb_start_intwrite(fs_info->sb);
 
 	if (may_wait_transaction(fs_info, type))
-		wait_current_trans(fs_info);
+		wait_current_trans(fs_info, type);
 
 	do {
 		ret = join_transaction(fs_info, type);
 		if (ret == -EBUSY) {
-			wait_current_trans(fs_info);
+			wait_current_trans(fs_info, type);
 			if (unlikely(type == TRANS_ATTACH ||
 				     type == TRANS_JOIN_NOSTART))
 				ret = -ENOENT;
@@ -1003,7 +1004,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid)
 
 void btrfs_throttle(struct btrfs_fs_info *fs_info)
 {
-	wait_current_trans(fs_info);
+	wait_current_trans(fs_info, TRANS_START);
 }
 
 bool btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
-- 
2.17.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

