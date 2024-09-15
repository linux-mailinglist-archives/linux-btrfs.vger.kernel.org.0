Return-Path: <linux-btrfs+bounces-8038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3CE979977
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 01:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3141C21F18
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2024 23:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235E38249F;
	Sun, 15 Sep 2024 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QW5VWarb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DuoK8Qc8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27E1CF96
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726441923; cv=none; b=QsyvsDmHsLbFWlU2aqzh//lLDoYHaFcGdSfv1u9Ch7+1UkgxfjTifvQ6lexcx/KST/Hi5y6sA1SWq0n+JP8ucvxEM5EZduKA8E/202R5JUmMk3iNsCjAPFWRhocwcE9kXiFX0KMRuoYcfUwJdj86oNHmuoNQkjVQuaEDsdZjMx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726441923; c=relaxed/simple;
	bh=iwr/7v1Z47EyZDyPx/25iLbZZowDf5EXOKugyTfttwI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WB2l2cs4R0XkavQkK5NCVTaI0pRihXpHvN1wlTDP8DKRYsHbBStK4DTWCHmCYwp0CasI/6tyl34YV65PlQxJdSXANZE99/nUIHaz1ji4O51VbMUPSkVwTxKV0R0orO9qW1aNfFQQdjqyt9uLZfJwguOM5XiZBeLGJsQfr5XMEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QW5VWarb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DuoK8Qc8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D00561F835
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 23:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726441913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=H0ln93ZSLRi5/n+j3E9tMgzKkBBxCPFYB14F6q383zo=;
	b=QW5VWarb9H2+Q5ehIijqJHoo/Pp1RPbaEf11D2LgsAmbbqHbPPcuGj+OMKfYssqVH26XIm
	1tR5ycjtwPfqwfy8tEYU/6r2oLcFq0y8LEbR8zNZo0O741bT87Po9cAmWhnXRUYGlk3SIZ
	bN4rqRnoanP4Sg3d3mIkllBUIU/4RLE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DuoK8Qc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726441912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=H0ln93ZSLRi5/n+j3E9tMgzKkBBxCPFYB14F6q383zo=;
	b=DuoK8Qc8mz4t6S+ld1ksA/oFHgXICLnoqtdCQDvEDsEBgmACRT2ok7vZ2ti2RcanOrDumO
	aeLZeaMvibTTwiqmr2sSq1iUpDfLRKI2aBNbgjkReosDz1CaMNGNNs0qL6gSzBwONanqGc
	mEoVLhiaq5+lQjNsdpoZIfdTbz9CkKc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E8361351A
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 23:11:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id veDFL7dp52aRLAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 23:11:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: de-couple subpage locked and delalloc range
Date: Mon, 16 Sep 2024 08:41:28 +0930
Message-ID: <cover.1726441226.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D00561F835
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Since commit d034cdb4cc8a ("btrfs: lock subpage ranges in one go for
writepage_delalloc()") btrfs uses subpage locked bitmap to trace all the
locked delalloc ranges, and that commits provides the basis for mixing
async and non-async submission inside the same page.

But that locked bitmap is not a perfect match to trace delalloc ranges,
as we can have the following case: (64K page size)

        0       32K      64K      96K       128K
        |       |////////||///////|    |////|
                                       120K

In above case, writepage_delalloc() for page 0 will find
and lock the delalloc range [32K, 96K), which is beyond the page
boundary.

Then when writepage_delalloc() is called for the page 64K, since [64K,
96K) is already locked, only [120K, 128K) will be locked.

This means, although range [64K, 96K) is dirty and will be submitted
later by extent_writepage_io(), it will not be marked as locked.

This is fine for now, as we call btrfs_folio_end_writer_lock_bitmap() to
free every non-compressed sector, and compression is only allowed for
full page range.

But this is not safe for future sector perfect compression support, as
this can lead to double folio unlock, if [32K, 96K) is submitted without
compression but [120K, 128K) is.

              Thread A                 |           Thread B
---------------------------------------+--------------------------------
                                       | submit_one_async_extent()
				       | |- extent_clear_unlock_delalloc()
extent_writepage()                     |    |- btrfs_folio_end_writer_lock()
|- btrfs_folio_edn_writer_lock_bitmap()|       |- btrfs_subpage_end_and_test_writer()
   |                                   |       |  |- atomic_sub_and_test()
   |                                   |       |     /* Now the atomic value is 0 */
   |- if (atomic_read() == 0)          |       |
   |- folio_unlock()                   |       |- folio_unlock()

The root cause is the above range [64K, 96K) is dirtied and should also
be locked but it isn't.

So to make everything more consistent and prepare for the incoming
sector perfect compression, mark all dirty sectors as locked.

The first patch is to introduce a new bitmap locally inside
writepage_delalloc().
The second patch is to fully de-couple locked bitmap from delalloc
range, and lock all dirty sectors.

Qu Wenruo (2):
  btrfs: move the delalloc range bitmap search into extent_io.c
  btrfs: mark all dirty sectors as locked inside writepage_delalloc()

 fs/btrfs/extent_io.c | 54 ++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/subpage.c   | 47 --------------------------------------
 fs/btrfs/subpage.h   |  4 ----
 3 files changed, 50 insertions(+), 55 deletions(-)

-- 
2.46.0


