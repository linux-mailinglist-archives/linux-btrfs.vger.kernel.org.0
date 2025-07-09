Return-Path: <linux-btrfs+bounces-15406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1511AFF425
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 23:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16F71C43319
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 21:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B28C241CBA;
	Wed,  9 Jul 2025 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DAojr+vs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DAojr+vs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246E221DB4
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098067; cv=none; b=A48mFiuptc3qIVrbw5wAhGCo+P8AUgJr0SG11MTVOkHly/wq5rEjNuFkhJKETCbGt/S6H2EiQ4jNfa22rcZBF/zFbTRrkREfifnnb4+ggaaVvcKQSIgZPzygIYCqJcpMUDetGy0qBUp8Hl1leCxKoXqOZD4vL6zQuWvZSByz7S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098067; c=relaxed/simple;
	bh=nn+O4N+YtBl6nu16Lsboj5EyctMCYXYoFNmC+Ow53jk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JPkNA0Ru5F3FAmWVaz7P8lNJsz0x3HQ2ZKTkaipANaVrBQDaeMJprQbPBn2ZRgLTDLTC6FKCgVSLFOg1S+bX9xkZDCYn96EWMin47xXKevNPR6G+Hx9MLxXboC81iW/78/lcli4HbjImMn21dhOxI8M5EWWuoqiktBsu+mIH37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DAojr+vs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DAojr+vs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8967B2117D
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 21:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752098061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vUglQm+rFtNxFKGoReXpjDokFGwz5kdPgD3Zdjs4XSY=;
	b=DAojr+vslySaMHwcQ3PStAXqu2i6643w/2fkpbKYwRteLxsVL1XL01oOwIIs3vfafTi3p9
	0HLI5DKgjOWxPyUnf4YSUn7XeNCsTMzT9S9++b04Me9Bha+Lbw16XqsynCUBC1tNHmhYfh
	U5P9MJ3yx3F1o9PxfpddKtBzDZaI4nc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DAojr+vs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752098061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vUglQm+rFtNxFKGoReXpjDokFGwz5kdPgD3Zdjs4XSY=;
	b=DAojr+vslySaMHwcQ3PStAXqu2i6643w/2fkpbKYwRteLxsVL1XL01oOwIIs3vfafTi3p9
	0HLI5DKgjOWxPyUnf4YSUn7XeNCsTMzT9S9++b04Me9Bha+Lbw16XqsynCUBC1tNHmhYfh
	U5P9MJ3yx3F1o9PxfpddKtBzDZaI4nc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2E0813757
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 21:54:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SQt/IAzlbmhVbQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 09 Jul 2025 21:54:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: only use bdev's page cache for super block writeback
Date: Thu, 10 Jul 2025 07:24:01 +0930
Message-ID: <cover.1752097916.git.wqu@suse.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 8967B2117D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

[CHANGELOG]
v2:
- Still use page cache for super block writes
  This is to ensure the user space won't see any half-backed super block
  caused by the race between bio writes and buffered read on the bdev.

  This is exposed by generic/492 which user space command blkid may
  fail to see the updated superblock.

  This also brings a slight imbalance, that our super block read is
  always uncached, but the superblock write is always cached.

RFC->v1:
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
It looks even weird in the older days that we manually setting different
page flags without going through the regular dirty -> lock -> writeback
-> clear writeback sequence.

Thankfully we're moving away from unnecessary bdev's page flag
modification, starting with commit bc00965dbff7 ("btrfs: count super
block write errors in device instead of tracking folio error state"),
we no longer relies on page cache to detect super block IO errors.

But we're still using the bdev's page cache for:

- Reading super blocks
  Reading a whole folio just to grab a 4KiB super block can be
  overkilled.
  And this is the easiest one to kill, just kmalloc() and bdev_rw_virt() will
  handle it well.

- Scratching super blocks
  We can use bdev_rw_virt() to write a super block with its magic
  zeroed.

  However we also need to invalidate the cache to ensure the user space
  won't see the out-of-date cached super block.

- Writing super blocks
  We're using the page cache of bdev, for a different purpose.
  We want to ensure the user space scanning tools like blkid seeing a
  consistent content.

  If we just go the bdev_rw_virt() path, the user space read can race
  with our bio write, resulting inconsistent contents.

  So here we still need to utilize the page cache of bdev, but with
  comments explaining why we need to.

- Waiting super blocks
  Instead of waiting the folio to be unlocked, just use an atomic and
  wait queue head to do the wait.

However this brings one small change:

- Device scan is no longer cached
  For mount time it's totally fine, but every time a btrfs device is
  touched, we will submit a 4K sync read from the disk.
  The cost may not be that huge though.


Qu Wenruo (2):
  btrfs: use bdev_rw_virt() to read and scratch the disk super block
  btrfs: use proper superblock writeback tracing

 fs/btrfs/disk-io.c | 65 +++++++++++++++++++++-------------------
 fs/btrfs/super.c   |  4 +--
 fs/btrfs/volumes.c | 75 ++++++++++++++++++++--------------------------
 fs/btrfs/volumes.h |  9 ++++--
 fs/btrfs/zoned.c   | 26 +++++++++-------
 5 files changed, 89 insertions(+), 90 deletions(-)

-- 
2.50.0


