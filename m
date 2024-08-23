Return-Path: <linux-btrfs+bounces-7437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A30895CFC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 16:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAAC4B2D4D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1831AC44C;
	Fri, 23 Aug 2024 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qH9YV/vw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BEC1917DB;
	Fri, 23 Aug 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421962; cv=none; b=ewsBY2mWGDBNNg0M6xEkGS29r03LLBAR4NiwVZMwRU27dUfEeSWG8bWB+mmH7S89M0WD6+fokzie8NGEwNemDArvJduiBi85PEX0Yni07eb6McWmNIQv9j5EqUqmlcmzK3ZpgP+Po3sDgudUrDOZ5CxMA1iSD7gH6pCxI7DeTOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421962; c=relaxed/simple;
	bh=nuDHZL0R8SpjRBAt4YFJOLzjwVCJe0Myzqm1d8Rvkus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saIxiqN0CPxufGR6jCaeQOOa0/KMy5njrWQq58D203CWSsDjo90VlkIAlCIMqriJEoaL/qYx9VAlwvLLebx3WTDJb20MILZvzJsQ1VbkPYrrsvRbbQ8tTT77DOaoaCCgOovY5FBqtdf56XHH7uNKyDqwIVERohsbTpazSqpWTXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qH9YV/vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C21C32786;
	Fri, 23 Aug 2024 14:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421962;
	bh=nuDHZL0R8SpjRBAt4YFJOLzjwVCJe0Myzqm1d8Rvkus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qH9YV/vwTiK4I3B2+WyyeL3O7TjPnAIzYs53ySi05QQjcvk2pB/QdzW3M5+rqP3Sm
	 y+br6SdfRSeAsgdOj/QzxFea5Axa3kpBdyGn2ZgrsHDRcSd+3PyVEXL2E/TUdc4q4X
	 3OHR7MuHB2qrtLGlC/PWfQoEyBL/i8B0Ud6Jqvjnk0PKLym7+9AyNTp1KNRk2K+DHw
	 eRx7Ta64JRtKgutNwLQVVrCIAiajsfynztyA2kh2Gr3zfh8CugcNKgzSav0aWKRoRd
	 /UOqUJvW/Weyx2b9RQBK1HiF4LWS4qqIkSIN8JdCSOj7G4Y3RpM7+pkExVI2xOnc92
	 chdd4cGyUBU4Q==
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
Date: Fri, 23 Aug 2024 10:05:29 -0400
Message-ID: <20240823140541.1975737-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140541.1975737-1-sashal@kernel.org>
References: <20240823140541.1975737-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.224
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


