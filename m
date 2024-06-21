Return-Path: <linux-btrfs+bounces-5865-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 743BB911A36
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 07:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EED1F22D65
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 05:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3901212FF6E;
	Fri, 21 Jun 2024 05:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="awwG2tlN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KpINO30D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FB82A8FE
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 05:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947044; cv=none; b=OucgYWcLXeV6ir/1+vZ8UNTapkvVcKJoN5nuXNOU2sdIwJkKKfMwiS9PhY03RZfnb7vOHvDmhqjUCwhH8gjFokY/WGfON/02gbv6WlpkAt0Ufr7NemCsVPn9cXv30U0su/tol7H054igxlaAH/Photks+I0CJjaUUutDDL05r+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947044; c=relaxed/simple;
	bh=VatO0xCmASeYgBL5ULM8P9iZjSajOYG6EFGl7VVjQXA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mofC/BPzYpwn8H2bck3MDAdgZCcaDKq6H5M9ghU86EB4GJ9Jau43WBHhW5h944o4d3ogwi0JQsNsoyY6PtyAba0XWQ0AmYB4Z029wN+EoRxFzEbYxLYer3Qf/lC5+fhTasU6yhNcgovZ8u+6WTKT1RCURUtNiqjyzpd3UpuqkXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=awwG2tlN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KpINO30D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D02E21AA7
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 05:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718947040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=survkao8crAXzjoSZaamAZ6BOsF8WAMhg1SqIjDz2ho=;
	b=awwG2tlN/2404oJwnubhHNgoNq+/gA3rt3LFZk7xMkpFTk5tCYXOK4u53ZFWZW07Ov/A9I
	+zoJ+JguO79WGshUhMuRe1U09gFlbsQXz67arKAUQjBh6ILPH2OHU/xvItEXFKzagpBWXU
	uQrQLZ8t6cbRqZI6mRli/ifwhZ2uUMA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=KpINO30D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718947039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=survkao8crAXzjoSZaamAZ6BOsF8WAMhg1SqIjDz2ho=;
	b=KpINO30DkaFjoD161DcZpixLFZaB05M9yJVKgEQdc5htPVbBZshCWFZvalc//imt4Fn6lT
	c+H/r7mjrs1Bi52vD0w4ExegV0PWoBNbRGE1nCf1DhjHWmJUTyvX0T80No4Vs3QMd372Dh
	iB2YJtGd0rKEtaNKpK9kUIidlODtYlQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B8AC13AAA
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 05:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rjU8BN4MdWavbAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 05:17:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs-progs: btrfs-progs: csum-change enhancement
Date: Fri, 21 Jun 2024 14:46:53 +0930
Message-ID: <cover.1718946934.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4D02E21AA7
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

[CHANGELOG]
v2:
- Enhance the error injection detection
  Now instead of plain run_mustfail, we do check both the failure and
  the stderr.
  Only when the csum-change failed and stderr includes the injection
  cookie output, we know it's really the injection causing error.

The first two patches are small enhancement and bugfix:

- Fix a missing error handling
- Do multi-transaction csum deletion and rename
  Or we can generate GiB or even TiB level of dirty metadata.

Finally introduce a basic error injection based test case, which will:

- Check if we have error injection first
- Inject error at the end of data csum generation
- Make sure resume from above situation is correct

I'm not adding extra injections because I believe there would definitely
be corner cases that need to be fixed.

Qu Wenruo (3):
  btrfs-progs: csum-change: add error handling for search old csums
  btrfs-progs: csum-change: add leaf based threshold
  btrfs-progs: misc-tests: add a basic resume test using error injection

 .../065-csum-conversion-inject/test.sh        | 61 +++++++++++++++
 tune/change-csum.c                            | 75 +++++++++++++++----
 2 files changed, 120 insertions(+), 16 deletions(-)
 create mode 100755 tests/misc-tests/065-csum-conversion-inject/test.sh

--
2.45.2


