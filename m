Return-Path: <linux-btrfs+bounces-11488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AD0A37480
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2025 14:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B99188EAF4
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2025 13:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1FE194A6C;
	Sun, 16 Feb 2025 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKZtoBQj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BAB1946A2
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Feb 2025 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739711772; cv=none; b=Mp2+fJnVje6XOlVjRlGQT/H7LbmEt9J6djvfcaNzy6VfqyCSIsOWGM46twKsHS97VGlpReFCXZqQnZMPxEbEAckETq0xfUOVgPYbHysrjNxWxRILohSa9bQVsq3NoKlfQd8b+0oUKpTlh2G/V4lu6l7KTy1KEqE4IvRAIuZ2Aa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739711772; c=relaxed/simple;
	bh=bPi5bof5xfWgdYORmPDHfmPA53/kG9moNG4Xy1Qjgvs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XSMKkmMamvryijg8n1xxHHP8RV7iY051wLgeqtIuF/t56ytXyWGgOM2Fg/1Gi9AanDWGkETXEPgOKdK0B70maV02/oliJM5NnZ2tXJrtlUXlYi2bRsVfNJwKX2jHf/zh8KNzo4tP63mCsrk5j6Rs56xWER277xIef4E0MHvO4qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKZtoBQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBE5C4CEE8
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Feb 2025 13:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739711772;
	bh=bPi5bof5xfWgdYORmPDHfmPA53/kG9moNG4Xy1Qjgvs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TKZtoBQjpVjpwQQ5G3wVfmP3g11r6vTcFh/rq2Fx0m7lDqIu/xqR8EsbsBSPCVOuY
	 jKk5Dfut7a6WNHR1CDbYApGSgruwyFot0vPO6YV4+3Xaqc4uDGtwx90uJ0lgHFnSUA
	 QqOyrqFV6lf8bOyeVuKjaY7TJAx0AmzWMfiSCU8Bm7OquTrZTAAOk0Mc0yGXfGfT7v
	 15BAhb9wGlbbkPkDzI4onpyZNO9HxQBR3oFNVxSSEBKejlwxfeGNviSWSm+RWLxOEF
	 eQy6+Z6BEE3CSQmmlI7HSJKa5nH74bezmLkNo9WzFwwH0k0aXbHUWntfF0mDMz9gl7
	 lRuAdEfIKP1uw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: do regular iput instead of delayed iput during extent map shrinking
Date: Sun, 16 Feb 2025 13:16:05 +0000
Message-Id: <e073434959bb9cd15b9a84e9fe345f3114b63159.1739710434.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739710434.git.fdmanana@suse.com>
References: <cover.1739710434.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The extent map shrinker now runs in the system unbound workqueue and no
longer in kswapd context so it can directly do an iput() on inodes even
if that blocks or needs to acquire any lock (we aren't holding any locks
when requesting the delayed iput from the shrinker). So we don't need to
add a delayed iput, wake up the cleaner and delegate the iput() to the
cleaner, which also adds extra contention on the spinlock that protects
the delayed iputs list.

Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
Tested-by: Ivan Shapovalov <intelfx@intelfx.name>
Link: https://lore.kernel.org/linux-btrfs/0414d690ac5680d0d77dfc930606cdc36e42e12f.camel@intelfx.name/
CC: stable@vger.kernel.org # 6.12+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 820aef514238..3b05a2d27704 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1255,7 +1255,7 @@ static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx
 
 		min_ino = btrfs_ino(inode) + 1;
 		fs_info->em_shrinker_last_ino = btrfs_ino(inode);
-		btrfs_add_delayed_iput(inode);
+		iput(&inode->vfs_inode);
 
 		if (ctx->scanned >= ctx->nr_to_scan || btrfs_fs_closing(fs_info))
 			break;
-- 
2.45.2


