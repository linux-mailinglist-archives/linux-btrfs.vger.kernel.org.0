Return-Path: <linux-btrfs+bounces-7308-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C440E955C6F
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2024 14:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9C1281B15
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2024 12:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B5D31A60;
	Sun, 18 Aug 2024 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q74hn8t0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q74hn8t0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C623A17580;
	Sun, 18 Aug 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723985042; cv=none; b=cltI5xMluxCzh8+LXgRkV7kuVSp/8kBJkMiN9jc+xbunfMcaTKSeb/gEY42oTs2++Pufs+3RYqZ03dcIoTt7Y55ykjyREFOSaMfRjZZk8m5JGEjD5MP9Aeub8eErJ0v1sCBsrvda0x9KFCkLRT72YQaPv0lTU8HgWuT6vaL3V8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723985042; c=relaxed/simple;
	bh=xAPasBmwSql69I8v15tLGNQAjYHZoxbkah538T24wJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M6l6j07a45JICloOVxBcBzg0dnHLMQMGV5wJPA7SXtLKuPX5hkbXIMq7bfWnpewJZsflF7Rg7puFZU9+voNiur8fjNvf6a3XARfXpiHf5KZ/L08hvQ5V0Ys1oU2C1XpMBsesfo/+jhz7J3NlGPvI5O+uWlx0EzwJGgJHarVPMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q74hn8t0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q74hn8t0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E341022668;
	Sun, 18 Aug 2024 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723985038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hNdsCgDwfxx9qOwvJpBNpv6a1Q/E/N9dUawDuhnVU74=;
	b=Q74hn8t0F2JlsFCjXjJO5twmnZrb78JdqP7tkqUWycouaGu5LAfIR4OiixhPFwEa1ih/ke
	xC0IsbzJHpWAnDVjAbKXgu3suSNIj/cHgkb08KfBU+J3ou+44D98h0ZDrozj+OgOBvr/q7
	LUL/9lCfBLcgoXQCbG0xMoND1856esg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723985038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hNdsCgDwfxx9qOwvJpBNpv6a1Q/E/N9dUawDuhnVU74=;
	b=Q74hn8t0F2JlsFCjXjJO5twmnZrb78JdqP7tkqUWycouaGu5LAfIR4OiixhPFwEa1ih/ke
	xC0IsbzJHpWAnDVjAbKXgu3suSNIj/cHgkb08KfBU+J3ou+44D98h0ZDrozj+OgOBvr/q7
	LUL/9lCfBLcgoXQCbG0xMoND1856esg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D86BD1397F;
	Sun, 18 Aug 2024 12:43:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CBCONI7swWZuBgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Sun, 18 Aug 2024 12:43:58 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.11-rc4, part 2
Date: Sun, 18 Aug 2024 14:43:54 +0200
Message-ID: <cover.1723984416.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.78 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.18)[-0.878];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.78

Hi,

a few more fixes. We got reports that shrinker added in 6.10 still
causes latency spikes and the fixes don't handle all corner cases. Due
to summer holidays we're taking a shortcut to disable it for release
builds and will fix it in the near future.

Please pull, thanks.

- only enable extent map shrinker for DEBUG builds, temporary quick fix
  to avoid latency spikes for regular builds

- update target inode's ctime on unlink, mandated by POSIX

- properly take lock to read/update block group's zoned variables

- add counted_by() annotations

----------------------------------------------------------------
The following changes since commit 6252690f7e1b173b86a4c27dfc046b351ab423e7:

  btrfs: fix invalid mapping of extent xarray state (2024-08-13 15:36:57 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc3-tag

for you to fetch changes up to 534f7eff9239c1b0af852fc33f5af2b62c00eddf:

  btrfs: only enable extent map shrinker for DEBUG builds (2024-08-16 21:22:39 +0200)

----------------------------------------------------------------
Jeff Layton (1):
      btrfs: update target inode's ctime on unlink

Naohiro Aota (1):
      btrfs: zoned: properly take lock to read/update block group's zoned variables

Qu Wenruo (2):
      btrfs: tree-checker: add dev extent item checks
      btrfs: only enable extent map shrinker for DEBUG builds

Thorsten Blum (1):
      btrfs: send: annotate struct name_cache_entry with __counted_by()

 fs/btrfs/free-space-cache.c | 14 +++++----
 fs/btrfs/inode.c            |  1 +
 fs/btrfs/send.c             |  2 +-
 fs/btrfs/super.c            |  8 +++++-
 fs/btrfs/tree-checker.c     | 69 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 86 insertions(+), 8 deletions(-)

