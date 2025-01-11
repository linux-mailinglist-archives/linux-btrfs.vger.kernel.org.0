Return-Path: <linux-btrfs+bounces-10914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D1A0A2DF
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 11:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B36A87A324A
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 10:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EC11917F9;
	Sat, 11 Jan 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J1oUWao6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J1oUWao6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C47191F6F
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Jan 2025 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736592251; cv=none; b=Y3O5AMflXLxxY565Z0gn5FUm8KHhgqv6BWlHTlD+jymd2rwWm8Vl1zZD/ad8nvqIaO1NSYwwGk8epuIm3kjRAjdWVKGjB5AbT769evM9tACmM5q+sxYMqTdX1eCZLNAtWOrp2MCTNSDkkEmMJaWo21Uawr08B1zkvnDADdLgBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736592251; c=relaxed/simple;
	bh=mD5CjNOzW7uF+cr06sJuL1LsFPLqYfZNYSCab0y4bY4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eEd2lID/0+FDZK0DrazeqeWuMe+aaLD8YZLUqh2GBEpNPjpXyzD+RKk+WW4JsLIhpzLHrJp4ozL5l8v+AiZNKXNDF7askXATKGSKVvFC2MDINwTz7Oq7yUpSxSQPEppbeT7uI73u9BqsUBLnxUuAiy7miKxalMwrdOfF7yaGYvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J1oUWao6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J1oUWao6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B279D21108
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Jan 2025 10:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736592246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=d8TQWRK5RCrQWqTQlrx/YHkbvCxv3SKn87tRnQwg58U=;
	b=J1oUWao6nduTCpm9ongkLxj8QTRplWev7OHf74+xEqIurme23jQdh2O/VCPnmbi3k5hUzq
	fnsv7aoReG8/BuaX+ZiDhW+K2Ih2W229TSXc9d4Ex1IHLhPOWWszdsuhLn0ySHU+TAKYBu
	ZplGAE9euWUjPB/PUJdCrndpR9UbjRw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736592246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=d8TQWRK5RCrQWqTQlrx/YHkbvCxv3SKn87tRnQwg58U=;
	b=J1oUWao6nduTCpm9ongkLxj8QTRplWev7OHf74+xEqIurme23jQdh2O/VCPnmbi3k5hUzq
	fnsv7aoReG8/BuaX+ZiDhW+K2Ih2W229TSXc9d4Ex1IHLhPOWWszdsuhLn0ySHU+TAKYBu
	ZplGAE9euWUjPB/PUJdCrndpR9UbjRw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E65A4139AB
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Jan 2025 10:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TTlWKXVLgmdCLgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Jan 2025 10:44:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 00/10] btrfs: error handling fixes
Date: Sat, 11 Jan 2025 21:13:34 +1030
Message-ID: <cover.1736591758.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
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
X-Spam-Score: -2.80
X-Spam-Flag: NO

[CHANGELOG]
v4:
- Rebased to the latest for-next branch
  This involves several minor conflicts due to the recent cleanup.

- Minor comment/commit message update

- Use btrfs_root_id() for error messages

- Fix the double accounting error reintroduced in the last patch
  Where the run_delalloc_nocow() function has a very weird handling for
  COW fallback, where @cur_offset can either be @cow_start or @cow_end
  depending on the fallback_to_cow() entrance.

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

Patch 9 is to cleanup the unnecessary @locked_folio parameter
of btrfs_cleanup_ordered_extents().

The final one is to make ordered extent cleanup to be more sane,
following the common reclaim-asap principle, other than delay the
cleanup until btrfs_run_delalloc_range().

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

 fs/btrfs/extent_io.c | 104 ++++++++++++----
 fs/btrfs/inode.c     | 279 ++++++++++++++++++++++++++-----------------
 fs/btrfs/subpage.c   |  47 ++++++--
 fs/btrfs/subpage.h   |  13 ++
 4 files changed, 300 insertions(+), 143 deletions(-)

-- 
2.47.1


