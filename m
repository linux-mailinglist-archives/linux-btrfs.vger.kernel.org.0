Return-Path: <linux-btrfs+bounces-10214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C66E49EBFA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 00:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DCB1887945
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 23:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5866722C374;
	Tue, 10 Dec 2024 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T9l41TaE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T9l41TaE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7230622C35E;
	Tue, 10 Dec 2024 23:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733874959; cv=none; b=Vp/R4oG1CCiH8c6tGhbDfKi/3Sc19eFv3OPQfW51McvHh9olQsEYWbALvQbely02DZnkkmPQBpEI0jCc2SJZb123hOuAKpeulWGNnuo/SwUFroWUoXDEbgW+El6dzAvBVLKqnkRbZuK3kSWxDisBpUxwpSU5x+OL+f+WKAXLI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733874959; c=relaxed/simple;
	bh=IVew1aDlUCnTzgzVs5mV0nFZ9+TP/v1Nl2UxDmzW5tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQjZk2ccOE8AYHoL5lDt8ESrBTTv7Ddx0eR8EMoyRHa5B/PgS9q3hK6dqjYR+gqx6k+D34frj2lky3HLJScdii7dv+voNENaEhu571LuoN3k7u6Fe/qb+lVX/GFUb3XkVVA1Eu7fWbDzL139ks74gzCKQArTLIsHqSwTkdLCHyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T9l41TaE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T9l41TaE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 919A821134;
	Tue, 10 Dec 2024 23:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733874949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IBVmVNarx5DXXXv58SXq8j/3EuMZpNDOaY0oHlEaZ+I=;
	b=T9l41TaEE9Z5HYYJfebvtt8FG1dn8kyHJnm+gx41/dPYUUTKf0LYmMEpPCOGkUuzq/wi2w
	6gf6wh8FYx6bZy4clDNtsOc3sVSOsqlYnKSU50M3dGjvj5lP915pq/PA7nmPLclR1SFLLs
	UTKfvEaVEnJBxSUZCPYvnJdw19Ip4Ok=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=T9l41TaE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733874949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IBVmVNarx5DXXXv58SXq8j/3EuMZpNDOaY0oHlEaZ+I=;
	b=T9l41TaEE9Z5HYYJfebvtt8FG1dn8kyHJnm+gx41/dPYUUTKf0LYmMEpPCOGkUuzq/wi2w
	6gf6wh8FYx6bZy4clDNtsOc3sVSOsqlYnKSU50M3dGjvj5lP915pq/PA7nmPLclR1SFLLs
	UTKfvEaVEnJBxSUZCPYvnJdw19Ip4Ok=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89C861370C;
	Tue, 10 Dec 2024 23:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LiieIQXVWGflNwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 10 Dec 2024 23:55:49 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.13-rc3
Date: Wed, 11 Dec 2024 00:55:04 +0100
Message-ID: <cover.1733873735.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 919A821134
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi,

please pull a few more fixes. Apart from the one liners and updated bio
splitting error handling there's a fix for subvolume mount with
different flags. This is known and fixed for some time but I've delayed
it to give it more testing. More details about that below.

Please pull, thanks.

- fix unbalanced locking when swapfile activation fails when the
  subvolume gets deleted in the meantime

- add btrfs error handling after bio_split() calls that got error
  handling recently

- during unmount, flush delalloc workers at the right time before the
  cleaner thread is shut down

- fix regression in buffered write folio conversion, explicitly wait for
  writeback as FGP_STABLE flag is currently a no-op on btrfs

- handle race in subvolume mount with different flags, the conversion to
  the new mount API did not handle the case where multiple subvolumes
  get mounted in parallel, which is a distro use case

----------------------------------------------------------------
The following changes since commit 22d2e48e318564f8c9b09faf03ecb4f03fb44dd5:

  btrfs: fix lockdep warnings on io_uring encoded reads (2024-11-29 16:56:38 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-rc2-tag

for you to fetch changes up to f10bef73fb355e3fc85e63a50386798be68ff486:

  btrfs: flush delalloc workers queue before stopping cleaner kthread during unmount (2024-12-06 15:04:18 +0100)

----------------------------------------------------------------
Filipe Manana (2):
      btrfs: fix missing snapshot drew unlock when root is dead during swap activation
      btrfs: flush delalloc workers queue before stopping cleaner kthread during unmount

Johannes Thumshirn (1):
      btrfs: handle bio_split() errors

Qu Wenruo (2):
      btrfs: fix mount failure due to remount races
      btrfs: properly wait for writeback before buffered write

 fs/btrfs/bio.c     | 17 ++++++++++++--
 fs/btrfs/disk-io.c |  9 ++++++++
 fs/btrfs/file.c    |  1 +
 fs/btrfs/inode.c   |  1 +
 fs/btrfs/super.c   | 66 ++++++++++++++++++++++--------------------------------
 5 files changed, 53 insertions(+), 41 deletions(-)

