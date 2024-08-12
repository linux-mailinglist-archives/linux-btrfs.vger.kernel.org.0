Return-Path: <linux-btrfs+bounces-7135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6141294F199
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 17:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1561B223CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 15:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AA5183CDD;
	Mon, 12 Aug 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLZxZNSi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25595130AC8;
	Mon, 12 Aug 2024 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476382; cv=none; b=IKgiXLc9LaNxst0w8VJT/cghhDQ6bv/f3cTILeH93mq5B5ZIHlC2ELIP00J5v8CK28qbipq92gFoqjFzYbe5MYqlb5WbiRePfOdXwRu71Q9UZ39AdiY2pr2pdt32Lps7g4GCXJU5KpQ1ZQ9T8zI7wC7wpFEpk/Al0GYdkNZttUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476382; c=relaxed/simple;
	bh=JxpmLD0PgjESFpo/tnECS6dAsiEutBeyOhOcjSJqhx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Enjj3VO53julzTWVI20eeUJll4eSAX/OH1XusRN5Ghv5wnkAvtXrAGs9WoL/5Oj7wxKJO58DEgaYwOB7L/nhOHMtJCP6NS8l8jpd40KLHewMA+vhw7jBnKrJjlTMQmA0WaqIIanDxMt0HqErmt4POYKSAEC3LPQaiTdqYRadzcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLZxZNSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185FEC32782;
	Mon, 12 Aug 2024 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476381;
	bh=JxpmLD0PgjESFpo/tnECS6dAsiEutBeyOhOcjSJqhx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLZxZNSiKoreJORyZb80YRrGVMMwt+GTA/km0ujJcK5KzgySUEYxh9z40w8CIFeH/
	 Jze4+W87l0WTilYlp3RZT1W4DE8kX0ybtNzJ15in0Cg5efhvwN1nBjb1UxPAZcgS1O
	 mYPydOpAY2ZMJs3601M9yqWOGLB8hKs/V/+z8PQYgrFPu2WpVuKB4JIncup9h3b1OV
	 BJM6RvA5hBz5gYwPh9c6lp72n/H2+cGNLb1x/15YenyPihDj+9HDgr14T/KwZYHHLO
	 omhFiA00HNG6NZe1F/J9bXOsUj2p93D7WrSZmH96OXWosoNOLeMcgp1tnNN0/8aDLU
	 cDlZNDgS7nz9w==
From: fdmanana@kernel.org
To: stable@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Filipe Manana <fdmanana@suse.com>,
	syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH for 6.6 stable] btrfs: fix double inode unlock for direct IO sync writes
Date: Mon, 12 Aug 2024 16:26:07 +0100
Message-ID: <d1a461ee8d8dc3064bc181304c70958990a1bdc8.1723044389.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723044389.git.fdmanana@suse.com>
References: <cover.1723044389.git.fdmanana@suse.com>
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
index a47a7bbf9b7e..952cf145c629 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2038,7 +2038,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 out_release_extents:
 	btrfs_release_log_ctx_extents(&ctx);
-	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		up_write(&BTRFS_I(inode)->i_mmap_lock);
+	else
+		btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 	goto out;
 }
 
-- 
2.43.0


