Return-Path: <linux-btrfs+bounces-7435-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FEA95CF58
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 16:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12531F2AA94
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD641A0AFA;
	Fri, 23 Aug 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewwy/Il4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E01A08BC;
	Fri, 23 Aug 2024 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421895; cv=none; b=cYgyWr3prU/m3eD+A+m9+/gC5tXiTPsL0vg6Vf6PfJFoptLj+Lnly71fA6Hkj1zmITca+XQ/ncKOe8Ck9VB0EB1t91M+KWFcCJe6E7pd8Py4vwg39CJE9WCqvatG8T0GBY/UoKWYHSjXtcGqGyxBfzL9X319X/f7YaYJHjKZf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421895; c=relaxed/simple;
	bh=rJyn8Cz8b9vSLUOwne/QJB5z88Ohf/S6i7HLJ7d7Eyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3EF2P4ydOdC2EjPYZNfCFEtHzOJFdGLJAxw+T5XRiTQ0rQI2X44avWd1mzUHvu1Cwge/FiDHgWNIihCaoUKvStpq/aPpEK6IqnmSYTUOw+QKQyTnHYc4yuE3EQvS+aA/ChoPJCnohuilvYnFyrsbQ7X3zl42wNSaa2ayLF9ZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewwy/Il4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7928DC4AF14;
	Fri, 23 Aug 2024 14:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421895;
	bh=rJyn8Cz8b9vSLUOwne/QJB5z88Ohf/S6i7HLJ7d7Eyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ewwy/Il4AQyl/K6NraxTYSOA2O1boY8xx13aTw90O7sriE3wRD0aRoKnYJUiNPN2H
	 v5VC1wxxf03pvml2ozib6yn7aUFS9Juv7k2Un29d/9SX2YJgFsz2exb+nY5ksVyh7y
	 ADS804uApTnV9OSoulBI27ycF71xMdb6Nlq7dH7/9v0ktvd1ciDbMmP7MhAYzTzJzP
	 jElEfAy5/jpUysby1LU+AgeSciMmliXNaBkZmbeFTiX2IW6c3m8vJmAKZnwWplVZLf
	 +J+gP1avp5h/EwPQBOkZEdZNcCttEVu2VSWEbqrT7v+Y8wcvHdaalllACdBtuJxAbd
	 etxGcjJMkpNSA==
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
Date: Fri, 23 Aug 2024 10:04:02 -0400
Message-ID: <20240823140425.1975208-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140425.1975208-1-sashal@kernel.org>
References: <20240823140425.1975208-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.106
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


