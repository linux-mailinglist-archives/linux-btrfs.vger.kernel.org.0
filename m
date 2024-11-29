Return-Path: <linux-btrfs+bounces-9969-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D71C49DE7DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 14:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6322AB24208
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 13:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EE719F116;
	Fri, 29 Nov 2024 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOt/aOMt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A5219E980
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887702; cv=none; b=Tu/1/xxbDeS8dpnttREDEnKCcqzirfpCNXSmu/cI+iYjwuRleexQf3pwKqc4Cf1hnUQ+9K+rw8zHkntk92dAOsLpoKja6fs8byHE4NXh/f89sSz4ARWvSUNgB6pAAsSp5pNwbyk0KKNDFYwDQ79vkCqdMjMnWlOuLCzGTps13nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887702; c=relaxed/simple;
	bh=zaokGr5+5AwiPfFGlhUc5ihUAjIgs/BswBKLNJDi0qU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZgHt2fNln+JeaTU721sTi+Fk5i6EGqfpig4YeFaihfOtWicWZaBAwak/1bN/0seKyzkWPs4KZsUNuAuBfPXalDAjCXNMy2kLOP/M4v1qIuLhgx45cNpFvvmja0AGe23GGXuwjlkMqWZm68RflodtK70OlNLj/kkENYZPoXIalug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOt/aOMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42984C4CECF
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732887701;
	bh=zaokGr5+5AwiPfFGlhUc5ihUAjIgs/BswBKLNJDi0qU=;
	h=From:To:Subject:Date:From;
	b=OOt/aOMtBew9k02XfFrCm/IG7oGy+KGus/ggX9naAANgsSube2/FxdGf5X3FxXK6w
	 qF9gVET99sSP51I2KPpH2FEekf+I3KrKASB5dECt7YxgNpWq6xC9hmozG2jcikBSgy
	 JFLqj9OkReUXayZ/kZBB/HQgZBjUTKAJWedTvmx3uiwWvUZYGnbsrmK42YmwU678Nd
	 lHPvEenMo0f71s0pz4anPD1r7chAzQY47Tgq60qQBE0hKnGcXuYdjpH1cnzj8Zxn3G
	 /ojil4gsTcQ+mRZ3zPlEaZPw6mtsRfnPj4EKjmmFMX6FKgcf52Czb03MJ3kVKq6SjF
	 x/mj5XG7Qu7Xw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix missing snapshot drew unlock when root is dead during swap activation
Date: Fri, 29 Nov 2024 13:41:37 +0000
Message-Id: <76ef43063706a4ef1a4313ba03ca6225e7d7dbac.1732887615.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When activating a swap file we acquire the root's snapshot drew lock and
then check if the root is dead, failing and returning with -EPERM if it's
dead but without unlocking the root's snapshot lock. Fix this by adding
the missing unlock.

Fixes: 60021bd754c6 ("btrfs: prevent subvol with swapfile from being deleted")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9267861f8ab0..6baa0269a85b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9876,6 +9876,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (btrfs_root_dead(root)) {
 		spin_unlock(&root->root_item_lock);
 
+		btrfs_drew_write_unlock(&root->snapshot_lock);
 		btrfs_exclop_finish(fs_info);
 		btrfs_warn(fs_info,
 		"cannot activate swapfile because subvolume %llu is being deleted",
-- 
2.45.2


