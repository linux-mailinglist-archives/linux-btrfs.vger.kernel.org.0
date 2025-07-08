Return-Path: <linux-btrfs+bounces-15316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC20AFC6B2
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 11:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4C718918E8
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FADE2BEC4A;
	Tue,  8 Jul 2025 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nhKsHXKH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nhKsHXKH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CEC217F26
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965615; cv=none; b=MUEQnL84gZFd9rjNfOVcG8zWPYgi/Nf1GBfQnxg1Y4PuWtskZyhgk2msWqZPEcc4pIVOeOtQ12XBpCpxozp1p3/bPyoMg+D+VJ07DqTaR+kBYwtfKunDaZjvgWj7eCWC+Qp4lZXdxXQQ5KyvSiWoFm2/4A5T5uNsBnDwq8Iip3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965615; c=relaxed/simple;
	bh=hS+oSoFT20TH/DqJKAa5Km2VEeXxHwAj/NgaUfvHuxI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fWPcaAhbwlZtUfsBQm95iRl4c8Ud0Dsv2LTkjafSWzp7l0b0J0g2T0YzuWM5xr5bGa9wEzbS1WhLYhqsEYW5DpccnwwN4XqiWqH+6kkej9fUhX+/4IJ3jWx5ZA3nPiZJ6N/RQSOb+gI5BFL528uimAlkwsWPOhfyUrsPW/uXcU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nhKsHXKH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nhKsHXKH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B7A251F458
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 09:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751965611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ll5IxNH6q2MmW3EjwCNyqypSQfDgww1zl8LmJ9wOGwQ=;
	b=nhKsHXKHRhQPB9Z24ao453oUZWElcEXGzaheULoR/s5mspYXMdYRc++wWqgMhV8IoXkswp
	aNMWAhvuK1MS2ALRGaVQ/lXnjPspoDMWEGFEokMko7KfigcdDEJDW4Hbrc9ECWCfNbq9r6
	fkYIaL0iwiPEgpUuYKMBp9uUfJz4lbA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751965611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ll5IxNH6q2MmW3EjwCNyqypSQfDgww1zl8LmJ9wOGwQ=;
	b=nhKsHXKHRhQPB9Z24ao453oUZWElcEXGzaheULoR/s5mspYXMdYRc++wWqgMhV8IoXkswp
	aNMWAhvuK1MS2ALRGaVQ/lXnjPspoDMWEGFEokMko7KfigcdDEJDW4Hbrc9ECWCfNbq9r6
	fkYIaL0iwiPEgpUuYKMBp9uUfJz4lbA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 004B213A68
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 09:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UtsfLarfbGgiYwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 08 Jul 2025 09:06:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/2] btrfs: do not poke into bdev's page cache
Date: Tue,  8 Jul 2025 18:36:31 +0930
Message-ID: <cover.1751965333.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

[ABUSE OF BDEV'S PAGE CACHE]
Btrfs has a long history using bdev's page cache for super block IOs.
This looks weird, but is mostly for the sake of concurrency.

However this has already caused problems, for example when the block
layer page cache enables large folio support, it triggers an ASSERT()
inside btrfs, this is fixed by commit 65f2a3b2323e ("btrfs: remove folio
order ASSERT()s in super block writeback path"), but it is already a
warning.

[MOVEING AWAY FROM BDEV'S PAGE CACHE]
Thankfully we're moving away from the bdev's page cache already, starting
with commit bc00965dbff7 ("btrfs: count super block write errors in
device instead of tracking folio error state"), we no longer relies on
page cache to detect super block IO errors.

We still have the following paths using bdev's page cache, and those
points will be addressed in this series:

- Reading super blocks
  This is the easist one to kill, just kmalloc() and bdev_rw_virt() will
  handle it well.

- Scratching super blocks
  Previously we just zero out the magic, but leaving everything else
  there.
  We rely on the block layer to write the involved blocks.

  Here we follow btrfs_read_disk_super() by kzalloc()ing a dummy super
  block, and write the full super block back to disk.

- Writing super blocks
  Although write_dev_supers() is alreadying using the bio interface, it
  still relies on the bdev's page cache.

  One of the reason is, we want to submit all super blocks of a device
  in one go, and each super block of the same block device is slightly
  different, thus we go using page cache, so that each super block can
  have its own backing folio.

  Here we solve it by pre-allocating super block buffers.
  This also makes endio function much simpler, no need to iterate the
  bio to unlock the folio.

- Waiting super blocks
  Instead of locking the folio to make sure its IO is done, just use an
  atomic and wait queue head to do it the usual way.

By this we solve the problem and all IOs are done using bio interface.

[THE COST AND REASON FOR RFC]
But this brings some overhead, thus I marked the series RFC:

- Extra 12K memory usage for each block device
  I hope the extra cost is acceptable for modern day systems.

- Extra memory copy for super block writeback
  Previously we do the copy into the bdev's page cache, then submit the
  IO using folio from the bdev page cache.

  This updates the page cache and do the IO in one go.

  But now we memcpy() into the preallocated super block buffer, not
  updating the bdev's page cache directly.
  If by somehow the block device drive determines to copy the bio's
  content to page cache, it will need to do one extra memory copy.

- Extra memory allocation for btrfs_scratch_superblock()
  Previously we need no memory allocation, thus no error handling
  needed.

  But now we need extra memory allocation, and such allocation is just
  to write zero into block devices. Thus the cost is a little hard to
  accept.

- No more cached super block during device scan
  But the cost should be minimal.

Qu Wenruo (2):
  btrfs: use bdev_rw_virt() to read and scratch the disk super block
  btrfs: do not poke into bdev's page cache for super block write

 fs/btrfs/disk-io.c | 76 ++++++++++++++--------------------------------
 fs/btrfs/volumes.c | 59 ++++++++++++++++++++---------------
 fs/btrfs/volumes.h | 11 ++++++-
 3 files changed, 67 insertions(+), 79 deletions(-)

-- 
2.50.0


