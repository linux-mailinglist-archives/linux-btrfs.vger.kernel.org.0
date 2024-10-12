Return-Path: <linux-btrfs+bounces-8880-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B0499B418
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 13:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3993C1F20C74
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 11:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E0E1F8EF6;
	Sat, 12 Oct 2024 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnsrLyh9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43161F8934;
	Sat, 12 Oct 2024 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732554; cv=none; b=vGGoD4v6pp680ztSS5obvktFWW6k+vdFfZKfzkWHkveGtENAS+hH37ONrL6oJ99TwxACrEXgmfl4nKjhWKpM/W+XzUkFOjz8h9ouRzJoIFo82YjtUaH7r1mDz56RHkXj3Vrc8mKeX8tzR8MZVerZ0nEUzZJJLqZ9z5MobFoweKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732554; c=relaxed/simple;
	bh=U8FFllOx3wObE1ADbHZAv4NbTzismmwQxdpoYaVOVyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpzTPG8ol4JduJasC5vsbNitM0X9FKJDYgW7wqBt3SeIwwxUCjYBptHfd5oFox1CsZKRHlzzmLAU5RYcu4Jdu0GVD1zjF7nv6J8D38+lMvEFsGCXqz1vAueupaE5G3pphbq4A7LKOCbvpdPUTAO54R/67hwkP85jOXbJR8VBGe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnsrLyh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F515C4CEC7;
	Sat, 12 Oct 2024 11:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732554;
	bh=U8FFllOx3wObE1ADbHZAv4NbTzismmwQxdpoYaVOVyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DnsrLyh9OWUI9j5zPQppKr31N1jYW3veIZ+RYXyfCmZQQzwYrnMqwP22iRtt0k2Rf
	 GxvYwsV551aQCndUOznLGcKt9KQIjhc0vdpxY006iStcEFNy+B9HUTJnYR/CJg00bd
	 LqV4hdcvBvTAB+OZTaBsHjucJXbuHyioBAgOzm+cExdAVljqh+Rap0NQTOUf7vnKvD
	 jfTlviCIPLQEW8KdHtVukbsVNsT/1o84sy56wtc/DwV2D9zDTCRkvlz5V78LMe0xR5
	 jzu0LK6J2w7HRiQr0nUYvK7/5ah67dVpp84wwEwY94cnjjXlkdTcx6KJ303exiW9aN
	 zNnf9LGD+4lXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 9/9] btrfs: update target inode's ctime on unlink
Date: Sat, 12 Oct 2024 07:28:47 -0400
Message-ID: <20241012112855.1764028-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112855.1764028-1-sashal@kernel.org>
References: <20241012112855.1764028-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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
index 07c6ab4ba0d43..ac68be3290ddd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4199,6 +4199,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 
 	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name_len * 2);
 	inode_inc_iversion(&inode->vfs_inode);
+	inode_set_ctime_current(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
 	inode->vfs_inode.i_ctime = dir->vfs_inode.i_mtime =
 		dir->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
-- 
2.43.0


