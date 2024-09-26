Return-Path: <linux-btrfs+bounces-8246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD65A987056
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 11:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D935286B29
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 09:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EE61AD3FC;
	Thu, 26 Sep 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om4tngvU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A11ACE00
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343211; cv=none; b=cUhUc5KZWImoWqVTfPfCU7Kj+7h/ZV/Nn54DsSFhsfoxC9lTcTpFBdY6/MewzwkBnTEiEbmOWUtHnG2wJTeTZWfyF7dVH0vweyQYy+O/nNToPBCiH5/qQYWuqmLmOqQdUj3v2uuG3E1+5COdpUsvEdJSucNCGNv/bt2KRuxaPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343211; c=relaxed/simple;
	bh=V/SZqRascJ77vL6ehG1hjZCIMectILQwn69vqsidYjY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W1j9wcZfs+C6p09jc/NHGjbV6TNWj+wSNxUKqGFtp5/fBF5h6XtyGSyQtiySoP/ioxlMVW66MKDhTuH6Ck8M1j1yw8YNaP2b7HCoo5twZKWyyZNFswzyTv0T5jWVc83Km3qM+u9MQPY9K1281R/a/LctsnGnhbgdLQK8usKZ14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om4tngvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA8CC4CECD
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727343211;
	bh=V/SZqRascJ77vL6ehG1hjZCIMectILQwn69vqsidYjY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=om4tngvUlKxcxRRZINjTJgk5Y/CUFR6XsDRfa1BlGF5WUJoLGzBp5xc/Sg+CPx+/q
	 Q9DVn8T/ZWra3oUhJw8/+vs9YTz13tNoOEJS8hWdMOnsUED5UTWKVtpH1fm+OVDEkZ
	 kHRkAQ+90T1s/XlpYDboBWS4l4G9VFIXy6TJ9nuxKHSyPOgO6CKJ9kPD7j7+9bhm10
	 zEMqRrSfiy93ckrfKvNOynAVW0fnS887sXvB4H7QSsRhe5Gd6iOjMzOj87QJgb+0oM
	 /4lWFrpWh0x+0HMJuVdYLE0PGC9WZB8bLj/LVeGcAxEbAoXtYeD/Nx6FqJ3b42idBq
	 EDie8v8XkvG0Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 6/8] btrfs: remove unnecessary delayed refs locking at btrfs_qgroup_trace_extent()
Date: Thu, 26 Sep 2024 10:33:20 +0100
Message-Id: <6d772cdeeb6f3991578be43a0e0c741694e8b677.1727342969.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727342969.git.fdmanana@suse.com>
References: <cover.1727342969.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to hold the delayed refs spinlock when calling
btrfs_qgroup_trace_extent_nolock() from btrfs_qgroup_trace_extent(), since
it doesn't change anything in delayed refs and it only changes the xarray
used to track qgroup extent records, which is protected by the xarray's
lock.

Holding the lock is only adding unnecessary lock contention with other
tasks that actually need to take the lock to add/remove/change delayed
references. So remove the locking.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 8d000a9d35af..3574af6d25ef 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2021,7 +2021,6 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 	}
 #endif
 
-	lockdep_assert_held(&delayed_refs->lock);
 	trace_btrfs_qgroup_trace_extent(fs_info, record, bytenr);
 
 	xa_lock(&delayed_refs->dirty_extents);
@@ -2160,9 +2159,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	record->num_bytes = num_bytes;
 	record->old_roots = NULL;
 
-	spin_lock(&delayed_refs->lock);
 	ret = btrfs_qgroup_trace_extent_nolock(fs_info, delayed_refs, record, bytenr);
-	spin_unlock(&delayed_refs->lock);
 	if (ret) {
 		/* Clean up if insertion fails or item exists. */
 		xa_release(&delayed_refs->dirty_extents, index);
-- 
2.43.0


