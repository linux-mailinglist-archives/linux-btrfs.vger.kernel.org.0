Return-Path: <linux-btrfs+bounces-19926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EE6CD3A13
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 03:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5211301FC38
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 02:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568561A9FA0;
	Sun, 21 Dec 2025 02:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBP4Gzuk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6D1D618A
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 02:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766285567; cv=none; b=aNUZFXCk+i6dwyhusKygBuNzCzWKotXZ6eWdtCm4HzmMrRvx18F0Metz54hRlxdluJ5I4PiERDdxaZZgAtc8bYBymhDkjGzmCIUXHJJV1AJyPbVdnpwg7XhcvUsyEUatbJiCWqai5a5POp7jDSxcZKgnOhlkbSYiKhL4sYZIzqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766285567; c=relaxed/simple;
	bh=wydG2tqDwgj6QuZW7DY/zuZo5VojiZ1uNvXaK/0N8JE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nFg4jn+7ptLQ6mSs71xswJ1uGwcvrLGsXF79ralHqVAVKb6u/TtpG0TY1EA4z5FcDtDv5Jcz4Og9ENh1uW7XpMJiA16KEGFpkQUmNB9UFzxg6bRj4Xh7X6J2V8hMjSd+dxf6CMhB9xmhneRYs0KJBZMDeIJH8Gs15HMXiXFK9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dBP4Gzuk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766285564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gck6PTahdn31ztY8BjIzxEwMrGwEobhk2pDC85pgr+M=;
	b=dBP4GzukA6We+d8eJuiC8A37+b4mZbpn6dg/jAlHnZ1mOw2J8mNwxsy1uCwivA5O57hme+
	Wh41cGXc51SKrMf34BAmLi5seboCoxNI/JfXvrqVvFAMaWbhq7iKJlaeFmk/gu9SkDpeUe
	RASleTcHWRCHU166KSY+4n06u5B3jLU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-T_VNJ7IVO7K6lHxJxxN1RQ-1; Sat,
 20 Dec 2025 21:52:41 -0500
X-MC-Unique: T_VNJ7IVO7K6lHxJxxN1RQ-1
X-Mimecast-MFC-AGG-ID: T_VNJ7IVO7K6lHxJxxN1RQ_1766285559
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 478D41956050;
	Sun, 21 Dec 2025 02:52:39 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8801F180049F;
	Sun, 21 Dec 2025 02:52:34 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Satya Tangirala <satyat@google.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-raid@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 00/17] bio cleanups
Date: Sun, 21 Dec 2025 03:52:15 +0100
Message-ID: <20251221025233.87087-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello,

we are not quite careful enough about setting bio->bi_status in all
places (see BACKGROUND below).  This patch queue tries to fix this by
systematically eliminating the direct assignments to bi_status sprinkled
all throughout the code.  Please comment.

The patches are currently still based on v6.18.

GIT tree:
https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/log/?h=bio-cleanups

The first version of this patch queue is avaliable here:
https://lore.kernel.org/linux-block/20251208121020.1780402-1-agruenba@redhat.com/

With these changes, only a few direct assignments to bio->bi_status
remain, in BTRFS and in MD, and SOME OF THOSE MAY BE UNSAFE.  Could the
maintainers of those subsystems please have a look?

Once the remaining direct assignments to bi_status are gone, we may want
to think about "write protecting" bi_status to prevent unintended new
direct assignments from creeping back in.


BACKGROUND

'struct bio' objects start out with their bi_status field initialized to
BLK_STS_OK (0).  When the bio completes, that field needs to be left
unchanged in case of success, and set to a BLK_STS_* error code
otherwise.

This is important when bios are chained (bio_chain()) because then,
multiple execution contexts will race updating the same bi_status field.
When an execution context resets bi_status to BLK_STS_OK (0) during bio
completion, this could hide the error code of the adjacent bio in the
chain.

When more than a single bio fails in a chain, we know that the resulting
bi_status will not be BLK_STS_OK, but we don't know which of the status
error codes will survive.


CRYPTO FALLBACK (SATYA TANGIRALA?)

