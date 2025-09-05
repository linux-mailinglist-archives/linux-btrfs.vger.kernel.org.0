Return-Path: <linux-btrfs+bounces-16658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000E6B45D94
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0056F7B1253
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258FF302158;
	Fri,  5 Sep 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+6XCG0o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC5A30B518
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088651; cv=none; b=dkqb57jh/qpHXhBTiZSO3AzC2E7mCgjVry9seUHlal7Wvd98e3uMu23TK5vnTy6H7nZ9MYM/Mvgy1Wq/KZAUDuW1kpcIZ4wKarMQKkoqpdym1AkpRrwN+VDcU/VwjoKGriRhtfS+KC0rdq6GRLaiOURw703MNYwMWRwCYLzQvkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088651; c=relaxed/simple;
	bh=69t+w7M5Fb7KViV4yPWb+g/SV8f1HNSKnAXUgUtPalM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXLS2T1f1coPFqagruPC07ZKh3cXXgWkSqIMBi7t+O5LrvrY8h8RN2BGLphPLrVuDgzDgU3WntoMeKfs1JJ3feYCU49nuejgOubyWLXJvTHjWWeSPiFrnfuC8Txe4GI38zzbgHt4hYlTz4rgYVQjqHHS3L3JfnZzDEM6/uEJjB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+6XCG0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D01C4CEF4
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088651;
	bh=69t+w7M5Fb7KViV4yPWb+g/SV8f1HNSKnAXUgUtPalM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=N+6XCG0oP8HDia1SJRbCnAF+2cYFVBAfk0ubhSXHxZKxp50xcCC8URIGC/+17Np4v
	 QQwppFxC9mmANP0hXMC6NFJR0vdB2ChFuQMI3fU5hOObAmAZ2U76N5lpCZC+BOJsX1
	 DPGTyz9n+60K9mV35Q+xB+btu3OlwGRTwvWQeRBEOGx4E9t7xsZmpvUjdNj0SPRvPY
	 1M2AgLSCCAMSRPfuUIt9XbcXDXWFyP9QZqVSqGQUfGiQchQI4HDtM/D5fhnFCazg6c
	 YlAGH+qyD3yDjMZyrvccvnmLHVVpBM3ofhzPc/dPjMxl6+j35zzRRVPUD5mqCJyxfT
	 Y3iQhHD7yz0oA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 14/33] btrfs: pass walk_control structure to replay_one_extent()
Date: Fri,  5 Sep 2025 17:10:02 +0100
Message-ID: <be42d132ae154a3e2fb68568eac556b40ec1eb23.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of passing the transaction and subvolume root as arguments to
replay_one_extent(), pass the walk_control structure as we can grab all
of those from the structure. This reduces the number of arguments passed
and it's going to be needed by an incoming change that improves error
reporting for log replay.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ca0946f947df..aac648ae30fb 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -642,12 +642,13 @@ static int read_alloc_one_name(struct extent_buffer *eb, void *start, int len,
  * The extent is inserted into the file, dropping any existing extents
  * from the file that overlap the new one.
  */
-static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
-				      struct btrfs_root *root,
+static noinline int replay_one_extent(struct walk_control *wc,
 				      struct btrfs_path *path,
 				      struct extent_buffer *eb, int slot,
 				      struct btrfs_key *key)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
+	struct btrfs_root *root = wc->root;
 	struct btrfs_drop_extents_args drop_args = { 0 };
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int found_type;
@@ -2728,7 +2729,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 			if (ret)
 				break;
 		} else if (key.type == BTRFS_EXTENT_DATA_KEY) {
-			ret = replay_one_extent(trans, root, path, eb, i, &key);
+			ret = replay_one_extent(wc, path, eb, i, &key);
 			if (ret)
 				break;
 		}
-- 
2.47.2


