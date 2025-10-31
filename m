Return-Path: <linux-btrfs+bounces-18435-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D37C23554
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 07:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563D73A6E6D
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 06:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C81E2F3C1F;
	Fri, 31 Oct 2025 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADhIOAk3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FD25BEE8;
	Fri, 31 Oct 2025 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891415; cv=none; b=LaBFpjhKguE2A7uSBEb4dVx8sSL4SfWimh3hbf41UtSkpZ2JTOxSjJpVzMbw6XYblB3oRCmL7WBL2NzqY4DLfziEZyibXUQFJm/GW2ZGJ0i6jDty6xpWBi4tSmF1SLcqk19TpEIeMDq/yNxD2T7N4u3AquAoa8igtVXDgLPUf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891415; c=relaxed/simple;
	bh=7GvVW4uZiDm+Tw9/lHA4zIrauzC8lt+7kjJjVl6Nmh0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lQ/BPajWOkDK/ge6KHINq8yw2dgCldLqsRNblszWEBicRFb2IVcuOImsbVOZRgKFx7f/KMM9BmPiNLxzOhT4d15tAWZ1H9ZX85DbU1VV0NyhVJKvBvvmjWiwB/iY9QKSqaR2JW16gaN6o2etSMb4q9LgTQaUJsQL5N27K3aTGjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADhIOAk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E61C4CEF1;
	Fri, 31 Oct 2025 06:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891415;
	bh=7GvVW4uZiDm+Tw9/lHA4zIrauzC8lt+7kjJjVl6Nmh0=;
	h=From:To:Subject:Date:From;
	b=ADhIOAk3iHBYRPIDhHIJjRfXk6JxkMJw0eZF/SzWIlcPcsZ/YgeHV7UISZCt8MENk
	 0PVhOU+HjBCos0FR0+6Z177Q9VZXrZNnTQIjCRjlFC/GVA+nn2MD8jEuCELMCqDzvY
	 3tRDqADSx1LiUZqU7vtIM14dYrOmKXEeHG9fsPamPXCs7jcGh3Tpv8jxSltWtfGfvK
	 LJNHu2zMa18ez6uDTPDK8WaANNs7ZmsS1hBqyjihnKyJ5juo9YrUwAGd8+H8YtDT3f
	 R44DBY1xYY8Trh2ZqwXdFMNbc/7UCDpfoCXvNZjS7z7PChUkOdXN6TpYYlsZLE/TgQ
	 bJjJOFxVLu+vw==
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
Subject: [PATCH 00/13] Introduce cached report zones
Date: Fri, 31 Oct 2025 15:12:54 +0900
Message-ID: <20251031061307.185513-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch series implements a cached report zones using information from
the block layer zone write plugs and a new zone condition tracking. This
avoids having to execute slow report zones commands on the device when
for instance mounting file systems, which can significantly speed things
up, especially in setups with multiple SMR HDDs (e.g. a RAID volume).

The first patch improves zone resource updates. The following 3 patches
cleanup and improve handling of zone reports and of other zone
management operations. From patch 5 to 10, cached report zones in
implemented and made available to users with a new ioctl() command.

Finally, patches 12 and 13 introduce the use of cached report zones in
the mount operation of XFS and BTRFS.

These patches are against Jen's for-next tree.

Damien Le Moal (13):
  block: freeze queue when updating zone resources
  block: cleanup blkdev_report_zones()
  block: handle zone management operations completions
  block: introduce disk_report_zone()
  block: reorganize struct blk_zone_wplug
  block: use zone condition to determine conventional zones
  block: track zone conditions
  block: introduce blkdev_get_zone_info()
  block: introduce blkdev_report_zones_cached()
  block: introduce BLKREPORTZONESV2 ioctl
  block: add zone write plug condition to debugfs zone_wplugs
  btrfs: use blkdev_report_zones_cached()
  xfs: use blkdev_report_zones_cached()

 block/blk-zoned.c                 | 762 ++++++++++++++++++++++++------
 block/blk.h                       |  14 +
 block/ioctl.c                     |   1 +
 drivers/block/null_blk/null_blk.h |   3 +-
 drivers/block/null_blk/zoned.c    |   4 +-
 drivers/block/ublk_drv.c          |   4 +-
 drivers/block/virtio_blk.c        |  11 +-
 drivers/block/zloop.c             |   4 +-
 drivers/md/dm-zone.c              |  54 ++-
 drivers/md/dm.h                   |   3 +-
 drivers/nvme/host/core.c          |   5 +-
 drivers/nvme/host/multipath.c     |   4 +-
 drivers/nvme/host/nvme.h          |   2 +-
 drivers/nvme/host/zns.c           |  10 +-
 drivers/scsi/sd.h                 |   2 +-
 drivers/scsi/sd_zbc.c             |  17 +-
 fs/btrfs/zoned.c                  |  11 +-
 fs/xfs/xfs_zone_alloc.c           |   2 +-
 include/linux/blkdev.h            |  44 +-
 include/linux/device-mapper.h     |  10 +-
 include/uapi/linux/blkzoned.h     |  36 +-
 include/uapi/linux/fs.h           |   2 +-
 22 files changed, 746 insertions(+), 259 deletions(-)


base-commit: ba6a8208cc205c6545c610b5863ea89466fc486a
-- 
2.51.0


