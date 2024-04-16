Return-Path: <linux-btrfs+bounces-4309-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A550F8A6BE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 15:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4499E1F228A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E41A12CD8B;
	Tue, 16 Apr 2024 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOWrCPR0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC69112C819
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272904; cv=none; b=VPwekK3DVmYS7tx3fvk89VChvnv18LhcEeqizIA3w8KcVzv6wgVD52A/3T7IW7KTVWXER+s443mmrgsGRhgPgkgbOBA95LUnwTeBiWDpJORA4J9SF5de+YV6ChsxFVZAXN16EULpSx5RXxKX4ptUTjHu9gpBy1gAPOiTU+RKwe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272904; c=relaxed/simple;
	bh=8N8m0mJg6ZSmycLbpiIAXUegEgLeH4iOu2NjKUBuGVI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZMhxVYSdMchG/w3dHa3nXI5oAdq9+ldKaoaxsMNqV+X1GcIH9W64R9DtpFrUSY67RFIW54Xnx7E6o24g1GhopHJu8OeCM9Vxozosc5dAsozS7piTZafhr1IaZlUCVPuCPmBfcDjed7Qi5NqRmHsWYcsvOuBlzmXIwMoUYZ+JV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOWrCPR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B931AC2BD10
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713272904;
	bh=8N8m0mJg6ZSmycLbpiIAXUegEgLeH4iOu2NjKUBuGVI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JOWrCPR08JBwe1+VrPVHYY65fcNO2CFq4Win4+mwthhKuow7OgBD602L9fDcE8am4
	 UOd1Ev2dFD60Co5VwkW2fhWfmrpyB9PuigHBvTjJ7qMWTGpi6runl+tG6OTC6lW/XE
	 QyOReJLwdLm4s5lFXmIvC2Fq8m2QnSBYHFzupecvWfnc1d807N6/c7IEBXyrjYNM5U
	 qM9ZZnLumEWthKCOwf1SIt5kxrJvkBr+yiQft5lu+5uQYsl8TmeIFstMkqj3Lb3Qdh
	 fWQNLACsSobaizcaxxcPopYw96g2a8CpXD58aaR1NtTS3RxrdTWUO/Lh8VZdFEHY1m
	 Q48oG1i1pylbA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 09/10] btrfs: update comment for btrfs_set_inode_full_sync() about locking
Date: Tue, 16 Apr 2024 14:08:11 +0100
Message-Id: <e49ceb747e0ac3221ab4e486166f640b4f5b44e6.1713267925.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713267925.git.fdmanana@suse.com>
References: <cover.1713267925.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Nowadays we have a lock used to synchronize mmap writes with reflink and
fsync operations (struct btrfs_inode::i_mmap_lock), so update the comment
for btrfs_set_inode_full_sync() to mention that it can also be called
while holding that mmap lock. Besides being a valid alternative to the
inode's VFS lock, we already have the extent map shrinker using that mmap
lock instead.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 9a87ada7fe52..91c994b569f3 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -381,9 +381,11 @@ static inline void btrfs_set_inode_last_sub_trans(struct btrfs_inode *inode)
 }
 
 /*
- * Should be called while holding the inode's VFS lock in exclusive mode or in a
- * context where no one else can access the inode concurrently (during inode
- * creation or when loading an inode from disk).
+ * Should be called while holding the inode's VFS lock in exclusive mode, or
+ * while holding the inode's mmap lock (struct btrfs_inode::i_mmap_lock) in
+ * either shared or exclusive mode, or in a context where no one else can access
+ * the inode concurrently (during inode creation or when loading an inode from
+ * disk).
  */
 static inline void btrfs_set_inode_full_sync(struct btrfs_inode *inode)
 {
-- 
2.43.0


