Return-Path: <linux-btrfs+bounces-17325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F93BB22F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 02 Oct 2025 02:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2DC3A4D3F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 00:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936331758B;
	Thu,  2 Oct 2025 00:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PTL0JuAt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PTL0JuAt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D27DF76
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 00:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759366635; cv=none; b=cC4LLmpqD7DRleowIGs9xzptkOGV+AesCzZxLJyQbhUDZ2wikTtQrUXReQ5pnbl3YHG2bHhCuoiqRIup2Psr2jRvu3xSSs4y7kJ6Ep/Yd/YhjgH2rc1zcN+FQmvyUEb/drroTYwLJ5I8r2t/hZcjgbRQyfZc7sQqrFYG+uy/4og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759366635; c=relaxed/simple;
	bh=nvpTpVYbB5GclLGwZz9q2fRNrDlUqOGK78L9v48PHj4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ViHcI4EFQsxzkOttgfG5nNYBReiIArxjUfZ8/cXnNo8Ytj3KbANQukKvxc1cpiJrx9LasaRhb1PY3n7lyiMzc2prTSr9qAvgTtdkE7iWs8J7acy06nTp6Edp8KNNjbJU3cToaZJBgFWHgVcxV00760R9PuyZpXt9hF37x0g7QZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PTL0JuAt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PTL0JuAt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 797E11F7C4;
	Thu,  2 Oct 2025 00:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759366631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C8MRozaVt9gYL1syIdXOg8Z1DtvDkklB1BuOVnjzjrE=;
	b=PTL0JuAtFrnNrLNLp2lC17PwFSaisBkA9BtaUy9QI/H4GtFs8iUzC9xYhJi6tYrgU9OwyZ
	FfaWpThYT6b2DdKFXhO17WJbb7nl/MTZmQyLmmuqoyaG7l5Wh+4zXxPiknf9jobqg26Pz6
	lWu2JveIoq545sh73MZUS0QYLkMXopE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=PTL0JuAt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759366631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C8MRozaVt9gYL1syIdXOg8Z1DtvDkklB1BuOVnjzjrE=;
	b=PTL0JuAtFrnNrLNLp2lC17PwFSaisBkA9BtaUy9QI/H4GtFs8iUzC9xYhJi6tYrgU9OwyZ
	FfaWpThYT6b2DdKFXhO17WJbb7nl/MTZmQyLmmuqoyaG7l5Wh+4zXxPiknf9jobqg26Pz6
	lWu2JveIoq545sh73MZUS0QYLkMXopE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7247113A42;
	Thu,  2 Oct 2025 00:57:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iMvtDObN3WgxVgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 02 Oct 2025 00:57:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: fix false alerts when running with 8K block size and 4K page size
Date: Thu,  2 Oct 2025 10:26:45 +0930
Message-ID: <20251002005648.47021-1-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 797E11F7C4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

[CHANGELOG]
v2:
- Add extra block size check against page size before skipping btrfs/012
  and btrfs/136

I am developing the bs > ps support for btrfs, and now it can pass most
btrfs and generic runs.

Some failures are due to the limitaions of the current bs > ps,
including:

- btrfs/023
  No RAID56 support, and the test case doesn't respect
  BTRFS_PROFILE_CONFIGS

- btrfs/131
  No v1 cache support just like subpage bs support.
  No big deal, as v1 cache is already marked deprecated.
  When the full deprecation comes, the test case needs some update.

- btrfs/226
  No Direct IO support.

- btrfs/267
  No Direct IO support thus the read falls back to buffered one.
  The fallback may change the pid thus some mirror is not properly read
  from disk and no read repair.

- btrfs/281
  No encoded send support

However there are some btrfs failures that are false alerts:

- btrfs/012
- btrfs/136
  Those are btrfs-convert tests, however ext* doesn't support bs > ps
  cases yet.

  Fix them by skip the run if the initial ext* mount failed.

- btrfs/192
  This one requires 4K nodesize, which implies 4K block size, and
  conflicts with user specified non-4K block size.

- btrfs/30[456]
  Those test cases have strict 4K block size requirement but still
  follows the user specified block size during mkfs.

  Fix btrfs/192 and btrfs/30[456] by explicitly specify 4K block size
  during mkfs.

There is also a minor comment mismatch in btrfs/267:

- btrfs/267 is verifying direct read repair but comments says buffered
  Instead it's btrfs/266 verifying the buffered behavior.
  So it's purely a comment mismatch.

  Fix it by explicitly mentioning buffered/direct IO for btrfs/26[67].


Qu Wenruo (3):
  btrfs/012 btrfs/136: skip the test if ext* doesn't support the block
    size
  btrfs/192 btrfs/30[456]: explicitly specify block size to avoid false
    alerts
  btrfs/26[67]: update the stale comments

 tests/btrfs/012 | 3 +++
 tests/btrfs/136 | 3 +++
 tests/btrfs/192 | 8 ++------
 tests/btrfs/266 | 4 ++--
 tests/btrfs/267 | 2 +-
 tests/btrfs/304 | 5 ++---
 tests/btrfs/305 | 5 ++---
 tests/btrfs/306 | 5 ++---
 8 files changed, 17 insertions(+), 18 deletions(-)

-- 
2.51.0


