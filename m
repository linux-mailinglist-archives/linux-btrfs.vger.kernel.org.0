Return-Path: <linux-btrfs+bounces-5437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C12B8FB0BD
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 13:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF731F2308B
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 11:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADBD1459EC;
	Tue,  4 Jun 2024 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE9peky4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D6B1459E2
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499337; cv=none; b=tLQaBde9xVbOSszkZ7Q6mEz5Vl5JIEX3H3U4BzTwz/SL4wCIwBwHeRmlM3qWWRT07Z55EbQD0eMg6kfGqZ76R0Ys46yA+iJlyIdC+LuGZ7DpE/vRsSvnOKat4dRDUybXOW4vq7N4P6jyJ7F6+TpaZgJ1ydtPdsFDArBmpAGugqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499337; c=relaxed/simple;
	bh=6jz57W78XV1MgsYGo0FhySrNR3MbmsWFHlFwlT9oRsw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AuoRxeei/V7ylL9j/u5uLx2nMm6001pnzItdX45Y2FW/sVORQUDqGqICznN8h9Q82kVdN02VrIl5RFu8N30nrljpgUm3yRVRzEZrQQ0yap39cg6yl0e9c65Q09aQoC3G6QUbmRMoS9x8Mu3KJ+4f8GDr/y0c7VzBQP2IJkELZxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE9peky4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24134C2BBFC
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 11:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717499337;
	bh=6jz57W78XV1MgsYGo0FhySrNR3MbmsWFHlFwlT9oRsw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VE9peky4BKDNuiXjfjB9wBIy9peN/0OZwnaCIA5t9c1XvI8p/lS+Sk0nRUG6G2Xe+
	 GSYb8/ClPlhcrT9ALkcNY+D6TyB4s+lvLk8yKtl6JnDO908Pk9orx7VwBwI6GftFVk
	 6Oyb478+6mFfJR1kgsaOmqxfJJAaOxck/uKrjX6hobec2cIRZaNIxGpKWgaGxeXRLC
	 x31tsJBoQ8JDgGJpjEn0AYBbeGlcqhUef18gU9Flz2JQqVhV18+16VmdxoRWHc7mSF
	 3RXL0EdM3GpfEzYY2hn42zeqQ40iLg8P/70rKZKNyMESWwVF7rax19aLL4xunHhdcr
	 z+lSjFUQv+9sA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: reduce critical section at btrfs_wait_ordered_extents()
Date: Tue,  4 Jun 2024 12:08:48 +0100
Message-Id: <f0b57ef2d2bff5ce085483a7ef0f0f34f578240a.1717495660.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717495660.git.fdmanana@suse.com>
References: <cover.1717495660.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_wait_ordered_extents(), there's no point in updating the counters
after locking the root's ordered extent lock, as the counters are local.
So change this to update the counters before taking the lock.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 15428a8d4886..1cabcfa85e7c 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -783,10 +783,10 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 		btrfs_queue_work(fs_info->flush_workers, &ordered->flush_work);
 
 		cond_resched();
-		spin_lock(&root->ordered_extent_lock);
 		if (nr != U64_MAX)
 			nr--;
 		count++;
+		spin_lock(&root->ordered_extent_lock);
 	}
 	list_splice_tail(&skipped, &root->ordered_extents);
 	list_splice_tail(&splice, &root->ordered_extents);
-- 
2.43.0


