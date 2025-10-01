Return-Path: <linux-btrfs+bounces-17306-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07514BAFEA2
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 11:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E611194153D
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 09:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8A1285CAB;
	Wed,  1 Oct 2025 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kwFQv8dg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kwFQv8dg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CD238D42
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759312230; cv=none; b=bCqq7zCsjNHfHcmQGs7XN5MvW0NT/quP23d2eWGsXI8U7XghsP5l/iN/a50Wg55Gmiww19lOC39g4ii+Dwv45OPmwt+TwxozrTKbqJLuleOLMKm1Dm+yh6moYVZ6IRXuDsy214FXT9W4b4m+wRNLOVRGVup5jklc0E6ujXFUa3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759312230; c=relaxed/simple;
	bh=Bye9T02L+OVQK6vrEmNvuG4xexduJQMcmbREUC67e8Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tOs0/MhMrv+ZbovJkCWCiGg33RjET+YqCU6xJBBZ593ktpXgErqZUiidxqLf2T5/FqmXyf8tvdelR+p5cS7URgqv2VyByy7pNZyMe2RrbhmD4KBltnJNYh/K6mYI1px9SmtOoh3pvHKfCnHDV7xDLdppiGaHMzl95p5l/dBkrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kwFQv8dg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kwFQv8dg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1603A1F7C1
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759312227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AnFf8RAd/lpdliUKxEUD4zzc9LDYRYVuBHxMjQYAN4E=;
	b=kwFQv8dgP4lddqxnZ73aNTR9JCGiddHf3COjTt06riKdX4Aq2CUUzNb/ksGhpIFJnc2P1P
	nxao788LColhiwOI7PrRw0T/KL0ubWPNCpxaKODPpJ19KDr0+8OmvrwxQ7k1RJvUDMGqah
	STkDB5ieXP6qeZrwV2HANJqkSoDVYl8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759312227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AnFf8RAd/lpdliUKxEUD4zzc9LDYRYVuBHxMjQYAN4E=;
	b=kwFQv8dgP4lddqxnZ73aNTR9JCGiddHf3COjTt06riKdX4Aq2CUUzNb/ksGhpIFJnc2P1P
	nxao788LColhiwOI7PrRw0T/KL0ubWPNCpxaKODPpJ19KDr0+8OmvrwxQ7k1RJvUDMGqah
	STkDB5ieXP6qeZrwV2HANJqkSoDVYl8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 536EC13A3F
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 09:50:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GW7XBWL53GikSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 01 Oct 2025 09:50:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: enable encoded read/write/send for bs > ps cases
Date: Wed,  1 Oct 2025 19:20:04 +0930
Message-ID: <cover.1759311100.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80

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
 fs/btrfs/bio.h         |   2 +-
 fs/btrfs/btrfs_inode.h |   8 ++-
 fs/btrfs/disk-io.c     |  29 +++++----
 fs/btrfs/file-item.c   |  15 ++++-
 fs/btrfs/inode.c       |  91 ++++++++++++++++++---------
 fs/btrfs/ioctl.c       |  21 -------
 fs/btrfs/send.c        |   9 +--
 8 files changed, 200 insertions(+), 115 deletions(-)

-- 
2.50.1


