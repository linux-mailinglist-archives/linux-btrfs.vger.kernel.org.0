Return-Path: <linux-btrfs+bounces-4907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EB88C2DE2
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2024 02:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ADDF1F21776
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2024 00:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13298F5C;
	Sat, 11 May 2024 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VhC4xdtX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VhC4xdtX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31434647
	for <linux-btrfs@vger.kernel.org>; Sat, 11 May 2024 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715386537; cv=none; b=VLg/2w1014us6RbZhVVNTBWhjwX5ZyEE0nVpCyn82/ckQf3WZbIZ2kWLsF5mLS1EXxTAUjjxeddk0Nzi/8Hap8QDxUVQvUnzOgmZgWm3m42dMaqrQaVPsajlsB4jIQVb5adQjhFjlGyCk29yWs0CWw4L7pTKQPZnwrX8WbaTl/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715386537; c=relaxed/simple;
	bh=2nww0sn6LG8jCbCx8vRpxVCl5h9NytmkrJTkWfRPQD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDMCv3vpAmc0gU0HzgwNrRYfG0ORwm+Fptlu3ROg/3ZRe7fd/6fyOSjiyIp9Jgsl8YUNJi2mz8de1Y+eBiqeBlvq5XXZgGd5EYRnQfHNwshzKc9G5UvGto3j5QTDmZioovZXjRUTd4Va/EetP4s8ud40T0vN9eGpNZVTDus4O74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VhC4xdtX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VhC4xdtX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0102121B6C;
	Sat, 11 May 2024 00:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715386532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4XOpczWSkN25YXSWu250NOvXI76Jer8dW4s6vifV+EM=;
	b=VhC4xdtXLqnXcgAq5Adm7iXChTQS1OrOS++3NrM5bc83tMDY7SaLfPF0/yh25mXNjVAkux
	ZFLftw4heQnUSA2Znt7Fj5BK2H+rZjaHN8gosrV1YzqPxHM7WzpgvMwI6rC5L0E7aIrtOu
	x6j3MtPHECNP2hHdcUNPXpwBX4+z0Is=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715386532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4XOpczWSkN25YXSWu250NOvXI76Jer8dW4s6vifV+EM=;
	b=VhC4xdtXLqnXcgAq5Adm7iXChTQS1OrOS++3NrM5bc83tMDY7SaLfPF0/yh25mXNjVAkux
	ZFLftw4heQnUSA2Znt7Fj5BK2H+rZjaHN8gosrV1YzqPxHM7WzpgvMwI6rC5L0E7aIrtOu
	x6j3MtPHECNP2hHdcUNPXpwBX4+z0Is=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70D8B13A3D;
	Sat, 11 May 2024 00:15:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id apl1B6K4PmYcPAAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 11 May 2024 00:15:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: josef@toxicpanda.com,
	Johannes.Thumshirn@wdc.com
Subject: [PATCH v4 0/6] btrfs: subpage + zoned fixes
Date: Sat, 11 May 2024 09:45:16 +0930
Message-ID: <cover.1715386434.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

[CHANGELOG]
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
  Thus we may try to submit pages which has no OE for it.

  This would be addressed by patch 1~4

- Some dirty range is not submitted thus OE would never finish
  This happens due to the mismatch that extent_write_locked_range() can
  clear the full page dirty, even if we're only submitting part of the 
  dirty ranges.

  Then later __extent_writepage_io() would refuse to submit a non-dirty
  page, and the check is only checking the full page dirty flag, not the
  subpage bitmaps.

  This would be addressed by patch 5~6.


Qu Wenruo (6):
  btrfs: make __extent_writepage_io() to write specified range only
  btrfs: lock subpage ranges in one go for writepage_delalloc()
  btrfs: subpage: introduce helpers to handle subpage delalloc locking
  btrfs: migrate writepage_delalloc() to use subpage helpers
  btrfs: do not clear page dirty inside extent_write_locked_range()
  btrfs: make extent_write_locked_range() to handle subpage writeback
    correctly

 fs/btrfs/extent_io.c | 105 +++++++++++++++++++++++++------
 fs/btrfs/subpage.c   | 144 +++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/subpage.h   |  10 ++-
 3 files changed, 233 insertions(+), 26 deletions(-)

-- 
2.45.0


