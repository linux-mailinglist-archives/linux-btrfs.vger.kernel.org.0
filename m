Return-Path: <linux-btrfs+bounces-18550-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD91C2C26F
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 14:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0768C4F1AAD
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 13:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698E130DD3C;
	Mon,  3 Nov 2025 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geRvIv5t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B74A26E6F4;
	Mon,  3 Nov 2025 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176911; cv=none; b=nH2xAiM1V2rOh/eh7wOrsfafq/YOeNU3BT23DfH1ibeQae4JRnxJKR+Oq7hZSuvhYxf2l2aw80J5V0oicq/qQf9W8VBMz0yTsZk3y9zD54uXZFymOmP4l22Y3JRLEX2NYnDNf7r+gRlyLjjR6ncpmEpMZv9GcQhxujkLm1DVE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176911; c=relaxed/simple;
	bh=kipPvaFiey0COV9EM0kWVSk7RINlLWVsCFeKU1yW3Sc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FawbAxNSHFdou8lxML78GBfG+NWV5npjw8z1Ft4nHNn/vSwmfLpbzxoxnoq3Q6F/boq193DAvNtxySIy5KhowjxER+7LhSy0YkXRz5dqG+a7VNW3ZPNcpRMMYf4oa+b4pAKE/17YhkKeWH2qLrJ7QkZoCWhk4JZsUNxU9xxuPjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geRvIv5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144D7C4CEE7;
	Mon,  3 Nov 2025 13:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762176911;
	bh=kipPvaFiey0COV9EM0kWVSk7RINlLWVsCFeKU1yW3Sc=;
	h=From:To:Subject:Date:From;
	b=geRvIv5tSUYrwESv0YQwzEYQ3KRXQgaZkPvj4DAePAULw3aryfrRyqrP0v96shMdF
	 JMbBHL2WaWG5NcPu6PqSyVVS/S2m8+YI1dNuNlSVHdJkkp0I8DARUgPim5B53L/aA4
	 Rhd35JbuV4AdPOzXAKv++X/P3/gE0eNd/RPRoaaY1Jv8NrlTwCpEzclk7MttFx8fff
	 mdFu15Qk+BcZd7N7yyKpkZIWxqyZwdpOF5ECdOwem7BgKipU0wXsW8L3yIoTjzwF2q
	 tSJiOqD9b9qFCNHduo/2BUJpw7SLQU+622baMHIPAP5PUNZbMxsRle/7fzJEM6jKwY
	 xF7W7Y8lJqSjQ==
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
Subject: [PATCH v2 00/15] Introduce cached report zones
Date: Mon,  3 Nov 2025 22:31:08 +0900
Message-ID: <20251103133123.645038-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements a cached report zones using information
from the block layer zone write plugs and a new zone condition tracking.
This avoids having to execute slow report zones commands on the device
when for instance mounting file systems, which can significantly speed
things up, especially in setups with multiple SMR HDDs (e.g. a BTRFS
RAID volume).

The first patch improves handling of zone management commands. Patch 2
fixes zone resource updates and the following 3 patches cleanup the zone
code in preparation for introducing cached zone report support.
From patch 6 to 13, cached report zones is implemented and made
available to users with a new ioctl() command.

Finally, patches 14 and 15 introduce the use of cached report zones in
the mount operation of XFS and BTRFS.

These patches are against Jens' for-next tree.

Changes from v1:
 - Move the patch "block: handle zone management operations completions"
   at the beginning of the series and added a Fixes tag.
 - Reworked a little patch 2 as suggested by Bart (error path handling)
 - Added patch 8 as requested by Bart.
 - Added patch 12 as suggested by Bart.
 - Corrected various typos in commit messages and code comments.
 - Added review tags

Damien Le Moal (15):
  block: handle zone management operations completions
  block: freeze queue when updating zone resources
  block: cleanup blkdev_report_zones()
  block: introduce disk_report_zone()
  block: reorganize struct blk_zone_wplug
  block: use zone condition to determine conventional zones
  block: track zone conditions
  block: refactor blkdev_report_zones() code
  block: introduce blkdev_get_zone_info()
  block: introduce blkdev_report_zones_cached()
  block: introduce BLKREPORTZONESV2 ioctl
  block: improve zone_wplugs debugfs attribute output
  block: add zone write plug condition to debugfs zone_wplugs
  btrfs: use blkdev_report_zones_cached()
  xfs: use blkdev_report_zones_cached()

 block/blk-zoned.c                 | 788 +++++++++++++++++++++++-------
 block/blk.h                       |  14 +
 block/ioctl.c                     |   1 +
 drivers/block/null_blk/null_blk.h |   3 +-
 drivers/block/null_blk/zoned.c    |   4 +-
 drivers/block/ublk_drv.c          |   4 +-
 drivers/block/virtio_blk.c        |  11 +-
 drivers/block/zloop.c             |   4 +-
 drivers/md/dm-zone.c              |  54 +-
 drivers/md/dm.h                   |   3 +-
 drivers/nvme/host/core.c          |   5 +-
 drivers/nvme/host/multipath.c     |   4 +-
 drivers/nvme/host/nvme.h          |   2 +-
 drivers/nvme/host/zns.c           |  10 +-
 drivers/scsi/sd.h                 |   2 +-
 drivers/scsi/sd_zbc.c             |  17 +-
 fs/btrfs/zoned.c                  |  11 +-
 fs/xfs/xfs_zone_alloc.c           |   2 +-
 include/linux/blkdev.h            |  49 +-
 include/linux/device-mapper.h     |  10 +-
 include/uapi/linux/blkzoned.h     |  41 +-
 include/uapi/linux/fs.h           |   2 +-
 22 files changed, 767 insertions(+), 274 deletions(-)


base-commit: ba6a8208cc205c6545c610b5863ea89466fc486a
-- 
2.51.0


