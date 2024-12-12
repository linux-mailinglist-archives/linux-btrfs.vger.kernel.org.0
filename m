Return-Path: <linux-btrfs+bounces-10281-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DB49EDF42
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963C3166FAD
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 06:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A996188713;
	Thu, 12 Dec 2024 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JXPUB7AM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UpQ9g3hN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BAE18455B
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733984072; cv=none; b=iVzcPWLzkzIqdwsTOsw5sv9MzXJEsDpXOpNM9uqXGr948zp3xG/8LL2NVB+EkAj98OAHZQfn3Fyxh+FrQXQb5SBkXF+Rc8nOUGdwYSZPj6lei9NJgmNtAKOgnhNYX/1fiVE4R1KFU88yWu6GhqYUFsXJYMdmGuPBiErKl3IUcU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733984072; c=relaxed/simple;
	bh=BbnrYlC/T3n4idN7VgxuFg6F6lcHqwVkoGdbDyx3Fhs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZkKAepEsOVgVWQt0TTS54BbRSbus9EeZ1PZ2ZinYr3r39D5zwl90COz6Uv+pZap0KHXsm7FzDjbVJuqlK1SZ6B9FR6ZmL9bblo12dQh9ChDVWBbd+2Ua8IZZ+IwQlfUlDQ606SlUyiB5sNQmlB/ybwz5fmdCl/8NfKAWim+tOUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JXPUB7AM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UpQ9g3hN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C65D2116C
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 06:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733984063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LVdp5SkZ4Q1ao9FJYvxGte/b00DTddpfjghpDTp3bbc=;
	b=JXPUB7AMXNFue9WY/ZCxFESEGQAD0jh6FheW2DgrpzECTe+5rWMKnvEnoVJqBbGISqUC9K
	q5KlluSfSFXTecpj9nPWRcCxkw6CRwg6+6YMifnBUvvy9OVJf3Sko3898AN0sXewwDDnQx
	nhwqXRwu7sLAWa4j0OQu/B8P5AwGIT0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733984062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LVdp5SkZ4Q1ao9FJYvxGte/b00DTddpfjghpDTp3bbc=;
	b=UpQ9g3hNeNHxGbEGC3oH1F7nMO/ouaiUwax1+heJjpWbeACiBQLmpCqYDdg0iaeDxko7py
	kdVvNKGIIwgYB8o3pciCdNhwxejof2Trcz8XB6DmZAfj3rmnwE1ZuBLtgCORuiFWbKjnlR
	q2Il5VS7m6Nm4QqXXRd5Kcl1eTkObCY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 775D313508
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 06:14:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OEAKDT1/Wme5VQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 06:14:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/9] btrfs: error handling fixes
Date: Thu, 12 Dec 2024 16:43:54 +1030
Message-ID: <cover.1733983488.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
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

[CHANGELOG]
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


Qu Wenruo (9):
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

 fs/btrfs/extent_io.c |  79 ++++++++++++---
 fs/btrfs/inode.c     | 230 +++++++++++++++++++++++++------------------
 fs/btrfs/subpage.c   |  48 ++++++---
 3 files changed, 235 insertions(+), 122 deletions(-)

-- 
2.47.1


