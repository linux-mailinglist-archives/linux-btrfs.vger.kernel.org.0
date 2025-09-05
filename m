Return-Path: <linux-btrfs+bounces-16648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CAFB45D88
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076D9A462F2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA24309EE6;
	Fri,  5 Sep 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3FhVKiN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D9306B39
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088640; cv=none; b=ggaumOUYQNhoN1bv2NApiFihxEQTtrhqVQClTedXmLmmWaP8w5t5Nbxjcsx0lvSGqs0APLh2Ntsitux5XBvolnRyVDVRUGJQwfKdXDGWtADpHSj5vKf2+fmwdl+Angxbkyo9EBjqO9Oo3kyq/TroYa4oMczlHaAzY5u4gbZrmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088640; c=relaxed/simple;
	bh=7afcbzFVlqJAj3i2oyQUeu30EGicpEb94oA92R3oiw4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQD46tV6ifKPXNIM5iqGFyyHt7asSlW2InJkkn/K585MoLg63ZvyeKgFZR6JD5m876Ii8P1MMNBticCvJ2pr5iNtJZ3Wsc89SMsjycib6VvsLNyPBz5D8N55izyUwLNz1x263ooUL81Z+29j4PGD85knMODFmyaeCRkWvWgpM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3FhVKiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A7EC4CEFB
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088639;
	bh=7afcbzFVlqJAj3i2oyQUeu30EGicpEb94oA92R3oiw4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=L3FhVKiNBM6kpEYiNDyBh39fMVNYYbOWDrA+UL3qT00Zp6wuFZHCvp+C92KqfDFcD
	 aeNIU/xvVPSO5dMkN/ewEjDgDyCwH75qS7iVM+0dJCd8ZKGS7W4Ahc4NT9TMu04Ji/
	 k0h1v/ygx5xqf4LSRXnvVWYU1J2aN0J6iKstmuWNxpsJAqekG8oDE5uTe6BJCbQzLh
	 19PsceXFRL8j2BGuMGdgfAlrhXHsVaEevGQLGnRCS76Fq+uO1XwxYqRuNOxRHZ4ZI6
	 WdfgE03Yrs0c4jU/2p0HBp1MaF994NlKkWk5bFhPmgHmuV/hVjyO5T7jjhT1zkiEoM
	 CVKKotMKov95g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/33] btrfs: rename root to log in walk_down_log_tree() and walk_up_log_tree()
Date: Fri,  5 Sep 2025 17:09:52 +0100
Message-ID: <1ec1b6e325425c3eb9753ecb24f95b422ff5ff36.1757075118.git.fdmanana@suse.com>
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


