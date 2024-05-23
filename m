Return-Path: <linux-btrfs+bounces-5238-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 855DC8CCCB4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 09:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8EE91C21F39
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 07:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4768513C9C8;
	Thu, 23 May 2024 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cxzdi59Z";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cxzdi59Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87313C9B8
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447974; cv=none; b=qMk/duhJeVcRoyRqy/Xp7I6f4iHtPgXnnovHg8JDBjGxRDKYQUCz+8KbrVteqhZF9UqvTQGhI6ta3aDFwtOQUyxBbOayRptvVi6dDeMhOZ70Jep8/1DYyVvyNAfHpvV5fRWuSDWafP5WNzKYtRWdbe2ag97M+kUtmdEJo27DF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447974; c=relaxed/simple;
	bh=OprDyt7sZfrnjYtNUtI2ZDsgdOaLAdWwQgnU+fJmFK0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K7YliqMQaxvqAy3h/r4iBMJ6H8h1g4YO9kByGUCHuX4omYOcpzf/TVWrBg+KspnfTOr8dSrqVw8EHjft79oUxywMQ9g767bZKGf7daIneL8evm4+nOS6Cy5HhYX5u3UWKxEOsA9Xj67THPV7oUTb9mEDf3mlSmiVB3UGHsPBQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cxzdi59Z; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cxzdi59Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4856922293
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 07:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716447970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=73OR4x2qGyMBl0YMQkTvZnrMbhq8/yLWBw2wYgH6r7k=;
	b=cxzdi59ZFSrHkQpWEf1hhiXu/gzqVn17jVXidFLa+6K0Q+03mgTf2dYNjzVVulP6OoO951
	OXno8/olpAMRwfd0wgcKbYlousEpkz9PqrNRZDtaL9Aj5Hy5Vm483pzzD+z218bqo+pRtx
	CcS2wL5Ih6/NjbhacBG927pO3HP+ieM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cxzdi59Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716447970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=73OR4x2qGyMBl0YMQkTvZnrMbhq8/yLWBw2wYgH6r7k=;
	b=cxzdi59ZFSrHkQpWEf1hhiXu/gzqVn17jVXidFLa+6K0Q+03mgTf2dYNjzVVulP6OoO951
	OXno8/olpAMRwfd0wgcKbYlousEpkz9PqrNRZDtaL9Aj5Hy5Vm483pzzD+z218bqo+pRtx
	CcS2wL5Ih6/NjbhacBG927pO3HP+ieM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54C0413A7D
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 07:06:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zKMwAuHqTmb0bwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 07:06:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v6 0/5] btrfs: subpage + zoned fixes
Date: Thu, 23 May 2024 16:35:41 +0930
Message-ID: <cover.1716445070.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4856922293
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

[CHANGELOG]
v6:
- Use unsigned int for bit map related members

- One extra ASSERT() to make sure our bit range never exceed the bitmap

- One extra ASSERT() for btrfs_run_delalloc_range() returning >0 case

- "dealloc" typo fix

- Small changes inside writepage_delalloc() main loop to make it a
  little easier to read

v5:
- Enhance the commit message on why we should not clear page dirty
  inside extent_write_locked_range()

- Reorder the patches so that no temporary list based solution for
  delalloc ranges

v4:
- Rebased to the latest for-next branch
  Thankfully no conflicts at all.

- Include all the previous preparation patches
  It turns out I split the preparation into other series and even get
  myself confused.

- Use the correct commit message from my local branch
  It turns out Josef is totally correct, the problem I described in
  "btrfs: do no clera page dirty inside extent_write_locked_range()" is
  really confusing, it has direct IO involved and my local branch is
  already using a much better commit and I just forgot it.
 
v3:
- Use the minimal fsstress workload with trace_printk() output to
  explain the bug better

v2:
- Update the commit message for the first patch
  As there is something wrong with the ASCII art of the memory layout.

[REPO]
https://github.com/adam900710/linux/tree/subpage_delalloc

If running subpage with zoned devices (TCMU emulated HDD, 64K or 16K
page size with 4K sectorsize), btrfs can easily hitting various bugs:

- ASSERT()s related to submitting page range which has no OE coverage

- Various reserved space leakage and some OE never finished

This is caused by two major reasons:

- run_delalloc_cow() is not subpage compatible
  There are several different problems involved furthermore.

  * extent_write_locked_range() would try to submit dirty pages beyond
    the specified subpage range
    Thus hit some ASSERT() that a dirty range has no corresponding OE


  * extent_write_locked_range() would unlock the whole page meanwhile
    we're only triggered for a subpage range
    Thus causing unexpected page to be unlocked.

  This would be addressed by patch 1~3 by:

  * Limited the submission range to follow the subpage ranges

  * Make the page unlocking part also subpage compatible, and always
    lock all delalloc subpage ranges covering the current page.

- Some dirty range is not submitted thus OE would never finish
  This happens due to the mismatch that extent_write_locked_range() can
  clear the full page dirty, even if we're only submitting part of the 
  dirty ranges, causing page dirty flags desync from subpage dirty
  flags.

  Then later __extent_writepage_io() would skip a non-dirty page, as the
  check is only checking the full page dirty flag, not the
  subpage bitmaps.

  This would be addressed by patch 4~5.


Qu Wenruo (5):
  btrfs: make __extent_writepage_io() to write specified range only
  btrfs: subpage: introduce helpers to handle subpage delalloc locking
  btrfs: lock subpage ranges in one go for writepage_delalloc()
  btrfs: do not clear page dirty inside extent_write_locked_range()
  btrfs: make extent_write_locked_range() to handle subpage writeback
    correctly

 fs/btrfs/extent_io.c | 132 +++++++++++++++++++++++++++++++------
 fs/btrfs/subpage.c   | 150 +++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/subpage.h   |  10 ++-
 3 files changed, 266 insertions(+), 26 deletions(-)

-- 
2.45.1


