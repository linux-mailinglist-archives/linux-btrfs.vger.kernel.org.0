Return-Path: <linux-btrfs+bounces-6633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82CC938894
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 07:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446561F213CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 05:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348BB17BA7;
	Mon, 22 Jul 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nLUeZnMK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Si2gdaYP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0491B964
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 05:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721627774; cv=none; b=CXZZVYxVc6QFpBixHxl7FSohbp7FP8NS+yijn5524wo7LPlgK0UQV2jLclhlvxgm2OqM3Snx9aH52dVjCrX0kSdoaU8I1e4OMDhtkNnB8ZiKbJDGEsSsNUi0VatXTLYkUeD510VGIaCpTDxIAg8rkBCzTevkP6SIhPHmLWVWSqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721627774; c=relaxed/simple;
	bh=piOpMcv1VGAJRfVuCRKJ3qEGBvmyEudw4EbTb8LkCkI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pqo62vVl5r0/r5Fn+VRwekrg6J8WRv3uwm7byzSIoXKA6ElCD/TYhmDLWNvFtCKolhxjw366cYkU6AAuRNpdegdJnpwkmLWIe/CFehvz/CBXIlZFLROpLqVOu1KTZkzAolnV8oesQdRRQsOJaDc/rJRjpXhdGpzjNzuxEZa3nPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nLUeZnMK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Si2gdaYP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E2911FB53
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 05:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721627769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fHiDRPDT6YS2cG0Yu7uP+qlH9Gl+WLy7znKIDk8a814=;
	b=nLUeZnMK58wFrxp5BmqzWQyMfOK/JPM6UU3tUrI7oyGB7AW30KtsS2L2B2wPlhku5AtjM6
	IVTW+yHBXtPdwe9brvM/XQpl1oTdgwMwRfm34nLtjgx1yaEUdF1xd1pCNTXxstUqzhk/bh
	ncd18Ay8AK6UYD5jwd6x/IMOND100vk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721627768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fHiDRPDT6YS2cG0Yu7uP+qlH9Gl+WLy7znKIDk8a814=;
	b=Si2gdaYP7vBydRkaHpxblEMmOZcCghmrVDVSmzhnms/mBgjes8pMsn3AsFEtqABzIkR4Ey
	JRsLiDBxx/JhqLuJokGd9egL2n7cZG7Nn0d3asrGCAVE2X7fdxdUgZpaCsgMRDxz+Gmz4l
	FWg+faZtNaWnerAa9bTgFpsNpEzs8Bo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE22B138A7
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 05:56:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zYtpGXf0nWa+LQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 05:56:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: scrub: update last_physical more frequently
Date: Mon, 22 Jul 2024 15:25:47 +0930
Message-ID: <cover.1721627526.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.60
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

[CHANGELOG]
v2:
- Rebased to the latest for-next branch
  No conflict at all

- Rewording the second patch
  There are two problems, one is serious (no last_physical update at
  all for almost full data chunks), the other one is just inconvenient
  (slow update on "btrfs scrub status").

- Add the missing spinlock
  It's mentioned in the commit messages but not in the code

There is a report in the mailling list that scrub only updates its
@last_physical at the end of a chunk.
In fact, it can be worse if there is a used stripe (aka, some extents
exist in the stripe) at the chunk boundary.
As it would skip the @last_physical for that chunk at all.
And for large fses, there are ensured to be several almost full data 

With @last_physical not update for a long time, if we cancel the scrub
halfway and resume, the resumed one scrub would only start at
@last_physical, meaning a lot of scrubbed extents would be re-scrubbed,
wasting quite some IO and CPU.

This patchset would fix it by updateing @last_physical for each finished
stripe (including both P/Q stripe of RAID56, and all data stripes for
all profiles), so that even if the scrub is cancelled, we at most
re-scrub one stripe.

Qu Wenruo (2):
  btrfs: extract the stripe length calculation into a helper
  btrfs: scrub: update last_physical after scrubing one stripe

 fs/btrfs/scrub.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

-- 
2.45.2


