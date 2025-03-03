Return-Path: <linux-btrfs+bounces-11961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D82EA4B970
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 09:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D9618890D2
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 08:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB381EB1BF;
	Mon,  3 Mar 2025 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mxhY7o+V";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mxhY7o+V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84A31B0406
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990944; cv=none; b=ZV9irGq3KLOltUY+wmYQDjgWD25/gAMhvH6dxfO8F9vuK3kCWTrOMZlQqaihmRtNVZSNSXllvV5ChsfW2anumdNBIa/RmctTyGlgRa6sLDcyrtW+6D24WRofUsFWi8C89LP3E68qUA2aDY5x0jon3o76F++SEW3PuH6/IuHSmmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990944; c=relaxed/simple;
	bh=TRh3jHAAJT79ud77R91ETaz4hmXUUXlel8BL5XS1x+Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fKAHZ74wRq3tg5w6mYnX353IoG4x+Vn4DBw8wxXpsVDlawXCZO6eDau8JflPxFFtC96Qe3UmqPxMOSK5wvu9WL0zFa3mmt8EZvqnNUqLTpFPKR5s8ql4czLIa+OPFscNye2I5wneAunJV9iLGBS7TYXzTRbgPeESq67Xp+i0RAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mxhY7o+V; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mxhY7o+V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF6DE1F441
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 08:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740990934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v0yjjRW6rUavLDbJmKDYD7ssSJ+XWS7GTX4WoEFa+44=;
	b=mxhY7o+VdT8NipZXZ8EZozQMIbhQa9nEkPL9hRT94eCgsEDX/YV8Z5FWna03dyQ4le1u/S
	UHLSdzWQ8GLOuJ+YDhKy4NKDDhm4Hwasvx2BKzfoJ+pPNZr6u3GY0LKEa6VjS14ICjPsZU
	+Hn7o3In/Zwj0gHsOHYXEJ/S9EPKdag=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740990934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v0yjjRW6rUavLDbJmKDYD7ssSJ+XWS7GTX4WoEFa+44=;
	b=mxhY7o+VdT8NipZXZ8EZozQMIbhQa9nEkPL9hRT94eCgsEDX/YV8Z5FWna03dyQ4le1u/S
	UHLSdzWQ8GLOuJ+YDhKy4NKDDhm4Hwasvx2BKzfoJ+pPNZr6u3GY0LKEa6VjS14ICjPsZU
	+Hn7o3In/Zwj0gHsOHYXEJ/S9EPKdag=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF7F513939
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 08:35:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iwTkK9VpxWdybwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 03 Mar 2025 08:35:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/8] btrfs: make subpage handling be feature full
Date: Mon,  3 Mar 2025 19:05:08 +1030
Message-ID: <cover.1740990125.git.wqu@suse.com>
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
X-Spam-Level: 

[CHANGLOG]
v3:
- Drop the btrfs uncached write support
  It turns out that we can not move the folio_end_writeback() call out
  of the spinlock for now.

  Two or more async extents can race on the same folio to call
  folio_end_writeback() if not protected by a spinlock, can be
  reproduced by generic/127 run loops with experimental 2k block size
  patchset.

  Thus disabling uncached write is the smallest fix for now, and drop
  the previous calling-folio_end_writeback()-out-of-spinlock fix.

  Not sure if a full revert is better or not, there is still some valid
  FGP flag related cleanup in that commit.

v2:
- Add a new bug fix which is exposed by recent 2K block size tests on
  x86_64
  It's a self deadlock where the folio_end_writeback() is called with
  subpage lock hold, and folio_end_writeback() will eventually call
  btrfs_release_folio() and try to lock the same spin lock.

- Various grammar fixes and commit message/comments updates

- Address comments from Filipe and adds his tags

v1:
- Merge previous two patches into one
- Re-order the patches so preparation/fixes are always before feature
  enablement
- Update the commit message of the first patch
  So that we do not focus on the out-of-tree part, but explain why it's
  not ideal in the first place (double page zeroing), and just mention
  the behavior change in the future.

Since the introduction of btrfs subapge support in v5.15, there are
quite some limitations:

- No RAID56 support
  Added in v5.19.

- No memory efficient scrub support
  Added in v6.4.

- No block perfect compressed write support
  Previously btrfs requires the dirty range to be fully page aligned, or
  it will skip compression completely.

  Added in v6.13.

- Various subpage related error handling fixes
  Added in v6.14.

- No support to create inline data extent
- No partial uptodate page support
  This is a long existing optimization supported by EXT4/XFS and
  is required to pass generic/563 with subpage block size.

The last two are addressed in this patchset.

And since all features are implemented for subpage cases, the long
existing experimental warning message can be dropped, as it is already
causing a lot of concerns for users who checks the dmesg carefully.

Qu Wenruo (8):
  btrfs: disable uncached writes for now
  btrfs: prevent inline data extents read from touching blocks beyond
    its range
  btrfs: fix the qgroup data free range for inline data extents
  btrfs: introduce a read path dedicated extent lock helper
  btrfs: make btrfs_do_readpage() to do block-by-block read
  btrfs: allow buffered write to avoid full page read if it's block
    aligned
  btrfs: allow inline data extents creation if block size < page size
  btrfs: remove the subpage related warning message

 fs/btrfs/disk-io.c      |   5 -
 fs/btrfs/extent_io.c    | 228 +++++++++++++++++++++++++++++++++++-----
 fs/btrfs/file.c         |  18 +++-
 fs/btrfs/inode.c        |  29 ++---
 fs/btrfs/ordered-data.c |  23 +++-
 fs/btrfs/ordered-data.h |   8 +-
 6 files changed, 248 insertions(+), 63 deletions(-)

-- 
2.48.1


