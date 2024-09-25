Return-Path: <linux-btrfs+bounces-8222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55192985762
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 12:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E54C4B228E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6C6189F58;
	Wed, 25 Sep 2024 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoOBJkim"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B015C136
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261441; cv=none; b=j8js6xqSxkuEk8a0pU+k7PmNcvT6LLUqyOqodiF3/NVvWPQ7aQUc2PLTPUSa+YE10zb536HGQvnMGSwsmkZkr4sTQohVMcZF9O2F4kUTQKEk025CsF/9u3/KtHXVZHAQt6lXiLoqVu6kfr8Cj8iTLjhetEdI/Vd9mJxUzLCE27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261441; c=relaxed/simple;
	bh=SNRkobYYDFwF59NZNWk1eSJhH+nLW/FMHtpQrZVTDQk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kl/Y6Mk/pmK82skrMv2ZRsu+BZnzaUUv53kGVskm6yvc+gKnfPST6vz9oCZ1pOClExkiQxRbY79UrIlTnC9ubYS3qAmm8V9+eqSGMRog/1eYXkMJKqmrjKQsL3HqQJ0C7gwiKw9h6npd3w6kAYlYR8gkWB+1k/nv1+BxEOjRsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoOBJkim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0736AC4CEC3
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 10:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727261440;
	bh=SNRkobYYDFwF59NZNWk1eSJhH+nLW/FMHtpQrZVTDQk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RoOBJkimtL9qsXFeM8gqGZb+9jQuDgyM3G6jSlJrHzVaV1pc/kPFHp42L0mRxH6OB
	 ZQ+05XFFhqdUC5ug8yCXVfNu9FIDRlMyBA3X5906EgnJg+JvewCWIZvXbuY16/shsa
	 qA9dnRyYUXnU7F5zeQAYqma0fUqpNwl5yQkH3UYihVuDrT7iA2hrZiV5I7nrDm6eU3
	 TmFE3XJcs6ACpR1TgbGHZnnizvCbASLG2gcLHET5jAD2i6VlO7puGLEAzUJia3UWS9
	 zTQVYSspkQYnSkoFC2Rh74jQqUtIaeM2gcYkpZSQaveprjpSeNVMobkNyfLmr/NsOs
	 ZGoLY5Rpce4zg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: always use delayed_refs local variable at btrfs_qgroup_trace_extent()
Date: Wed, 25 Sep 2024 11:50:29 +0100
Message-Id: <85c1544f70dc783d68353cc83697ef432facf6c2.1727261112.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727261112.git.fdmanana@suse.com>
References: <cover.1727261112.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of dereferecing the delayed refs from the transaction multiple
times, store it early in the local variable and then always use the
variable.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index c847b3223e7f..ce7641fdc900 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2130,7 +2130,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_qgroup_extent_record *record;
-	struct btrfs_delayed_ref_root *delayed_refs;
+	struct btrfs_delayed_ref_root *delayed_refs = &trans->transaction->delayed_refs;
 	const unsigned long index = (bytenr >> fs_info->sectorsize_bits);
 	int ret;
 
@@ -2140,12 +2140,11 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	if (!record)
 		return -ENOMEM;
 
-	if (xa_reserve(&trans->transaction->delayed_refs.dirty_extents, index, GFP_NOFS)) {
+	if (xa_reserve(&delayed_refs->dirty_extents, index, GFP_NOFS)) {
 		kfree(record);
 		return -ENOMEM;
 	}
 
-	delayed_refs = &trans->transaction->delayed_refs;
 	record->num_bytes = num_bytes;
 	record->old_roots = NULL;
 
-- 
2.43.0


