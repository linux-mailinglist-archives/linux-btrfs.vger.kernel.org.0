Return-Path: <linux-btrfs+bounces-18565-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5CDC2C23C
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 14:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF4218997DD
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4B23164CE;
	Mon,  3 Nov 2025 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWF43w5T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D13126C8;
	Mon,  3 Nov 2025 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176944; cv=none; b=U0H1C36bCqB9wsohzJUISiwiIHRzIbjslzGiez48jCICssMGMyy8tSeNkyW7fYrn0V+FshMRJmVHHM5qSxQfdrRHuSPE6roUkEe3SpSLbM7mEE5tXyCAHNDPXqH/t+qG262nhj9Pg/xx1vdrseyaNe7IlMT6O9G43jpbC5bsg4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176944; c=relaxed/simple;
	bh=71ngn76yrYFjaxkK05PGAxZ9HfO52W4Ba3k1t35Su6U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtxNDAtrNVZcxPUFBi4CsdIIzUysuYLXJVuhfQ58VVmpYzwL0PGJgZGR157tOorEAW14lZhUye/iRNp7O7FQyP3b/5WoRsjjqrfMflLH8G+fPsbfhfwzIomdkAzeBnjg4FKHkyOmWiZ/N7KY5QkIACovUk2fDqWYQNHgL8jw0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWF43w5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1DDC4CEE7;
	Mon,  3 Nov 2025 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762176944;
	bh=71ngn76yrYFjaxkK05PGAxZ9HfO52W4Ba3k1t35Su6U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OWF43w5ThLkGT6v8kuvqbmh2kuLm4dhel6BuA2De50zPhfxBt3b40WdtyeO2YuLMY
	 qfKSeQUvMgCQS+3ovwrocalAvstvwjsBe+5Bn5gd7Cct5u5RHVVjvIaynHq8t7/DyU
	 sqjOVE0/LZ9N9f6c1FrLMbMIZ3+b/Bo/ow5rOuNuc5Klmnukp+HZFLfEolCbR4mTjO
	 3tpKfeHk0Ue348ibeIeiP8iCbFrl6F6mur5+lHjXdIsSPpLYcjf0WPzv5l5LjRMhzc
	 VTUGODYLFdR++42ScmSIx8g+qb4Ty0s40utpMJg5Wx8Yc0Od5k5915BNDrs/TBcg5S
	 oEqHL3bOcNXRg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v2 15/15] xfs: use blkdev_report_zones_cached()
Date: Mon,  3 Nov 2025 22:31:23 +0900
Message-ID: <20251103133123.645038-16-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103133123.645038-1-dlemoal@kernel.org>
References: <20251103133123.645038-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify xfs_mount_zones() to replace the call to blkdev_report_zones()
with blkdev_report_zones_cached() to speed-up mount operations.

With this change, mounting a freshly formatted large capacity (30 TB)
SMR HDD completes under 2s compared to over 4.7s before.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_zone_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index 23cdab4515bb..8d819bc134cd 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -1231,7 +1231,7 @@ xfs_mount_zones(
 	trace_xfs_zones_mount(mp);
 
 	if (bdev_is_zoned(bt->bt_bdev)) {
-		error = blkdev_report_zones(bt->bt_bdev,
+		error = blkdev_report_zones_cached(bt->bt_bdev,
 				XFS_FSB_TO_BB(mp, mp->m_sb.sb_rtstart),
 				mp->m_sb.sb_rgcount, xfs_get_zone_info_cb, &iz);
 		if (error < 0)
-- 
2.51.0


