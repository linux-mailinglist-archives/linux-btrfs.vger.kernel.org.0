Return-Path: <linux-btrfs+bounces-12246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AACA5EA7D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 05:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64ACB3B50F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 04:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C0986325;
	Thu, 13 Mar 2025 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YEZPSH81";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YEZPSH81"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E343915E90
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741839672; cv=none; b=iy1EtL2vSXhABISrSxP8k7QXugMJu0N0fvmQBcw8AU9Lv1A5vMpGd9R1t9zbI1NAlCvId5m53/GE+GzjSPL0X1JRm0c88kQJJpM5zuNx2/fBzVl6enZOBu/FNLodCwXyd9la+RT5LA4f3mfaIuqq4YcJx6Ugo+b5EYNtOJdwj9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741839672; c=relaxed/simple;
	bh=sz3fkRJE3tauLzU7Av1BvG+o25ofXU9H5LReyDEqQo8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XrZaPfjtLOgQcolsgcZ+m3nQcehFjSTxgRPGJaGU6JVcG1lq7Ons6tgs+8GeA8qBoMttqK3c7tjXXPhvNsx9YItZlzk6qhIIme5ZT64jgvASOHIc8Pr0M06z+8iPBjBYBFcjdNRZgm3ZB7Vusq1ZfS4Z5RT8ShuNpOIAeomIlC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YEZPSH81; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YEZPSH81; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A47162118D
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741839667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=65EsoUdm30rfWx4pePgZM1BMxYt17wgrDX97Hv9lSjs=;
	b=YEZPSH81OxWpIzefq0d2/v5IUpxj8JYyMyd5i61LgFsU7O6+0y+SF4RNHJ3rUluvovGIxR
	+dttCYdalWXJTpA26//oOH0vrFw94/gOp29Wxr6tIV9BeUGgJGWKALcPWGiya5jpv6sZV4
	/hxArwhmHkCqz5XgLvXiRIOCUEEju1I=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741839667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=65EsoUdm30rfWx4pePgZM1BMxYt17wgrDX97Hv9lSjs=;
	b=YEZPSH81OxWpIzefq0d2/v5IUpxj8JYyMyd5i61LgFsU7O6+0y+SF4RNHJ3rUluvovGIxR
	+dttCYdalWXJTpA26//oOH0vrFw94/gOp29Wxr6tIV9BeUGgJGWKALcPWGiya5jpv6sZV4
	/hxArwhmHkCqz5XgLvXiRIOCUEEju1I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8C2513797
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E2myJTJd0mcrYQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] btrfs: remove ASSERT()s for folio_order() and folio_test_large()
Date: Thu, 13 Mar 2025 14:50:42 +1030
Message-ID: <cover.1741839616.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
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

There are quite some ASSERT()s checking folio_order() or
folio_test_large() on data folios.

They are the blockage for the incoming larger data folios.

This series will remove most of them, with the following exceptions
remaining:

- wait_dev_supers() and write_dev_supers()
  They are folios from block device cache, will not be affected by our
  larger data folios support.

- relocation_one_folio()
  It's about data relocation inode, and we can disable larger data folios
  for such special inode easily.

- btrfs_attach_subpage()
  The folio_test_large() is only for metadata, just change it to be a
  metadata specific check.

- defrage_prepare_one_folio()
  It rejects larger folios gracefully so no need to handle it yet.
  Although we still need some extra work to make defrag to properly
  support larger folios.

- btrfs_end_repair_bio()
  This will be covered by a dedicated series converting the bio layer to
  use folio interfaces other than bvec interfaces.
  Until then the ASSERT() will stay.

The first patch is just a small cleanup for send, exposed during the
removal of ASSERT()s.

Qu Wenruo (7):
  btrfs: send: remove the again label inside put_file_data()
  btrfs: send: prepare put_file_data() for larger data folios
  btrfs: prepare btrfs_page_mkwrite() for larger data folios
  btrfs: prepare prepare_one_folio() for larger data folios
  btrfs: prepare end_bbio_data_write() for larger data folios
  btrfs: subpage: prepare for larger data folios
  btrfs: zlib: prepare copy_data_into_buffer() for larger data folios

 fs/btrfs/extent_io.c |  3 ---
 fs/btrfs/file.c      |  6 +-----
 fs/btrfs/send.c      | 29 +++++++++++++----------------
 fs/btrfs/subpage.c   |  6 ++----
 fs/btrfs/zlib.c      |  2 --
 5 files changed, 16 insertions(+), 30 deletions(-)

-- 
2.48.1


