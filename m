Return-Path: <linux-btrfs+bounces-10885-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECC9A085F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 04:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E931889FC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 03:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C731E32CB;
	Fri, 10 Jan 2025 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YpCjYSSY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YpCjYSSY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6362F3E
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736479928; cv=none; b=IfV9rw71gn5GuZrDqi+1tYRyebJQ2cRMLStF22GiNHjU9lzOw5lV8Yd/KuRw7ybM5l6/wILhXGR+BDThF2AAL1HrAuyKP2y9Y8GfWvedrBvDgr525KVUfGm+O+fJVN4LxYmL48bOYs8zkZUiI83DoaFis4on9Tiq5M+hl/gXrAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736479928; c=relaxed/simple;
	bh=7T21Y2RnnSu8wN68Xpj8VCz4B3wLOdAllJs+AfNUz3w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=g1PIZ1+oCLvZMil1JV05GT6sh08ZC2yN6jzuxe+jRHQUaGQ7xZmMSW3rEmE35dv+gfUfCYZuudjn9l8JhFdugza40i+ogEh2MYg6Nu0XA9DCAqIavNMpYJs7d1V6/X4bcBJvIOUPLA4EaS9yxTWjQ+3l00Hq+NXLyIFxfC/s0XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YpCjYSSY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YpCjYSSY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 508DC21169
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 03:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736479924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JWnXzON3f2ZYJ7+i4FIgI2YcRrcoOkPCGjCl2E1njiU=;
	b=YpCjYSSYrf44Z4YNQZKvZuUtzrzlTg0So6ep2R7P5mcjM/bCFo/068nFxsUn2+Q3h+q+nD
	3cfHvqfSWRQA5yZ4pkO0wipCCUzvlJdWmDvpg6bwZFi90JRrrMMTMGPYth/BjaOcrcLz0v
	auWX0c68UUQYnGJ4WZvLmZIYCAZxPv4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YpCjYSSY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736479924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JWnXzON3f2ZYJ7+i4FIgI2YcRrcoOkPCGjCl2E1njiU=;
	b=YpCjYSSYrf44Z4YNQZKvZuUtzrzlTg0So6ep2R7P5mcjM/bCFo/068nFxsUn2+Q3h+q+nD
	3cfHvqfSWRQA5yZ4pkO0wipCCUzvlJdWmDvpg6bwZFi90JRrrMMTMGPYth/BjaOcrcLz0v
	auWX0c68UUQYnGJ4WZvLmZIYCAZxPv4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D15E1397D
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 03:32:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hiBUD7OUgGe0NQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 03:32:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 00/10] btrfs: error handling fixes
Date: Fri, 10 Jan 2025 14:01:31 +1030
Message-ID: <cover.1736479224.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 508DC21169
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[CHANGELOG]
v3:
- Add a new patch to move the ordered extent cleanup into
  cow_file_range() and run_delalloc_nocow()

- Update the comment of writepage_dealloc()
  To give a more detailed view on what should be done for all the 3
  return value patterns

- Rename the variable @last_finished to @last_finished_delalloc_end
  And enhance the comment of it.

- Add a comment on why we want submit_one_bio() after
  submit_one_sector() failed

- Add a comment explaining what cleanup_dirty_folios() does

- Update the ASCII graph to use @cur_offset other than @cur_start

v2:
- Fix the btrfs_cleanup_ordered_extents() call inside
  btrfs_run_delalloc_range()

  Since we no longer call btrfs_mark_ordered_io_finished() if
  btrfs_run_delalloc_range() failed, the existing
  btrfs_cleanup_ordered_extents() call with @locked_folio will cause the
  subpage range not to be properly cleaned up.

  This can lead to hanging ordered extents for subpage cases.

- Update the commit message of the first patch
  With more detailed analyse on how the double accounting happens.
  It's pretty complex and very lengthy, but is easier to understand (as
  least I hope so).

  The root cause is the btrfs_cleanup_ordered_extents()'s range split
  behavior, which is not subpage compatible and is cursed in the first
  place.

  So the fix is still the same, by removing the split OE handling
  completely.

- A new patch to cleanup the @locked_folio parameter of
  btrfs_cleanup_ordered_extents()

I believe there is a regression in the last 2 or 3 releases where
metadata/data space reservation code is no longer working properly,
result us to hit -ENOSPC during btrfs_run_delalloc_range().

One of the most common situation to hit such problem is during
generic/750, along with other long running generic tests.

Although I should start bisecting the space reservation bug, but I can
not help but fixing the exposed bugs first.

This exposed quite some long existing bugs, all in the error handling
paths, that can lead to the following crashes

- Double ordered extent accounting
  Triggers WARN_ON_OCE() inside can_finish_ordered_extent() then crash.

  This bug is fixed by the first 3 patches.
  The first patch is the most important one, since it's pretty easy to
  trigger in the real world, and very long existing.

  The second patch is just a precautious fix, not easy to happen in the
  real world.

  The third one is also possible in the real world, but only possible
  with the recently enabled subpage compression write support.

- Subpage ASSERT() triggered, where subpage folio bitmap differs from
  folio status
  This happens most likey in submit_uncompressed_range(), where it
  unlock the folio without updating the subpage bitmaps.

  This bug is fixed by the 3rd patch.

- WARN_ON() if out-of-tree patch "btrfs: reject out-of-band dirty folios
  during writeback" applied
  This is a more complex case, where error handling leaves some folios
  dirty, but with EXTENT_DELALLOC flag cleared from extent io tree.

  Such dirty folios are still possible to be written back later, but
  since there is no EXTENT_DELALLOC flag, it will be treat as
  out-of-band dirty flags and trigger COW fixup.

  This bug is fixed by the 4th and 5th patch

With so many existing bugs exposed, there is more than enough motivation
to make btrfs_run_delalloc_range() (and its delalloc range functions)
output extra error messages so that at least we know something is wrong.

And those error messages have already helped a lot during my
development.

Patches 6~8 are here to enhance the error messages.

And the final one is to cleanup the unnecessary @locked_folio parameter
of btrfs_cleanup_ordered_extents().

With all these patches applied, at least fstests can finish reliably,
otherwise it frequently crashes in generic tests that I was unable to
finish even one full run since the space reservation regression.


Qu Wenruo (10):
  btrfs: fix double accounting race when btrfs_run_delalloc_range()
    failed
  btrfs: fix double accounting race when extent_writepage_io() failed
  btrfs: fix the error handling of submit_uncompressed_range()
  btrfs: do proper folio cleanup when cow_file_range() failed
  btrfs: do proper folio cleanup when run_delalloc_nocow() failed
  btrfs: subpage: fix the bitmap dump for the locked flags
  btrfs: subpage: dump the involved bitmap when ASSERT() failed
  btrfs: add extra error messages for delalloc range related errors
  btrfs: remove the unused @locked_folio parameter from
    btrfs_cleanup_ordered_extents()
  btrfs: move ordered extent cleanup to where they are allocated

 fs/btrfs/extent_io.c | 104 +++++++++++++----
 fs/btrfs/inode.c     | 268 +++++++++++++++++++++++++------------------
 fs/btrfs/subpage.c   |  48 +++++---
 fs/btrfs/subpage.h   |  13 +++
 4 files changed, 290 insertions(+), 143 deletions(-)

-- 
2.47.1


