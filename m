Return-Path: <linux-btrfs+bounces-16729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F22B48CCF
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 14:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 008FA7A6AEB
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 12:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81CD2F7AA1;
	Mon,  8 Sep 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONlEEDyu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DAD22D4F1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333112; cv=none; b=ovQw7Czzg2EWYSx2sIyLY+zBhsYmEaAN1hOT15Cli3rqijv/oomLFS/3Gr0fIaha2RBK/cGaUgnZAYKrsNicCx5O1A84hciSFGc7PkWYy7OBYwT9Jjbd+whkpkxoIwO+dBoBNZKafQa0Tmv0fUEl9weCm41JCFPIZ8gS5cgayiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333112; c=relaxed/simple;
	bh=1eHBdzsQIKDQCMW9xOYOw2WSVwqCFkNpgrYnwKZHTaU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Kwr/DUqVHZVuOCAzWNkPZ8f+QLfcb5CQYYWs2bKdd1U3comkVVUmE3LcHFLr9QGaSPfWm6b3C5J+jkOlf93lUjVbfppf1KgK2ljfdflroATaSMokIQNgnPzy+j+Z6UNxtkfsjf0kc91geDrbWv8UrkB+7v2mC9iXA0gVPCMgEvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONlEEDyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A94C4CEF9
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 12:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757333111;
	bh=1eHBdzsQIKDQCMW9xOYOw2WSVwqCFkNpgrYnwKZHTaU=;
	h=From:To:Subject:Date:From;
	b=ONlEEDyuahfdJ52PmX0k/WiWoN/YOxPM7PAR61zwbjcSK+lTqlThJKc1fsbEAXhF5
	 bAqEhZJUpX8JMfd2ePVXVIc2DlcOvpksDaQ4my2TMMj24APWN5bf4OrJnrSMo5GpOd
	 JYpIwP092KHYGMMqUOTyvNzIpX8nrb7Z/kknPa4kFp+gpIMfJEX/QtbxDhCh8t3skv
	 gNYest3h5hdmQYPzVATyRppY96zCsyxOtn2KjgHu5l0rMQPI2+8jM1lN6wW86XsCCX
	 0GTHge1L2bHUYTv5tNDT9cpmowpusyFfVV/LByebVaI9vzEhPh707jZde5eoc6sgeh
	 fE466tYO4AQ+g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: send: index backref cache by node number instead of by sector number
Date: Mon,  8 Sep 2025 13:05:08 +0100
Message-ID: <38a42e9d2d1ebd8f94f9f68385095854bc05a086.1757332226.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We now have a nodesize_bits member in fs_info so we can index an extent
buffer in the backref cache by node number instead of by sector number.
While this allows for a denser index space with the possibility of using
less maple tree nodes, in practice it's unlikely to hit such benefits
since we currently limit the maximum number of keys in the cache to 128,
so unless all extent buffers are contiguous we are unlikely to see a
memory usage reduction in the backing maple tree due to less nodes.
Nevertheless it doesn't cost anything to index by node number and it's
more logical.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c5771df3a2c7..32653fc44a75 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1388,7 +1388,7 @@ static bool lookup_backref_cache(u64 leaf_bytenr, void *ctx,
 	struct backref_ctx *bctx = ctx;
 	struct send_ctx *sctx = bctx->sctx;
 	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
-	const u64 key = leaf_bytenr >> fs_info->sectorsize_bits;
+	const u64 key = leaf_bytenr >> fs_info->nodesize_bits;
 	struct btrfs_lru_cache_entry *raw_entry;
 	struct backref_cache_entry *entry;
 
@@ -1443,7 +1443,7 @@ static void store_backref_cache(u64 leaf_bytenr, const struct ulist *root_ids,
 	if (!new_entry)
 		return;
 
-	new_entry->entry.key = leaf_bytenr >> fs_info->sectorsize_bits;
+	new_entry->entry.key = leaf_bytenr >> fs_info->nodesize_bits;
 	new_entry->entry.gen = 0;
 	new_entry->num_roots = 0;
 	ULIST_ITER_INIT(&uiter);
-- 
2.47.2


