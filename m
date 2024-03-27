Return-Path: <linux-btrfs+bounces-3683-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4EC88F046
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 21:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D2C1F30024
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 20:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E432E1534F4;
	Wed, 27 Mar 2024 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AsNXxNm2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c/+uD66h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73814D6EB;
	Wed, 27 Mar 2024 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571986; cv=none; b=qnqJDiZTvGTZCUciQ7vCAK7HBUwMcxkvBsSbfsCl7WMH6lme1dQ3HXvi5T54ToXyiqYpZ9ofmB/OVmfW96FC6TtMkOXKHShcANt8oMmzL32iurMdG9yU7n84bt7A5Y/zMcCNLperL1FAc8JnpFEoEkcyuB71g8yeaURbhc6Ho9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571986; c=relaxed/simple;
	bh=MYjXKGml4yTVTChKso7uNGqldcMcIKtOtNKtzVnHsmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mcCDWvhDzJ9MJM6fFakHuLtRgVwfRL4+/qUXwVT2zMx6VVwA2RVvaghLD4SkAQbb+1hyk5SB4G9DKn3u6RUqJkcucn/gu1OxOdRV+pMZTtHIPFKf4gN0R/Kjp/k/WLZRMhXpVAugs9X3vJlxzJIiBYl3Hri09drVqRAjXMUIWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AsNXxNm2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c/+uD66h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C28DE229B9;
	Wed, 27 Mar 2024 20:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711571982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/IKbn2oj33so0jZy+ftN03yc0feDXvMhZ5ZgHhL7tD0=;
	b=AsNXxNm2pZNhDHZEweT6VY5xGt5B8qgWaYhOgi3bBG5zaafR12F46jEt00GqbIao/rjmlD
	I+61S66YhhqzD3KiJvevlZNgIYI+FvHH8Ucv863V46TNpSqLnAV+yI6WyEh/4bYGcR0ma6
	Pt8x1x+x9hNu46I3fyNTvaTdPashRj4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711571981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/IKbn2oj33so0jZy+ftN03yc0feDXvMhZ5ZgHhL7tD0=;
	b=c/+uD66hnaQgGXhed0gnWJzk9V5YrzEc2vxRPGrwIjSS5IypRqPeF+W0JJk5aHTtkIi9fW
	mVQcX8hXkNCmbX5CO2twPLm5k4abgW6soisUEXyXl5oIDx+Ull2IUsI243TrNC7RWBR398
	CQ1PSFhurU/fGpdX8PBIlEJdjnF2rh8=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B8E0613AB3;
	Wed, 27 Mar 2024 20:39:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IS7bLA2EBGYcFAAAn2gu4w
	(envelope-from <dsterba@suse.com>); Wed, 27 Mar 2024 20:39:41 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.9-rc2
Date: Wed, 27 Mar 2024 21:32:19 +0100
Message-ID: <cover.1711571199.git.dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.51
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="c/+uD66h"
X-Rspamd-Queue-Id: C28DE229B9

Hi,

here's another batch of stability fixes.

The first fix is for the bug you also hit after 6.8-rc2 pull request [1].
We got another report, fortunately it was reproducible and in the end we also
got the fix.

[1] https://lore.kernel.org/linux-btrfs/CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com/

The rest is usual mix of fixes, zoned mode, device status handling and
error handling.

Please pull, thanks.

- fix race when reading extent buffer and 'uptodate' status is missed by one
  thread (introduced in 6.5)

- do additional validation of devices using major:minor numbers

- zoned mode fixes:
  - use zone-aware super block access during scrub
  - fix use-after-free during device replace (found by KASAN)
  - also delete zones that are 100% unusable to reclaim space

- extent unpinning fixes
  - fix extent map leak after error handling
  - print correct range in error message

- error code and message updates

----------------------------------------------------------------
The following changes since commit 1cab1375ba6d5337a25acb346996106c12bb2dd0:

  btrfs: reuse cloned extent buffer during fiemap to avoid re-allocations (2024-03-05 18:14:19 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc1-tag

for you to fetch changes up to ef1e68236b9153c27cb7cf29ead0c532870d4215:

  btrfs: fix race in read_extent_buffer_pages() (2024-03-26 16:42:39 +0100)

----------------------------------------------------------------
Anand Jain (2):
      btrfs: validate device maj:min during open
      btrfs: return accurate error code on open failure in open_fs_devices()

Filipe Manana (4):
      btrfs: fix extent map leak in unexpected scenario at unpin_extent_cache()
      btrfs: fix warning messages not printing interval at unpin_extent_range()
      btrfs: fix message not properly printing interval when adding extent map
      btrfs: use btrfs_warn() to log message at btrfs_add_extent_mapping()

Johannes Thumshirn (3):
      btrfs: zoned: use zone aware sb location for scrub
      btrfs: zoned: fix use-after-free in do_zone_finish()
      btrfs: zoned: don't skip block groups with 100% zone unusable

Tavian Barnes (1):
      btrfs: fix race in read_extent_buffer_pages()

 fs/btrfs/block-group.c |  3 ++-
 fs/btrfs/extent_io.c   | 13 +++++++++++++
 fs/btrfs/extent_map.c  | 16 ++++++++--------
 fs/btrfs/scrub.c       | 12 +++++++++++-
 fs/btrfs/volumes.c     | 27 ++++++++++++++++++++++-----
 fs/btrfs/zoned.c       | 14 +++++++-------
 6 files changed, 63 insertions(+), 22 deletions(-)

