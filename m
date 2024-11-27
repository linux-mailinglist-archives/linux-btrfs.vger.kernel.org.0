Return-Path: <linux-btrfs+bounces-9934-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD569DA39E
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 09:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06FB7B216CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 08:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0D217B427;
	Wed, 27 Nov 2024 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GKmzoF6Q";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GKmzoF6Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB074208A5
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732695351; cv=none; b=o25lUE40Gt3ztEciSuITXto9VAoSFs3TsBcX4zt3wURTDJzuOxSs8kpZNK/P4h2pFHs6Ya4UgTibkaHaqUWVKMZNqpSvibhTf0BiK52+OGo8y976bX+dblJdnJkuBUzO16YE4qAs9B5hJ7b5fu8qL1oVas6VQnO7N4Jc2TAtE1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732695351; c=relaxed/simple;
	bh=/qVe2eBk8o7DWT9J4KPmnuTup7+UjT2Tp5YducMbKMU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=e31kaceeEQBg8AjV/YEmdKrOq6QDe1DkkvVgYyvP089RxU4GshTeV4ARBKtmFWLB6yDWpps198eSNFyUxvwTRSS2K4I4C86XKG8UcVFxJMVypQkdRdes2CGzLPDZ2B6FmiCyDGSdYAJJeM5JBayCYktJ5mv2sRTooNpEuv4TJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GKmzoF6Q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GKmzoF6Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFAEE2120E
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732695347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GRlzALMpvWhJHRJlmPggCsYV8coH8fMCpV3QUVR6bkE=;
	b=GKmzoF6QKChosjreLTf53FirUPYlpJzwgSxj9jnsp1Bk/0fOS5efljer2kfZ2OWJT9Z4w4
	HFSyr927mNwDu6gnLvLHdWAUmsgI/CFxTeFpKRogC9/pFuHxhhnEj5yf5LPA8ltpr9+1kf
	k8FdLn8B2spfTJuuy8/jK2LYVQ1MvB4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732695347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GRlzALMpvWhJHRJlmPggCsYV8coH8fMCpV3QUVR6bkE=;
	b=GKmzoF6QKChosjreLTf53FirUPYlpJzwgSxj9jnsp1Bk/0fOS5efljer2kfZ2OWJT9Z4w4
	HFSyr927mNwDu6gnLvLHdWAUmsgI/CFxTeFpKRogC9/pFuHxhhnEj5yf5LPA8ltpr9+1kf
	k8FdLn8B2spfTJuuy8/jK2LYVQ1MvB4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C07A139AA
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 08:15:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yScVLzLVRmcBJgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 08:15:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: error handling fixes for extent_writepage()
Date: Wed, 27 Nov 2024 18:45:27 +1030
Message-ID: <cover.1732695237.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
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

[CHANGELOG]
v2:
- Update the commit message for the first patch
  It turns out the root cause is the race between
  btrfs_finish_one_ordered() and btrfs_mark_ordered_io_finished()

  And that race is possible no matter if the sector size is smaller than
  page size.

  So update the commit message to reflect that.

- Remove comments update in the patch
  To make backport easier.

- Update the commit message for the second patch
  Mostly to down play the possible problem, as the extent map is already
  pinned, thus no way to failed to grab the extent map.

It's more and more common to hit crash in my aarch64 testing VM.

The main symptom is ordered extent double accounting, causing various
problems mostly kernel warning and crashes (for debug builds).

The direct cause the failure from writepage_delalloc() with -ENOSPC,
which is another rabbit hole, but here we need to focus on the error
handling.

All the call traces points to the btrfs_mark_ordered_io_finished()
inside extent_writepage() for error handling.

It turns out that btrfs_mark_ordered_io_finished() inside
extent_writepage() is racing with the same cleanup inside
btrfs_run_delalloc_range().

And if the one inside extent_writepage() is called before the ordered
extent removed from the ordered tree (the removal is queued in a
workqueue), then we hit the double accounting.


There is also a theoretical failure path from submit_one_sector(),  but
I have never hit a case caused by that failure, the fix is only for the
sake of consistency.

Both fixes are similar, by moving the btrfs_mark_ordered_io_finished()
calls for error handling into each function, so that we can avoid
touching ranges that is already covered.

Although these fixes are mostly for backports, the proper fix in the end
would be reworking how we handle dirty folio writeback.

The current way is map-map-map, then submit-submit-submit (run delalloc
for every dirty sector of the folio, then submit all dirty sectors).

The planned new fix would be more like iomap to go
map-submit-map-submit-map-submit (run one delalloc, then immeidately submit
it).


Qu Wenruo (2):
  btrfs: fix double accounting race in extent_writepage()
  btrfs: handle submit_one_sector() error inside extent_writepage_io()

 fs/btrfs/extent_io.c | 63 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 15 deletions(-)

-- 
2.47.0


