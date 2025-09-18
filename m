Return-Path: <linux-btrfs+bounces-16933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41A2B84A0E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 14:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C05583668
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 12:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4715303A01;
	Thu, 18 Sep 2025 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqBDUz0A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11560302151
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199346; cv=none; b=tmOt1tjDo0Pns4mo0g1LF70Ql2/YMGsHLydNxZNhYeorH9KYG7ZBej7KbmlZXB6MmiyRNWwMxri1z6vEfe+0BA5s+vm3Fb39ExBj5H5lhzpowBTcwT0mLkzowI78lSL2Upe9BZkIikJm7ytYhFgXkzgfUArudHSHRD2VojT0fig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199346; c=relaxed/simple;
	bh=goEdDz6RQWbAsRfKhxRv5750sbCnSB7J/LVM/LKJzMA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEnBoFXMUSNrcY0JOnYdsnxnZAY232PPF/p5sFXrLX6/z29OM1RmF0bhrb+7KdVgp8Yd1RDKDXXU8YpaLstHs7fqyDu8BXIh4a6074pVoGtcoe7WneZmrU5vOBfWk/58KXqoTH3SQ/YWjH+o4bAeljDbGmlLv8K0iwyjGFAcqX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqBDUz0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E04C4CEEB
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758199345;
	bh=goEdDz6RQWbAsRfKhxRv5750sbCnSB7J/LVM/LKJzMA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mqBDUz0AxnwIcxm5Rn8IDk+PkP58QPbJl1/FTZq+3YeOf9O+XfZgiHruo1mCcD1Gn
	 HaI9KMOwqiKCo8exeUuBjwFNo70abWNjVoEOwzjZC5cKo1d9dX6Xz9RrFhsLQY9Wfb
	 M86PIh6a19u24svtCaZDkuQYBvrISS2sba0X2bcOtIvnAQVaHj4iunFPoeuCAcp9ZK
	 bDbqugL1DA8T8ZchfJjG0+K/VFrAcEs92DK6TQHKsf04gzjtK0jt9huaenC8Xu4Wtp
	 ht8ZITx7E3WskRYLX+iCnTxAnByXILMLWIOt7kdfQB8+xmDBL84ytdqmD8XtFvj0Ui
	 UN4jmYRud0q5g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: simplify inline extent end calculation at replay_one_extent()
Date: Thu, 18 Sep 2025 13:42:19 +0100
Message-ID: <c0885c6f8c9b7e04a52b3a1ae447c5938a697e49.1758198953.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1758198953.git.fdmanana@suse.com>
References: <cover.1758198953.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There is no need to store the extent's ram_bytes in two variables,
further more one of them, named 'size', is used only for the extent's end
offset calculation. So remove the 'size' variable and use 'nbytes' only.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 96492080fed8..ac7805d40ab2 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -732,7 +732,6 @@ static noinline int replay_one_extent(struct walk_control *wc)
 	struct btrfs_key ins;
 	struct btrfs_file_extent_item *item;
 	struct btrfs_inode *inode = NULL;
-	unsigned long size;
 	int ret = 0;
 
 	item = btrfs_item_ptr(wc->log_leaf, wc->log_slot, struct btrfs_file_extent_item);
@@ -745,10 +744,8 @@ static noinline int replay_one_extent(struct walk_control *wc)
 		if (btrfs_file_extent_disk_bytenr(wc->log_leaf, item) != 0)
 			nbytes = btrfs_file_extent_num_bytes(wc->log_leaf, item);
 	} else if (found_type == BTRFS_FILE_EXTENT_INLINE) {
-		size = btrfs_file_extent_ram_bytes(wc->log_leaf, item);
 		nbytes = btrfs_file_extent_ram_bytes(wc->log_leaf, item);
-		extent_end = ALIGN(start + size,
-				   fs_info->sectorsize);
+		extent_end = ALIGN(start + nbytes, fs_info->sectorsize);
 	} else {
 		btrfs_abort_log_replay(wc, -EUCLEAN,
 		       "unexpected extent type=%d root=%llu inode=%llu offset=%llu",
-- 
2.47.2


