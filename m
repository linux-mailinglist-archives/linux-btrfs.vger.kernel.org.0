Return-Path: <linux-btrfs+bounces-16654-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB638B45D8B
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DE7A4654C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2C430B503;
	Fri,  5 Sep 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxq8rSJG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5E309F18
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088646; cv=none; b=uFJziePmVPiyBjx8GFTAvkma8lc8A0GIk9DjmDC40izMoogH4gYd/MCOZb3sQHY+NmwpP/ILQGMxm+J5bFlKFrIZouiAv3wrkkKXwFwWoDlfihroNnUEWrU3PJhIHcxFg8Vpxrt8M+Unl1d9Xn1hgGObEugSJHZfZ6IVtJk9j0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088646; c=relaxed/simple;
	bh=NQj4S89jaLmyhBjoxaaJOHrlb+Zb3GHOyPLpjkEFSxQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgfxiKMezQaJfTnZbGBZjCeJz4O8y/zLzuGxlaTO0EqglWOH0aeUaCUBJtJK8Mert9j3/c8ehbEiagPbXM9NMkr0tc9m8z6yevPf4m8lVZRfhBZOHv2cKAVB722pNia/cn2j2rPbmx7MNmQTiJTfnxP4/spWqI1ON7DPCOAmiZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxq8rSJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3E1C4CEF7
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088646;
	bh=NQj4S89jaLmyhBjoxaaJOHrlb+Zb3GHOyPLpjkEFSxQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jxq8rSJG6WAe/BOXwPNRtVpFUXIVLYg5JZ/FcGnZ0BTVuuDhqZl3L32+S5OVRuWF+
	 pqwd5JwUGFO2cRxRvkqizGwXzDeCxAFQOaKar2ARUGt3T0VlH7VZVOZfeYwJ7727GG
	 /XIDGiZ/B93cSW/tiIG64XOvJFc0VQgZxfKczedvXWdYbsHS10ahrKkbJpKIPJTMOF
	 huWPBx3fjSherbF67l0xDVKHYnts+XSkzvM2vAaawARdA9doKxXe7X/0l9oc3MqHIs
	 DMkPeWP5b/Wl5PpAm+bnPaKFt2qFUCnofmZRX91oHRm+Jgw2et6w2O+AtwVVUmDI4U
	 FYruHJqDtXdxQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/33] btrfs: pass walk_control structure to replay_xattr_deletes()
Date: Fri,  5 Sep 2025 17:09:58 +0100
Message-ID: <592339eb87bdef9db3f8e87abbdbe0475d4c329f.1757075118.git.fdmanana@suse.com>
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


