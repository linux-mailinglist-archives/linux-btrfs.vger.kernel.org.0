Return-Path: <linux-btrfs+bounces-19562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D17CAD0CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 13:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8CC53061EB9
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 12:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72C12F28FB;
	Mon,  8 Dec 2025 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2ExzLcj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2703A2D94A1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765195837; cv=none; b=lDP0AarPS8NbkQvSvVIC6bGdisDGCKbxEoLuuFwfkQ2v8Ig4QnXgYTbwzNJIV7iH0Qq7dNxifxeK0EZVhN7U3Kta9ha1Cr1BaZLj55KGbVww16KImE/y1CUi3vzsS01QqqdhbCpM0mmP5xu/4kWZLZp+/1RnGSNBzXLtBlql3uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765195837; c=relaxed/simple;
	bh=S/R/+Uk+LTZcWsw9GFQtjbZ0Vh6QPzpbP3UybfCI9FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=il4LUlO/p99tzQG4v3FH6EsEEjk42eh40YDtdNCNHTKOGG+cLpyvUCp1irFNpYBF9MANrKwCM4OuhLqH2UV+coPOhOO7uohORGYfOBajy5ejFRuLA8kAssFNcMACLCG7MsOyD6jWh3S1AFVTmaXAm5xuJ2Qenl9g2PgGz6lMkZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y2ExzLcj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765195834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I3Ugs4PfXVw3YdaIIC3p55RTQO4ZnhtjaIUa7FSWYKA=;
	b=Y2ExzLcjfndyxUj8Sge46vSmxF5SEDC17WUB11iMvuqD7l1kVW9Ynhzf+rDG9SjknZTpN+
	nk2bMHsFE7oVrzHOw66AoaVH8WBhveq2xL6r8KScm0OM7K0cawiUlgc2yaGZivmU9Kjcmx
	yfohyl9K8y+q2AJ0ExWmHijdY4nL4ro=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-MajWwowAOrG8YikhUpIiYA-1; Mon,
 08 Dec 2025 07:10:28 -0500
X-MC-Unique: MajWwowAOrG8YikhUpIiYA-1
X-Mimecast-MFC-AGG-ID: MajWwowAOrG8YikhUpIiYA_1765195827
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5D1C1956096;
	Mon,  8 Dec 2025 12:10:26 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.34.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E93251955F24;
	Mon,  8 Dec 2025 12:10:21 +0000 (UTC)
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
Subject: [RFC 00/12] bio cleanups
Date: Mon,  8 Dec 2025 12:10:07 +0000
Message-ID: <20251208121020.1780402-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello,

we are not quite careful enough about setting bio->bi_status in all
places (see BACKGROUND below).  This patch queue tries to fix this by
systematically eliminating the direct assignments to bi_status sprinkled
all throughout the code.  Please comment.


The first patch ("bio: rename bio_chain arguments") is an loosely
related cleanup.  The remaining changes are:

- Use bio_io_error() in more places.

- Add a bio_set_errno() helper for setting bi_status based on an errno.
  Use this helper throughout the code.

- Add a bio_set_status() helper for setting bi_status to a blk_status_t
  status code.  Use this helper in places in the code where it's
  necessary, or at least useful without adding any overhead.

And on top of that, we have two more cleanups:

- Add a bio_endio_errno() helper that combines bio_set_errno() and
  bio_endio().

- Add a bio_endio_status() helper that combines bio_set_status() and
  bio_endio().

The patches are currently based on v6.18.

GIT tree:
https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/log/?h=bio-cleanups

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
error codes will win.


CRYPTO FALLBACK (SATYA TANGIRALA?)

Related to chained bios but unrelated to setting bio->bi_status,
blk_crypto_fallback_encrypt_bio() in block/blk-crypto-fallback.c swaps
out bi_private and bi_end_io and reuses the same bio for downcalls, then
restores those fields in blk_crypto_fallback_decrypt_endio() before
calling bio_endio() again on the same bio.  This will at the very least
break with chained bios because it will mess up __bi_remaining.


Thanks,
Andreas

Andreas Gruenbacher (12):
  bio: rename bio_chain arguments
  bio: use bio_io_error more often
  bio: add bio_set_errno
  bio: use bio_set_errno in more places
  bio: add bio_set_status
  bio: don't check target->bi_status on error
  bio: use bio_set_status for BLK_STS_* status codes
  bio: use bio_set_status in some more places
  bio: switch to bio_set_status in submit_bio_noacct
  bio: never set bi_status to BLK_STS_OK during completion
  bio: add bio_endio_errno
  bio: add bio_endio_status

 block/bio-integrity-auto.c       |  3 +--
 block/bio.c                      | 25 ++++++++++++-------------
 block/blk-core.c                 | 10 ++++------
 block/blk-crypto-fallback.c      | 22 +++++++++++-----------
 block/blk-crypto-internal.h      |  2 +-
 block/blk-crypto.c               |  4 ++--
 block/blk-merge.c                |  6 ++----
 block/blk-mq.c                   | 11 ++++-------
 block/fops.c                     |  6 ++----
 block/t10-pi.c                   |  2 +-
 drivers/block/aoe/aoecmd.c       |  8 ++++----
 drivers/block/aoe/aoedev.c       |  2 +-
 drivers/block/drbd/drbd_int.h    |  3 +--
 drivers/block/drbd/drbd_req.c    |  9 +++------
 drivers/block/ps3vram.c          |  3 +--
 drivers/block/zram/zram_drv.c    |  4 ++--
 drivers/md/bcache/bcache.h       |  3 +--
 drivers/md/bcache/request.c      |  8 +++-----
 drivers/md/dm-cache-target.c     |  9 +++++----
 drivers/md/dm-ebs-target.c       |  2 +-
 drivers/md/dm-flakey.c           |  2 +-
 drivers/md/dm-integrity.c        | 30 +++++++++++-------------------
 drivers/md/dm-mpath.c            |  6 ++----
 drivers/md/dm-pcache/dm_pcache.c |  3 +--
 drivers/md/dm-raid1.c            |  7 +++----
 drivers/md/dm-thin.c             |  5 ++---
 drivers/md/dm-vdo/data-vio.c     |  3 +--
 drivers/md/dm-verity-target.c    |  2 +-
 drivers/md/dm-writecache.c       |  7 +++----
 drivers/md/dm-zoned-target.c     |  2 +-
 drivers/md/dm.c                  |  4 +---
 drivers/md/md.c                  |  8 +++-----
 drivers/md/raid1-10.c            |  3 +--
 drivers/md/raid1.c               |  2 +-
 drivers/md/raid10.c              | 18 +++++++-----------
 drivers/md/raid5.c               |  4 ++--
 drivers/nvdimm/btt.c             |  4 ++--
 drivers/nvdimm/pmem.c            |  7 ++-----
 fs/btrfs/bio.c                   |  8 ++++----
 fs/btrfs/direct-io.c             |  2 +-
 fs/btrfs/raid56.c                |  6 ++----
 fs/crypto/bio.c                  |  2 +-
 fs/erofs/fileio.c                |  2 +-
 fs/erofs/fscache.c               |  4 ++--
 fs/f2fs/data.c                   |  6 +++---
 fs/f2fs/segment.c                |  3 +--
 fs/iomap/ioend.c                 |  3 +--
 fs/verity/verify.c               |  2 +-
 fs/xfs/xfs_aops.c                |  3 +--
 fs/xfs/xfs_zone_alloc.c          |  2 +-
 include/linux/bio.h              | 30 +++++++++++++++++++++++++++---
 51 files changed, 153 insertions(+), 179 deletions(-)

-- 
2.51.0


