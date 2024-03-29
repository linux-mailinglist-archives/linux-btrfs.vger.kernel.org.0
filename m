Return-Path: <linux-btrfs+bounces-3777-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D3D891D4C
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 15:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BC2286F22
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6665C1D1D7C;
	Fri, 29 Mar 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIIhG5zA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4641D1D61;
	Fri, 29 Mar 2024 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716322; cv=none; b=UGuGAYDnVJkDPxmQD4WnvD5XiAZmcOmzhdHX3RdUZZH1gs/4isU0zqs7PwdHNfFzRG5yVX58/0udmcuFWUDOblF3MV69u0eocxeCuflo+AHrTWezVpQMo7fLRJYJSxLGXLnru11x9wXJ1a4sfG5V7WxLpCWYiDNJOX2Ch785/QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716322; c=relaxed/simple;
	bh=CBLJ62ZdxOVQDTLj11F5FJn+stz1NKJMv4S1wqAkH4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHyiUrZZRRoZGPB0VEtyLqb7M7V6nGxnPhFFm4KjP5XPkBTAtwkrRsEKSSBgUqxVtrT4m1i1ChcpLyhLOf3/XScL3bKBil2w45wPA7nxhetIjkjbKtk0W8T40+fC9AY11+nTib/Xcx+ZCNGNaIWHQWIgNSS9AvWmXEb06C/IrcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIIhG5zA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD6FC43394;
	Fri, 29 Mar 2024 12:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716322;
	bh=CBLJ62ZdxOVQDTLj11F5FJn+stz1NKJMv4S1wqAkH4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TIIhG5zANNDyc9evMRvwvk1P73pwlNEPWRx0iATjZgf9sOJoczMbd78QIN0uBzU/I
	 HTvzCjXBb8/2bAYuRGhc92Ewlblkjj8Wx/QuAtvZCb+oULCOV1Q9KtNRs3kjJ/dLd7
	 Xqo8j4ellN9K/KS22nDXL6hvOn+7+LqEj+kx8Fl1d39Xwd07C6T/yYcxROoMZcvj3e
	 JnbNt+gWNXxsigRQdUUYWG4WHYAgEVG7kDrzu9aFzU7G0ll+FHZcZMvpNi0Eg/bJaT
	 OIVo9PxMI2O9CQR1OHv6rbpAjMOZsnLfamb5Ti1oVdCTBuaLPU87j6nmvGWXp/sYXT
	 8tnSTGo4/q/5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 62/75] btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
Date: Fri, 29 Mar 2024 08:42:43 -0400
Message-ID: <20240329124330.3089520-62-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit 26b66d1d366a375745755ca7365f67110bbf6bd5 ]

The get_parent handler looks up a parent of a given dentry, this can be
either a subvolume or a directory. The search is set up with offset -1
but it's never expected to find such item, as it would break allowed
range of inode number or a root id. This means it's a corruption (ext4
also returns this error code).

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/export.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 744a02b7fd671..203e5964c9b0f 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -174,8 +174,15 @@ struct dentry *btrfs_get_parent(struct dentry *child)
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		goto fail;
+	if (ret == 0) {
+		/*
+		 * Key with offset of -1 found, there would have to exist an
+		 * inode with such number or a root with such id.
+		 */
+		ret = -EUCLEAN;
+		goto fail;
+	}
 
-	BUG_ON(ret == 0); /* Key with offset of -1 found */
 	if (path->slots[0] == 0) {
 		ret = -ENOENT;
 		goto fail;
-- 
2.43.0


