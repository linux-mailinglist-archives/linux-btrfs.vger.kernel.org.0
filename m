Return-Path: <linux-btrfs+bounces-18607-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4E0C2ECA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 02:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EF314F519B
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 01:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64278219E8D;
	Tue,  4 Nov 2025 01:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huht8O2O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3161EF36C;
	Tue,  4 Nov 2025 01:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220136; cv=none; b=H4+WaaXMNI/OOM27TeAbmdHt49VHovYD5ol9RgiG3upDnbSJcQoIybawFBbyv+EvrzJlX5i7mEviExSDsx2tVUQQDcHEGBGdui5FfA+an/DJxCaXNVrnaF++4qw20GwLdY8a0/g2Tzb5zY5jEk8hTgW1mddJG3f42YALMzCB7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220136; c=relaxed/simple;
	bh=E4sdnP60o+W5GBAMSZaGMY71b2TSCKqPh9HWyY4k1gU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kbGDpfYgKWsBETEybWq29WOemlUNtOBkaaGhNEAydI9P8qipgMphqXj/peIVvFrNEiCTxMpkor2CKw4eEjHdfIdOmMbrSWq845+rZI08jORVgTi6RnYyDjEiC3Wmj5gn0mOXEO+HprkP/DlkVdOhtUATc0+vSMMTWRRSiYRhvlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huht8O2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3352C4CEFD;
	Tue,  4 Nov 2025 01:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220136;
	bh=E4sdnP60o+W5GBAMSZaGMY71b2TSCKqPh9HWyY4k1gU=;
	h=From:To:Subject:Date:From;
	b=huht8O2OLPMAIR6ZU1YuP2gqNEeRsIlg4HuyBjrTfueZW61tSBb54zIMMgC6RJf3R
	 jqDnJq4Kf5YeU0NMuKsAuHVoFeNlT64wwe2mzJgGPw8JqatG9YczOEmIOVIZhh6waI
	 446AhUq6DWAoHBi5Kdz4/cS0YiBebN6gJJfBjR669iZdGcFrTNR/O6dsFcYhpUvl+7
	 08q7wjIytIuLVSUowA6qOKThOW4ofyoiWc6KVJYYCOpUzg282+AHBtV9OhmD8vuUDz
	 jvPAiHtR0xUzEanUb6eDvtLHHaNsNa3w0aeoqU7bXBIeAhw4+hRJtI0VBRLx+i7CeH
	 1UryUzkc7WzHQ==
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
Subject: [PATCH v3 00/15] Introduce cached report zones
Date: Tue,  4 Nov 2025 10:31:32 +0900
Message-ID: <20251104013147.913802-1-dlemoal@kernel.org>
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

Changes from v2:
 - Rebased on the latest block for-next tree
 - Fixed compilation warning (undocumented argument) in patch 4
 - Modified patch 13 to display condition name instead of raw value, as
   suggested by Johannes.
 - Added review tags

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

 block/blk-zoned.c                 | 790 +++++++++++++++++++++++-------
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
 drivers/scsi/sd_zbc.c             |  20 +-
 fs/btrfs/zoned.c                  |  11 +-
 fs/xfs/xfs_zone_alloc.c           |   2 +-
 include/linux/blkdev.h            |  49 +-
 include/linux/device-mapper.h     |  10 +-
 include/uapi/linux/blkzoned.h     |  41 +-
 include/uapi/linux/fs.h           |   2 +-
 22 files changed, 770 insertions(+), 276 deletions(-)


base-commit: 359212b8a23d517d3eb1708d4f28995634afd7d3
-- 
2.51.0


