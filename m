Return-Path: <linux-btrfs+bounces-5440-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEB48FB0C0
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 13:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6365A1F22F28
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 11:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9832C145A16;
	Tue,  4 Jun 2024 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knX/2PwJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE58D145A0A
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499340; cv=none; b=TuKiPrOEizW3m2KTnHvG8r7W7uaJW2wswVEPYN7DgWj9KZwaHJnR1qQ/V7MEYCEGXMO9BRLyA+aHttw96XDq4M9XvMy2u8NectW2ROgk0bUZFzo4N2qu2wXtrXfcrhgERe3bi2We6f56u7/O6OsoB8PGMNZ0ifnTPrvg4VZMVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499340; c=relaxed/simple;
	bh=tWZ0MS0YS6KSsam3joOdeBOaK+riZkc7r/Qh1cW8Rk8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=btNFuwytVm8/KT/UshiMRAvQ6bBsvou1If++1Qv39jMPXDaDQVXKqq1xR6y+d0fFmO2GM+qQ3OYDbr54abjSgvd3+TtCVpVADCAN3oE7MR4wT3S4OZjCkiIi9rjtUj1a3JlMuFMiTpRVS9CP2VG006kJYCv29i6de1oG785hVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knX/2PwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BF9C2BBFC
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 11:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717499340;
	bh=tWZ0MS0YS6KSsam3joOdeBOaK+riZkc7r/Qh1cW8Rk8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=knX/2PwJsmB5IbZ1TpnYYr4Wq9qjHxGtqtc/PyavcZIfvyD6i/ENC4ip81gR/h+ck
	 bM7U+nFCsw0h1wxRbfFiKnvt/5nkAxJX8ogje3/bHQn3uGVsgNpS5WPShaoWXHTag8
	 yNzrF/fbIF3I8YooafGRXppTI5cHwF5m6AbbMm2i2M0/YlzudV+cXQmWIlTn18hufy
	 ZVeLzRf3BBg5G7Il5cXiuNmvaeJRnu/CQwwvcK8DaHwlL6U7Gj8GH23VO3XooqRnx6
	 RMUnZ2WytpU6jYRc6RPOtuDnuiSJLyHKpSNmXjhI2611lftTI2rJFKwt/ReyhNa+Xr
	 nZFDkB0FppzzQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs: mark ordered extent insertion failure checks as unlikely
Date: Tue,  4 Jun 2024 12:08:51 +0100
Message-Id: <1d0c219fe64db06e3c8ffa7b28299fca959473e7.1717495660.git.fdmanana@suse.com>
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

We never expect an ordered extent insertion to fail due to already having
another ordered extent in the tree for the same file offset, since we
always wait for existing ordered extents in a range to complete before
writing into the range again. So mark the failure checks for the results
of tree_insert() as unlikely, to make it clear it's never expected (save
exceptional causes like bugs or memory corruptions) and to serve as a hint
for the compiler to possibly generate better code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1d7707948833..c98c8fdc14a1 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -224,7 +224,7 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
 	spin_lock_irq(&inode->ordered_tree_lock);
 	node = tree_insert(&inode->ordered_tree, entry->file_offset,
 			   &entry->rb_node);
-	if (node)
+	if (unlikely(node))
 		btrfs_panic(fs_info, -EEXIST,
 				"inconsistency in ordered tree at offset %llu",
 				entry->file_offset);
@@ -1303,7 +1303,7 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	}
 
 	node = tree_insert(&inode->ordered_tree, new->file_offset, &new->rb_node);
-	if (node)
+	if (unlikely(node))
 		btrfs_panic(fs_info, -EEXIST,
 			"zoned: inconsistency in ordered tree at offset %llu",
 			new->file_offset);
-- 
2.43.0


