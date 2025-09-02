Return-Path: <linux-btrfs+bounces-16576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B395B3F98C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 11:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167E94E12CD
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 09:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3382EA753;
	Tue,  2 Sep 2025 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pllgQ6BX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pllgQ6BX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF0122A80D
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803758; cv=none; b=IVM1U6IWZLyfMtPCy262sdujcHOYEOwQGptAiqyDkn7/6KNL60D9UlBtdqaXehEkd4f2W1U0cUkbQmPfA6hPiOrRlYmhUMPHrTDNQ31T+Od3H8u4993u/W/b+vYC7Aa725bnQI3q4kfngE9NK8YANRmNnPJfGbW5FrF0tvd9DbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803758; c=relaxed/simple;
	bh=3Hqw1/R5JlidRFEMPtcaMf0KnrH5UH52kgQFytYCwlw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MNIkIGQDRFXXWuZcYSYo11mZfnJhs0pVvUrE/zTKZlUTDkbnX91mf8eYOH1qFXE8g9KSXeYy4L7bpJrOA8Z9baEacZ02OVTlwevibJJCOo8KpdPVGFble19Jr3++eD1UXNukYilXpS41BhudK2i+0rpj3jUqQW48JPIbZNcaYRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pllgQ6BX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pllgQ6BX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9DC571F44E
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756803754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XjyBC1PXZBKp28tHmiiQeoBSh3OQDu7ubs6HZM53/28=;
	b=pllgQ6BX4XRWhmedzOeEFph7pqm6NHGZby/fbVJ7G3biwXUTzPP0sxbwPwWw9V7EuwGgWA
	DEOXPktHa6HH08qnlIS9WKihNEvbqNtCcpBnr0SzszuAE3ePBlqHrbXeGKecsULqsDm4jd
	SpQxbOwWAqlEFDW198pUG7+ZWb4gRJc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756803754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XjyBC1PXZBKp28tHmiiQeoBSh3OQDu7ubs6HZM53/28=;
	b=pllgQ6BX4XRWhmedzOeEFph7pqm6NHGZby/fbVJ7G3biwXUTzPP0sxbwPwWw9V7EuwGgWA
	DEOXPktHa6HH08qnlIS9WKihNEvbqNtCcpBnr0SzszuAE3ePBlqHrbXeGKecsULqsDm4jd
	SpQxbOwWAqlEFDW198pUG7+ZWb4gRJc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D446913888
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id inXWJKmytmgMBAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 02 Sep 2025 09:02:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/5] btrfs: bs > ps support preparation
Date: Tue,  2 Sep 2025 18:32:11 +0930
Message-ID: <cover.1756803640.git.wqu@suse.com>
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
X-Spam-Score: -2.80

One of the blockage for bs > ps support is the conflicts between all the
single-page bvec iterator/helpers (like memzero_bvec(),
bio_for_each_segment() etc) and large folios (with highmem support).

For bs > ps support, all the folios will have a minimal order, so that
each folio will cover at least one block. This saves the hassle of the
fs to handle sub-block contents.

However for all those single-page bvec iterator/helpers, they can only
handle a bvec that is no larger than a page.

To address the conflicting features, go a completely different way to
handle a fs block:

- Use phys_addr_t to represent a block inside a bio
  So we won't need to bother the sp bvec helpers, just pass a single
  paddr around.

- Do proper highmem handling for checksum generation/verification
  Now we will grab the folio from using the paddr, and make sure the
  folio will cover at least one block starting at the paddr.

  If the folio is highmem, do proper per-page kmap_local_folio()/kunmap()
  to handle highmem.
  Otherwise do a full block csum calculation in one go.

  This should brings no extra overhead except the paddr->folio
  conversion (which should be really tiny), as for systems without
  HIGHMEM, folio_test_partial_kmap() will always return false, and the
  HIGHMEM path will be optimized out by the compiler completely.

  Unfortunately I don't have a 32bit VM at hand to test.

- Introduce extra marcos to iterate blocks inside a bio
  Two macros, btrfs_bio_for_each_block() which starts at the specified
  bio_iter.
  The other one, btrfs_bio_for_each_block_all() will go through all
  blocks in the bio.

  Both returns a @paddr representing a block. Callers are either using
  paddr based helper like
  btrfs_calculate_block_csum()/btrfs_check_block_csum(), or RAID56 which
  is already using paddr.

  For now it's only utilized by btrfs, bcachefs has a similar helper and
  that's my inspiration.

  I hope one day it can be escalated to bio.h.

With all those preparation done, btrfs now can support basic file
opeartions with bs > ps support, but still with quite some limits:

- No compression support
  The compressed folios must be allocated using the minimal folio order.
  As btrfs_calculate_block_csum() requires the minimal folio size.

- No RAID56 support
- No scrub support
  The same as compression, currently we're allocating the folios in page
  size.
  Although raid56 codes are now using the btrfs_bio_for_each_block*()
  helpers, the underlying folio sizes still needs update.

[Changelog]
v2:
- Use paddr to represent a block inside a bio
  This makes a lot of data checksum handling much easier to read.
  And make csum verification/generation to properly follow all the
  highmem helpers, by doing kmap inside the helper, not requiring the
  callers to do kmap.

- Fix a compiler warning when caching max and min folio order
  Remove the fs_info local variable, as for non-experimental builds it
  is not utilized.

Qu Wenruo (5):
  btrfs: support all block sizes which is no larger than page size
  btrfs: concentrate highmem handling for data verification
  btrfs: introduce btrfs_bio_for_each_block() helper
  btrfs: introduce btrfs_bio_for_each_block_all() helper
  btrfs: cache max and min order inside btrfs_fs_info

 fs/btrfs/bio.c         | 22 +++++++-------
 fs/btrfs/btrfs_inode.h | 14 +++++----
 fs/btrfs/disk-io.c     |  2 ++
 fs/btrfs/file-item.c   | 26 ++++-------------
 fs/btrfs/fs.c          |  4 +++
 fs/btrfs/fs.h          |  2 ++
 fs/btrfs/inode.c       | 59 ++++++++++++++++++++++++++------------
 fs/btrfs/misc.h        | 49 +++++++++++++++++++++++++++++++
 fs/btrfs/raid56.c      | 65 ++++++++++++++++--------------------------
 fs/btrfs/scrub.c       | 18 ++++++++++--
 10 files changed, 162 insertions(+), 99 deletions(-)

-- 
2.50.1


