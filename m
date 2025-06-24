Return-Path: <linux-btrfs+bounces-14923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD101AE69B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 16:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705C03B7938
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 14:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C922E11AF;
	Tue, 24 Jun 2025 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5VyIx/r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C812E11A4
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776154; cv=none; b=kduKfZwmBnl8wwR9XF8nVFn4hy4IzRS+7vd0lydCIyLas5kVHer/bYitTDYiLTz74fg/Zlg6utpe9Wacv4XDdTaDJy3EUjcLhxvs11aV+Z2vZNW0j7aySaua0jS3xvDoM6+u3A6Bl+hDuQaOTqIFzTRWxxCHLQMEYy5FuX/9HeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776154; c=relaxed/simple;
	bh=D3d+TxeXgbZhX/mjabETQEBmTYJ8JL+vNotCO9IaVRo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQcPAMk8x4WCFqPYiFsjM/NJZH05wyCBnSnxiqjelQPO5ZI39X1ldSBdHyhUF1Tz8lfmBUxSsN/rroUOdHyQ2FvyP7EwQNOw0H0VQ/IO14nF/2v+E3YUgm0j9sdfsYKdZP4Cy7rv4ZEfLSlTwBEKXzi0lKRa9/O1IxVpSdAkVZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5VyIx/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D415C4CEF1
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750776153;
	bh=D3d+TxeXgbZhX/mjabETQEBmTYJ8JL+vNotCO9IaVRo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=K5VyIx/rINj4KIjOhOEQy0uVlSEkzyfK0ookaadN0YOr0EoL4ef8KcvGFoFsSN5qC
	 qbNnQV33SWdgNrMw5zgzGZTk2kADyJoxAAOhgp/QBSjxgh/RGGF1lQM4bvW4SrZoeT
	 bNl0XINW11HcZ6vBOWOBeAOYtV0ee6O2ttEnzGDmjh5vYo0M3lCstLPvk9ED3fKVlM
	 KEu5pPlUxSY2B6hGCFpLraa1MfGWNpSs+MMiOdIPqH/GICG/fQcCIP+Y8JC4wk2tH0
	 /xQS4Uc2N8YjIE4zxX4ymlVL+llfRR9B/bUOwrIiILn2SARTWxQhjcflbSpA8ipRfg
	 jfM6YSEvXzx1w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/12] btrfs: use inode already stored in local variable at btrfs_rmdir()
Date: Tue, 24 Jun 2025 15:42:17 +0100
Message-ID: <e1789e1dbfdb73b930d74d6eae8b728d8241cabd.1750709411.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750709410.git.fdmanana@suse.com>
References: <cover.1750709410.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to call d_inode(dentry) when calling btrfs_unlink_inode()
since we have already stored that in a local inode variable. So just use
the local variable to make the code less verbose.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 12141348236d..f8e4651fe60b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4759,8 +4759,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 		goto out;
 
 	/* now the directory is empty */
-	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
-				 &fname.disk_name);
+	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(inode), &fname.disk_name);
 	if (!ret)
 		btrfs_i_size_write(BTRFS_I(inode), 0);
 out:
-- 
2.47.2


