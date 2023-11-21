Return-Path: <linux-btrfs+bounces-246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F9C7F2E82
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE75B21DF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC53524CD;
	Tue, 21 Nov 2023 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co/RPbXT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33115524C3
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F21DC433C7
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700573932;
	bh=8hoomi/+8IAUX+q2q1XOETMVkafRiaK26+mL4dAbekM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Co/RPbXTS/x72nHPlZWgnQBYE2lOwxGbCrWNfRu03ndj3z+gs4aedB8i+3AGhB+9+
	 srySUetYq8pS3hC7BAxakOirSK+nTl2YZWl/dLEUDaWCbh3mnife/QgCQVQea/DuAo
	 i3hEBN1aDJRYoaBul/+biGfG3XxKWz7oR50xptGxx83T46CbY/OM1bA6D7rYwvdVvx
	 O5Bvg0J2b93maTpUTDn8NXxgSAlvCq+DG3I9KCx2ZWOPFCaCn/FTg6oHMRcqKlBK0c
	 +3Hd3VQbFxoQBnx267xJuRFSbcFt0r8o1BcTurXqn1fr4WRy6S4TmQq3WSKEIeSVly
	 Jry4JtePZej6g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: remove stripe size local variable from insert_dev_extents()
Date: Tue, 21 Nov 2023 13:38:39 +0000
Message-Id: <d92fcbca8411fe28d6b3c84b795b46765a3635d7.1700573314.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1700573313.git.fdmanana@suse.com>
References: <cover.1700573313.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's not needed to have a local variable to store the stripe size at
insert_dev_extents(), we can just take from the chunk map as it's only
used once and typing 'map->stripe_size' is not much more verbose than
simply typing 'stripe_size'. So remove the local variable.

This was added before the recent addition of a dedicated structure for
chunk mappings because the stripe size was encoded in the 'orig_block_len'
field of an extent_map structure, so the use of the local variable made
things more readable.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0fea258eea15..4365f7b6b94d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2597,7 +2597,6 @@ static int insert_dev_extents(struct btrfs_trans_handle *trans,
 	struct btrfs_device *device;
 	struct btrfs_chunk_map *map;
 	u64 dev_offset;
-	u64 stripe_size;
 	int i;
 	int ret = 0;
 
@@ -2605,8 +2604,6 @@ static int insert_dev_extents(struct btrfs_trans_handle *trans,
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	stripe_size = map->stripe_size;
-
 	/*
 	 * Take the device list mutex to prevent races with the final phase of
 	 * a device replace operation that replaces the device object associated
@@ -2622,7 +2619,7 @@ static int insert_dev_extents(struct btrfs_trans_handle *trans,
 		dev_offset = map->stripes[i].physical;
 
 		ret = insert_dev_extent(trans, device, chunk_offset, dev_offset,
-				       stripe_size);
+					map->stripe_size);
 		if (ret)
 			break;
 	}
-- 
2.40.1


