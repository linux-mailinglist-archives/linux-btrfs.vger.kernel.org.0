Return-Path: <linux-btrfs+bounces-5085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338A18C8FA6
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2024 07:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA0A281ADB
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2024 05:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB3DB661;
	Sat, 18 May 2024 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fhbJtSge";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kAttnSsE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F38F44
	for <linux-btrfs@vger.kernel.org>; Sat, 18 May 2024 05:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716008887; cv=none; b=rEcdOKvJ9Sf9O/gBZrVyFV5VV73DRHxcWFpM2Af474Abnc4O+O+7NJ2AWlpWcYx+GzmgLp+BJ9ItaKSS2jYvzJs3m0MemNXThl4yX7IAXj+B2Ld4dhcoWwESjsJMMEjU+BVufyE7s+8eYvcK4+PooU+SHD+ypkv2IJ2zRFw+TnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716008887; c=relaxed/simple;
	bh=OIMdec6HIEAuceF7KH1kZKBXn+VnarQogTZqrp9wlOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jG4mdXIg9nvYCEUXWXZJ7roi6X3u72ToPWK2GoNreA/uI2oVRG4K3nmN0FbmBpbVkdS7Zy0rmf6e4mJQsmXbIjniFtEJRdPtmZbiHvIk/FHedbjVSETTUchfpP3D39K4kLW89Z3Jy79mcxuMJFNjB4DCDAgXj1ELib+c3qWrjI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fhbJtSge; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kAttnSsE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D15A1219BC;
	Sat, 18 May 2024 05:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716008883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=c4wF6fthogM9sqflzW9yLpYElqoCfG5Va4UU2cl6oJU=;
	b=fhbJtSgebWgvYXJN3GveB61irtCHliLKO2f5k/Oq8SJkTQE1zPnO6+yo1MglHIM1vQFa7O
	88ed8nTyICXs8yys/azdYMK+6aS/EVtSS1O9AwIvEnfjFXUweeH10Pk8Ad3ztNDEYF9miw
	NxzyPrvLMQlXOTM3oH877GgWbIpvrX0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kAttnSsE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716008882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=c4wF6fthogM9sqflzW9yLpYElqoCfG5Va4UU2cl6oJU=;
	b=kAttnSsECnFcvoDqIdg0Gh1jMzIqKdNZoYReLvCgmZEq96yVTCcnnYsQPyVgNfMne6lAkG
	dSKqA1BT3BzDLhNyNp4/JGB9aBIdXt39M0lqV3CCrUQOsNngTo48iO8jyYNYYy443dkmNQ
	guYY7Ev/ovYyzkale1keYTlDdlhB/7M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A0E213942;
	Sat, 18 May 2024 05:08:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CP1dBbE3SGbnXgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 18 May 2024 05:08:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes.Thumshirn@wdc.com,
	josef@toxicpanda.com
Subject: [PATCH v5 0/5] btrfs: subpage + zoned fixes
Date: Sat, 18 May 2024 14:37:38 +0930
Message-ID: <cover.1716008374.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D15A1219BC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.01

[CHANGELOG]
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

 fs/btrfs/extent_io.c | 105 +++++++++++++++++++++++++------
 fs/btrfs/subpage.c   | 144 +++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/subpage.h   |  10 ++-
 3 files changed, 233 insertions(+), 26 deletions(-)

-- 
2.45.0


