Return-Path: <linux-btrfs+bounces-8878-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 425B099B3D9
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 13:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C40FFB23C50
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 11:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8771CCB42;
	Sat, 12 Oct 2024 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOmzOEmp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46101CBEB8;
	Sat, 12 Oct 2024 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732482; cv=none; b=oD0gkj1w490gUbQzYihXCYrhPHscjfK0qVpYLkcEVNNv3yNRWa0nd5ZShewXMJmV7aZggxiHNT1301Immzip5DCXYzQaqLvdtln5KPaq+FthNidoN+H2JEYtUzDva3Lvwf+BVS09eP5ueISpMNaWmBmctF4wYT3ci+p9jQKJecM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732482; c=relaxed/simple;
	bh=YDVSGA/jFK4M17MfyjQFVNfdTrCHk87aLypRffFNPO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hvhd32ISGK+12ynkd6B1ASL4SbFCelxWhz/l+mRj6amh0bETXluP9GgAuzi3fKNBz9I4GBAF26UXysGPzvQAD4xG8mobL3g7gXcOMmuSpt6+4kEt0W95KYd5JeCD+Lg61D1jyt8VPrYGFj/BPBORUI3v5/CLLH9Rhgyz+nObjXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOmzOEmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B31CC4CEC6;
	Sat, 12 Oct 2024 11:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732482;
	bh=YDVSGA/jFK4M17MfyjQFVNfdTrCHk87aLypRffFNPO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tOmzOEmp3jBevQUFYtJJkqoFzTX3IRNm4FMPUWhrRRMLuaHGeZDOsG7CzOLlO8aFH
	 7Gftn/znxcx1fRm9PlMzJus1dueKtRrc/cz+rFMsp13DNN8VduTexMbkygT/xXWHw0
	 C/0MIbV+ZzmjdZw6L1BnID8hRWAB368C8xRy4bwUEdpBstMjvEJYBBicSWY9YITRb+
	 hh6RijuOn74TqMzavQICZQLf3s4zA+pXlYRRgiYYbJjYF3ozL/B/UDpO7lH6f0Stbm
	 et8HegJWngKrmq+/UC1lIILdT/CprYBW/Wkyhvos60FSxtz7mOyhQ6SZuMVpUAEeTK
	 tLqDA5zIL438A==
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
Date: Sat, 12 Oct 2024 07:26:52 -0400
Message-ID: <20241012112715.1763241-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112715.1763241-1-sashal@kernel.org>
References: <20241012112715.1763241-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
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


