Return-Path: <linux-btrfs+bounces-18849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B072C49A56
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 23:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17A9C4F127A
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 22:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069682D6607;
	Mon, 10 Nov 2025 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qWAyIs5B";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qWAyIs5B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917C32EC080
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814548; cv=none; b=dIdIeNgpWeBYsSdoaFCI71bwAd5YmDppHB0+TR5IGUM5TxSm1eFOtglnZzeXaRu1ylfjIkgt+AKjNokuBkPXMyoo8ec97+rXt6fM3+jBBnT3XUpVE8LOQBpjSPshHqTnEp+C7KhSjpuMApL9+kB/5pWK60kU6w97C57goBtsSnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814548; c=relaxed/simple;
	bh=BuM3aDo+TnY1zsx1XAbORdeIfOApc3zEDfjn/KdGetY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IZ64zBU1vV4OzZhiBx0ioHIAGwtkXiti5/k1RzrC+aaOWIdb1THO6sv8qa9UQiAJAo4uFxKqyCaWlk9MWQMrN79hepDnyx2xM7cJqtvGx9+OX0zOr3U1ZABrFieu+vIufCkdIE4pP9/M7x0L+H+nnvzqrMC9h3j2jGF4Z+NF7UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qWAyIs5B; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qWAyIs5B; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83C5321E9A
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762814543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qsjSxAk+xsrIbs/j3JRZo1YHQcsCKgFX3ldhtXIBtgg=;
	b=qWAyIs5BVXDAjMnEtpK1cRjR1j7eR81DBcTC2EB5vb/7UNEKsGazVD3uYtyIoi2EByBklp
	gxuP4t0J7QwO4gq//fQN6rU774hJgdx0eDV1zU+7pPjWLcLCu1OWlW08/0UgEUEy/R64xw
	BeTibSdFihsjL5fMHarikHGbv5CjfCM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762814543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qsjSxAk+xsrIbs/j3JRZo1YHQcsCKgFX3ldhtXIBtgg=;
	b=qWAyIs5BVXDAjMnEtpK1cRjR1j7eR81DBcTC2EB5vb/7UNEKsGazVD3uYtyIoi2EByBklp
	gxuP4t0J7QwO4gq//fQN6rU774hJgdx0eDV1zU+7pPjWLcLCu1OWlW08/0UgEUEy/R64xw
	BeTibSdFihsjL5fMHarikHGbv5CjfCM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0C7614623
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:42:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TzacIE5qEmk/agAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:42:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/4] btrfs: enable encoded read/write/send for bs > ps cases
Date: Tue, 11 Nov 2025 09:11:57 +1030
Message-ID: <cover.1762814274.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.78 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.18)[-0.919];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.78

[CHANGELOG]
v4:
- Rebased to the latest for-next branch
  The new async-csum is causing conflicts related to
  btrfs_csum_one_bio() and how to grab fs_info from compressed_bio.

v3:
- Fix a bug in btrfs_repair_eb_io_failure() for nodesize < ps cases
  In that case, we only need a single paddr slot, but a larger step
  (nodesize instead of sectorsize).
  Add a new @step parameter to btrfs_repair_io_failure() to handle this
  special situation.

v2:
- Fix smatch warnings
  Mostly remove any ASSERT()s checking returned value of bio_alloc().

- Fix a bug in the btrfs_add_compressed_bio_folios()
  Where the function still assumes large folios, but now we can have
  regular folios.


Previously encoded read/write/send is disabled for bs > ps cases,
because they are either using regular pages or kvmallocated memories as
buffer.

This means their buffers do not meet the folio size requirement (each 
folio much contain at least one fs block, no block can cross large folio
boundries).


This series address the limits by allowing the following functionalities
to support regular pages, without relying on large folios:

- Checksum calculation
  Now instead of passing a single @paddr which is ensured to be inside a
  large folio, an array, paddrs[], is passed in.

  For bs <= ps cases, it's still a single paddr.

  For bs > ps cases, we can accept an array of multiple paddrs, that
  represents a single fs block.

- Read repair
  Allow btrfs_repair_io_failure() to submit a bio with multiple
  incontiguous pages.

  The same paddrs[] array building scheme.

  But this time since we need to submit a bio with multiple bvecs, we
  can no longer use the current on-stack bio.

  This also brings a small improvement for metadata read-repair, we can
  submit the whole metadata block in one go.

- Comprssed bio folios submission
  Now the function btrfs_add_compressed_bio_folios() can handle both
  large and regular folios, even handling different sized folios in the
  array.

- Read verification
  Just build the paddrs[] array for bs > ps cases and pass the array
  into btrfs_calculate_block_csum_folio().

Unfortunately since there is no reliable on-stack VLA support, we have
to pay the extra on-stack memory (128 bytes for x86_64, or 8 bytes for
64K page sized systems) everywhere, even if 99% of the cases our block
size is no larger than page size.

The remaining part of full bs > ps support is:

- Direct IO support for bs > ps
  This depends on a patch that is going through iomap/vfs tree instead.
  Thus that part will only go through the v6.19 cycle

- RAID56 support
  Which depends on the follow series which reduces btrfs_raid_bio size:
  https://lore.kernel.org/linux-btrfs/cover.1759984060.git.wqu@suse.com/

Qu Wenruo (4):
  btrfs: make btrfs_csum_one_bio() handle bs > ps without large folios
  btrfs: make btrfs_repair_io_failure() handle bs > ps cases without
    large folios
  btrfs: make read verification handle bs > ps cases without large
    folios
  btrfs: enable encoded read/write/send for bs > ps cases

 fs/btrfs/bio.c         | 140 +++++++++++++++++++++++++++++------------
 fs/btrfs/bio.h         |   5 +-
 fs/btrfs/btrfs_inode.h |   8 ++-
 fs/btrfs/compression.c |  10 +--
 fs/btrfs/disk-io.c     |  29 +++++----
 fs/btrfs/file-item.c   |  15 ++++-
 fs/btrfs/inode.c       |  91 ++++++++++++++++++---------
 fs/btrfs/ioctl.c       |  21 -------
 fs/btrfs/send.c        |   9 +--
 9 files changed, 207 insertions(+), 121 deletions(-)

-- 
2.51.2


