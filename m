Return-Path: <linux-btrfs+bounces-5412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475478D81DB
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 14:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C5F283354
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 12:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DB0126F2F;
	Mon,  3 Jun 2024 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Idyr9jsQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7B10949
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416377; cv=none; b=mZ0OGy4OMlRMk4GQA55UH0+7xCdJnjNZBBAt1hETuKCDjpl94GDn3hQBVJ9arB9bu+5TLPaIDwZOmUwP0p/xOCtemyiFiNzlHcFld+PHAwc+0Wp/cQla5uCfjxiqey+N/DmDZTRvY0hqBHQQwVVcSjcXox1uAmw99U68a1nKodg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416377; c=relaxed/simple;
	bh=BI/nj6gKznE322LKRi7uLXRnngUv0+i4PzLx5lUGLGU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=qPBK/BuQ4qyo+dF4YpiIU7+Ew7DgoPrwrojRVwLDovBBIh4t+qNZE0Lbu9tFqvelXVgD36C7hi+lRuli+FTN+nXky12PsBrwBkVQb+4aJm3Ij84CjTcokYppNLa+RKzFGh0dMrrwg8IU8Dm6p5++ordZA8IQS2UJz3TMyMv2f3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Idyr9jsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C0CC4AF07
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 12:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717416376;
	bh=BI/nj6gKznE322LKRi7uLXRnngUv0+i4PzLx5lUGLGU=;
	h=From:To:Subject:Date:From;
	b=Idyr9jsQ6xR1LvVfM4uOcri2TQyAGeToc2fseWYBd3ixmT048ywSKpH/5mBqX9TRf
	 6SmeOfVqnegFVfBRbcRo0SB47cHj4AMJuMu4rPzqdYNxTOizBDyN5/aoFinoQYCFA/
	 JyZO5R4wfSBm/7UAs+B85KphoYEIdlXceixIosm9S9Ejm0RPhFXeqydY0E6DrM1U7O
	 iHL4EeXZLgDhUBRUeyF9fd8LX6L5jPtrLJXE1u8Aio1ih3V5AVdH9B6RICQOvhKQvC
	 r9/To/TCvBZ040DWxMW5hH1x593f7r9kbacJSja65xfx2Am8bVNXuyPN0Zv7+sxkWs
	 mbxwXZi0KccDQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix leak of qgroup extent records after transaction abort
Date: Mon,  3 Jun 2024 13:06:13 +0100
Message-Id: <0a4d66f6922f5219c7c8c37d88a919304abdbb55.1717416325.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Qgroup extent records are created when delayed ref heads are created and
then released after accounting extents at btrfs_qgroup_account_extents(),
called during the transaction commit path.

If a transaction is aborted we free the qgroup records by calling
btrfs_qgroup_destroy_extent_records() at btrfs_destroy_delayed_refs(),
unless we don't have delayed references. We are incorrectly assuming
that no delayed references means we don't have qgroup extents records.

We can currently have no delayed references because we ran them all
during a transaction commit and the transaction was aborted after that
due to some error in the commit path.

So fix this by ensuring we btrfs_qgroup_destroy_extent_records() at
btrfs_destroy_delayed_refs() even if we don't have any delayed references.

Reported-by: syzbot+0fecc032fa134afd49df@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/0000000000004e7f980619f91835@google.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8693893744a0..b1daaaec0614 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4522,18 +4522,10 @@ static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 				       struct btrfs_fs_info *fs_info)
 {
 	struct rb_node *node;
-	struct btrfs_delayed_ref_root *delayed_refs;
+	struct btrfs_delayed_ref_root *delayed_refs = &trans->delayed_refs;
 	struct btrfs_delayed_ref_node *ref;
 
-	delayed_refs = &trans->delayed_refs;
-
 	spin_lock(&delayed_refs->lock);
-	if (atomic_read(&delayed_refs->num_entries) == 0) {
-		spin_unlock(&delayed_refs->lock);
-		btrfs_debug(fs_info, "delayed_refs has NO entry");
-		return;
-	}
-
 	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
 		struct btrfs_delayed_ref_head *head;
 		struct rb_node *n;
-- 
2.43.0


