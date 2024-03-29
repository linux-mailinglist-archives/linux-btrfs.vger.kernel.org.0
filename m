Return-Path: <linux-btrfs+bounces-3790-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 287B1891EDC
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 15:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13431F2B29A
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FEF1B9A31;
	Fri, 29 Mar 2024 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ar8r49bt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC6D1B9A10;
	Fri, 29 Mar 2024 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716644; cv=none; b=nRFl+Lvytn3A7Uy+JoXOfyYbQy16zxrZQR93tFwy2IDz+LTC08+dWvNnAoCPU5VSBvLBPY211jL0HnCnIw0u/X9NUPRSfjmrOn33a+6KJtfp/gpv4rJeudfKwFnhFMnKLEX0nDTY2mDTiyCsZdZAN3kHcE5dZno9zidZG68zNgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716644; c=relaxed/simple;
	bh=wjH2febHGZZt5K3X7H+ZU2AnIuDf0ekNxv1Un2cJadg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AITblCpJwrOd1kbtJ32d+ZSw4l2c5gHkv/XSbmF9WwIWvUZCiAvIB9e8KplpMqIe8sHtlMFFbJS79z5PxrCbYZ/IQICspSTjrYYGz/pdVWQ/D19+t64xjxJOEXaJCJALTNSXY6SQWBsFI9/TQITff2913g1DX15kEZvH7dstCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ar8r49bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CF5C43394;
	Fri, 29 Mar 2024 12:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716644;
	bh=wjH2febHGZZt5K3X7H+ZU2AnIuDf0ekNxv1Un2cJadg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ar8r49btg+8L4m32YIhDPB/2Uy9di5aFhxMJPh6VSv9ij54Ua4ryM/5cY3mckWyLe
	 rqax6DqvXHw+5dLa2m56A6l4KDPpUryAqSpqUakW1ltE4QNAvbJW9BtX3m2bTatp22
	 hj3u/otqbG+WL9kttZXZvF2P0+tCrowDyEtm3GGBYAhOzrp04zVIBK0yZPBknvk3fK
	 LpVQ4nvsuYu6xAjmVckOC7HJI23s4XiYisO4guTqhGFrEGdqoLCdW5tAw4pRfXWFBJ
	 DQiP8UiBaKiC8gl3iWguPGQ7qQA9jZLrIHggAnLKj9Wb3v91T0sHoSZGZ6uuhYoUuQ
	 +fPwM+sABox9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 19/23] btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
Date: Fri, 29 Mar 2024 08:49:52 -0400
Message-ID: <20240329125009.3093845-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125009.3093845-1-sashal@kernel.org>
References: <20240329125009.3093845-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index 6e4727304b7b4..08d1d456e2f0f 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -182,8 +182,15 @@ struct dentry *btrfs_get_parent(struct dentry *child)
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


