Return-Path: <linux-btrfs+bounces-5076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B02988C8A5C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 18:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675091F233B2
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B07513DB8D;
	Fri, 17 May 2024 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGgQiiLI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D3813D8B6
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715964763; cv=none; b=UCOdmVLj4CuGTLxqH2pHVoceeT/cqJE57PIFUOrWSF+8aBUKpDm+w0Ru4XqKO7C9JXhofJwa5J8wfyj7mMdhnT82UAcrYmxWJBXjBY3xrnKyoIprkWhNaRNd0ZRsPUIfayLizMgnnTKFY0RdI3ks0el38AG+gmMpnNR7Talnk0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715964763; c=relaxed/simple;
	bh=giaF07HsS/o92Sx8QlESt03wiFeVuvpcaqG+P8qleA0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JH8/6JYamzmarIUY7gzPbHg8pc6U9NnimRpdhV8vORfakaXlnK1XZ9/Wc17IPDDFWL8b6aAspvtwZEGdH4I2C6WRPhM6xDhDJFEMZ/BKfYbLHzxsnjog+3JSntEo1b7diDtVgdolB5DRAFSLSZCwAWRd37bDTT5Gg/RxIZHQRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGgQiiLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90361C32781
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 16:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715964763;
	bh=giaF07HsS/o92Sx8QlESt03wiFeVuvpcaqG+P8qleA0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uGgQiiLIV3KWqLtdaH1g1GuDcEokLU1l25DvaMiIucsyJHbCLqAX25GxobxIKagTk
	 FQHYV3J2bSSanFtBGduC43wsBn1jjMYjx6GoPGxJYIiH68cawCEVt/tlRIAFJdkhxZ
	 ispbjJrRIOCjLvdoZiQFS1vzIgVS52r0exCSGGTWlBDERm5utBPco3J+eznBY1frz1
	 y95oXbsFzlKt3GFbK/o2+AuDEYmqWQaYjOFE0cDhKovO6tHYmpfalAF/0SbaHDHkJn
	 TV9o8a5si4pSL3mAZKwynaL9n7+LVtU/XaMrUtpwOgf49H8hNspvlYFGhyoMWUbhv9
	 kI4nwXujuPldg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/2] btrfs: make btrfs_finish_ordered_extent() return void
Date: Fri, 17 May 2024 17:52:38 +0100
Message-Id: <c0f00d4779410f4f4096fcc006beec8b23d15fa2.1715964570.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715964570.git.fdmanana@suse.com>
References: <cover.1715964570.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently btrfs_finish_ordered_extent() returns a boolean indicating if
the ordered extent was added to the work queue for completion, but none
of its callers cares about it, so make it return void.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ordered-data.c | 3 +--
 fs/btrfs/ordered-data.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 55a9aeed7344..adc274605776 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -374,7 +374,7 @@ static void btrfs_queue_ordered_fn(struct btrfs_ordered_extent *ordered)
 	btrfs_queue_work(wq, &ordered->work);
 }
 
-bool btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
+void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 				 struct page *page, u64 file_offset, u64 len,
 				 bool uptodate)
 {
@@ -421,7 +421,6 @@ bool btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 
 	if (ret)
 		btrfs_queue_ordered_fn(ordered);
-	return ret;
 }
 
 /*
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index b6f6c6b91732..bef22179e7c5 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -162,7 +162,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent);
 void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
 void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 				struct btrfs_ordered_extent *entry);
-bool btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
+void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 				 struct page *page, u64 file_offset, u64 len,
 				 bool uptodate);
 void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
-- 
2.43.0


