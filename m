Return-Path: <linux-btrfs+bounces-4487-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F018ADAF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 02:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49A3287411
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 00:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FD7200100;
	Mon, 22 Apr 2024 23:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gobt1g3r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA1C1CB326;
	Mon, 22 Apr 2024 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830368; cv=none; b=piYng1Qq/E8oCdmPozFH+PPJpFI+txzrLfLglOzuxAHNfZgBpze34ZX0D7O3iE2yA2uby0T4wjQYzDOItsJ8Oi8KTO1Kfty7YnQRTM0Td09FsJZC3LImg+Z4UZ2/dm1MZNNHwl5komjTYOOEHTd85Tpz0yoIju207ogm+Vy1C7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830368; c=relaxed/simple;
	bh=TsR2E27DLIduhKcxUT++lM7daxWCYkV4N77uZXkHibo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEhbt+eFpi2EirKl4rUIPr/GHrI4U8boBCa1ftEjveCel2yyS1C0rEtHJOkOb5SIT9E13F9NT/e0lIepI23vWx3/+RM1QX1QfJt0BuTRhYyWSlW1bCdnBQrqi6SCt7QMS/f737SsJPby6mJJcXUGuvdV851+LRwRXciAZTcH1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gobt1g3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B0EC3277B;
	Mon, 22 Apr 2024 23:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830367;
	bh=TsR2E27DLIduhKcxUT++lM7daxWCYkV4N77uZXkHibo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gobt1g3rz/cVixmQzrBs+2wzL4s7jp6a9uU316CP1sRkxj6MsK/ZmnfJqLMaminm5
	 2ZZx21l0xuff0GoPXwQcOnA4De7aUfBS6nVRElTk6Td6FKl03KKY6ODqAULOKMeNRd
	 sZdxQTJtBBuxuf2MNm5nYQduWEhItH67nNu/mWburQwR9lhFk113I+WFW5HzL8fHVz
	 e6j7NPIRdVl94bsKRDIgxzy59czif0EwuUYxX1krwylrazyxt4QaU1/ILmJ8roo7UW
	 /goWEXDDFGRv5uBfrvj7o90+I2F9RkOlh6FUYl/osiXdFHKc68jmckk1NvSmoRBHZR
	 kZjDGn63GaCPg==
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
Subject: [PATCH AUTOSEL 4.19 4/7] btrfs: always clear PERTRANS metadata during commit
Date: Mon, 22 Apr 2024 19:20:36 -0400
Message-ID: <20240422232040.1616527-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422232040.1616527-1-sashal@kernel.org>
References: <20240422232040.1616527-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.312
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
index a34c0436ebb1d..df9b209bf1b2d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1271,6 +1271,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			radix_tree_tag_clear(&fs_info->fs_roots_radix,
 					(unsigned long)root->root_key.objectid,
 					BTRFS_ROOT_TRANS_TAG);
+			btrfs_qgroup_free_meta_all_pertrans(root);
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
@@ -1295,7 +1296,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			if (ret2)
 				return ret2;
 			spin_lock(&fs_info->fs_roots_radix_lock);
-			btrfs_qgroup_free_meta_all_pertrans(root);
 		}
 	}
 	spin_unlock(&fs_info->fs_roots_radix_lock);
-- 
2.43.0


