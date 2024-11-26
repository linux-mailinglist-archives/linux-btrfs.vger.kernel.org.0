Return-Path: <linux-btrfs+bounces-9906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C409D91C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 07:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1A15B225D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 06:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EB715575F;
	Tue, 26 Nov 2024 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IISuxtlO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IISuxtlO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E4C3208
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732602596; cv=none; b=e+iKq/RT7IRffRafnfdZhBAfv8m5A0JsQr5WahbyLWaBLpXfeZrJQKqsdnfqWNcFvoydj85owNFkrtuUu+ru1r2aLfP74S+pdurr8joOD/w4SeQzickpmFKzSQrL3hU+bG7/fNcFhqdkStt98a5HozreoCBwhFHyJ0G1WB3fsTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732602596; c=relaxed/simple;
	bh=EmjK55qxw2T/B8RM/d1j3X9zrBl4qvI7YVq2oAZAm3o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OrGFpmFf9HS2WsWzpCOhGmaoPmiynbZR5BmAxJqqOWcrV9aofFLv+NWhtB6ob1/iGU/hX2vJOxLQ0TTH9Shm9/UDYSVizGbUuLNMuVHWIhX3/G3uINogbq34g0DEtyrhTyD9/aCPxHRStDpnRHyAb19uyUAR80T1Yt5bC4Hmij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IISuxtlO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IISuxtlO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B56551F457
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 06:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732602591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uJqBUmLwiloEEtW5ANHLObcHuPNr+2irf7DmyV+3GAk=;
	b=IISuxtlOhE1Amd/5Foh1I37WD3iZhT5fNPr84Lta+wB5WT6I81KjgO7PsUPQJ+SMCnSjT7
	HpvI2463Q1HZfDqmK/7JUmH36dI2Rbjq/iBqtvGAxHh3dQsuOKJiBUswTimK5NbVG4IslK
	bn7iZyX9LHBIDlhb6pR5hGR73DYig+E=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=IISuxtlO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732602591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uJqBUmLwiloEEtW5ANHLObcHuPNr+2irf7DmyV+3GAk=;
	b=IISuxtlOhE1Amd/5Foh1I37WD3iZhT5fNPr84Lta+wB5WT6I81KjgO7PsUPQJ+SMCnSjT7
	HpvI2463Q1HZfDqmK/7JUmH36dI2Rbjq/iBqtvGAxHh3dQsuOKJiBUswTimK5NbVG4IslK
	bn7iZyX9LHBIDlhb6pR5hGR73DYig+E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9E64139AA
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 06:29:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8NqkJN5qRWeZUQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 06:29:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: error handling fixes for extent_writepage()
Date: Tue, 26 Nov 2024 16:59:22 +1030
Message-ID: <cover.1732596971.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B56551F457
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Now with the new compressed write support and the incoming partial
uptodate folio and inline write support, it's easier and easier to hit
crashes for test cases likes generic/750, when the sector size is
smaller than page size.

The main symptom is ordered extent double accounting, causing various
problems mostly kernel warning and crashes (for debug builds).

The direct cause the failure from writepage_delalloc() with -ENOSPC,
which is another rabbit hole, but here we need to focus on the error
handling.

All the call traces points to the btrfs_mark_ordered_io_finished()
inside extent_writepage() for error handling.

It turns out that that unconditional, full folio cleanup is no doubt the
root cause, and there are two error paths leading to the situation:

- btrfs_run_delalloc_range() failure
  Which can lead some delalloc ranges are submitted asynchronously
  (compression mostly), and we try to clean up those which we shouldn't.

  This is the most common one, as I'm hitting quite some -ENOSPC during
  my fstests runs, and all the hang/crashes are following such errors.

- submit_one_sector() failure
  This is much rare, as I haven't really hit one.
  But the idea is pretty much the same, so we should not touch ranges we
  shouldn't.

Both fixes are similar, by moving the btrfs_mark_ordered_io_finished()
calls for error handling into each function, so that we can avoid
touching async extents.

Although these fixes are mostly for backports, the proper fix in the end
would be reworking how we handle dirty folio writeback.

The current way is map-map-map, then submit-submit-submit (run delalloc
for every dirty sector of the folio, then submit all dirty sectors).

The planned new fix would be more like iomap to go
map-submit-map-submit-map-submit (run one delalloc, then immeidately submit
it).

Qu Wenruo (2):
  btrfs: handle btrfs_run_delalloc_range() errors correctly
  btrfs: handle submit_one_sector() error inside extent_writepage_io()

 fs/btrfs/extent_io.c | 71 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 18 deletions(-)

-- 
2.47.0


