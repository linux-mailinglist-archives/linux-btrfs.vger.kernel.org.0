Return-Path: <linux-btrfs+bounces-10576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BE59F6C07
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA88518892CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E150E1FC0EB;
	Wed, 18 Dec 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajAmNBuG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D28F1FC0E2
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541632; cv=none; b=rKHamuYVlTtBKk3VPE9zhDhbrv4s2lisFsVCEubG9Rx5vFKo5epLs67lYQpZ/pI9ZmcIr/3tR0tB30+9S641xw03pxcaY0+X9slx+IsRmdvdvPQcde3hzJzvhQGeVi/XT2pBSraixQdIXJyVdQyJJc9+MnxxKC1MHn1QkBa+ltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541632; c=relaxed/simple;
	bh=amfu69XGVKcpUCq4XJ0FAL/QurK9vmGStA6FqT6BeHw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HeCCu2tr0SBDiql5AAJ06JiRw4FQ4G7oVpUe7gZw6gtdEulNlCbqd3FIs2Asv/4UgEHldYeXOCmJmnh3eZ8XMHrANlzGysAe7ti4wULkI74x34FXM7aUfht1oXiQkhSdBoMZ/tvkzi6TzY2MIl2gSyXHecCNthrIoHC/rb0ltzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajAmNBuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F830C4CED0
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541631;
	bh=amfu69XGVKcpUCq4XJ0FAL/QurK9vmGStA6FqT6BeHw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ajAmNBuGXagHrw0vMuT61kLeFxjU3hMnpiL/bCqEmnibULpfBHV7d6oXRjY0D2aTV
	 KTvCIPnlBoeCBQlBbcoOO10L+yRAERMRMac6lgwtWMwAFbdXYBVWEBmg5sGDykLc1j
	 0m6p+zUjrF78+OcsggxLYu/40GXK/RrU+XO94bo8nvW5f7jtKdLhMjxk0Bqke1bbkP
	 7GXRbUdZU99OKwalklJOxiRHDBDABRSOiEf7NcOipLTHeMWWuProvdD7m+tAs5ngXA
	 CjMOaiti4QBDgmbBTIw1t6WhQw8nEa+3TF2b161s7mMpD5CYNbTv3ZBmKc9GhRZtcS
	 C3MwP3kFPs+wg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 20/20] btrfs: xattr: remove unnecessary call to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:47 +0000
Message-Id: <c49e3a1aa2ffd66cd762fc417fc6b0a4b0cb73f2.1734527445.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734527445.git.fdmanana@suse.com>
References: <cover.1734527445.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The call to btrfs_mark_buffer_dirty() at btrfs_setxattr() is not
necessary as we have a path setup for writing with btrfs_search_slot()
having a 'cow' argument set to 1.

This just makes the code more verbose, confusing and add a little extra
overhead and well as increase the module's text size, so remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/xattr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index bc18710d1dcf..3e0edbcf73e1 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -204,7 +204,6 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 		btrfs_set_dir_data_len(leaf, di, size);
 		data_ptr = ((unsigned long)(di + 1)) + name_len;
 		write_extent_buffer(leaf, value, data_ptr, size);
-		btrfs_mark_buffer_dirty(trans, leaf);
 	} else {
 		/*
 		 * Insert, and we had space for the xattr, so path->slots[0] is
-- 
2.45.2


