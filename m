Return-Path: <linux-btrfs+bounces-6430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873C593008B
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 20:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0254F1F239EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 18:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0DE20B20;
	Fri, 12 Jul 2024 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WWizCmdg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TAkAf+wY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC55168DC;
	Fri, 12 Jul 2024 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720810120; cv=none; b=fj9jNE5xfi5tfblnRmnG3Bwc4mUGOxWxZaiYJBOiTdJxfTgHuoL+1eI41IuQpje2XHMoqhMpMJykqwClMD6JEccMA3K8oAiD1ZS88bv0FtnWc4TWR8qcCtKOJfmb7siqljCcxDqQTT2LKw2IU8Rt4cILtffj7ByZczSKshwylmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720810120; c=relaxed/simple;
	bh=I90yjCY1Dvz00vWK492Gi5cmhk3nFxS7EaeeaQGnepM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OgTY0spe8kw94d1cUhj/DWrNHzzXoiQP1PfgtB6dPY0pH5wDT1P0c+PYa0T3yBaAvqtDXojn80Ez40CjZkbAG470HB/O79KbqhF1iIpB5rVp2s/7V+NLUIzPuKAnBbeX8d++RIeNyaWCdCMlXBi9Sj7TYd7pCv/VXh4+wm6+nks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WWizCmdg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TAkAf+wY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F3BA1FB99;
	Fri, 12 Jul 2024 18:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720810117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SOeqvw5RUu5R2ECsxUvsHeLqr92Df8mof2vHJyYk8ck=;
	b=WWizCmdgDwOZ3Li9l8i/6QvAaBbojwDhTOIiugL56EpkpCJFZeOvm52HquDCIVD09J6et0
	bwzP+qIPCPvA2Z4wevoc2YGvihTc0jZgGuzJ5CG4g1tp/7Tuq1M/btM719t7Ch73qERz9N
	jQudax/DocqsN1BIfLoz4EkKaTrYTfY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=TAkAf+wY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720810115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SOeqvw5RUu5R2ECsxUvsHeLqr92Df8mof2vHJyYk8ck=;
	b=TAkAf+wYqBmy+VnMlNudZu2fWqvIN9XcTYtzdlvXApedqp8DaN3wSE0xe5+Xox4tsv+AQW
	K1cizEuft1QqKgtyXtIpKyIbsSOTOuLPFZA1Df3bD0sY1vEmqeMKKh76gP0U/JJj8oyEZ5
	Wr6JPq6x/5B7UvLv429FDs8wnEBHkXw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84C5C1373E;
	Fri, 12 Jul 2024 18:48:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z64ZIIN6kWY3QwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 12 Jul 2024 18:48:35 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.10-rc8
Date: Fri, 12 Jul 2024 20:48:27 +0200
Message-ID: <cover.1720807949.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F3BA1FB99
X-Spamd-Result: default: False [-1.01 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Score: -1.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Hi,

please pull the following branch that fixes a regression in extent map
shrinker behaviour.

In the past weeks we got reports from users that there are huge latency
spikes or freezes. This was bisected to newly added shrinker of extent
maps (it was added to fix a build up of the structures in memory).

I'm assuming that the freezes would happen to many users after release
so I'd like to get it merged now so it's in 6.10.  Although the diff
size is not small the changes are relatively straightforward, the
reporters verified the fixes and we did testing on our side.

Please pull, thanks.

The fixes:

- adjust behaviour under memory pressure and check lock or scheduling
  conditions, bail out if needed

- synchronize tracking of the scanning progress so inode ranges are not
  skipped or work duplicated

- do a delayed iput when scanning a root so evicting an inode does not
  slow things down in case of lots of dirty data, also fix lockdep
  warning, a deadlock could happen when writing the dirty data would
  need to start a transaction

----------------------------------------------------------------
The following changes since commit a56c85fa2d59ab0780514741550edf87989a66e9:

  btrfs: fix folio refcount in __alloc_dummy_extent_buffer() (2024-07-04 02:19:10 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc7-tag

for you to fetch changes up to 4484940514295b75389f94787f8e179ba6255353:

  btrfs: avoid races when tracking progress for extent map shrinking (2024-07-11 16:50:54 +0200)

----------------------------------------------------------------
Filipe Manana (3):
      btrfs: use delayed iput during extent map shrinking
      btrfs: stop extent map shrinker if reschedule is needed
      btrfs: avoid races when tracking progress for extent map shrinking

 fs/btrfs/disk-io.c           |   2 +
 fs/btrfs/extent_map.c        | 123 +++++++++++++++++++++++++++++++++----------
 fs/btrfs/fs.h                |   1 +
 include/trace/events/btrfs.h |  18 ++++---
 4 files changed, 107 insertions(+), 37 deletions(-)

