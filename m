Return-Path: <linux-btrfs+bounces-8221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49602985761
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 12:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8E11F21CCF
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 10:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FE6189F2A;
	Wed, 25 Sep 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qT76ybj7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE681189BB8
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261440; cv=none; b=pU7EUPuap+93M4tKvgP1D2RIB3Nm9eFcs+T0kfj8daTf0y5TftSRo9uz1OTVAhMgX/Kx+poTNSLJqXBVWxF8c/YwmGmOO7xsyRQmCokybDSuQAPogbJTtfZQQgh8sa+85L+A+wtd0p6cRCnIfk9j3z0rrvuUuVDh36IQwarUSR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261440; c=relaxed/simple;
	bh=a0IzNfJLwvrrJbWwwr0HKKOw0RcoZpaH3EShlTJt7Yo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=piIDGo9r3zo2w5Su+imts15r0e/j4aG0FofJsY/sEY+w9nN9GVhdgT9n5PAF1qvqeQSRnMB6TTKE6YzOupNtFPWYj29+fUfAJdfvRcIpcFy1PCh8SZbEkSej9ds86jHaWpkWhX1fO+aphOmM1zaHnhuzDGBf+0QstkzZ7X7qyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qT76ybj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB85C4CECD
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 10:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727261439;
	bh=a0IzNfJLwvrrJbWwwr0HKKOw0RcoZpaH3EShlTJt7Yo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qT76ybj77XPc4J2vKu05xZKd2cAP0HXtUZsKKYdeiduU/FWKnKzf+sGV/Ml3k5nk3
	 r5FVPvkLCUmZwEhgiDn/KR8F2p7e86Od8xfW6Bqs/dMhrPE3ULIk3Rdt/Fy3iYH3TC
	 6iurb63cNXsN1MrTqHxBORgyG0vJXl1DE5OToQXrSJ/7XFEvXWybNevDoXngUBcdDi
	 wxrnYvyTDIwOS41EsK5nyqkXdM437u9sq167C9AQaJsWe2F1IT1iGc/Y7xy17emr7N
	 +RCld6Du+Q2m5sC8x/Hn55TwTWZ9L1OOnvcA/8se1OsEy6PWR4gq+SbfSvW4Kg0HcR
	 G/8ytuqVC0e/w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: remove unnecessary delayed refs locking at btrfs_qgroup_trace_extent()
Date: Wed, 25 Sep 2024 11:50:28 +0100
Message-Id: <9805b109b83260a62df501650d6a37b6576f46bb.1727261112.git.fdmanana@suse.com>
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
index 8f9f2828c46e..c847b3223e7f 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2011,7 +2011,6 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 1;
 
-	lockdep_assert_held(&delayed_refs->lock);
 	trace_btrfs_qgroup_trace_extent(fs_info, record, bytenr);
 
 	xa_lock(&delayed_refs->dirty_extents);
@@ -2150,9 +2149,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
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


