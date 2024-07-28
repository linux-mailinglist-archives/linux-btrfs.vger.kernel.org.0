Return-Path: <linux-btrfs+bounces-6801-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC5293E2B3
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 03:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEAB5B22B0D
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 01:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9E619412C;
	Sun, 28 Jul 2024 00:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+q0JBIO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC4194099;
	Sun, 28 Jul 2024 00:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128069; cv=none; b=a9c03x3ljSiEob1la1fzYqizAwyOHp0irhZTmVbwKryiTJ7YQK3Fi8eAsnX7jdfId5hMHGFOVEbmbXnGeI15E6xXwWNSsHf2yVL+QQ0QdRIx2j8rCdL7onFmwKF9g6V7Fq7zfxbyI0jdi16k15m9DTHW4Spo7SwJDooLW53hm2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128069; c=relaxed/simple;
	bh=utmi8ZSGJoU3f/4pW0XkiteJ6Jw3o+9Ywaf41aq1GZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXgjr8OpEkogToXjRq3u55JWuLvjt01arIhhFPskroMSyFVdvOIk9sCJmgT1AkAdGKm5F8m50Zm6VR+6L+vD2oFF2aMybbrAY0/X4G/OLX30yTEzYwZaqzADpSN2uShoP2S54SpFFj/RsLpseY1c4mUM5KcxTGBuigd4PccVMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+q0JBIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B237C4AF09;
	Sun, 28 Jul 2024 00:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128068;
	bh=utmi8ZSGJoU3f/4pW0XkiteJ6Jw3o+9Ywaf41aq1GZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+q0JBIOxCjT/PPaS0J5ilON5jMllBUDzowlcpvDJ4NRQy64AQJtZplh5rLEFpB0J
	 Ed/9FPY8dbzaqIxABb4JSax2eh57djUI3zhPmHSNRRXcfW3M36W52+6UcA/2eAAORw
	 +xbMzUqqo7cR8omajRrLC565Od8MplDfiXDH9en6IndvQ4UF6cWMMFQLC2M2zpTbtf
	 5c6P6pH/s05UDkaW9Kn75Y6lw25QKs2xrpbMSMJgeHi2RL5MEJl5URfSZRBaMNZFVq
	 OgvIPvucw0386ShYDPyFYqKaagGLmCa+qAe/MnGotZeHEGu+uUjDeimyVlwZ6KxdVl
	 uCJ7RyIqwK74Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 23/27] btrfs: reduce nesting for extent processing at btrfs_lookup_extent_info()
Date: Sat, 27 Jul 2024 20:53:06 -0400
Message-ID: <20240728005329.1723272-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 5c83b3beaee06aa88d4015408ac2d8bb35380b06 ]

Instead of using an if-else statement when processing the extent item at
btrfs_lookup_extent_info(), use a single if statement for the error case
since it does a goto at the end and leave the success (expected) case
following the if statement, reducing indentation and making the logic a
bit easier to follow. Also make the if statement's condition as unlikely
since it's not expected to ever happen, as it signals some corruption,
making it clear and hint the compiler to generate more efficient code.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 41db538e4959e..a7190fd747e07 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -104,10 +104,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 	struct btrfs_delayed_ref_head *head;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_path *path;
-	struct btrfs_extent_item *ei;
-	struct extent_buffer *leaf;
 	struct btrfs_key key;
-	u32 item_size;
 	u64 num_refs;
 	u64 extent_flags;
 	u64 owner = 0;
@@ -157,16 +154,11 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 	}
 
 	if (ret == 0) {
-		leaf = path->nodes[0];
-		item_size = btrfs_item_size(leaf, path->slots[0]);
-		if (item_size >= sizeof(*ei)) {
-			ei = btrfs_item_ptr(leaf, path->slots[0],
-					    struct btrfs_extent_item);
-			num_refs = btrfs_extent_refs(leaf, ei);
-			extent_flags = btrfs_extent_flags(leaf, ei);
-			owner = btrfs_get_extent_owner_root(fs_info, leaf,
-							    path->slots[0]);
-		} else {
+		struct extent_buffer *leaf = path->nodes[0];
+		struct btrfs_extent_item *ei;
+		const u32 item_size = btrfs_item_size(leaf, path->slots[0]);
+
+		if (unlikely(item_size < sizeof(*ei))) {
 			ret = -EUCLEAN;
 			btrfs_err(fs_info,
 			"unexpected extent item size, has %u expect >= %zu",
@@ -179,6 +171,10 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			goto out_free;
 		}
 
+		ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
+		num_refs = btrfs_extent_refs(leaf, ei);
+		extent_flags = btrfs_extent_flags(leaf, ei);
+		owner = btrfs_get_extent_owner_root(fs_info, leaf, path->slots[0]);
 		BUG_ON(num_refs == 0);
 	} else {
 		num_refs = 0;
-- 
2.43.0


