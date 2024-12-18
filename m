Return-Path: <linux-btrfs+bounces-10561-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A220B9F6BEB
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0B61883DAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBEF1FA16E;
	Wed, 18 Dec 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiX8zQYe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7E1F9F7D
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541616; cv=none; b=AYugoMvyz+s3ZLVwMGHjjBGod6HGfRocs+tefvrsqm7putZPnkpGVavJSWbcoTRxEEdYvw9ADMsLNNqNcHHev5aFulPanL6IDMR/K48ilGIBMd03ywXoB828ZXw44ARybTNS4qVZ+gUE5Dqb2pwhc9bBd/EItnAng1s8Zn/QxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541616; c=relaxed/simple;
	bh=5qm1uafcb4QTszeBGB306Iw56fpUr50UE+IuGt29ixs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B8MywB0s3iZrR/z319pECxdRo40csM6qjDOBOvhZFmrIo+L5GWjDidv7dVC9LCI484+49XQIibDQddaLzZY1+egjalW5GYydOg9xMg2ix1VvKZmjjwQKmnU2fkeIT+81q+5E4VRTCi9EEt/kvceUhb3CP6l8+I0eEv/pwJrbBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiX8zQYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2365FC4CEDD
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541616;
	bh=5qm1uafcb4QTszeBGB306Iw56fpUr50UE+IuGt29ixs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SiX8zQYeAiO7fMaiVLwl/D1gE0XJl8dIEuRybhfywcdvNWjGAVZ+AXElANZbR1aE8
	 J07jGsqqJTCEWsfdBZEaNicPaVkD8XyD3htyNnwuUIE5jCe7LNXpevI3gy/bWvtAMB
	 09jY0YzJ514abD6K7fXoVAywyZCCkttg7O/0TNfNQqcBmwNhrg6Jm3LhoQnewffmQH
	 l0N48wrHssdazUL8/NqrIwCPkASdjz/vl9BybbyHwXeCxZoReXG3CqhbsSwn78MUVj
	 r714U0RQEZ8mYBNAL2j8xBCBlcLQVeN7hTo+KCmXLXVJW28q+GcRnT/PZ2ybFoKwoN
	 bbuzTKkHAh12A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/20] btrfs: delayed-inode: remove unnecessary call to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:32 +0000
Message-Id: <ed9ca43b72f6a1579760f5c93727f03d42f62515.1734527445.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734527445.git.fdmanana@suse.com>
References: <cover.1734527445.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The call to btrfs_mark_buffer_dirty() at __btrfs_update_delayed_inode() is
not necessary as we have a path setup for writing with btrfs_search_slot()
having a 'cow' argument set to 1.

This just makes the code more verbose, confusing and add a little extra
overhead and well as increase the module's text size, so remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 508bdbae29a0..02c1efd53904 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1038,7 +1038,6 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 				    struct btrfs_inode_item);
 	write_extent_buffer(leaf, &node->inode_item, (unsigned long)inode_item,
 			    sizeof(struct btrfs_inode_item));
-	btrfs_mark_buffer_dirty(trans, leaf);
 
 	if (!test_bit(BTRFS_DELAYED_NODE_DEL_IREF, &node->flags))
 		goto out;
-- 
2.45.2


