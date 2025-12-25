Return-Path: <linux-btrfs+bounces-20006-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0262CDE206
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 23:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E82F3300C5FD
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 22:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B77029B8EF;
	Thu, 25 Dec 2025 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qRIw5cfl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tnlXorU8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15B672621
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Dec 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766700985; cv=none; b=hpDpwMBDpAMS/pwdkLttCzEfKRf7OMTfkgWVRHughXZzcLmh1/cNmlYMqjJ9auz7RgM6rN9IDKO8YSv/ugS3RpoOO7EnHL+RkoDnkOT9S2EwQd34jU3ReNM4/+cVn1nQMCEZIR1r2M6POQSEZWPj+Lf6V60Qcg7jd4eo4EID87w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766700985; c=relaxed/simple;
	bh=DhJZBuaz3SvEKzQjbYzcFz3CjFxOqOC0OBsNfMXlKNk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=anIllYsq8G83R1pwUV+RkRjIY2UGPWQayITWAqYYH57m1uCnozrVAMXe/ljxNoWbtCq0LIFNo4DZmL0cHoJDVFqhLpIsRjbnZhYcSjG447q/lvRq+rN2M/D2oKIxejtFdWF3KE29aiTF0PtG0M4BUg6MdjDVlNQ6HU2rFotd38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qRIw5cfl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tnlXorU8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D81A45BD37;
	Thu, 25 Dec 2025 22:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766700980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1ceeYD2bcBe6FWkS8wf73dDouhPSq3EP45EPnl6erf4=;
	b=qRIw5cflz5OBHit/nXF49L1YMFoxUY9nE67EeYZDTBusTq9PJbxmkreo9WPMK/+zCZx5K9
	2X7N70rW4KtaeMvYwu1qicAKwKmrgVk8dLO92luHchlcfiloGGc5c3x10yJF42jieCayiN
	+ppx/oz+iBCW2Cw+lG+VxpPvq3/4yQU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tnlXorU8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766700979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1ceeYD2bcBe6FWkS8wf73dDouhPSq3EP45EPnl6erf4=;
	b=tnlXorU8bwJmLlEI0Vc6hjHh6umtmb03Zn2an8NaEL+GbfWVz1H8kl93qHBVRgqILnD8He
	tXfDAX0VICiLcEulO3haOoxGWauLiNxm82PoAjsjenY1QCEqYMq0rqabJfMD1CNWIcpwh7
	zl3CiwkVvyybufSPQh9DoFZMrCAZpps=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3FAC3EA63;
	Thu, 25 Dec 2025 22:16:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bW2XJLK3TWlCSgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 25 Dec 2025 22:16:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH 0/2] fstests: btrfs: make space cache related tests future proof 
Date: Fri, 26 Dec 2025 08:45:51 +1030
Message-ID: <20251225221553.19254-1-wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: D81A45BD37
X-Spam-Flag: NO
X-Spam-Score: -3.51

The existing btrfs/131 is testing no space cache, v1 space cache and v2
space cache mount options.

It's fine for LTS kernels as they will stay there for a long time with
v1 space cache support.

However v1 space cache is already deprecated since commit 1e7bec1f7d65
("btrfs: emit a warning about space cache v1 being deprecated"), and the
kernel support for v1 cache will drop soon.

In that case btrfs/131 will cause false alerts, and we will have no test
case covering no space cache and v2 space cache mount options.

The series will:

- Enhance btrfs/131 to skip the test if the kernel has no v1 cache support
  This is done by a more explicit check.

- Add a new test case without v1 cache
  The newer one can cover cases which is not covered before, including:
  * bs > ps cases
  * bs < ps cases
  * zoned devices

Qu Wenruo (2):
  fstests: btrfs/131: add explicit v1 space cache requirement
  fstests: btrfs: add a new test case that is future-proof

 common/btrfs        |  25 +++++++++++
 tests/btrfs/131     |  12 +++---
 tests/btrfs/340     | 103 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/340.out |  15 +++++++
 4 files changed, 148 insertions(+), 7 deletions(-)
 create mode 100755 tests/btrfs/340
 create mode 100644 tests/btrfs/340.out

-- 
2.51.2


