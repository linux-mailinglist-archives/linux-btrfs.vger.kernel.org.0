Return-Path: <linux-btrfs+bounces-4477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F658ADA18
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 02:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0576286BDD
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 00:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6326C16078F;
	Mon, 22 Apr 2024 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcFd6Hy6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57A15FA7B;
	Mon, 22 Apr 2024 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830181; cv=none; b=sj7Jed7JCAGjEr6FNZwa3tLUhz31i4vbU59SdDyjFEvKErItPQ7hR8rD7OlFUNxB3YApBVpsZn/eRYn+T8DyeWdN+jbgPUTYFsmu/RUSj6rSGoankkvxnWOtpLo/he+y6uFw5HrCJjYTffly9pbrI0hOcW5vUMXTm0QEYZxRc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830181; c=relaxed/simple;
	bh=M+UD4lwK0UXydLOLgOo76LXFHrR7uFJQwPsEqQJ6RTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3/shCoGoiCR7lyHmLkmjMDx2ZNyefX17vX2Q/a5/81BXmALVNSn+KI1s2BGqTgxdJGLOt3bRDRk2xkfZn9Uwj7LlSxjD+ZRxzzl+Mzd5IxgegSX/zZ0x2TMWKsoFdgyC94ZEQkLRdoBjFmR3C1bFyU+R7ozDx3Z4EaAyU4IFBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcFd6Hy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D922C3277B;
	Mon, 22 Apr 2024 23:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830181;
	bh=M+UD4lwK0UXydLOLgOo76LXFHrR7uFJQwPsEqQJ6RTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kcFd6Hy6OaAYXSvpfQiRMe7DbF0nmTiunxYQBTj+vqrbT2wPykU6dJp4JrCS1TbfS
	 IVxR15eE5qUyiPKbz1i7UHNupbLBK/uyDJWOtIuzP5weZQy+U2gtunjYC35KCz4Ge4
	 cRnE/ae17BXSMYwfjMl/J26aJBbzwwnv4aik/N1el4SQJyYX406qimTdNwQH+jnp03
	 NKCnqWFAxBLXJLbYfU36G0FgieThie3Yw9a8g6uoEqOdHnQQAIhPrJ4k4LAqOpmQfm
	 GjLY6fU16O8x/ZKTT7Psg+JEPgdCEZjsOa853EpcvtGJKUePtlTcAFnTZ1voHVeDpJ
	 8Y2+IYJjklxQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/29] btrfs: always clear PERTRANS metadata during commit
Date: Mon, 22 Apr 2024 19:16:48 -0400
Message-ID: <20240422231730.1601976-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
Content-Transfer-Encoding: 8bit

From: Boris Burkov <boris@bur.io>

[ Upstream commit 6e68de0bb0ed59e0554a0c15ede7308c47351e2d ]

It is possible to clear a root's IN_TRANS tag from the radix tree, but
not clear its PERTRANS, if there is some error in between. Eliminate
that possibility by moving the free up to where we clear the tag.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 457ec7d02a9ac..0548072c642fb 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1449,6 +1449,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			radix_tree_tag_clear(&fs_info->fs_roots_radix,
 					(unsigned long)root->root_key.objectid,
 					BTRFS_ROOT_TRANS_TAG);
+			btrfs_qgroup_free_meta_all_pertrans(root);
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
@@ -1473,7 +1474,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			if (ret2)
 				return ret2;
 			spin_lock(&fs_info->fs_roots_radix_lock);
-			btrfs_qgroup_free_meta_all_pertrans(root);
 		}
 	}
 	spin_unlock(&fs_info->fs_roots_radix_lock);
-- 
2.43.0


