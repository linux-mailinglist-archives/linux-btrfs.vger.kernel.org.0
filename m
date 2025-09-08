Return-Path: <linux-btrfs+bounces-16730-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD16EB48CD1
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 14:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F76C16E566
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 12:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9152F7AA1;
	Mon,  8 Sep 2025 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SijdIUhI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E5A55
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333152; cv=none; b=Lw4jl2LYM966EZ2ye8FJKBU0LeflUNaojAKjgwDZu0jsL2+4TS0h1f1OFcd3+hDwqhb5EQ8pHNr1uFD4xW0QfvfVTkUi11k/LJ5amAa9kI7nTZx1E+UK5oqUHrHKPaM83Igixxm5N/cGwIn+xxKz69ZYASdS3STnMlpa5y9Soic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333152; c=relaxed/simple;
	bh=Vv2Pg+65iwChF73/b1a8seUvTKpFup93EZzQgluZ+YM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eX3soLSVl9YTZf+iyjPxgPXthzKi5F7PRePBvNM8POdpJcb64oJNfwYx+txNAhwAigOI2cP9ZA/uKgTdUrqmzu53OBgA1krYzWZDaRZ7Iwrr06twhO+JFsWR5pP+q24tYWsr+XyLn/ujyntewlS9YIQp19Q42TXjo1txagohNo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SijdIUhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F059C4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 12:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757333151;
	bh=Vv2Pg+65iwChF73/b1a8seUvTKpFup93EZzQgluZ+YM=;
	h=From:To:Subject:Date:From;
	b=SijdIUhInm9cpkZDlepLKkFShnKFAu5s3d0grKNns2bqlBxEiuvZEn+uXUeyC1CGu
	 CwLPCK94/t6xw3BV0KqU2W/xdTBOHEKmjIV1jbP0m+pxVRjepN0bPecpzvfqQekQp5
	 IwS07Mn/ooEzrKxlO9QVXNXM5kq16mhf/6dG8Ui6IGAVYMUWCiet7s25agk0qFlajs
	 dSpzEqmhYTHRtgkvGbpYl3H7cAbYOCeI3O9Zpq48e1IwPCDZd3BU2p7h6vQQ15TSNc
	 hpUHEYLFVKbWc/nEfjwJc0XTycH+IB5MV7o8BZToNUa7qTmBQLkaeq/N4rjzvdEBoZ
	 CkFJDnHYsuKPA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: annotate block group access with data_race() when sorting for reclaim
Date: Mon,  8 Sep 2025 13:05:49 +0100
Message-ID: <456b17e9620d5118fcca2674b365e0770b1d1fc1.1757332833.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When sorting the block group list for reclaim we are using a block group's
used bytes counter without taking the block group's spinlock, so we can
race with a concurrent task updating it (at btrfs_update_block_group()),
which makes tools like KCSAN unhappy and report a race.

Since the sorting is not strictly needed from a functional perspective
and such races should rarely cause any ordering changes (only load/store
tearing could cause them), not to mention that after the sorting the
ordering may no longer be accurate due to concurrent allocations and
deallocations of extents in a block group, annotate the accesses to the
used counter with data_race() to silence KCSAN and similar tools.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 239cbb01f83f..548483a84466 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1795,7 +1795,14 @@ static int reclaim_bgs_cmp(void *unused, const struct list_head *a,
 	bg1 = list_entry(a, struct btrfs_block_group, bg_list);
 	bg2 = list_entry(b, struct btrfs_block_group, bg_list);
 
-	return bg1->used > bg2->used;
+	/*
+	 * Some other task may be updating the ->used field concurrently, but it
+	 * is not serious if we get a stale value or load/store tearing issues,
+	 * as sorting the list of block groups to reclaim is not critical and an
+	 * occasional imperfect order is ok. So silence KCSAN and avoid the
+	 * overhead of locking or any other synchronization.
+	 */
+	return data_race(bg1->used > bg2->used);
 }
 
 static inline bool btrfs_should_reclaim(const struct btrfs_fs_info *fs_info)
-- 
2.47.2


