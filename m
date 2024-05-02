Return-Path: <linux-btrfs+bounces-4671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A608B9B46
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 15:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4CB1C220CD
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 13:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1E784FC3;
	Thu,  2 May 2024 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gr7HgnwT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gr7HgnwT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6480025;
	Thu,  2 May 2024 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655080; cv=none; b=Zx1v2eBxMy4CAXdG/Gn6QMTsi+PoOUpsIsWaxHSKZgYm3TzhfKcD235RXgWDrhHku/JOPIzLgwgjbXeQhjsl7jKL3R4N3TVy7bSa61n+iBL1/0dPiqpydPKo+14nY+EVVQ1AQgoSs1cUK3PbRM+T7+6u6Tfr3hU0rZE59Cib/n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655080; c=relaxed/simple;
	bh=9Sytb0R/juyLCsyWpjAt6xK7NUX0YzbFi7AcUjRnJxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRfO4J7R1RMGIqq2WfvOjpHjASWYvwvolHiqda48y9rkj+TYvWwaZBdsA72FrmsIe5KanA64siEzNlzqWL/fS/09NKMmV5uIA1w/MfqgrZ5eEUOrLZpYW06xVpsaPDnovm2yQsWVNyr5782BHy5N7JQg37FnLMxoxW/FH7XIz+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gr7HgnwT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gr7HgnwT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3063F1FC05;
	Thu,  2 May 2024 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714655077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Fas0eFkeRGK0Fm3A4e9li8djyPi6sXuaWV6aGsjK1qA=;
	b=Gr7HgnwT1hJPi/+NQZEpdqh5N00lxrV92xt9md83nJ9HXKPd+2BOtK28MjP3LG8N2PaM+4
	eoo2j2CJZEl7FxSu5eEzbXHZw7jQugy7xcx5mSI8ma5u4iHOvamUG/EiAU7RrJBLX/a5cY
	86uDfDLQQBIGijQWaAeDncqCrqPpRIU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714655077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Fas0eFkeRGK0Fm3A4e9li8djyPi6sXuaWV6aGsjK1qA=;
	b=Gr7HgnwT1hJPi/+NQZEpdqh5N00lxrV92xt9md83nJ9HXKPd+2BOtK28MjP3LG8N2PaM+4
	eoo2j2CJZEl7FxSu5eEzbXHZw7jQugy7xcx5mSI8ma5u4iHOvamUG/EiAU7RrJBLX/a5cY
	86uDfDLQQBIGijQWaAeDncqCrqPpRIU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26FDC13957;
	Thu,  2 May 2024 13:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sy6CCWWPM2b/RgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 02 May 2024 13:04:37 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.9-rc7
Date: Thu,  2 May 2024 14:57:18 +0200
Message-ID: <cover.1714654371.git.dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[]

Hi,

please pull a few more fixes, thanks.

- set correct ram_bytes when splitting ordered extent, this is
  can be inconsistent on-disk but harmless as it's not used for
  calculations and it's only advisory for compression

- fix lockdep splat when taking cleaner mutex in qgroups disable ioctl

- fix missing mutex unlock on error path when looking up sys chunk for
  relocation

----------------------------------------------------------------
The following changes since commit fe1c6c7acce10baf9521d6dccc17268d91ee2305:

  btrfs: fix wrong block_start calculation for btrfs_drop_extent_map_range() (2024-04-18 18:18:50 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc6-tag

for you to fetch changes up to 63a6ce5a1a6261e4c70bad2b55c4e0de8da4762e:

  btrfs: set correct ram_bytes when splitting ordered extent (2024-04-30 12:03:44 +0200)

----------------------------------------------------------------
Dominique Martinet (1):
      btrfs: add missing mutex_unlock in btrfs_relocate_sys_chunks()

Josef Bacik (1):
      btrfs: take the cleaner_mutex earlier in qgroup disable

Qu Wenruo (1):
      btrfs: set correct ram_bytes when splitting ordered extent

 fs/btrfs/ioctl.c        | 33 ++++++++++++++++++++++++++++++---
 fs/btrfs/ordered-data.c |  1 +
 fs/btrfs/qgroup.c       | 21 ++++++++-------------
 fs/btrfs/volumes.c      |  1 +
 4 files changed, 40 insertions(+), 16 deletions(-)

