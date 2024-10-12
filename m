Return-Path: <linux-btrfs+bounces-8881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB8A99B437
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 13:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E8328D813
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13571FEFB6;
	Sat, 12 Oct 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3rhUbMl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DB11FCC66;
	Sat, 12 Oct 2024 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732582; cv=none; b=XMcyYL2Yf7UaHruIsgZrh/r+2iIqtfRTWHR7NMFHe2ur0+rcU14TUiRwh/4zNjdFejXkfmX5JaLS4jPnHBW+E/MtebD36asc0CQ4DMuc5FNlYoahz7JSQMfdb49CFpydJKOVcurWA2H4bFsIdbWezVZGZJ3l/Gi3DxybG5xJGRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732582; c=relaxed/simple;
	bh=nuDHZL0R8SpjRBAt4YFJOLzjwVCJe0Myzqm1d8Rvkus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AE40WP40Fn1Oz/Crpw3VMlofXp/o36OsNvzu/7vcCfzAaYdPLVzFcLERC/vANBuN124QFZm+vdNZurbpUBFwjlTiT5McSZiGMslYBqjB5MPg2F5xG2GV89ZFXmlVSb6sXDKpQASgiF5KMm4CJLq0WZm/aDKFKWefh4fNQjAidUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3rhUbMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F77FC4CEC6;
	Sat, 12 Oct 2024 11:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732582;
	bh=nuDHZL0R8SpjRBAt4YFJOLzjwVCJe0Myzqm1d8Rvkus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3rhUbMlO4PYEJ+FrS83CZcVBwCUpLqK3UH+aX/k+ZvvMBsaKI5lUbsqh+NJ76oiH
	 mPRHZflWtBlz+OGN2NJreA7PFAG0pl3fF/EMWp57WX+b1x4ymbnspxyVdb8LlM2wWi
	 oT0vW1PfST0znOo6pXM3EnGR0akRu/SOaM5t/thMJn961l3XowaGIvqi+E34D1G0pi
	 UwiATRrLCbNp+4vpcIlD8GxCo8NixHflexI8C8bYIN1JjOZP72iursUVcTUsk5SQsl
	 SpuNdBq8CwRHgxQV3gMBfvXiILp30jeJapdK9e8Rf+LXPiziC+gvr0EfxnjqcVr5Kb
	 GuLxTIxVRSWIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 9/9] btrfs: update target inode's ctime on unlink
Date: Sat, 12 Oct 2024 07:29:14 -0400
Message-ID: <20241012112922.1764240-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112922.1764240-1-sashal@kernel.org>
References: <20241012112922.1764240-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index 1f99d7dced17a..4a6c85df7b3ce 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3704,6 +3704,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 
 	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name_len * 2);
 	inode_inc_iversion(&inode->vfs_inode);
+	inode_set_ctime_current(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
 	inode->vfs_inode.i_ctime = dir->vfs_inode.i_mtime =
 		dir->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
-- 
2.43.0


