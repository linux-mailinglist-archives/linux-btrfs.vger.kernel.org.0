Return-Path: <linux-btrfs+bounces-3071-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BA88753C8
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 17:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89A61C2314A
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779F912F59A;
	Thu,  7 Mar 2024 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llRhQKpG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C94912D754
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827292; cv=none; b=IxX8HGnYjWRh/lY5pzAEdKWF/i/ttVt7BLk8my86srm5Y2tqTQ7QSWUsytF/5S4ldjYrnibvx3Vm3tOT3l6K48vt/kw5IaGVp0aJbWvgQ1QiQnAfsfI9j7eGqYTlpNVZwYyH6NSssZN1Y0ZscwXuIgwg3Ic5K15ih23u0UPUo2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827292; c=relaxed/simple;
	bh=0HnxSPZOVZJT/gSuCH/nID6+7wP9PdGnlVuNA8SqPis=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=jW4h5xugmG2lVLWeb0E+jtzAw5y4Iqoe6e+F7oTao63H01rmCsmJVwjcY56+bhBps2NMSXGgc5qSEVxzE1lR2G963kEowXsHnyHhuFWcywzuCTo4HodXlE7Zg0FI+gZ1i6Zr7M5SJwpVx4jYpm2COEgM1QPG85FoFFAbUik//gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llRhQKpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F8BC43390
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709827292;
	bh=0HnxSPZOVZJT/gSuCH/nID6+7wP9PdGnlVuNA8SqPis=;
	h=From:To:Subject:Date:From;
	b=llRhQKpGTs+5LOmy5RaPM+G0LKY34KTueobeK7d4C+PgqWD2HCYJYjxYsUSjhP5L5
	 7Mle5uLZgLarG2AW1wkJFi7vKVgmOpvN+ZeF/clb4DZeWrjEKg2KKbxsfYcP/1WLf5
	 YWVRln2wY9fynacBr9ZeWC5JvCApSm7abKrdtDE232PwKSvQZKTjBWeTt5FSbMQ5VU
	 EjnziUCEqvCCELqIb/ZBR6rgAelPlQJD8+75gUPZhytlLSEOjPBcXW/IxEkck4T97v
	 km9iRxDaIuVJCgcr6qXTDWN9ILtWk7ib9QTLSlFUsBBVcMVe19Setu4V0t9E/rYRRv
	 Iu2wfBNB14xxA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove pointless BUG_ON() when creating snapshot
Date: Thu,  7 Mar 2024 16:01:27 +0000
Message-Id: <0d0347a460b26e36966f95604ca8c69b956f1c62.1709814676.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When creating a snapshot we first check with btrfs_lookup_dir_item() if
there is a name collision in the parent directory and then return an error
if there's a collision. Then later on when trying to insert a dir item for
the snapshot we BUG_ON() if the return value is -EEXIST or -EOVERFLOW:

  static noinline int create_pending_snapshot(...)
  {
     (...)

     /* check if there is a file/dir which has the same name. */
     dir_item = btrfs_lookup_dir_item(...);
     (...)

     ret = btrfs_insert_dir_item(...);
     /* We have check then name at the beginning, so it is impossible. */
     BUG_ON(ret == -EEXIST || ret == -EOVERFLOW);
     if (ret) {
        btrfs_abort_transaction(trans, ret);
        goto fail;
     }

     (...)
  }

It's impossible to get the -EEXIST because we previously checked for a
potential collision with btrfs_lookup_dir_item() and we know that after
that no one could have added a colliding name because at this point the
transaction is in its critical section, state TRANS_STATE_COMMIT_DOING,
so no one can join this transaction to add a colliding name and neither
can anyone start a new transaction to do that.

As for the -EOVERFLOW, that can't happen as long as we have the extended
references feature enabled, which is a mkfs default for many years now.

In either case, the BUG_ON() is excessive as we can properly deal with
any error and can abort the transaction and jump to the 'fail' label,
in which case we'll also get the useful stack trace (just like a BUG_ON())
from the abort if the error is either -EEXIST or -EOVERFLOW.

So remove the BUG_ON().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 46e8426adf4f..5b6536c1f6d1 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1864,8 +1864,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	ret = btrfs_insert_dir_item(trans, &fname.disk_name,
 				    BTRFS_I(parent_inode), &key, BTRFS_FT_DIR,
 				    index);
-	/* We have check then name at the beginning, so it is impossible. */
-	BUG_ON(ret == -EEXIST || ret == -EOVERFLOW);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
-- 
2.43.0


