Return-Path: <linux-btrfs+bounces-16699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85514B4891B
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 652B37A2BF8
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E832F60A1;
	Mon,  8 Sep 2025 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5tIlYtN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97C32F4A16
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325214; cv=none; b=pBXNxC4Zt2SJbaXZ639IBPfoqzfsKeuo+VOYkwQm05LL0lDi8yZp/keZnxX/6Oi9XnjtD3b+0aj3LQ/JReUxRIV63pETmWeOAAA/sytSbQ0SOwU8vmzrjqry1sPVkoqgUyF9uQd+Ab8j3ni/M2Uq2VNCckhXBApFs0S3hEo475M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325214; c=relaxed/simple;
	bh=7afcbzFVlqJAj3i2oyQUeu30EGicpEb94oA92R3oiw4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UO9ni6DvCIntz/CSxgJOwzy0lvACQk2Gn7ALC+/EJEuqaac/IihZ9QcGEawPuAeNR9FtEaTN4NP2WF8r4LPzCrkC79YASsJm16eJrsup+ioNtGOG+3l+YWr2QGjBQzjZBCzlbHp6V+2Ct9B7uMmsXdD+rxGXJfmOI/CehtpN9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5tIlYtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9F9C4CEF8
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325214;
	bh=7afcbzFVlqJAj3i2oyQUeu30EGicpEb94oA92R3oiw4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=e5tIlYtNrDleehIgFKwx1ZMOhlrayaxQzv7eHNGx29lwH7ILItOyjipDECqDAvMLr
	 ga4bOa2qqAR6yYjUb+ukO2SYcWjZP5jWMjD1cgscteOYPpfaTys4tc3AoKEtRXaw/G
	 +J029M3X37WtFrp1cvvasHb7ySv5dkVTxxKscu/HxE3JkqKHWnx2CQJuJ7/aO9BWP7
	 vtca4Xb0xS3I1ODEDOhPGnj42dl+9If74ZyxkI69kH7h9/wSnQqMIUnqzbNnkoWStM
	 gKEq3JopMeduk8LrhAiKBSopfXCtOXUf/uC2xkVNCp3h2pc7zEO5HGgIqdzJrZuQLi
	 6ucUX8iiPpaoA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/33] btrfs: rename root to log in walk_down_log_tree() and walk_up_log_tree()
Date: Mon,  8 Sep 2025 10:52:58 +0100
Message-ID: <1ec1b6e325425c3eb9753ecb24f95b422ff5ff36.1757271913.git.fdmanana@suse.com>
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

Everywhere we have a log root we name it as 'log' or 'log_root' except in
walk_down_log_tree() and walk_up_log_tree() where we name it as 'root',
which not only it's inconsistent, it's also confusing since we typically
use 'root' when naming variables that refer to a subvolume tree. So for
clairty and consistency rename the 'root' argument to 'log'.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c0cc94efbcaa..321ec0de0733 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2779,11 +2779,11 @@ static int clean_log_buffer(struct btrfs_trans_handle *trans,
 }
 
 static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
-				   struct btrfs_root *root,
+				   struct btrfs_root *log,
 				   struct btrfs_path *path, int *level,
 				   struct walk_control *wc)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_fs_info *fs_info = log->fs_info;
 	u64 bytenr;
 	u64 ptr_gen;
 	struct extent_buffer *next;
@@ -2821,8 +2821,7 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 		}
 
 		if (*level == 1) {
-			ret = wc->process_func(root, next, wc, ptr_gen,
-					       *level - 1);
+			ret = wc->process_func(log, next, wc, ptr_gen, *level - 1);
 			if (ret) {
 				free_extent_buffer(next);
 				return ret;
@@ -2873,7 +2872,7 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 }
 
 static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
-				 struct btrfs_root *root,
+				 struct btrfs_root *log,
 				 struct btrfs_path *path, int *level,
 				 struct walk_control *wc)
 {
@@ -2889,7 +2888,7 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 			WARN_ON(*level == 0);
 			return 0;
 		} else {
-			ret = wc->process_func(root, path->nodes[*level], wc,
+			ret = wc->process_func(log, path->nodes[*level], wc,
 				 btrfs_header_generation(path->nodes[*level]),
 				 *level);
 			if (ret)
-- 
2.47.2


