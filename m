Return-Path: <linux-btrfs+bounces-19657-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5415FCB5B86
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 12:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D884B300BECC
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 11:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF9630DD3B;
	Thu, 11 Dec 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRwHcsYn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A3430DD34
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765454260; cv=none; b=brqS1wrguTCKu8p1FaEagZbMS/rr0QQdmlf4Q3YS/jy+0Qelrzlmjn6BfcrmilxOgUnNQvyGhzxD5E8pPFysSu1bQiNGOvJxWM3p5rEKXka1Oy5u8K4LmxlIXj5C+AyyMQxwYszdOgIqZW2klfOsEaE29dXL2LnWVMOUCneRosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765454260; c=relaxed/simple;
	bh=X6RbbIgdVJIy59gyfMK8prupSGJOtqV7tgjYKzE+3Fc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=q3vENEROMsfewItEdlwlQqQtYsWRNxqC7GbIAs3EUEwWn5mbqvgsHj5kuoePlwVGcdypUPhG6/TAL2uIxQ1Fl0qXFC8cMYc3apSU+/9bBRM1WHcDPOEYqTrOoTSCKgKDFEaUmTbRksWTFKk7hul+D1nXrovyvvja/aulKJGilHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRwHcsYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31490C4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765454259;
	bh=X6RbbIgdVJIy59gyfMK8prupSGJOtqV7tgjYKzE+3Fc=;
	h=From:To:Subject:Date:From;
	b=JRwHcsYnHHGu7mH3+mHg2U9UNDFtMMY3CljmJfY+z/dZfMbqs3qFGB6/P19uyWQkj
	 rthIlOLzkLu6+yfyDg1z+g/w//SZY75ZiOWLBtCr7gSnk0wu7KEFelqcV3FHhRmAc4
	 Cjx+E3HqcyLGCazV9xm8Gyki1tM3XwA+vL4dm4kw2gSVSkJG2MPpJ2Wg8k9CuBLhHN
	 sMKOz/FWQZe8KugmR7ZEKBtnlU/0UvpFhWbfCh5XsAvt8oKGgFPs5eiZA8JPk6/QVP
	 MiRB5AbvS6zQLskyuIE9ZXbjg+pKDpqfzz+Xrr/1H0V1UP4vKH9SBK1D5QMMsG1CGl
	 O+PxHpJjFeaMg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix changeset leak on mmap write after failure to reserve metadata
Date: Thu, 11 Dec 2025 11:57:35 +0000
Message-ID: <ab2ab25d0598c04467a62e9e88c9131cec159c48.1765454225.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If the call to btrfs_delalloc_reserve_metadata() fails we jump to the
'out_noreserve' label and there we never free the extent_changeset
allocated by the previous call to btrfs_check_data_free_space() (if
qgroups are enabled). Fix this by calling extent_changeset_free() under
the 'out_noreserve' label.

Fixes: 6599716de2d6 ("btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents")
Reported-by: syzbot+2f8aa76e6acc9fce6638@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/693a635a.a70a0220.33cd7b.0029.GAE@google.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1e0ff3d7210d..e42fd2beb1e3 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2019,13 +2019,14 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	else
 		btrfs_delalloc_release_space(inode, data_reserved, page_start,
 					     reserved_space, true);
-	extent_changeset_free(data_reserved);
 out_noreserve:
 	if (only_release_metadata)
 		btrfs_check_nocow_unlock(inode);
 
 	sb_end_pagefault(inode->vfs_inode.i_sb);
 
+	extent_changeset_free(data_reserved);
+
 	if (ret < 0)
 		return vmf_error(ret);
 
-- 
2.47.2


