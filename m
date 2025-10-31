Return-Path: <linux-btrfs+bounces-18448-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83536C2361D
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 07:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5230D1A639B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 06:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19553191BE;
	Fri, 31 Oct 2025 06:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUBaBZX7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D43161B2;
	Fri, 31 Oct 2025 06:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891438; cv=none; b=ppTn6i67lc8JQTYl42ZnYmwD4oN8/GcbXXAnKkzYEmWcVpfzZjINOcvyfCywYFzd7Xznvw28SRWlsFLFi0r4CAWinnQaWluqnY6uVp1z8psl2w9CS09gKArDmn5p+Q3RFTaZqysW/SFo0B+/1w4PU2CadDsKSTf3rHv/H4evkr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891438; c=relaxed/simple;
	bh=FbZy3KaSfTVCZMhW0kFyGoAA/ywDZmHfYKpfi/XoXsQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXYzH+kc7dZmJZnEj60oe0gGMzeyvK2anAsz5QYogpOGfXP+1ss/+gAZvE/DYFex3pBlyt6eOMaYq9kxM0v0DQ9JKuy0RrG02y6vIENJcJjlnJP8ve2bsVp2VAUxDQ1/AJYR4joU/IRdfU9QpZdSADkm7WS+ezHW4BAJu7Lh+HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUBaBZX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8739EC4CEF1;
	Fri, 31 Oct 2025 06:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891438;
	bh=FbZy3KaSfTVCZMhW0kFyGoAA/ywDZmHfYKpfi/XoXsQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HUBaBZX7tYnu6KkCB5R0b9DlxmnO/MoztbBUmGNjqSjyKLPt+vAClDxB8WNMNEFvE
	 /B1vkhN6grqHOrduFlQ1e+Yj0QEmGheSLwGzHhcvd3EP3jhnE2w5I6DoZFcWHsz+CH
	 6fMrVL2vN1DOCPi1+0Sd0aYu3NN0poaEPObu7L7R8hdpgld5WpqSrvX7UI7rqZ148y
	 LTA0G0ar77yPWwLfrenRx92uPJa6tbaU7Hl2hhxz8nceW13hlce2YAnV0i4Laxygk1
	 6SSJP9QijYQE07qCN/RHAPreEV7IaaGWmenJMpxzwkjr924OXKoasEvHuLI4cnyFUA
	 Fn6G0BGaTsztQ==
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
Subject: [PATCH 13/13] xfs: use blkdev_report_zones_cached()
Date: Fri, 31 Oct 2025 15:13:07 +0900
Message-ID: <20251031061307.185513-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031061307.185513-1-dlemoal@kernel.org>
References: <20251031061307.185513-1-dlemoal@kernel.org>
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


