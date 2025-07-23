Return-Path: <linux-btrfs+bounces-15641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D14AB0F10B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 13:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FDD1C25D67
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 11:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6698D28B3FD;
	Wed, 23 Jul 2025 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jOnOzbD7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jOnOzbD7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9692AD3E
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269692; cv=none; b=ETKkri6TDqJYrpc5XN0WxGxclKXSowE7C0yHxn6siaXfVYd98lwuy9jWXkTvn8T5lhJ219fJy5Urig/VYzTYhm53vDZjopBmrUe6ZOOPSkibZCaG8TN2G3UD1f8d9uKqGzFV7k+rJBTpFWle/V5B/mKgYhBBqe+OXp6xpzbDJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269692; c=relaxed/simple;
	bh=FQnx4kSpIKIV4jFLpB5RgQtCS/dV0JieEXi3VsEYGn0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KIUEI2ou0nxg2UsPRai5FhwkYLk+Dh1CW1EYOE87B3X+Cu8DdzFnn1luGHTjnRT5FqX21Y1UQ1APkBdaIJ8SA0XkPcjjuNbbp3oi7jPTy3ZpC3SV4NPEDZot+5rwuSSU7+4n3BgBe0tThLZigTWqwiWKKrlze5KbpvjwvimroFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jOnOzbD7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jOnOzbD7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7064A218A8
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753269688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W8lccASosjEOJYWleSnyeST8SSWjaBimJRvfUJk1Agg=;
	b=jOnOzbD75ZwCOHqgYu2dFETyTNb5rUqVw5oFyoMwAfHdUEGbDOZabLI1/yxVk/DIZSGRNI
	gdaJx4LW/vPdcuyYvIyFICYxIZErEKan2q5K9cASXEM7zZK7SevSQXkcKJUPHX98aBQyIn
	y9mjQFGGJXqx6ymHdF5u6dsDb0dfGsU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=jOnOzbD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753269688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W8lccASosjEOJYWleSnyeST8SSWjaBimJRvfUJk1Agg=;
	b=jOnOzbD75ZwCOHqgYu2dFETyTNb5rUqVw5oFyoMwAfHdUEGbDOZabLI1/yxVk/DIZSGRNI
	gdaJx4LW/vPdcuyYvIyFICYxIZErEKan2q5K9cASXEM7zZK7SevSQXkcKJUPHX98aBQyIn
	y9mjQFGGJXqx6ymHdF5u6dsDb0dfGsU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A20A013302
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:21:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RQkMGbfFgGhaeAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:21:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: fix possible race between error handling and writeback
Date: Wed, 23 Jul 2025 20:51:21 +0930
Message-ID: <cover.1753269601.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7064A218A8
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

There are some rare kernel warning for experimental btrfs builds that
the DEBUG_WARN() can be triggered from btrfs_writepage_cow_fixup(),
mostly after some delalloc range failure.

The root cause is explained the the last patch, the TL;DR is we
shouldn't call btrfs_cleanup_ordered_extents() on folios that are
already unlocked.

Those unlocked folios can be under writeback, and if we cleared the
order flag just before the writeback thread entering
btrfs_writepage_cow_fixup(), we will trigger the warning.

The first patch is a small enhancement to the error messages, which
helps debugging.

The second patch is to make nocow_one_range() to do proper cleanup,
aligning itself to cow_file_range().

The last one is to fix the race window by keep folios of successful
ranges locked, so that we either unlock them manually at the end of
run_delalloc_nocow(), or get btrfs_cleanup_ordered_extents() called on
locked folios for error handling.

Qu Wenruo (3):
  btrfs: enhance error messages for delalloc range failure
  btrfs: make nocow_one_range() to do cleanup on error
  btrfs: keep folios locked inside run_delalloc_nocow()

 fs/btrfs/inode.c | 131 +++++++++++++++++++++--------------------------
 1 file changed, 58 insertions(+), 73 deletions(-)

-- 
2.50.0


