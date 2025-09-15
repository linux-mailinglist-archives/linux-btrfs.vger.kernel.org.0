Return-Path: <linux-btrfs+bounces-16830-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B170BB58246
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 18:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB992A1E6C
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 16:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170602857F2;
	Mon, 15 Sep 2025 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2X3Isc8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B122836A3
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954242; cv=none; b=s99zlFuxP3Uao6LpDmDZfiqLIMH7PKTsBnymMbJnzlpX6CYbf9MfBtyqwAjpDgENxAvJ5ebdJiLuaMX7OOtMnctMV0wZqml3MYHsLm3bdLxtp6Rhvd5wPlB8mDpmHeLe+WgkakqrSHpjkxeECdtb1DqXDyUUPnG29Xgjo9TTPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954242; c=relaxed/simple;
	bh=+YCean5I4QtSX61A/gIux2YwzGHb7MDQ8n2F0EWDn6E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fv2jLW8b90EwTXCpJV0hsO6PIVsJjHPbmz3GhzaEihCe6vGTdjvqJNbI81MeZY44NX2eSbRw+1IFhiqWj0yyHtPR7+PqlTJUWzRyra1eWNeSZQTbXiJVIzIX7/PVzFEYMl6nNgCyKvLdgEbRNMyjWllH9M1hkyIdMi07VuUkOwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2X3Isc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0000C4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954242;
	bh=+YCean5I4QtSX61A/gIux2YwzGHb7MDQ8n2F0EWDn6E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=M2X3Isc8lRRJyZlKBPGtjSZxdJRmL9DnIy0M1+CPUI6CaOh1Q7iz+sSZFnHJt3gJp
	 gAhq+2djyJSleayISZofxxWPm8lky6vWJu11yRiglZcnTytoqUXWiHdbpfYboWBbWA
	 w5CzTGdaVajfuDrMxgD+v0IM8NaN6YMmS7a+/YBjuuNsNKaJH99AbZBWB/ZDahokSZ
	 Lpx5VBE2K7etRNppqcMjAkAmcO7ew7TfsZDPh+NjlGZws862w6dj1yYDbH3SHEq0My
	 U10thGk9eMbbOFIkeCcfYUGEk2w8Zo3IQqXOixQTbSJAR/fJp8fuVvY4l5cuPgb/b0
	 9E6aSkiX+Z1qw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/11] btrfs: print-tree: print information about inode extref items
Date: Mon, 15 Sep 2025 17:37:07 +0100
Message-ID: <3e2fc2ad71bd5a4e4d2d488a23253382a8f8e90a.1757952682.git.fdmanana@suse.com>
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

Currently we ignore inode extref items, we just print their key, item
offset in the leaf and their size, no information about their content
like the index number, parent inode, name length and name.

Improve on this by printing the index, parent and name length in the same
format as btrfs-progs. Note that we don't print the name, as that would
require some processing and escaping like we do in btrfs-progs, and that
could expose sensitive information for some users in case they share their
dmesg/syslog and it contains a leaf dump. So for now leave names out.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/print-tree.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 7a7156257d59..0a2a6e82a3bf 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -297,6 +297,26 @@ static void print_inode_ref_item(const struct extent_buffer *eb, int i)
 	}
 }
 
+static void print_inode_extref_item(const struct extent_buffer *eb, int i)
+{
+	const u32 size = btrfs_item_size(eb, i);
+	struct btrfs_inode_extref *extref;
+	u32 cur = 0;
+
+	extref = btrfs_item_ptr(eb, i, struct btrfs_inode_extref);
+	while (cur < size) {
+		const u64 index = btrfs_inode_extref_index(eb, extref);
+		const u32 name_len = btrfs_inode_extref_name_len(eb, extref);
+		const u64 parent = btrfs_inode_extref_parent(eb, extref);
+		const u32 len = sizeof(*extref) + name_len;
+
+		pr_info("\t\tindex %llu parent %llu name_len %u\n",
+			index, parent, name_len);
+		extref = (struct btrfs_inode_extref *)((char *)extref + len);
+		cur += len;
+	}
+}
+
 void btrfs_print_leaf(const struct extent_buffer *l)
 {
 	struct btrfs_fs_info *fs_info;
@@ -334,6 +354,9 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 		case BTRFS_INODE_REF_KEY:
 			print_inode_ref_item(l, i);
 			break;
+		case BTRFS_INODE_EXTREF_KEY:
+			print_inode_extref_item(l, i);
+			break;
 		case BTRFS_DIR_ITEM_KEY:
 		case BTRFS_DIR_INDEX_KEY:
 		case BTRFS_XATTR_ITEM_KEY:
-- 
2.47.2


