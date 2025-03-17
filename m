Return-Path: <linux-btrfs+bounces-12313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA8CA642FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 08:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89C327A279A
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 07:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715DC21A45C;
	Mon, 17 Mar 2025 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XqnOzTU7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lkpKBRHw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A814A1C6FF3
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195491; cv=none; b=rpXad+e+JYY8UyeXnW6u9svcf50xF5A/VoquWB4OCxTJ9dNd0K7ErBeB0swqZsw7Rpg9ckaFrcyAglsacBwem+6mvRAVT9lWn91lmugUpu3eK1RkHOONlEMpd1z3yn7PUGBnLbN1usV0yPXQtixisCL2dl9Mf/TTn4c/gNZ3OuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195491; c=relaxed/simple;
	bh=knWpqEPtXG5jfVPA+bKo7YhlOZw3WyzJf1OaTga/0Io=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ItlrrclwcUjRozQiNHdoI6TJ72r03KlU2Sw7C5aaaNbt6hyc734OiHcom/RMYbZz+1IwZDKHX5+hY+1BS2hzxJEC0ocSncv5LzeFyEiclTPM72JGn2cKijBu2L9ihckFn7hHVKOghWb6bPlPV/YQICJu+pBTQjqADIF/514gxEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XqnOzTU7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lkpKBRHw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA6BB220D1
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WYWkj7HexIF9OlUtrHGN6C8Nl0VLLEuGicFQv8+Puug=;
	b=XqnOzTU7Hd+mU+qoMreYNZn8pA1aK3hNzqz+Bznk+BQ+Ybfj4Xn2wwbRqUOjdzZJMRQOor
	U2MZ49pXFDeZ9yDfPBYcsRlZ2tT4ELoQ4GUDctmsD16XDWpuKSMoxeGVbTcs9cKFwHlOdy
	EmJVp8+55U4ui3+sJ+cJ5NQyMws7WJI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WYWkj7HexIF9OlUtrHGN6C8Nl0VLLEuGicFQv8+Puug=;
	b=lkpKBRHwIwQpQNkWW01XTm+NIqMwpLK33DzkPPmFOdZxZhGhp4x99BxaDIYqnQexA+T+KE
	2APceo4lNH912Zwf1QnQ18W14e1J2BY/QZEA0QB1lNnvUYNr+hMahnA5VG0rnENiPoMn3r
	zuLHrRU7RsAXbgXwtktS7ww6D3rJyVQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D849139D2
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +DykMxfL12e1YwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/9] btrfs: remove ASSERT()s for folio_order() and folio_test_large()
Date: Mon, 17 Mar 2025 17:40:45 +1030
Message-ID: <cover.1742195085.git.wqu@suse.com>
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
X-Spam-Level: 

[CHANGELOG]
v3:
- Prepare btrfs_end_repair_bio() to support larger folios
  Unfortunately folio_iter structure is way too large compared to
  bvec_iter, thus it's not a good idea to convert bbio::saved_iter to
  folio_iter.

  Thankfully it's not that complex to grab the folio from a bio_vec.

- Add a new patch to prepare defrag for larger data folios

v2:
- Update the commit message for the first patch

There are quite some ASSERT()s checking folio_order() or
folio_test_large() on data folios.

They are the blockage for the incoming larger data folios.

This series will remove most of them, with the following exceptions
which are not a blockage for larger data folios.

- wait_dev_supers() and write_dev_supers()
  They are folios from block device cache, will not be affected by our
  larger data folios support.

- relocation_one_folio()
  It's about data relocation inode, and we can disable larger data folios
  for such special inode easily.

- btrfs_attach_subpage()
  The folio_test_large() is only for metadata, just change it to be a
  metadata specific check.

The first patch is just a small cleanup for send, exposed during the
removal of ASSERT()s.

The conversion for defrag is only tested to not break the existing
subpage and regular cases.
The full tests can only be done with larger data folios support enabled.

Although there is one real blockage before enabling larger data folios:

- btrfs_buffered_write()
  Currnetly we always reserved space first, then grab the folio.
  This makes it impossible to support variable sized folios.

  We have to align the behavior to iomap, which grab the folio first
  then determine the reserved space according to the folio size.

  This will touch the core function of btrfs and can not be hidden
  behind experimental flags.
  Thus that change will be a dedicated one and needs a lot of
  reviews/tests.

Qu Wenruo (9):
  btrfs: send: remove the again label inside put_file_data()
  btrfs: send: prepare put_file_data() for larger data folios
  btrfs: prepare btrfs_page_mkwrite() for larger data folios
  btrfs: prepare prepare_one_folio() for larger data folios
  btrfs: prepare end_bbio_data_write() for larger data folios
  btrfs: subpage: prepare for larger data folios
  btrfs: zlib: prepare copy_data_into_buffer() for larger data folios
  btrfs: prepare btrfs_end_repair_bio() for larger data folios
  btrfs: enable larger data folios support for defrag

 fs/btrfs/bio.c       | 28 ++++++++++++-----
 fs/btrfs/defrag.c    | 72 ++++++++++++++++++++++++++------------------
 fs/btrfs/extent_io.c |  3 --
 fs/btrfs/file.c      |  6 +---
 fs/btrfs/send.c      | 29 ++++++++----------
 fs/btrfs/subpage.c   |  6 ++--
 fs/btrfs/zlib.c      |  2 --
 7 files changed, 79 insertions(+), 67 deletions(-)

-- 
2.48.1


