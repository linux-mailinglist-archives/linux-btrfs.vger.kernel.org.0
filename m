Return-Path: <linux-btrfs+bounces-6552-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8459093708F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 00:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E3E1F2297D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 22:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD48146585;
	Thu, 18 Jul 2024 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uUTcq9Df";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B1KnQPAT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDE5145FFB
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721340674; cv=none; b=kPqN5XzmIn7Wx5NILyu4QurE/XBY27LmiDnel10QmBOPa+EkftCjbqGNPk3gXHaOFiXXH4K/rhyY/DFDsSyOXr4JaCDfCPJ1KUJYZ4gmamNLjPSsJjTgKUMNPdK86/2TK6S2puQdBz2p0SOBK+zpK/3RbQFvXih5zhMAoXzNUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721340674; c=relaxed/simple;
	bh=LymfgG5mKRE8TExFKeu1Q8usftKhppOUEaB4awnr8mE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z9B7U5ERt8wUdCXACTXx5yi5Q3qyiSO+aHBA5DvFHeDayB+P+k2AOKOgPLyC0Erqvj4oLSRj1BB5rMxoXN57uzVUwejqt+g8ruSWQngNxbNQbywrjM9voFMr2f+hjVK8bN9/dP18KWBW9maT87eVkneVQ7QpRcYtVduRFwmCDGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uUTcq9Df; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B1KnQPAT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A44AA216E8
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721340669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IWNWtLwaai0ldOmp5xhd4YoRXreg9dEloIykxpQtITs=;
	b=uUTcq9Df+QjCzpUCUexsD50CTu5sZJ/V+gI0QaYG/qwLcSUHNR7i4DeWJE2Bt3kUbSgASg
	BGzWyU825YonL5n6v4OYT9BcnMyaUeeEE6J69yYEZBfJ37FPmfHkGhCrGVs2V/cA+yxxVm
	8MThnNe86+uRCPegcyh+2BehgQydEjo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721340668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IWNWtLwaai0ldOmp5xhd4YoRXreg9dEloIykxpQtITs=;
	b=B1KnQPATo/d5uJYyiDxpi+jaowwVbJLUScGgkBezTSYN9v7wL3/LVKl/fYkvBpLCS5kpem
	saFTk9Vk164TwPepOkJlOmKQaF1AdZjNT0bdzSv6n0m4qMfYQJkmu5SQ+aNu9gSNdq4NfX
	uuqg66SMvuG/dM1E53HrpjRYMWFlWCc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C600B1379D
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 670mH/uSmWZZFwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:11:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/3] btrfs-progs: btrfs-progs: csum-change enhancement
Date: Fri, 19 Jul 2024 07:40:42 +0930
Message-ID: <cover.1721340621.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

[CHANGELOG]
v3:
- Rebased to the latest devel branch
- Migrate to use "btrfs --version" to detect features

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
  btrfs-progs: csum-change: add leaf based threshold
  btrfs-progs: tests: use feature output from "btrfs --version"
  btrfs-progs: misc-tests: add a basic resume test using error injection

 tests/common                                  | 13 ++--
 .../065-csum-conversion-inject/test.sh        | 45 ++++++++++++
 tune/change-csum.c                            | 68 ++++++++++++++-----
 3 files changed, 105 insertions(+), 21 deletions(-)
 create mode 100755 tests/misc-tests/065-csum-conversion-inject/test.sh

--
2.45.2


