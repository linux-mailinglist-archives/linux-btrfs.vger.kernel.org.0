Return-Path: <linux-btrfs+bounces-7434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5428595CF2C
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 16:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7935B1C239EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE8F19ADBB;
	Fri, 23 Aug 2024 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMAB5GdB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910C18BBA8;
	Fri, 23 Aug 2024 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421842; cv=none; b=mBtJ73DO3pjEtbEYIcnQS0esjy2QtBKpfxoMt0lKtJ76sJijF9dnkFD86L+Xnz0q97lEbOhItitKvk5nux47FhYeczuXzMhADbDMsSf+TIw2+90AAt4XDLbkt9uXFF4mQLWMc4WzuNNSD3b5PmhwukHk/fTF7z/yptnWIIHS7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421842; c=relaxed/simple;
	bh=YDVSGA/jFK4M17MfyjQFVNfdTrCHk87aLypRffFNPO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPH6tAatabGqj4vmFIe/DfyaBloxZjaGJokagylZGvhau9yPsFRDHF5K0TSoP4ixeby4M8Titbgv81enwnIMndhFZLe6SZ7FtoCnxi3v+oPVJwiyZ2RQ0APeGCkIbp4fEsZDXbL30X0IMUQD8aMKl+mHATvpbbvTUlsKjYfZHsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMAB5GdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE50CC4AF09;
	Fri, 23 Aug 2024 14:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421841;
	bh=YDVSGA/jFK4M17MfyjQFVNfdTrCHk87aLypRffFNPO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pMAB5GdBLsVixSM3TCk5bc8v5YZw0DyGkfi1NZntCvH8XwOzyyWufT2+exMfuYYsw
	 RdvLf+t59ALHRLi/paiGxdBwOdkJExGXtXfOyVmLlXl66gs1fAv5D4FO24nw6kIvcT
	 tS9oBzJdCRjQ/298BfKd1LcK4leQIyWSU423XlUdQn9RShtHZGHyn24dgt8oJVTRu3
	 8QdRNHEEnDO0EoQce6rxI0AmVM/hysX/haWViHQf4sgUyvoxovBbbfdsgxA+NRtHTH
	 JYoRxkMgZNox0czA4pZl+GhMoIigh1n8OMjVKUiMkVlzv+Z1uAFGeIuUAqN69o2tY1
	 W0D2hCqduTa/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 20/20] btrfs: update target inode's ctime on unlink
Date: Fri, 23 Aug 2024 10:02:34 -0400
Message-ID: <20240823140309.1974696-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140309.1974696-1-sashal@kernel.org>
References: <20240823140309.1974696-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.47
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 3bc2ac2f8f0b78a13140fc72022771efe0c9b778 ]

Unlink changes the link count on the target inode. POSIX mandates that
the ctime must also change when this occurs.

According to https://pubs.opengroup.org/onlinepubs/9699919799/functions/unlink.html:

"Upon successful completion, unlink() shall mark for update the last data
 modification and last file status change timestamps of the parent
 directory. Also, if the file's link count is not 0, the last file status
 change timestamp of the file shall be marked for update."

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: David Sterba <dsterba@suse.com>
[ add link to the opengroup docs ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5ddee801a8303..173b16ae510b0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4145,6 +4145,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 
 	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
 	inode_inc_iversion(&inode->vfs_inode);
+	inode_set_ctime_current(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
 	inode_set_ctime_current(&inode->vfs_inode);
 	dir->vfs_inode.i_mtime = inode_set_ctime_current(&dir->vfs_inode);
-- 
2.43.0


