Return-Path: <linux-btrfs+bounces-17447-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DD8BBD03E
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 05:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDB618924B8
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 03:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2361D5ABA;
	Mon,  6 Oct 2025 03:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aC7szt9n";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aC7szt9n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7733FC7
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 03:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759723156; cv=none; b=ABwsm81p7IgOWZJ7zS/RMQyfkyjofaUL0QOUOZnEq4tURgUnuj9V5B0CAsLcwXQFNJA9XH3LMOmlefvvKQbBhvTAgHlFj+OYN1TveeUTbBwl6XG82vvJNl8yra3hAX58t8KnY8uXd9dR5W5kIRovkCczCGxsBBiUcmBE2ux2AFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759723156; c=relaxed/simple;
	bh=9/pmHqyO1aMjOBRinrm8ahqeaKjExrooNxH43ZNhEOQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cmFZqr23iqlYH3keNjnTAoNLGlGFYfJv/D2qJxW5vaA0g7ErM6PuECu6NkUvX6IWoRwUvu3a5iRbY7wGb+bMLQSrlAtRXbuaadm6FL4pr0ACmhR4meGaM9x0Yf8ymGwgONs1AT2XWqzwqzHi0kiTHxp00iGNLne+2q8NckHQXls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aC7szt9n; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aC7szt9n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2723B33711
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 03:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759723152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pMOIwf1vLd/rhRlfZtneWlscOPnj3ALweFi9b18x7bE=;
	b=aC7szt9ny1YzZo/k3lCjDixQaZOV1ixfugdYxbNhfKmAdRR6xU/fOELt+yQnVoxgLMp/BF
	gyxCeObQMIjJA0p1qeH1zfSbM/pzTHa1gUIIStUFgmgH5sudGC8UJuLnjIq4Tk3yt3gkT4
	/hqDrq9eRW1TvCca2Pp9AFqsZ7j0Pjs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759723152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pMOIwf1vLd/rhRlfZtneWlscOPnj3ALweFi9b18x7bE=;
	b=aC7szt9ny1YzZo/k3lCjDixQaZOV1ixfugdYxbNhfKmAdRR6xU/fOELt+yQnVoxgLMp/BF
	gyxCeObQMIjJA0p1qeH1zfSbM/pzTHa1gUIIStUFgmgH5sudGC8UJuLnjIq4Tk3yt3gkT4
	/hqDrq9eRW1TvCca2Pp9AFqsZ7j0Pjs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 644A91386E
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 03:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I/PzCY8+42gDaAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 06 Oct 2025 03:59:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/4] btrfs: enable encoded read/write/send for bs > ps cases
Date: Mon,  6 Oct 2025 14:28:49 +1030
Message-ID: <cover.1759708020.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

[CHANGELOG]
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

Another thing is, even with all those support, direct IO is still not
supported.
The problem is iomap can still split the bio between pages, breaking our
bio size requirement (still have to be block aligned).


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
2.50.1


