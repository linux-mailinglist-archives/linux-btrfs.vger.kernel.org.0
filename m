Return-Path: <linux-btrfs+bounces-5103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE8B8C9AA7
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 11:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F65B221BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B834C635;
	Mon, 20 May 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezL1Q+Yk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588DA495E5
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198417; cv=none; b=XUCLtTu1NMiHJ2lne2Zi+ATXM+b0eDFz9pcSmjJcAxTDXfHARBn7BjUUbNRDeYSS8rAipj1VJdiCvXQcevEEUK8jBPZQq1PRsqmx8Mpj9rzVOCQUj7WqraS2URpH5EtNS3VQ7YddpwkCNdpzf6gem683eI/nxT/8jX78Qcm2TOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198417; c=relaxed/simple;
	bh=+z234Z8najshoAT+qi5q9wi413uNu1bbahMvaMJnnRI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JdhVqEmx0AfNhuS+yxYGmzg3wWp+TswK12zZeXzDcta7U1U7inRPlS3KPgR4mhL8cmhoOgBYpOKdh7SggMJV3H2kfu6CVFrqU+VGUVfDrhtFzsibawskr5fvn578kP2enWo2mv7PMxlLTWtxRE44xwUp1F/zyoS21SzcqHoVa0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezL1Q+Yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F66C4AF07
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716198416;
	bh=+z234Z8najshoAT+qi5q9wi413uNu1bbahMvaMJnnRI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ezL1Q+Ykydf2rYmHq/iC3QHUcSyV5XBzNiTD8ZHylxZ/DdcyVUe5i46VlFPvNGjzD
	 AC44G8LVAvjL+UBUiCiJxXxG/TaGQqVuKLPdBp8Ygkt3/hM7U2Q1BVa6qwxbA2L5aF
	 ocl+FI5T7h7I/1nXEXmgSoQB7xclGs5Pam3SvyQy/moIqzaowrrB8w4x4Ofvl7jXxm
	 9L1SrhL/hMKs9b32p9P3+20kckdZu7Ixio+Qhk24R07Ft0Zc8T7anFHlDxdgn/bN4M
	 bhB+OvYPYaBryhvdjAoZtQJcxF3YcIWdzoWu0+1Zkite8Kf6JTzLeOl2l2roDXPJwJ
	 zoDV7hg7Q1ePQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 2/6] btrfs: make btrfs_finish_ordered_extent() return void
Date: Mon, 20 May 2024 10:46:47 +0100
Message-Id: <a3bb4237ce22fcc7d56b4eb9d22d077df566eed3.1716053516.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716053516.git.fdmanana@suse.com>
References: <cover.1716053516.git.fdmanana@suse.com>
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
index 7d175d10a6d0..16f9ddd2831c 100644
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


