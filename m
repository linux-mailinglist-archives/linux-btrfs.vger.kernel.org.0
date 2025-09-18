Return-Path: <linux-btrfs+bounces-16948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD90B874C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 00:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5C97C825C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 22:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068D82FDC27;
	Thu, 18 Sep 2025 22:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W66T/+Rf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W66T/+Rf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F182D7D42
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236341; cv=none; b=WYlq80B+w774EnmToDW5dke7GBe9veZJQx/kfbZpAp0foZIN8T4/KCqJRkzo1BnIlB/Ykh/L3Bmn9vSgpH0tPV5eJzVv9BJdYYctO209RyBgP+W19WIIkDT+p+Q207294Vt9OtRi4UxANtb3oEkG1hyGCLjlYsfxphVpx5zlak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236341; c=relaxed/simple;
	bh=XzN1RfUmWmJyeQoVkLvYI7/RKornFMDMMMKoVYFGLYU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pOY2hzFs74x4nyEy98bbm2gokSODXVIISOadb25ov1sXfgcbfw2Q1kgs2khp1ISZVwWhWBxQmofY2RLyYd6THec3g5F6gBjYZIHHYVtPLx/n9WxP1sHvaLFTnocOgrlaVj5vhdMFLLfE2TWIfDqoCOeLgDvA27PPFEJpsUcaIdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W66T/+Rf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W66T/+Rf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 808E23368A
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 22:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758236337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oPdj3ppJ0aa0HBj9JSoMU/e8gFAbEGcv/Z9dNkIqyas=;
	b=W66T/+RfYWrMEAE7TWztaY8eKeC5HKOMT+tO0MiomAXGifwJaJ+Xv51G569FBFaNFcKh5q
	YDpVQdExsizwNkUnOIgghaAR1fexpkaXWLTBRw+RwseuSvEfbtpZL+Y0pWcR3jMCGujS+c
	e37axY0Hs2C/yUoes+FqLtE2wwnepXU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758236337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oPdj3ppJ0aa0HBj9JSoMU/e8gFAbEGcv/Z9dNkIqyas=;
	b=W66T/+RfYWrMEAE7TWztaY8eKeC5HKOMT+tO0MiomAXGifwJaJ+Xv51G569FBFaNFcKh5q
	YDpVQdExsizwNkUnOIgghaAR1fexpkaXWLTBRw+RwseuSvEfbtpZL+Y0pWcR3jMCGujS+c
	e37axY0Hs2C/yUoes+FqLtE2wwnepXU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B928C13A39
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 22:58:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C4hAHrCOzGjiYAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 22:58:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: initial bs > ps support
Date: Fri, 19 Sep 2025 08:28:30 +0930
Message-ID: <cover.1758236028.git.wqu@suse.com>
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

[CHANGELOG]
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

- No extra large folios (folio > bs > ps)
  Still debugging the weird out-of-sync dirty and OE creation for extra
  large folios.

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

In the long run, we will need to support all those complex mechanism
anyway.

Qu Wenruo (8):
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
 fs/btrfs/disk-io.c     | 20 +++++++++++---
 fs/btrfs/extent_io.c   |  7 +++--
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
 18 files changed, 315 insertions(+), 146 deletions(-)

-- 
2.50.1


