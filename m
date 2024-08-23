Return-Path: <linux-btrfs+bounces-7436-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FBF95CF75
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 16:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FCD1C20C37
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA5E1A7042;
	Fri, 23 Aug 2024 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGfNNfXw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0E18F2FB;
	Fri, 23 Aug 2024 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421929; cv=none; b=YOBSRjAu9qqfrKkty4jmpH7s/+wze5x4y28oW1R7/6wzHpFU4yBCT8wk7qdAAgPmw9Ux+F9vKXcoZtG2EFtdT8VjP0kaMJVV9tlYI4WwwseUw+yZpiOL4Qbxr5BtUK57zF4cSQUXDItC236NLivmi4nj2i6d1UT8z86pU8DaIMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421929; c=relaxed/simple;
	bh=U8FFllOx3wObE1ADbHZAv4NbTzismmwQxdpoYaVOVyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1sfPJJfFYOYmDvenTDWc1fN+6+KDSKlX2JPR0P5LYCgD2TiqVYc7c07jkw8Vv/dNUekrRwH0p8P5ziMJcMFli5imArRtnhViw8LInQjnJuWouy4N5jgMZKgCLDu5dFnDtpG5SIbwWL1AmdS9sk174HJiFft0+ZBAiASfmUvIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGfNNfXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C1AC4AF09;
	Fri, 23 Aug 2024 14:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421928;
	bh=U8FFllOx3wObE1ADbHZAv4NbTzismmwQxdpoYaVOVyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dGfNNfXwgDHRgRuGdoydmYMYHzFRNqDAzBZl/0jCtqgu5OEXEr4Xqdd3BCqz4FBM7
	 1xNFUkT4E8W4QtDkjzyE3pm6oK/7FEavfHKEBsxv6ZfPdm45nMhcJFOh1K+XH7LxUr
	 RRqVW7elsWnl0RmTgZlh/yAvtVQ7lQcH4qs2lC/1+n5bMD7NA9lGp98DbV6t22m83w
	 7KLqvxbPbZZXMlj6QfQ8/xexcG7LfUSwRgp7HOeCFOGCaDzMv2h9y0oH0a9psku8ql
	 A42TXOBgPzqIq+vF4JygTmz6zuppm4Q1o+4nmtmMlTwyY3+li/HKU9Bq6XiULiiqH7
	 GgXvA+lmcmUow==
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
Date: Fri, 23 Aug 2024 10:04:56 -0400
Message-ID: <20240823140507.1975524-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140507.1975524-1-sashal@kernel.org>
References: <20240823140507.1975524-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.165
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


