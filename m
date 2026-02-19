Return-Path: <linux-btrfs+bounces-21771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFaVCRvIlmkGmwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21771-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 09:21:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 482E115D05B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 09:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AA853002F4B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 08:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFB1336ECA;
	Thu, 19 Feb 2026 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jfy48cbT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PeCuXevF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AED33343F
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771489297; cv=none; b=XKgOPAWTQ5rDGIaSAxKZ1aNp4obWlcJ3mRD/M9yX3nkZHZ+X98979+lN5Yx54OcA/XVqMkc4WuMZkzaaPnVRk8M3e50Us98EXdkPXTT/tO3SMUJYmU2+SO9St95eN3iV+IPq5hwBZM1LUr9wYLYf137dh/Sa4Av1GFhONyDUxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771489297; c=relaxed/simple;
	bh=mgqGcFo6J2Xh9nou093RMS6OO0TS2OcLAh2tKqhFFP8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mbwtypgcqlwCbftd8YJypPMfk6ZDnOA3oewI71I5rIEW+6KlS+IuGqRDEd579EtEbkhBQXZu/ZIsOZViALtfB75mWgPCl8BacyX45tRecYaX311DIQkiNqDZeLQCHyJbeJSxfJ1luCsAVTadfoR0gSd27354JuXEAHsVOILbB8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jfy48cbT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PeCuXevF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 61D4F5BCC3
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 08:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771489294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sTi3BlaIA5/Gfya0DWBcnnGqlsKSt/UnGnaZpDDhfro=;
	b=jfy48cbTvTPfm4EaqwtPsxhz5mrhjnbV+LDgEJh4y3rV47/YHhK/fvgZL67f74mYkwEiSc
	a+0kgqJ/0u0Mbu+v+JoehuRdSk/s7TXcHKthw4gTPr8oiaemckjjoCZiMSU71QmRu6hJaU
	rquQKZM7MjcqHDa8uBnOPe4cQLVdvj0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771489293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sTi3BlaIA5/Gfya0DWBcnnGqlsKSt/UnGnaZpDDhfro=;
	b=PeCuXevFMpyYcMM2panWRFGoYfzqNXm0Qkk9jPZ77MKmMYYrwR/vp24y2HRSyP0PUDaGHf
	rssZR9Xrgqn13OJuFtzaoEc//LmkIChpZWM7/tq4FhP6NerDX/lbN3zSBUzv9DWUdw0i6P
	2hT+I+R/ZS7rLYZrcwUcJWjcIG/RxKI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 936023EA65
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 08:21:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tKRdFQzIlmkYZAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 08:21:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs: fix all bugs introduced in the compressed_folios[] removal
Date: Thu, 19 Feb 2026 18:51:10 +1030
Message-ID: <cover.1771488629.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21771-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 482E115D05B
X-Rspamd-Action: no action

[CHANGELOG]
v2:
- Fix an unaligned bio size on x86_64 triggering btrfs/333
  We can still have an unaligned size for the encoded write, in that
  case we still need to roundup the bio to fs block boundary.

I'm a total idiot, that my usual 64K page sized arm64 VM is configured
back to use 4K page size for bs > ps runs, but forgot to revert the
config back.

This makes all recent arm64 runs use 4K page size, making it almost
no different than x86_64 runs.

This means the recent compressed_folios[] cleanup is not really properly
tested for bs < ps cases at all.
Thus all the regressions are not properly detected during the
development.

In fact commit e1bc83f8b157 ("btrfs: get rid of compressed_folios[] usage
for encoded writes") introduced two bugs in just one go, one can even
lead to data corruption for bs < ps cases.

All bugs are caught by dded ASSERT()s, but some ASSERT()s are just
incorrect in the first place, like patch 2~4.

Meanwhile the first one can lead to data corruption if
CONFIG_BTRFS_ASSERT is not selected, thus it will need higher priority.

Again, very sorry for my super stupid arm64 kernel config error.

Will no longer run 4K page sized kernel on that VM any more, and deploy
a new VM for 4K page sized tests, with proper kernel string suffix to
indicate the page size in the future.

Qu Wenruo (4):
  btrfs: fix a bug that makes encoded write bio larger than expected
  btrfs: do not touch page cache for encoded writes
  btrfs: fix an incorrect ASSERT() condition inside
    zstd_decompress_bio()
  btrfs: fix an incorrect ASSERT() condition inside lzo_decompress_bio()

 fs/btrfs/compression.c | 11 ++++++++---
 fs/btrfs/inode.c       |  7 ++++---
 fs/btrfs/lzo.c         |  4 ++--
 fs/btrfs/zstd.c        |  2 +-
 4 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.52.0


