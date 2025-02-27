Return-Path: <linux-btrfs+bounces-11887-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B403A47589
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 06:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552363AD0C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 05:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D431C5D6E;
	Thu, 27 Feb 2025 05:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M1pBuqih";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M1pBuqih"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93F81EB5E2
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 05:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635711; cv=none; b=RY9h4D1VaRWwePYiwF6T3NvbzadHbDqeKogp//Pf4xiFbdN5hv4jEeZGlPF7BtynlMSGUG8pqq6wef+i+SOZUjSfUGaBt99q73wfNjS9NqaLBJL3A2KH7oY6nMmty/1mjERJlYT11dRq6xm6mD7C+xVty66qCpY2MYKefwWHjI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635711; c=relaxed/simple;
	bh=zAw60nD1vhSzj/NsCiFumZK97me2Jtg4WzELn6d2ou0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UamVBIFWzsnAw6Cm1nD/Rx0/pGDmfjFpqLqtbJHjLYfrX5vqys8GJ4ncxtUqEsDaJ+MXhS9rQSiNJbHRUR1Dai0sHcoPczKsR2+t7VLsmMZS6Tyjt1pzSwLpEvv2Autkqljy1corm8DR/0AzpZO8aPHB6AStEk1cn6vNsCrxMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M1pBuqih; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M1pBuqih; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5AA041F394
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 05:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740635705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qlUmmLBgLHGB9iuGPJjPiHkSl+ELooNYhh566Z7QQ68=;
	b=M1pBuqihQmpWnl0H9xGlt5c6W7BJPB0teIpv5xrZ5HSACbr/12MNjorkxTqFKVDPOIE/SS
	eqiG80lUW8XBTCcw2tHhn1teYoX5oybPY2Gwyt74MdeNbCg1Kt8urjiKwJU7pZf/6T71DQ
	Px3TyxnP8qaH7zDtjcTMnt5a0Em1woE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=M1pBuqih
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740635705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qlUmmLBgLHGB9iuGPJjPiHkSl+ELooNYhh566Z7QQ68=;
	b=M1pBuqihQmpWnl0H9xGlt5c6W7BJPB0teIpv5xrZ5HSACbr/12MNjorkxTqFKVDPOIE/SS
	eqiG80lUW8XBTCcw2tHhn1teYoX5oybPY2Gwyt74MdeNbCg1Kt8urjiKwJU7pZf/6T71DQ
	Px3TyxnP8qaH7zDtjcTMnt5a0Em1woE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 919D81376A
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 05:55:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QORPFDj+v2ebUgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 05:55:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/8] btrfs: make subpage handling be feature full
Date: Thu, 27 Feb 2025 16:24:38 +1030
Message-ID: <cover.1740635497.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5AA041F394
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[CHANGLOG]
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
  btrfs: prevent inline data extents read from touching blocks beyond
    its range
  btrfs: subpage: do not hold subpage spin lock when clearing folio
    writeback
  btrfs: fix the qgroup data free range for inline data extents
  btrfs: introduce a read path dedicated extent lock helper
  btrfs: make btrfs_do_readpage() to do block-by-block read
  btrfs: allow buffered write to avoid full page read if it's block
    aligned
  btrfs: allow inline data extents creation if block size < page size
  btrfs: remove the subpage related warning message

 fs/btrfs/disk-io.c      |   5 -
 fs/btrfs/extent_io.c    | 229 +++++++++++++++++++++++++++++++++++-----
 fs/btrfs/file.c         |   5 +-
 fs/btrfs/inode.c        |  29 ++---
 fs/btrfs/ordered-data.c |  23 +++-
 fs/btrfs/ordered-data.h |   8 +-
 fs/btrfs/subpage.c      |  10 +-
 7 files changed, 246 insertions(+), 63 deletions(-)

-- 
2.48.1


