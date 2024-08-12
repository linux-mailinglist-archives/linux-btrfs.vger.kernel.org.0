Return-Path: <linux-btrfs+bounces-7136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5EF94F19E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 17:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB33282FC4
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DC9183CDD;
	Mon, 12 Aug 2024 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="airMxTOu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3A130AC8;
	Mon, 12 Aug 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476439; cv=none; b=PkO/njeK7bjyhBb0UtLdAWs+pA13icjLAOvfRjZ6hjlaF8xi39EDPxT+X9aCaxwY2p3NEfFX94K7i7k9UTnujmFgnmvxjCloEMpWssceFY4vdAJTAJssTVnYPj8TzWrnp/pbG9hHVe8aer9Hu1vxt3sKJ+8vNkJPw/u3EfK9fLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476439; c=relaxed/simple;
	bh=GWbnxO+i71W+PBFSstC6MoZQiRkr5WpJS4TgOyZYlxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Am4wa2Tzb0DQsHWf+4yZ8/5xKxblFf+gujn3D4jTWOaJ3ZuB+0deIReygrEY3n/WwHIY7HDXk/RdHKYjUJSs3Z+6aWzRWpbEpZUBKl9ALkmKgcef0WKkof+iu2Qjf8SPm6QoTST4tQfqqqqGs6Arq67I5+zTrRU1FjIz1uMoDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=airMxTOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C3DC32782;
	Mon, 12 Aug 2024 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476438;
	bh=GWbnxO+i71W+PBFSstC6MoZQiRkr5WpJS4TgOyZYlxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=airMxTOufTEGLXiFcDDfy4tmPn/dZ4tAe/+ThSXz9x7bVScdT4JB0ttH3JCzXZHew
	 R3K+94LMTUKpsV8WELD/YAQAdLH+LpZM8CyN0+g6Ukz1oU1yjMconGUa00UYWW6ILD
	 48JM8BU9BX89nFRxRxD/Znbnen7HZkb3I5xxvmmIsOaHFmnxmo+wkAO+MAqAciUelK
	 zcorMCyTx5eKu73hM+aEK6ZoPKRGzt0Iuew1SienazEXP2ttSUrj2wxYmTFoppv/qr
	 6ImyObWQITwu7YukYojtddbkVckqgW0jSs1SKrmrbxmpYg38TRFUWFSexVvJwk8eik
	 JRlIfsmFOsgpg==
From: fdmanana@kernel.org
To: stable@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Filipe Manana <fdmanana@suse.com>,
	syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH for 6.1 stable] btrfs: fix double inode unlock for direct IO sync writes
Date: Mon, 12 Aug 2024 16:27:13 +0100
Message-ID: <c04a7db7f8824b9216179b1db478f0f0bafe0d91.1723045219.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723045219.git.fdmanana@suse.com>
References: <cover.1723045219.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

commit e0391e92f9ab4fb3dbdeb139c967dcfa7ac4b115 upstream.

If we do a direct IO sync write, at btrfs_sync_file(), and we need to skip
inode logging or we get an error starting a transaction or an error when
flushing delalloc, we end up unlocking the inode when we shouldn't under
the 'out_release_extents' label, and then unlock it again at
btrfs_direct_write().

Fix that by checking if we have to skip inode unlocking under that label.

Reported-by: syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/000000000000dfd631061eaeb4bc@google.com/
Fixes: 939b656bc8ab ("btrfs: fix corruption after buffer fault in during direct IO append write")
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7c3ae295fdb5..e23d178f9778 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2037,7 +2037,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 out_release_extents:
 	btrfs_release_log_ctx_extents(&ctx);
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		up_write(&BTRFS_I(inode)->i_mmap_lock);
+	else
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	goto out;
 }
 
-- 
2.43.0


