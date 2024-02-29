Return-Path: <linux-btrfs+bounces-2929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99E186CE32
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 17:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5C3B26838
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B8614BF4A;
	Thu, 29 Feb 2024 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL/dw270"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555614BF3B;
	Thu, 29 Feb 2024 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221858; cv=none; b=R9F7Yfw66jn3/9mdk00BfCLMoCouFWQ9a1d80b05JGCA/n9qxdO1RDUg+wdC00GyMsoOcFAB8SVEGVGLoVFJaSblKm0FmPdLAbYzJxwCmb5YgW6MPi/2lDY7P6NAhcn7DtKRyvnyeRSRcawwLfJuaQRhDgfkZJg0HjxcyzBn/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221858; c=relaxed/simple;
	bh=jyUcNQ9GntSGfERNYUd4qRk75zDk8r3yKu0X3vCk3eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WgQ3hdO58EuT5tLCZg0fcyosFl3SzCOMI0kKi71o1apgtoD7u5WYEO9yKVfRtY7ODzwgJl1uihG0unwKqRvKZ02PTXukXoxgEnLjRxxI7gJ7JmS4B3uwIw3eBL6cf80/496f7MSqto8S+dZq6LHcEKOrt22Y9Un+x9FAYQj+zFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL/dw270; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569CFC433C7;
	Thu, 29 Feb 2024 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221858;
	bh=jyUcNQ9GntSGfERNYUd4qRk75zDk8r3yKu0X3vCk3eo=;
	h=From:To:Cc:Subject:Date:From;
	b=mL/dw270uP/XVn2cCxlXh3g3kOfkaD4A/sFSmXlpK2WpIOAinD4gyPjDC8Pphrfgm
	 ejxKCfnxQ5PlCpoleb3XkF1JW3oKUF5eWTFCbUQ1oXfOjbWT2Wt1bUEAVoCWavIr3/
	 AL4uh7mFc/M7bTaVzw1Gyz9zYrRpYGDEJrZJx0EO5GvUbmpBxe+k3pzl55Tva65RAH
	 3OxGW7eSKvgIZ+U+TSFmB1KSNXg9g2URRHnxkvHYcGKHHem/z2ldIhcl9ycBrJ7kOu
	 BdtRkleU/S8Ae2NHwb77bAOrDWZepCpi6hfU8UqKbvSSlrk+ecPd4FmD1cTS5iDHNx
	 Z4rBJbs8AOnsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/7] btrfs: add and use helper to check if block group is used
Date: Thu, 29 Feb 2024 10:50:50 -0500
Message-ID: <20240229155057.2850873-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.149
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 1693d5442c458ae8d5b0d58463b873cd879569ed ]

Add a helper function to determine if a block group is being used and make
use of it at btrfs_delete_unused_bgs(). This helper will also be used in
future code changes.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 3 +--
 fs/btrfs/block-group.h | 7 +++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 4ca6828586af5..a2bac7196d18b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1330,8 +1330,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		}
 
 		spin_lock(&block_group->lock);
-		if (block_group->reserved || block_group->pinned ||
-		    block_group->used || block_group->ro ||
+		if (btrfs_is_block_group_used(block_group) || block_group->ro ||
 		    list_is_singular(&block_group->list)) {
 			/*
 			 * We want to bail if we made new allocations or have
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index a15868d607a92..f042c1c85a255 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -211,6 +211,13 @@ static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
 	return (block_group->start + block_group->length);
 }
 
+static inline bool btrfs_is_block_group_used(const struct btrfs_block_group *bg)
+{
+	lockdep_assert_held(&bg->lock);
+
+	return (bg->used > 0 || bg->reserved > 0 || bg->pinned > 0);
+}
+
 static inline bool btrfs_is_block_group_data_only(
 					struct btrfs_block_group *block_group)
 {
-- 
2.43.0


