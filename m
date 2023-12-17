Return-Path: <linux-btrfs+bounces-996-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4843B81607C
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Dec 2023 17:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC521B223A3
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Dec 2023 16:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4EA46536;
	Sun, 17 Dec 2023 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WLAw68Jl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608DA44C99;
	Sun, 17 Dec 2023 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=zthoML/uhpAs1hPvD/fh13swKppKnu7l7FTtACwvAxE=; b=WLAw68JlEwbNFdIQ2xyIscfsps
	CWgTZVnaIvQlWzz06TQgw+PjcgppWNTQHeaP9heFZI/N1X6bRYNdiDnf2HKguxboWjjhX0XmDtIjK
	Cfq3ixlcQVdCDmt8I6cHcZgfNphEKcI3/sVh25Wwnsz+IwF9FU+0k1hDj6q3C9Vdeme9/K9trDDqA
	V71hDtLh1lZVVWiDsNBiBlb8sihMmf06SvtbxGjuggJOMDbBBTxgpx44hH1dWWFQwYuZk0pKkO4pD
	z9I6Ggwwd4Bgt8+xX5UuHNQ6CBWHRRa61Hf3XU+/hpP1RR7WYzVz20j0J0IOo1IjoDdlSGlIKer06
	t4lIRgSQ==;
Received: from [88.128.92.84] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEuOw-0088L9-1x;
	Sun, 17 Dec 2023 16:54:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: remove support for the host aware zoned model
Date: Sun, 17 Dec 2023 17:53:54 +0100
Message-Id: <20231217165359.604246-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

hen zones were first added the SCSI and ATA specs, two different
models were supported (in addition to the drive managed one that
is invisible to the host):

 - host managed where non-conventional zones there is strict requirement
   to write at the write pointer, or else an error is returned
 - host aware where a write point is maintained if writes always happen
   at it, otherwise it is left in an under-defined state and the
   sequential write preferred zones behave like conventional zones
   (probably very badly performing ones, though)

Not surprisingly this lukewarm model didn't prove to be very useful and
was finally removed from the ZBC and SBC specs (NVMe never implemented
it).  Due to to the easily disappearing write pointer host software
could never rely on the write pointer to actually be useful for say
recovery.

Fortunately only a few HDD prototypes shipped using this model which
never made it to mass production.  Drop the support before it is too
late.  Note that any such host aware prototype HDD can still be used
with Linux as we'll now treat it as a conventional HDD.

Diffstat:
 block/blk-settings.c           |   83 +++++------------------------------------
 block/blk-sysfs.c              |    9 ----
 block/blk-zoned.c              |    3 -
 block/blk.h                    |    2 
 block/partitions/core.c        |   12 -----
 drivers/block/null_blk/zoned.c |    2 
 drivers/block/ublk_drv.c       |    2 
 drivers/block/virtio_blk.c     |   78 +++++++++++---------------------------
 drivers/md/dm-kcopyd.c         |    2 
 drivers/md/dm-table.c          |   45 +++++++++-------------
 drivers/md/dm-zoned-metadata.c |    7 +--
 drivers/md/dm-zoned-target.c   |    4 -
 drivers/nvme/host/zns.c        |    2 
 drivers/scsi/scsi_debug.c      |   27 ++++++-------
 drivers/scsi/sd.c              |   50 +++++++++++-------------
 drivers/scsi/sd_zbc.c          |   16 -------
 fs/btrfs/zoned.c               |   23 +----------
 fs/btrfs/zoned.h               |    2 
 fs/f2fs/data.c                 |    2 
 fs/f2fs/super.c                |   17 +++-----
 include/linux/blkdev.h         |   38 +-----------------
 21 files changed, 124 insertions(+), 302 deletions(-)

