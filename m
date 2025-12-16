Return-Path: <linux-btrfs+bounces-19796-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAE6CC4588
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 17:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C69230AE099
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 16:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221132C21FC;
	Tue, 16 Dec 2025 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH/szRMz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF42135B8
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902804; cv=none; b=DDcYAdyvUB01GxUVxZ9eXGpjZSO8XFoa/YNZvJwiSkJTwradmQnz31lAaAETwtI1tQ7ZpI1Grbg5Ij6ODYzE9RyZgmuhFD9X9CpjkERehLtpLuWgY956/eHO+ODIe2RbrzvsHSO7XlICjYb+9cEQ7RbBR90n4id/IYajp2/fQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902804; c=relaxed/simple;
	bh=z3ZlZG3KWPlyx0XQaYaERRzKTYadEgRwpxCJWUYJUi8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAhbjCwb/ay8GgXolRpGnL12FXe0lrnJQxlDPURKCRmJHegQlUF0RLj02ak0K0ATwivxOad6pspJdNhgfHHRP2Mzr5UPRpPW5R7/HHIKsc5wOv/VPv5cofqgrLmup0p/y9/Q+QcuYbpJ7ZntY/nZrf+Sh1KKqPuihL8afYVC5xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH/szRMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3EDC4CEF1
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 16:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765902804;
	bh=z3ZlZG3KWPlyx0XQaYaERRzKTYadEgRwpxCJWUYJUi8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kH/szRMz7+KAZ/lIOdhFM2pcRYcFZhS9bwIBWBHDCP0TDh/rcKJEQpXmAptEgR9ek
	 m4dtB7DE4BD4xbLuoVb+GzbxC4OMg9WUy4qupbXn2ORWWZeDtc9ZBU9Od14la/T2Rm
	 4C8HxnpI7ep8QfZXSfSLL4PgDKAYGB/E9aLHHyTRYc2VtZ2T9S0Sxm86AMsro5QOP5
	 StKmWe8enTdvuO/Ij1+7sPFh99zd25BhbXa6l4/j9t+awwp8BzETSHAMBJOwCPERv/
	 Y9mZYKUu4Jmc/BMfY+KAFA92brQKyR9Nk2j2CRL9b9NVcW5Z+PsBan59ApOle2tLC6
	 rxDzIvgNP593w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: remove redundant path release in btrfs_find_orphan_roots()
Date: Tue, 16 Dec 2025 16:33:17 +0000
Message-ID: <60bee177dfd828aeca26aaf742eb58d76bfc646f.1765899509.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1765899509.git.fdmanana@suse.com>
References: <cover.1765899509.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to release the path in the if branch used when the root
does not exists since we released the path before the call to
btrfs_get_fs_root(). So remove that redundant btrfs_release_path() call.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/root-tree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index a7171112d638..40f9bc9485e8 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -261,8 +261,6 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 		} else if (ret == -ENOENT) {
 			struct btrfs_trans_handle *trans;
 
-			btrfs_release_path(path);
-
 			trans = btrfs_join_transaction(tree_root);
 			if (IS_ERR(trans)) {
 				ret = PTR_ERR(trans);
-- 
2.47.2


