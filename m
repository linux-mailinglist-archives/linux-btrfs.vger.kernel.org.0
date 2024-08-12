Return-Path: <linux-btrfs+bounces-7134-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED09694F196
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 17:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BA328157B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 15:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D1D184522;
	Mon, 12 Aug 2024 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Heskn4Iq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2568717C9FC;
	Mon, 12 Aug 2024 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476359; cv=none; b=SWK0pvExDHSCrewKnzQDk6pvhowYhxPJQKe+5mEj+tONWcSvzlOEjMssfEYCdQZSwTt72RaSLAZS7TG/Kv4wC1i02WT0nPWsqy01CWkn3tcLYVvDTn/YI7jIhJ+lZfP9ce/LesjuDqNRwZidt3UD8Y0ALmlzZDl7fervcSmo/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476359; c=relaxed/simple;
	bh=NmCf39JdeAxzWlINGyTyT0YTEVkYbzQv+t+jtZ22OCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLjod4kWA4rLNi8IbS07VU0MZAnHHw8GJCLI5JJ4T25u8YsDbiRNTxhoOvD1D3sXfo5HGfgXlLhJdrwu5aw8wWyjEh88YBLTJpNKu2YVQsR1CJOGF0GH4qTEYDAzMByOhhpEntJpiLpDqcNo4uNJGIFDBuGDLPncQzfVToV7cTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Heskn4Iq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A97EC32782;
	Mon, 12 Aug 2024 15:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476358;
	bh=NmCf39JdeAxzWlINGyTyT0YTEVkYbzQv+t+jtZ22OCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Heskn4Iqi8vOyNirE+GW6Qtq9Rqa6ScXuxU2yTQrimxHUPVO0mCrmLAfMf3+kha+S
	 5LHwzCONssor1SEYIupv0oSNIu57TTmQksF4dahzxGfg51NUiyOCNp1IFH7DOJAkQ0
	 gJ/YnsI1ycfnHmwj1NdCV07WeVK2UjZv9YL5bXaj9mY95v5UaYIODb6tv1qOT7RUu8
	 +Gw/XHfspFADCYkpCWjLbLcUVroE/L91EJwg+Fv4ZxMljrfXVm+3e7FRowCekReH7k
	 vYtw403tloqBsU3PYPNWmXsbqai8lZT/2ehujqPCz6gh2SB/+PqqUifN3O1XYafe83
	 CwP0TGA9wDbmg==
From: fdmanana@kernel.org
To: stable@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Filipe Manana <fdmanana@suse.com>,
	syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH for 6.10 stable] btrfs: fix double inode unlock for direct IO sync writes
Date: Mon, 12 Aug 2024 16:25:53 +0100
Message-ID: <8ffd293acee0e4c823a4ed1e4e5672981d614d72.1723043969.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723043969.git.fdmanana@suse.com>
References: <cover.1723043969.git.fdmanana@suse.com>
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
index 35ce1c810bd3..ca434f0cd27f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2080,7 +2080,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
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


