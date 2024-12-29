Return-Path: <linux-btrfs+bounces-10651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0468E9FDDDC
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2024 08:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192253A166C
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2024 07:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89EB3BBD8;
	Sun, 29 Dec 2024 07:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UkVbVeTe";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UkVbVeTe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DBFE573;
	Sun, 29 Dec 2024 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735458054; cv=none; b=Q+egvglzgV4mBG6orqm0WA6Lk92VjNfYyrCV0IpkA7GdcOu8OLfcXgVpCE7vMLGMmrcxoHAfu4FLdJdp++tykHn8yuFRD9vJezyx2ODumboIoDcBkjvlSIwZzaR/46B5PbJz7PJalw2yWjeR0oEPzqpUAfmBrVEi8lTnI1qDamI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735458054; c=relaxed/simple;
	bh=H3HdkkAaxWdRotQYVMAObkFH0TYfGfMcXz+4BiWnANY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N44jLyWwHMfDzqRZDAXqcKECSrKWUWiU7XbxZ1dNHUojl6aTCUaRINaxXzeYxTe7HaLFOPT92cL+BQkT7Zq0BCPA1SaDxazDw37U4UmxaGR6r/II3k4o55Z16qxmBbNyxw3YA4KDOubBZ/HBRP0l2vIvDco+y6g/5I1qJRrieDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UkVbVeTe; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UkVbVeTe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 908301F44F;
	Sun, 29 Dec 2024 07:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1735458044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=d5AmQpTFt2YljKNwh0IpogHSXNMU8beRcpkw6KcCpAg=;
	b=UkVbVeTeBJBAi650YqEkHQfMrZ9vV+holQZTZDcMA2xTCoozTmZURuRc73Nh2pK2M3cgJS
	iEP1Cap7Zsy6gYfQ/kMRQdHTwL5Q9BPW9quEnSt/LbmSSyPuybI/3Yu/ugsoj34AuY+wrt
	h9nuOEptLkVVS7n34QLc3vJ0vSeaEfk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=UkVbVeTe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1735458044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=d5AmQpTFt2YljKNwh0IpogHSXNMU8beRcpkw6KcCpAg=;
	b=UkVbVeTeBJBAi650YqEkHQfMrZ9vV+holQZTZDcMA2xTCoozTmZURuRc73Nh2pK2M3cgJS
	iEP1Cap7Zsy6gYfQ/kMRQdHTwL5Q9BPW9quEnSt/LbmSSyPuybI/3Yu/ugsoj34AuY+wrt
	h9nuOEptLkVVS7n34QLc3vJ0vSeaEfk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85964139D0;
	Sun, 29 Dec 2024 07:40:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PP9QIPz8cGf5NgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Sun, 29 Dec 2024 07:40:44 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.13-rc5
Date: Sun, 29 Dec 2024 08:40:38 +0100
Message-ID: <cover.1735454878.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 908301F44F
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
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

a few more fixes that accumulated over the last two weeks, fixing some
user reported problems. Please pull, thanks.

- swapfile fixes
  - conditional reschedule in the activation loop
  - fix race with memory mapped file when activating
  - make activation loop interruptible
  - rework and fix extent sharing checks

- folio fixes
  - in send, recheck folio mapping after unlock
  - in relocation, recheck folio mapping after unlock

- fix waiting for encoded read io_uring requests

- fix transaction atomicity when enabling simple quotas

- move COW block trace point before the block gets freed

- print various sizes in sysfs with correct endianity

----------------------------------------------------------------
The following changes since commit f10bef73fb355e3fc85e63a50386798be68ff486:

  btrfs: flush delalloc workers queue before stopping cleaner kthread during unmount (2024-12-06 15:04:18 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-rc4-tag

for you to fetch changes up to fca432e73db2bec0fdbfbf6d98d3ebcd5388a977:

  btrfs: sysfs: fix direct super block member reads (2024-12-23 22:06:44 +0100)

----------------------------------------------------------------
Boris Burkov (2):
      btrfs: check folio mapping after unlock in relocate_one_folio()
      btrfs: check folio mapping after unlock in put_file_data()

Filipe Manana (5):
      btrfs: fix use-after-free when COWing tree bock and tracing is enabled
      btrfs: fix race with memory mapped writes when activating swap file
      btrfs: fix swap file activation failure due to extents that used to be shared
      btrfs: allow swap activation to be interruptible
      btrfs: avoid monopolizing a core when activating a swap file

Johannes Thumshirn (1):
      btrfs: fix use-after-free waiting for encoded read endios

Julian Sun (1):
      btrfs: fix transaction atomicity bug when enabling simple quotas

Qu Wenruo (1):
      btrfs: sysfs: fix direct super block member reads

 fs/btrfs/ctree.c      |  11 ++--
 fs/btrfs/inode.c      | 154 +++++++++++++++++++++++++++++++++++---------------
 fs/btrfs/qgroup.c     |   3 +-
 fs/btrfs/relocation.c |   6 ++
 fs/btrfs/send.c       |   6 ++
 fs/btrfs/sysfs.c      |   6 +-
 6 files changed, 130 insertions(+), 56 deletions(-)

