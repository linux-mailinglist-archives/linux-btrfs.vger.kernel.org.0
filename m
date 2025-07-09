Return-Path: <linux-btrfs+bounces-15359-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D76AFDEAB
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 06:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF827ABF28
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 04:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EABD25FA0F;
	Wed,  9 Jul 2025 04:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KyZAGySq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DGVKbL6G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806701A23A5
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 04:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752033973; cv=none; b=cTyUpcmvx01uq1feXQWoFKWQ5Us5Rjw0E1GGu5In5dLZSi/f/0MvYgrsruPiP0HQ1OIyGx4GS4wXk2DE4MN9I2800KNJQdysXYsPt7nVkJbGHb2n6zw2X5PAGh30rEp4wijnzB+j2q5LvQ4v1L6gDE9d+SafKg6IbnZfeKJdwnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752033973; c=relaxed/simple;
	bh=PB8uwfMWCeG5k1Qb5tDWfRzQOjx+6td/JTXdCpS3jBI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tfi+syGntYJW4TVKB8HtgUNpeCDu7QCtwxJSavPdHkN4zehkxsk7vFwpxWnyaMFFoplOxJcEBlwZffoXX012FiLtwc8sXYiyz+2lcrtIYfvemty0KksiyyGxCo1TaVRWODTfdPMcyOHW3S3kPmaSNDOdBYMZo/n605ArH7ss9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KyZAGySq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DGVKbL6G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 58FE31F38E
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 04:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752033969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hp3HqsnQsq+X6RtoFGt0gajmZuxwHGWgR10+qdtk/qk=;
	b=KyZAGySqpT5Lby89O/NEqRF69Zt7ujOkVb850zRBskxSs71Oo5Rf1lH7kr4o0W5TDIctPn
	Y4BZEtUHRcjViU65pLT+Z8CRkUMwV4v29Z4Vq4g9SWGFPgHiq1gJZTS3skuCEMXJK0vnVO
	eMa/iEY9ddwnuNzJDzU4wUiTidJtNRs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DGVKbL6G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752033968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hp3HqsnQsq+X6RtoFGt0gajmZuxwHGWgR10+qdtk/qk=;
	b=DGVKbL6GnTtjqQ4bgjwu83SGQ/gmHa7aMUCzHv91SKwjjfaK/1KJ49J2HssmRO/YsYjumE
	6o2N/vtPSFUtHsvJWwfz8fnH2BZJ5wRKMbG7iYy3Slkxju8EhrsR8LpryH5edGXovNXHmc
	8g+2GJYEP8Zpfcx/SBEi9SiTh/Gz3TE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AEE713757
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 04:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e21zE6/qbWiwKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 09 Jul 2025 04:06:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: do not poke into bdev's page cache
Date: Wed,  9 Jul 2025 13:35:47 +0930
Message-ID: <cover.1752033203.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 58FE31F38E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

[CHANGELOG]
v2:
- Make sb_write_pointer() use bdev_rw_virt()
  That is the missing location that still uses bdev's page cache, thanks
  Johannes for exposing this one.

- Replace btrfs_release_disk_super() with kfree()
  There is no need to keep that helper, and such replace will help us
  exposing locations which are still using the old page cache, like the
  above case.

- Only scratch the magic number of a super block in
  btrfs_scratch_superblock()
  To keep the behavior the same.

- Use GFP_NOFS when allocating memory
  This is also to keep the old behavior.

  Although I'd say btrfs_read_disk_super() call sites are safe, as they
  are either scanning a device, or at mount time, thus out of the write
  path and should be safe.

  The sb_write_pointer() one still needs the old GFP_NOFS flag as they
  can be called when writing the super block.

Btrfs has a long history using bdev's page cache for super block IOs.
This looks weird, but is mostly for the sake of concurrency.

However this has already caused problems, for example when the block
layer page cache enables large folio support, it triggers an ASSERT()
inside btrfs, this is fixed by commit 65f2a3b2323e ("btrfs: remove folio
order ASSERT()s in super block writeback path"), but it is already a
warning.

Thankfully we're moving away from the bdev's page cache already, starting
with commit bc00965dbff7 ("btrfs: count super block write errors in
device instead of tracking folio error state"), we no longer relies on
page cache to detect super block IO errors.

But we're still using the bdev's page cache for:

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

But this brings some overhead, thus I marked the series RFC:

- Extra 12K memory usage for each block device
  I hope the extra cost is acceptable for modern day systems.

- Extra memory copy for super block writeback
  Previously we do the copy into the bdev's page cache, then submit the
  IO using folio from the bdev page cache.

  This updates the page cache and do the IO in one go.

  But now we memcpy() into the preallocated super block buffer, not
  updating the bdev's page cache directly.

Qu Wenruo (2):
  btrfs: use bdev_rw_virt() to read and scratch the disk super block
  btrfs: do not poke into bdev's page cache for super block write

 fs/btrfs/disk-io.c | 86 +++++++++++++++-------------------------------
 fs/btrfs/super.c   |  4 +--
 fs/btrfs/volumes.c | 83 +++++++++++++++++++++-----------------------
 fs/btrfs/volumes.h | 10 ++++--
 fs/btrfs/zoned.c   | 28 ++++++++-------
 5 files changed, 93 insertions(+), 118 deletions(-)

-- 
2.50.0


