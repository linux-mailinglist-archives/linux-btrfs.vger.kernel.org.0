Return-Path: <linux-btrfs+bounces-8879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BE399B3FD
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 13:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1388F1C217CE
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 11:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2BF1EB9E4;
	Sat, 12 Oct 2024 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLbdgYYA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3FB1E906F;
	Sat, 12 Oct 2024 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732526; cv=none; b=NTI/ZHjhKJdJ7azZGu4/ijVKttcxDb5rcYievNGLTTo6qNXdAcnO7TmYWHBCn7ESjza98cfjKa6EyEGV/zD7Sld42MTPslv6CzLu+DSAuYSe/aNtEmQKWbTKj5R4dsmMUkxhu3aJ2iy4PL1vGSMmZFJiA4AbuTlI+8mAICXWEA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732526; c=relaxed/simple;
	bh=rJyn8Cz8b9vSLUOwne/QJB5z88Ohf/S6i7HLJ7d7Eyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thxv9odGuDNnCYYO6YA1EXAUjK+bnx+bChQGNIN5qYrDJIWFUzMGdAIVk1lMaGHZJX8owN3RXKvqPFKtv+aloDJmeQknvzSDgj4d0+D4MDQXdVZvCGUqg50gUcfLv2KO46V7jfVaZuRRSl3qczU8SOQiaZdInRcPzY6eH0PS0BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLbdgYYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D712C4CECF;
	Sat, 12 Oct 2024 11:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732526;
	bh=rJyn8Cz8b9vSLUOwne/QJB5z88Ohf/S6i7HLJ7d7Eyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HLbdgYYA5WfYaO5goaRiZ8vdIsWkYx/l3Zt+sfdOGkqL1HO2X0eDDMdvNR1UPFDkB
	 vBIzVYXF7olRRnkwAoKVDNmUI+FSNuzm195SPBcgeXTNxAozynpNh5kAy1661VtbOz
	 R3OqJq/Jy4vObHrKeGy5nOp4msPbtOFrfxIvAE3DjjlAmZ3EEixWTabcnWGrg0DZS2
	 tp4ryuH/noCdM6iI1SUT2/gS6F3FhsAubyQAZtWRwCz3ZlxRgKSPMx9WCDWdTyp3TW
	 fyG/9szPNEuryTVmIFLhvQ2NrXpVY+7U2zcQD8LbmjXZZwTIu8kLyT5t/VlfkN4lYj
	 fW0qUVFQ+030Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 13/13] btrfs: update target inode's ctime on unlink
Date: Sat, 12 Oct 2024 07:28:02 -0400
Message-ID: <20241012112818.1763719-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112818.1763719-1-sashal@kernel.org>
References: <20241012112818.1763719-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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
index 10ded9c2be03b..817816626738e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4379,6 +4379,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 
 	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
 	inode_inc_iversion(&inode->vfs_inode);
+	inode_set_ctime_current(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
 	inode->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
 	dir->vfs_inode.i_mtime = inode->vfs_inode.i_ctime;
-- 
2.43.0


