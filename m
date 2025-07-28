Return-Path: <linux-btrfs+bounces-15702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC15B136AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 10:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF81189B80C
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 08:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2BE238D22;
	Mon, 28 Jul 2025 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GzBCykFk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bofpc8Kz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10BB221704
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691299; cv=none; b=a+gNV+Mnqrm/rH+JQLkeXZpGDv/pLWeJ8od9sOgnjIjHwRNywLzUH536KHJDaSmBaAGXCp9bcRrgecJwRC0AKVmgKm6sjxP2XoHOCA+iN1KlvFK626jK2R7YmONb+03vQY5WsqLV4aYETCmmKnFM7YTkTO+oFPGYiGWJ2yf1/mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691299; c=relaxed/simple;
	bh=11lcUjPlIcdlYQSJxnXshCK+NkGLdoVA16IlviSzl1k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LokXlMzttR3ur+NyXYVX8t4EGHLRlAKQczz+J2g1KbS7FcdEM26T2zRtf0VuNIHGafbN3n+uYZIb8iwtXvK3P47gILgcPHTX/eOIHJJ61nlMUJ5xmu+d1VP7IsaswcuVH95ELDTbHie6YOfKUrf/Ofq3k5AnLIuRdnQB0QqcyGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GzBCykFk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bofpc8Kz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F02C221201
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 08:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753691296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1IzhYb3CtqRaNXF2FlhJzFEGXi10Y1f+BA2I+DOpsRc=;
	b=GzBCykFk0aYpj9INCHUd78Qz1E9MGCfQHRwRh/+qNuFqIz2SZffq64+V30W7b91zr7Jsf8
	WyaK4ilIzpZhpO3+W6MXXaZ+x0a0h3mhIYmUJz1MYrrB6ImHZCXMCC3d5OUl5/zBAhljTR
	mzT3AYvFMNjWAiV9+HqFKpe1uAIylbo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bofpc8Kz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753691295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1IzhYb3CtqRaNXF2FlhJzFEGXi10Y1f+BA2I+DOpsRc=;
	b=bofpc8KzN/EJsR4cxMMyu+ltmnAwR/w+/3BHqjp3Bgy4NudrCZrf/yS04HsBZR5wv2Ak48
	86RNrBdzZOkpTZP9Ui2HjZMmXH8F5xGYgutFaOMs/PJyeUUxIkgNHy7wVIFhJb6jhTxyPg
	JqtzkYJHdyofj8vESLTLsLby84Vy5os=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3882C138A5
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 08:28:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2BvbOp40h2g0GwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 08:28:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs: btrfs: fix possible race between error handling and writeback
Date: Mon, 28 Jul 2025 17:57:53 +0930
Message-ID: <cover.1753687685.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: F02C221201
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

[CHANGELOG]
v2:
- Add a new patch to explain the error handling better
  This makes the later nocow_one_range() error handling change easier to explain.

There are some rare kernel warning for experimental btrfs builds that
the DEBUG_WARN() can be triggered from btrfs_writepage_cow_fixup(),
mostly after some delalloc range failure.

The root cause is explained the the last patch, the TL;DR is we
shouldn't call btrfs_cleanup_ordered_extents() on folios that are
already unlocked.

Those unlocked folios can be under writeback, and if we cleared the
order flag just before the writeback thread entering
btrfs_writepage_cow_fixup(), we will trigger the warning.

The first patch enhance the error handling of run_delalloc_nocow(), with
proper comments and charts explaining the cleanup range.

The second patch is a small enhancement to the error messages, which
helps debugging.

The third patch is to make nocow_one_range() to do proper cleanup,
aligning itself to cow_file_range().

The last one is to fix the race window by keep folios of successful
ranges locked, so that we either unlock them manually at the end of
run_delalloc_nocow(), or get btrfs_cleanup_ordered_extents() called on
locked folios for error handling.


Qu Wenruo (4):
  btrfs: rework the error handling of run_delalloc_nocow()
  btrfs: enhance error messages for delalloc range failure
  btrfs: make nocow_one_range() to do cleanup on error
  btrfs: keep folios locked inside run_delalloc_nocow()

 fs/btrfs/inode.c | 259 +++++++++++++++++++++++------------------------
 1 file changed, 128 insertions(+), 131 deletions(-)

-- 
2.50.1


