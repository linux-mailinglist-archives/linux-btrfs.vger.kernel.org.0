Return-Path: <linux-btrfs+bounces-18622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7926C2ED11
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 02:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFD0434D308
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 01:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32E1261B9F;
	Tue,  4 Nov 2025 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLfzZ7iA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9341F37D3;
	Tue,  4 Nov 2025 01:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220179; cv=none; b=KcASzFf0VG9OLxkvvRjyaaRmPgzWgo+Ogmmbc+J/f6mkLPPZzeIjjeEgivik1C9uUXGHNfw7qjaMQE88yswiIoAiMdQ7Wl31EGcuHT/5ln49JTu2lxkwu893gNAqKdo39TZ2rj+MPJE8Axh9AsYyvb+/9idtcLoGGyrKI6elwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220179; c=relaxed/simple;
	bh=lM97F0v5u7tfzv4+N5DwIFhzxaeVeb7f7Oe6yZJKG98=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDpy90Ja0gcQeQCSzriepJ9blYLvyN3aWBP0O/7MIWE5AEBFvo0e0Qi283UnsFQKTmN8+WMtJxlsO5RvgPbLFsLnQZf5ZqNHNKOtBmTs+nK/odx7s7UzHrJOyPKyMinIkRt1tNO6je2wbA+wlWFPzXI9LsL8ieajRewjPrL0n4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLfzZ7iA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40052C4CEE7;
	Tue,  4 Nov 2025 01:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220178;
	bh=lM97F0v5u7tfzv4+N5DwIFhzxaeVeb7f7Oe6yZJKG98=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KLfzZ7iAhUUxgx+ZouN+LaA+t1fyTUZ8WBjFe4KCDPCXjki/eom+RJ/zdYd59XR40
	 7MJLGiBw3Nd9fHZt4GARXkiXkeiQnzjmpmrfuPoG1GgTWHkFhyeoF+toNAX9od+iot
	 2C83IrodQsRB0MTpgDsQsXecUwo/a8TFtXuReVSwmZuAsBVG2YPHl4AqkFwg1haFYF
	 9rB9OJPxbbaMywPbkqxtTvm93kcHPXCb0WGtnKY8TCKeCLfhYV0DSIpC6wESvpa068
	 9PhkbJGeLLXmr8+PgfKGnxMAiazurD/ChKjJCW3BSjjbKTWDAp1M12gR0RBUd6P41y
	 tMximekj6slNg==
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
Subject: [PATCH v3 15/15] xfs: use blkdev_report_zones_cached()
Date: Tue,  4 Nov 2025 10:31:47 +0900
Message-ID: <20251104013147.913802-16-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104013147.913802-1-dlemoal@kernel.org>
References: <20251104013147.913802-1-dlemoal@kernel.org>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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


