Return-Path: <linux-btrfs+bounces-6953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E678D945A31
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 10:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 584CFB22831
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 08:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F951CAB3;
	Fri,  2 Aug 2024 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv0zOfL0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695C1C3793
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2024 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588296; cv=none; b=iA7dMIZgh35kNqdEcRbe9Qs8f9oPR9TI1DDuK+CjCk+jdj7EqmrqZ5/EZgLGs9wWjK8sc+Q7XbEvZIiUPT2Df9VsqdgGdPY7qA1n8siW65Sh569isDcvzeOU/6a3jDS+nsaI8tOER2e++yZasTk6yC4HNxgSQsrj4Bf1WjMDHtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588296; c=relaxed/simple;
	bh=+qjh9PPJ0EkWyJY5tH+kPPcq84zE7D+qJ5cpKu53jss=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=E0MOHQ5VEBAZqKyxBlzkbQDvUBBdRwQ79WpYU8lNqQ3I5CHXmYMjA6LvY9lYbw6boC4PbAWymPDrHTB6FTY8t3nRO1PmwjMPZJ/Q4aG9pp4sc/GTLsabcrt9YUJyXKQRzHUP4eykFjr27UQmpwu5g+ydgElhE6Onl/esz+MD4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv0zOfL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC7AC32782
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2024 08:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722588296;
	bh=+qjh9PPJ0EkWyJY5tH+kPPcq84zE7D+qJ5cpKu53jss=;
	h=From:To:Subject:Date:From;
	b=Bv0zOfL0YutLzIBS5MZ2j4Efr4vJ65tuVbe5uxNqhJFvq6cduafo6QFx37hLtoQqc
	 KBWwwO/25YM9sPV6ekb7E0YXHY71Np6JJd8a9a/o5MqNm1URhHrMYhpnjsZVxQtQE5
	 S0mH75xHGg2RzhGgaUXxpa5MXqup/nEUw6bCeKdguXWF7+b2rZwGYZbK33fpk1LXCq
	 sXiCgzsmvDZmXFY29/JOb2wLOkSuA4CzzRKLyiTnQWTYxE1KifPjeWodSRRJcMLORx
	 UFp2QndPfMG4wpMDalYLoQWkEAsCnkjPO4UEnj45I8ypTp1Kt7z0YGfdBnLBftjst8
	 HlgJaAQe3yofg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix double inode unlock for direct IO sync writes
Date: Fri,  2 Aug 2024 09:44:52 +0100
Message-Id: <7aa71067c2946ea3a7165f26899324e0df7d772e.1722588255.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we do a direct IO sync write, at btrfs_sync_file(), and we need to skip
inode logging or we get an error starting a transaction or an error when
flushing delalloc, we end up unlocking the inode when we shouldn't under
the 'out_release_extents' label.

Fix that by checking if we have to skip inode locking/unlocking under
that label.

Reported-by: syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/000000000000dfd631061eaeb4bc@google.com/
Fixes: 939b656bc8ab ("btrfs: fix corruption after buffer fault in during direct IO append write")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d742c04931d6..76f4cc686af9 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1868,7 +1868,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 out_release_extents:
 	btrfs_release_log_ctx_extents(&ctx);
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		up_write(&inode->i_mmap_lock);
+	else
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	goto out;
 }
 
-- 
2.43.0


