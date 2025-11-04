Return-Path: <linux-btrfs+bounces-18703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823ACC33124
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 22:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05B41891F1B
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 21:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7BD3054CE;
	Tue,  4 Nov 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMXjp4sP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398673043D6;
	Tue,  4 Nov 2025 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291628; cv=none; b=dgA2DjV7j7dM3//8o44xIkqCmbnHBpzcRAfBeFqaf4P+rFh3YQBHdA+2M8AtmDNkmTBaMeszLsMcDI1xWqlpBh9LIh1H2B/jC2aPaAl9LDyAFzq7B7mZfVGl+f70kIK5L8Bg8pGB6sRItQ0yFt2PLA0yb6KH8pg01XwImeM97qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291628; c=relaxed/simple;
	bh=ZQitxpNbla8eatdIt11qa+C2wAmNOTfTTPJx07AuheM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAAVVqJBL4YK2Lez8DdXWjPfhdR7XeL1JTW/CB9315vV+74GJaiH5yhsEr5wvJZR88EcC3NkMV+i0heZYg6RW15qOx3YMIKONOELtNNwRCZZ8rkxawmgvepp2Bj34UCtEmjgp/mKB1uyEzcd4/byMgKcNN/L/RPE0y0mMlC3X/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMXjp4sP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEE0C16AAE;
	Tue,  4 Nov 2025 21:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762291628;
	bh=ZQitxpNbla8eatdIt11qa+C2wAmNOTfTTPJx07AuheM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sMXjp4sPvYyhvfNDO+HaY+mz76FAj1m1xRua75qET13g6hbvwAUMi1sTxX6/xJ1Py
	 2Xmc6XOrcPWCN7M/UQPpE3+nWvYzXhTVyZojCFhLRczFrRy12Pp8oWmxiB7Yu/kR3b
	 xPcJzh1q2XwtJACOz0UmJq0HOezj6SW7KDA4DtfL8uIw9OL2YRFXBx860Se79uZZtS
	 zqAIwtyfuC4vDKyv6DMg+1gutR68lcqCHLTvcyAyy1kGyGUnQQ9Zz/DCFQZ8F8ISvC
	 dGt7p6TpMRnXI1YY+6RkeZM3ZONSrpzk8IvSD5yJXrwF3A+HfGWkM46G74s9GuEz2r
	 H1OjBBMrQ4cGw==
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
Subject: [PATCH v4 15/15] xfs: use blkdev_report_zones_cached()
Date: Wed,  5 Nov 2025 06:22:49 +0900
Message-ID: <20251104212249.1075412-16-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104212249.1075412-1-dlemoal@kernel.org>
References: <20251104212249.1075412-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify xfs_mount_zones() to replace the call to blkdev_report_zones()
with blkdev_report_zones_cached() to speed-up mount operations.
Since this causes xfs_zone_validate_seq() to see zones with the
BLK_ZONE_COND_ACTIVE condition, this function is also modified to acept
this condition as valid.

With this change, mounting a freshly formatted large capacity (30 TB)
SMR HDD completes under 2s compared to over 4.7s before.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 fs/xfs/libxfs/xfs_zones.c | 1 +
 fs/xfs/xfs_zone_alloc.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_zones.c b/fs/xfs/libxfs/xfs_zones.c
index b0791a71931c..b40f71f878b5 100644
--- a/fs/xfs/libxfs/xfs_zones.c
+++ b/fs/xfs/libxfs/xfs_zones.c
@@ -95,6 +95,7 @@ xfs_zone_validate_seq(
 	case BLK_ZONE_COND_IMP_OPEN:
 	case BLK_ZONE_COND_EXP_OPEN:
 	case BLK_ZONE_COND_CLOSED:
+	case BLK_ZONE_COND_ACTIVE:
 		return xfs_zone_validate_wp(zone, rtg, write_pointer);
 	case BLK_ZONE_COND_FULL:
 		return xfs_zone_validate_full(zone, rtg, write_pointer);
diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index 040402240807..9c8587622692 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -1239,7 +1239,7 @@ xfs_mount_zones(
 	trace_xfs_zones_mount(mp);
 
 	if (bdev_is_zoned(bt->bt_bdev)) {
-		error = blkdev_report_zones(bt->bt_bdev,
+		error = blkdev_report_zones_cached(bt->bt_bdev,
 				XFS_FSB_TO_BB(mp, mp->m_sb.sb_rtstart),
 				mp->m_sb.sb_rgcount, xfs_get_zone_info_cb, &iz);
 		if (error < 0)
-- 
2.51.0


