Return-Path: <linux-btrfs+bounces-2287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC09F84FB6B
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 19:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F258B26CE4
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 18:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C695E84A43;
	Fri,  9 Feb 2024 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ol6Fey4T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EF084A36
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501661; cv=none; b=B4kgqdlsbB6VzyQdRYYwQR12RTaUk3zR2mmOytnHzPedZLiyN5tpyL+5k4/L+VdDmXjZD1Kv2iEwMcjVcXzZH9BQ20XFPj9mabiLucDecYuZwmq3XuH9Fe7FHmb9KBWDNVvdM23lrv885jzt+SChh5P29TaihiHwSn9KVOm9wcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501661; c=relaxed/simple;
	bh=84HnlfqRkyfyOzLphFjA1q5tLsbyOMFXpg625Ia0wl0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWbeAWfr1jlcOs7b/qMjwi5vrBXEpfZWtIIbCKjlEY+SJySonKFpaDnC+MTQxrtyMWoJxJ4fFXKoIDXvzt0/SjPJjNV4jIESUSbrYeh33HGaJH4ESe4puOhf/Cixrg71zplayX7C6gws8N736HWWj8LsL73z1Su3i1SqC3yJSn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ol6Fey4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BD6C43390
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707501660;
	bh=84HnlfqRkyfyOzLphFjA1q5tLsbyOMFXpg625Ia0wl0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ol6Fey4T+Uet4eHuLZE0TCaCaZlznRFevsTrXlZTFUVBYqQFuGY6PbFBHv7WKDima
	 cenh8A3ln2tnS4b2JqhOF69mtkGiHWBMPmmZaEqNCjRT0M6muqpth/a+JxsU1xjixX
	 pQnlfBtoZ8DyJBVOQaLpX8W36KkhklQGu5bkXItyB7aN9mvBKha08uWitgy7w4IbjZ
	 8YRhLXRF34joQe+YbAXqgp5esf/xF0lU5Vu5UmEPA1q9LeDLJBnxCrrNtwo0LxzNwl
	 hn31D6TkJeBjCfQE0Zj3eYK1pN9e6J5ViQPYileXrcP+RpqzzCmsQ9/9iAW1hyNWds
	 5ddPBnv+M79Jg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/9] btrfs: add lockdep assertion to remaining delalloc callbacks
Date: Fri,  9 Feb 2024 18:00:48 +0000
Message-Id: <3c6359337ba942d628b989cc7458cde4d9a5373a.1707491248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707491248.git.fdmanana@suse.com>
References: <cover.1707491248.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The merge and split callbacks for an inode's io tree are supposed to be
called while the io tree's spinlock is being held, so that the given
extent_state records are stable, not modified or freed while the callbacks
are using them. So add lockdep assertions in the callbacks.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 778bb6754e00..c7a5fb1f8b3e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2300,6 +2300,8 @@ void btrfs_split_delalloc_extent(struct btrfs_inode *inode,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 size;
 
+	lockdep_assert_held(&inode->io_tree.lock);
+
 	/* not delalloc, ignore it */
 	if (!(orig->state & EXTENT_DELALLOC))
 		return;
@@ -2338,6 +2340,8 @@ void btrfs_merge_delalloc_extent(struct btrfs_inode *inode, struct extent_state
 	u64 new_size, old_size;
 	u32 num_extents;
 
+	lockdep_assert_held(&inode->io_tree.lock);
+
 	/* not delalloc, ignore it */
 	if (!(other->state & EXTENT_DELALLOC))
 		return;
-- 
2.40.1