Related to chained bios but unrelated to setting bio->bi_status,
blk_crypto_fallback_encrypt_bio() in block/blk-crypto-fallback.c swaps
out bi_private and bi_end_io and reuses the same bio for downcalls, then
restores those fields in blk_crypto_fallback_decrypt_endio() before
calling bio_endio() again on the same bio.  This will at the very least
break with chained bios because it will mess up __bi_remaining.


Thanks,
Andreas

Andreas Gruenbacher (17):
  xfs: don't clobber bi_status in xfs_zone_alloc_and_submit
  bio: rename bio_chain arguments
  bio: use bio_io_error more often
  bio: add bio_set_status
  bio: use bio_set_status for BLK_STS_* status codes
  bio: do not check bio->bi_status before assigning to it
  block: consecutive blk_status_t error codes
  block: fix blk_status_to_{errno,str} inconsistency
  block: turn blk_errors array into a macro
  block: optimize blk_status <=> errno conversion
  bio: bio_set_status from non-zero errno
  bio: do not check bio->bi_status before assigning to it (part 2)
  xfs: use bio_set_status in xfs_zone_alloc_and_submit
  bio: switch to bio_set_status in submit_bio_noacct
  bio: never set bi_status to BLK_STS_OK during completion
  bio: never set bi_status to BLK_STS_OK during completion (part 2)
  bio: add bio_endio_status

 block/bio-integrity-auto.c       |   3 +-
 block/bio.c                      |  25 +++----
 block/blk-core.c                 | 123 ++++++++++++++++---------------
 block/blk-crypto-fallback.c      |  22 +++---
 block/blk-crypto-internal.h      |   2 +-
 block/blk-crypto.c               |   4 +-
 block/blk-merge.c                |   6 +-
 block/blk-mq.c                   |  10 +--
 block/fops.c                     |   6 +-
 block/t10-pi.c                   |   2 +-
 drivers/block/aoe/aoecmd.c       |   8 +-
 drivers/block/aoe/aoedev.c       |   2 +-
 drivers/block/drbd/drbd_int.h    |   3 +-
 drivers/block/drbd/drbd_req.c    |   7 +-
 drivers/block/ps3vram.c          |   3 +-
 drivers/block/zram/zram_drv.c    |   4 +-
 drivers/md/bcache/bcache.h       |   3 +-
 drivers/md/bcache/request.c      |   8 +-
 drivers/md/dm-cache-target.c     |   9 ++-
 drivers/md/dm-ebs-target.c       |   2 +-
 drivers/md/dm-flakey.c           |   2 +-
 drivers/md/dm-integrity.c        |  34 ++++-----
 drivers/md/dm-mpath.c            |   6 +-
 drivers/md/dm-pcache/dm_pcache.c |   3 +-
 drivers/md/dm-raid1.c            |   7 +-
 drivers/md/dm-thin.c             |   7 +-
 drivers/md/dm-vdo/data-vio.c     |   3 +-
 drivers/md/dm-verity-target.c    |   2 +-
 drivers/md/dm-writecache.c       |   7 +-
 drivers/md/dm-zoned-target.c     |   3 +-
 drivers/md/dm.c                  |   4 +-
 drivers/md/md.c                  |   8 +-
 drivers/md/raid1-10.c            |   3 +-
 drivers/md/raid1.c               |   2 +-
 drivers/md/raid10.c              |  20 +++--
 drivers/md/raid5.c               |   4 +-
 drivers/nvdimm/btt.c             |   4 +-
 drivers/nvdimm/pmem.c            |   4 +-
 fs/btrfs/bio.c                   |   8 +-
 fs/btrfs/direct-io.c             |   2 +-
 fs/btrfs/raid56.c                |   6 +-
 fs/crypto/bio.c                  |   2 +-
 fs/erofs/fileio.c                |   4 +-
 fs/erofs/fscache.c               |   8 +-
 fs/f2fs/data.c                   |   6 +-
 fs/f2fs/segment.c                |   3 +-
 fs/iomap/ioend.c                 |   3 +-
 fs/verity/verify.c               |   2 +-
 fs/xfs/xfs_aops.c                |   3 +-
 fs/xfs/xfs_zone_alloc.c          |   4 +-
 include/linux/bio.h              |  28 ++++++-
 include/linux/blk_types.h        |   2 +-
 include/linux/blkdev.h           |  18 ++++-
 53 files changed, 236 insertions(+), 238 deletions(-)

-- 
2.52.0


