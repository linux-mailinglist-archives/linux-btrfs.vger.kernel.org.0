Return-Path: <linux-btrfs+bounces-17027-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FBFB8E925
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 00:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E43B3BE20C
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Sep 2025 22:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E551225BEE7;
	Sun, 21 Sep 2025 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mlXiSoiQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="esHC1vgo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F476226863
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758494829; cv=none; b=Tn+X7czeZFjtfUWZuDR3+C+kA+C4YUe4v8HDmM9zzeU7PD4riH/1KzPHgJ2RRKu3g6X5muFOfDSXVS62MfyW1Q7ptf8TkmXpHYOln3aToB8hy0OwZYykYpLxyJ7T+2TeRnJYdZ+mFv3KbLaiLzHIcj7ocOoD34abb7sn1LdcYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758494829; c=relaxed/simple;
	bh=W2fVokvlxLvWOmemIacKwCO6cbGLXEoFx0mSbdp9U/c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=B5loJdYlqN8IvjmU+jEUiVY/InIEQ24jpwl0wsy9GHhMBgkb5/pLXNnQQFJUJmrD0n3kn0V32rxyRED9qAe2XYVtSOu4SwAEljqOff8LowrCnX6dz5zvdYhBLmQrpGX1xhzzkgLLBGYQ8WAk1jsCR23FTia7yl9lMjy+AOLv96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mlXiSoiQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=esHC1vgo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE09222141
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 22:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758494470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yJzEQRVsak1w2j6zLaCNh47oSeXRoYxyzavpjV2x7ZY=;
	b=mlXiSoiQSU2nSr1e0j6637MQs57qR/oGlzjDvHdRUvez5n+5VVurU1yM1kOYS1dYUP+Z5a
	y89481Os2m+Al6vK6vWLP0qLS8AX83CUhkZWFmUezaD3VOIcJPMCrP5yELm22ovdbokSpc
	eQX5r8gPjrzfkWVd0ZMX4+Q7ueUI6Rs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758494469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yJzEQRVsak1w2j6zLaCNh47oSeXRoYxyzavpjV2x7ZY=;
	b=esHC1vgoqz0K3GZ5wrc580epuXXlIJyqO2GB9n30dN2iW6Lb4NeIl6tDFTttShmWPC1A/C
	VdGxA0wsiAEEeFx17IC8l42c+W6NekQX1i1gqGN6kFpcMCNqqPNdK0g7y80hsgZ6e3So7E
	8Ei24XgpJErOoF68Reh4OIGQoW3gekg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AFDE13ACD
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 22:41:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IkQ8AAV/0GisdwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 22:41:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/9] btrfs: initial bs > ps support
Date: Mon, 22 Sep 2025 08:10:42 +0930
Message-ID: <cover.1758494326.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

[CHANGELOG]
v2:
- Add a new patch to fix the incorrect @max_bytes of
  find_lock_delalloc_range()
  This in fact also fixes a very rare corner case where bs < ps support
  is also affected.

  This allows us to re-enable extra large folios (folio > bs) for
  bs > ps cases.

RFC->v1
- Disable extra large folios for bs > ps mounts
  Such extra large folios are larger than a block.

  Still debugging, but disabling it makes 8K block size runs survive the
  full fs tests, with some minor failures due to the limitations.

  This may be something affecting regular large folios (folio > bs,
  but bs <= ps).

This series enables the initial bs > ps support, with several
limitations:

- No direct IO support
  All direct IOs fall back to buffered ones.

- No RAID56 support
  Any fs with RAID56 feature will be rejected at mount time.

- No encoded read/write/send
  Encoded send will fallback to the regular send (reading from page
  cache).
  Encoded read/write utilized by send/receive will fallback to regular
  ones.

Above limits are introduced by the fact that, we require large folios to
cover at least one fs block, so that no block can cross large folio
boundaries.

This simplifies our checksum and RAID56 handling.

The problem is, user space programs can only ensure their memory is
properly aligned in virtual addresses, but have no control on the
backing folios. Thus they can got a contiguous memory but is backed
by incontiguous pages.

In that case, it will break the "no block can cross large folio
boundaries" assumption, and will need a very complex mechanism to handle
checksum, especially for RAID56.

The same applies to encoded send, which uses vmallocated memory.

In the long run, we will need to support all those complex mechanism.

[FUTURE ROADMAP]
Currently bs > ps support is only to allow extra compatibility, e.g.
allowing x86_64 to mount a btrfs which is originally created on ppc64
(64K page size, 64K block size).

But this should also open a new door for btrfs RAID56 write hole
problems in the future, by enforcing a larger block size and fixed 
power-of-2 data stripes, so that every write can fill a full stripe,
just like RAIDZ.

E.g. with 8K block size, all data writes are now in 8K sizes, and will
always be a full stripe write for a 3 disks RAID5 with a stripe length
of 4K.

This RAIDZ like solution will allow a much simpler RAID56 (no more RMW
any more), at the cost of a larger block size (more write-amplification,
higher memory usage etc).

Qu Wenruo (9):
  btrfs: fix the incorrect @max_bytes value for
    find_lock_delalloc_range()
  btrfs: prepare compression folio alloc/free for bs > ps cases
  btrfs: prepare zstd to support bs > ps cases
  btrfs: prepare lzo to support bs > ps cases
  btrfs: prepare zlib to support bs > ps cases
  btrfs: prepare scrub to support bs > ps cases
  btrfs: fix symbolic link reading when bs > ps
  btrfs: add extra ASSERT()s to catch unaligned bios
  btrfs: enable experimental bs > ps support

 fs/btrfs/bio.c         | 27 +++++++++++++++++++
 fs/btrfs/compression.c | 42 ++++++++++++++++++++---------
 fs/btrfs/compression.h |  2 +-
 fs/btrfs/direct-io.c   | 12 +++++++++
 fs/btrfs/disk-io.c     | 14 ++++++++--
 fs/btrfs/extent_io.c   | 21 +++++++++++----
 fs/btrfs/extent_io.h   |  3 ++-
 fs/btrfs/fs.c          | 20 ++++++++++++--
 fs/btrfs/fs.h          |  6 +++++
 fs/btrfs/inode.c       | 18 +++++++------
 fs/btrfs/ioctl.c       | 35 +++++++++++++++++-------
 fs/btrfs/lzo.c         | 59 ++++++++++++++++++++++-------------------
 fs/btrfs/raid56.c      | 42 +++++++++++++++++++----------
 fs/btrfs/raid56.h      |  4 +--
 fs/btrfs/scrub.c       | 51 +++++++++++++++++++----------------
 fs/btrfs/send.c        |  9 ++++++-
 fs/btrfs/zlib.c        | 60 +++++++++++++++++++++++++++---------------
 fs/btrfs/zstd.c        | 44 +++++++++++++++++--------------
 18 files changed, 321 insertions(+), 148 deletions(-)

-- 
2.50.1


