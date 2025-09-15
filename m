Return-Path: <linux-btrfs+bounces-16829-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A1AB58244
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 18:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5F32A1905
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 16:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F8A27877D;
	Mon, 15 Sep 2025 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrgW+oKx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667B528468E
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954241; cv=none; b=QcjqfKI731uoqKkDOM5Kj2ryE3PADmOcMtIPGCTLgX+SDo/bCBpIKRcg5+qXWMvsgDKFvY4WRx91w/BoQ7MpJ1TUQ7x+RUD98BxpZfTtm+KoPywjv4RWoZx43SskdnAMDiocdH1TwLXoC3rMDYG/2sY3ts9WJp+ArT1bpq2Xh6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954241; c=relaxed/simple;
	bh=vJ8651hIMnbeE8h2STfFI3sxSycJFFtD6GOKUShbU7A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJvI/bDEjN0KEGMYiRVJCz7ai1MiasnPfGzZBd+Bx0mob/GzxIFpHUKQkhx5mMjhkVtaeXStpBMv/XMwTzAFvCO5vpMna3o9wDasC8/ob3Fu8ERA/NjUeYWygm3FNhQr9P9lU5k0qsh/zpGon1/kvlGF0ze20xuXHMKZXWBKD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrgW+oKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD32C4CEFA
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954241;
	bh=vJ8651hIMnbeE8h2STfFI3sxSycJFFtD6GOKUShbU7A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OrgW+oKx6CrUMSIfPwePoj/+yHVbOifTgOvmBrJzhEb7EjnZTbFMrPTnwl6y8WUZj
	 g4Vx4bZmtOO88D4aJVay0XpNgGG5pcqpBpmttGp1JuMIKVznmzawem+UUQoxDfT9w2
	 ys5Boa1dSPrsyUOFSiWnIe5hNT1TxD0Xjyt1IBpLu1FduNNrDW/T3BxT9gi9Og6KfC
	 TmS33eHoUbOvkpfG8mC4KxV/epvL/Sa/ePuT/wZjCG6FCFkUK+dSkDSEtjtN99jCCS
	 qhqhj0s6ve+EW9iFyLjwu3+SdOHCzupYDQ0FIhcGZtMxG9EocPwjkTl0G+7ZgIP++v
	 3Yz5jXiwBVKzg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/11] btrfs: print-tree: print information about inode ref items
Date: Mon, 15 Sep 2025 17:37:06 +0100
Message-ID: <a9308ce42e1e1fbfb5dfe169288915995cda9f95.1757952682.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757952682.git.fdmanana@suse.com>
References: <cover.1757952682.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently we ignore inode ref items, we just print their key, item offset
in the leaf and their size, no information about their content like the
index number, name length and name.

Improve on this by printing the index and name length in the same format
as btrfs-progs. Note that we don't print the name, as that would require
some processing and escaping like we do in btrfs-progs, and that could
expose sensitive information for some users in case they share their
dmesg/syslog and it contains a leaf dump. So for now leave names out.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/print-tree.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 5ae611cb3f2e..7a7156257d59 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -280,6 +280,23 @@ static void print_dir_item(const struct extent_buffer *eb, int i)
 	}
 }
 
+static void print_inode_ref_item(const struct extent_buffer *eb, int i)
+{
+	const u32 size = btrfs_item_size(eb, i);
+	struct btrfs_inode_ref *ref = btrfs_item_ptr(eb, i, struct btrfs_inode_ref);
+	u32 cur = 0;
+
+	while (cur < size) {
+		const u64 index = btrfs_inode_ref_index(eb, ref);
+		const u32 name_len = btrfs_inode_ref_name_len(eb, ref);
+		const u32 len = sizeof(*ref) + name_len;
+
+		pr_info("\t\tindex %llu name_len %u\n", index, name_len);
+		ref = (struct btrfs_inode_ref *)((char *)ref + len);
+		cur += len;
+	}
+}
+
 void btrfs_print_leaf(const struct extent_buffer *l)
 {
 	struct btrfs_fs_info *fs_info;
@@ -314,6 +331,9 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 		case BTRFS_INODE_ITEM_KEY:
 			print_inode_item(l, i);
 			break;
+		case BTRFS_INODE_REF_KEY:
+			print_inode_ref_item(l, i);
+			break;
 		case BTRFS_DIR_ITEM_KEY:
 		case BTRFS_DIR_INDEX_KEY:
 		case BTRFS_XATTR_ITEM_KEY:
-- 
2.47.2


