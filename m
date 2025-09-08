Return-Path: <linux-btrfs+bounces-16705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A660B4891E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E75189CF69
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBED82EFD8A;
	Mon,  8 Sep 2025 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT6BQ6nS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC592F7AAD
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325220; cv=none; b=AfYT7ikGr3buW/rMDSyaHlUutVYFzGT+9thz7x8GTpuZqINtpUqpwV/JF65eOjr/ewr5wV9fw2LPtyuuZG4RsD0tkMeJurx9vpZUAy6roSk4rEindLAJj5g5JZt4DDuqzpC4BbDKck2hJH3W7X8xWmEmsCmGnRli3KOYLlCjIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325220; c=relaxed/simple;
	bh=NQj4S89jaLmyhBjoxaaJOHrlb+Zb3GHOyPLpjkEFSxQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9tdCLeq/JHqdI0xHIWCUJ3s0nyqEK9F437w0Piy2loR5Dkgo9kU+m6A/zBnpW055Xh2JJVGnCslmtQiAgbrnI7LGCd1FoWVzzyfUKbvzdxzn3mgoJZC5j8Kie9pTmHQGbRb6eyu4aaTiP51Zx30hi9rHChyswJeU1u3k9QwnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT6BQ6nS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9592AC4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325220;
	bh=NQj4S89jaLmyhBjoxaaJOHrlb+Zb3GHOyPLpjkEFSxQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NT6BQ6nSd2civv3mKege170oKbIlgt/I39EGHGFk6VITsFdH/svCRJk1Hp1veseST
	 z2ObfbHskfe5l0LBv1yp1e3ogZFfazUXlJ3BA6oVp7gHHNBxW4Z3bQIG3DwETS0rbG
	 VGi0gfx+dtoMA+OjWAHP4oEOTI9UEDqTB8gO66hnCYx4252JaL94vuWH/NbV0454cK
	 cK4guOgMQCmyK8muTzNzQUe7Fi1D5fKArLwMoGUFSSyMuDsR41T80XWnp73V1EHo/n
	 nrfciPCyndEPoFktFsACvzn896UExfgqUZRswzJq6/lE9F16BhAlLv6O8hovc9pYry
	 KzVETFKGgXu4w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 10/33] btrfs: pass walk_control structure to replay_xattr_deletes()
Date: Mon,  8 Sep 2025 10:53:04 +0100
Message-ID: <592339eb87bdef9db3f8e87abbdbe0475d4c329f.1757271913.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757271913.git.fdmanana@suse.com>
References: <cover.1757271913.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of passing the transaction, subvolume root and log tree as
arguments to replay_xattr_deletes(), pass the walk_control structure as
we can grab all of those from the structure. This reduces the number of
arguments passed and it's going to be needed by an incoming change that
improves error reporting for log replay.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4d34aee0cafa..cd4c5ae3e0a3 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2336,12 +2336,13 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int replay_xattr_deletes(struct btrfs_trans_handle *trans,
-			      struct btrfs_root *root,
-			      struct btrfs_root *log,
-			      struct btrfs_path *path,
-			      const u64 ino)
+static int replay_xattr_deletes(struct walk_control *wc,
+				struct btrfs_path *path,
+				const u64 ino)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
+	struct btrfs_root *root = wc->root;
+	struct btrfs_root *log = wc->log;
 	struct btrfs_key search_key;
 	struct btrfs_path *log_path;
 	int i;
@@ -2645,7 +2646,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 		    wc->stage == LOG_WALK_REPLAY_INODES) {
 			u32 mode;
 
-			ret = replay_xattr_deletes(trans, root, log, path, key.objectid);
+			ret = replay_xattr_deletes(wc, path, key.objectid);
 			if (ret)
 				break;
 			mode = btrfs_inode_mode(eb, inode_item);
-- 
2.47.2


