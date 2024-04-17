Return-Path: <linux-btrfs+bounces-4377-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F0B8A8745
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 17:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F283E1C211B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF208146A98;
	Wed, 17 Apr 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2PJXLoE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA37C3E493
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367097; cv=none; b=hRyQEvsVOFET2pVeaRL0h5neCwF+hFBoSHulKZPU3w2P+y5Lq1Ba8ykL2p+iyjAlqUXZXz6x5/frHB2fLT3SiSvvWF3IvKczJIAH+9wAIDsuz1Msrx6jLwHwCG8UCnZjndtO4NoLZwuva6gcbSbnVwPa7XgsY8qoW3jDWn7Fkic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367097; c=relaxed/simple;
	bh=ubg3a85CGcp3CJYNRv/V53oCuN1eoplwkKTPRPxYwt0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=seDKAPOQo6JFeZpz4Im1PZkOn4F33lEKNFPEScabS5kEsR4LjUWrjTI+nc3nJIG6fQ7EuV6c05ILfb8Q1uCFQXoDHkNeut5TC5sdeWvU/aoV7tbnB5MMaiviTl3MWcLSxFZg/e3LCFN6I5Wq7e1o4JJx7EkqZswjrhm9OOP4ZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2PJXLoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0C5C072AA
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 15:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713367096;
	bh=ubg3a85CGcp3CJYNRv/V53oCuN1eoplwkKTPRPxYwt0=;
	h=From:To:Subject:Date:From;
	b=T2PJXLoEhzJmdpBVo0zsPUPT3vE2C+GTM89V4oR3ryK1rzijiN0eg4RhYY7bLyU+w
	 364uqD3wgC3A91M/7tQT37/PVC0YYjVbc3ICSCClrEX69B8xsJErXBnBkLv9IzZNTv
	 f5ijxiJztks3nR2rUeIsFIGY/8ws9uXJet6p3dJxBcg/86dhyPmSALNmWRb7iCxSEx
	 cSWqBfZO4/YajFgrAqibDlP9SYP2l66n7UXVcZ/3f/SLAfWsu8NgMvVkOds2qfqQk2
	 BFTVX+ctM/0q2Twvl6q6F5MtcY5aPNQ1HFSxZtNzjkpL8QoK4W60UXMvbDT0Lp0kX3
	 ixc7kcit27ROw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: initialize delayed inodes xarray without GFP_ATOMIC
Date: Wed, 17 Apr 2024 16:18:12 +0100
Message-Id: <b1eaf444091755ac133e26f44fb2836bb5280132.1713367002.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to initialize the delayed inodes xarray with a GFP_ATOMIC
flag because that actually does nothing on the xarray operations. That was
needed for radix trees (before their internals were updated to use xarray)
but for xarrays the allocation flags are passed as the last argument to
xa_store() (which we are using correctly).

So initialize the delayed inodes xarray with a simple xa_init().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6eeac9618a69..5b6838156237 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -663,8 +663,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	root->nr_delalloc_inodes = 0;
 	root->nr_ordered_extents = 0;
 	root->inode_tree = RB_ROOT;
-	/* GFP flags are compatible with XA_FLAGS_*. */
-	xa_init_flags(&root->delayed_nodes, GFP_ATOMIC);
+	xa_init(&root->delayed_nodes);
 
 	btrfs_init_root_block_rsv(root);
 
-- 
2.43.0


