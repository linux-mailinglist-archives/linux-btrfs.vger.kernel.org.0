Return-Path: <linux-btrfs+bounces-16128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0613B2ADE2
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 18:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72DB18A35C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1905D340D8E;
	Mon, 18 Aug 2025 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CalRsrjy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CalRsrjy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E02322545
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533684; cv=none; b=WTzUqs64UEl7aKomfrDBFpKqwC7VfeGFOyG47XtTxyiG5H6D0soH2flhwCvsdz3CMM+UUkIDlCfsFCEHqZkLPnZDv/qXWWj24qfFwcDeOftk/trmSUJKUyrZUHAMIdmobX/p7pd36hWPiTI6/zpyh1jJdT6rzlijaKJPHwMRhhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533684; c=relaxed/simple;
	bh=lG3/HZN/oApQulXrFiLP6o6pN3Ev4BBURK5QR6bR8KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxTXGq2Xfh6fn2EsTVl0Vi5Jek1anyE2LPiF3t89PMOjaEzhCRknIcyq7KQ4fnn7fNLGY+rMd2oQ7l6zFB/4qB9DBr9sCZUgN7h2Nst5yxZfRdgDV1pwaC6n2cHv/o2dO0pyV/ZemxlRahoOLessLkh6pwyt3Txxk2no1v34V58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CalRsrjy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CalRsrjy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E8512125E;
	Mon, 18 Aug 2025 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755533679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Rv14F8Ja44eIaCCKmqxgwzyp1sZSF8Esb2z+zs6Un5s=;
	b=CalRsrjyaDhz0VGnnEBB6eE8938nlVeuPUHBkSSppBgn0pjvANjExpaypM9zESCQSvE4Pq
	C9co4iiVTZxrxxNO6gyXn1jz5viNNAhOw4jLtQKzqQmLSj4hKkLS4lHzrOJ4QUOCoEKYXo
	LK3qfKoSgt31CrwG919iHFuF5jfxZBU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CalRsrjy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755533679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Rv14F8Ja44eIaCCKmqxgwzyp1sZSF8Esb2z+zs6Un5s=;
	b=CalRsrjyaDhz0VGnnEBB6eE8938nlVeuPUHBkSSppBgn0pjvANjExpaypM9zESCQSvE4Pq
	C9co4iiVTZxrxxNO6gyXn1jz5viNNAhOw4jLtQKzqQmLSj4hKkLS4lHzrOJ4QUOCoEKYXo
	LK3qfKoSgt31CrwG919iHFuF5jfxZBU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33EB813A55;
	Mon, 18 Aug 2025 16:14:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YlZeDG9Ro2gzPwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 18 Aug 2025 16:14:39 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.17-rc3
Date: Mon, 18 Aug 2025 18:14:28 +0200
Message-ID: <cover.1755532653.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 3E8512125E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Hi,

please pull the following branch. There are several zoned mode fixes,
mount option printing fixups, folio state handling fixes and one log
replay fix. Thanks.

- zoned mode
  - zone activation and finish fixes
  - block group reservation fixes

- mount option fixes
  - bring back printing of mount options with key=value that got
    accidentally dropped during mount option parsing in 6.8
  - fix inverse logic or typos when printing nodatasum/nodatacow

- folio status fixes
  - writeback fixes in zoned mode
  - properly reset dirty/writeback if submission fails
  - properly handle TOWRITE xarray mark/tag

- do not set mtime/ctime to current time when unlinking for log replay

----------------------------------------------------------------
The following changes since commit 7b632596188e1973c6b3ac1c9f8252f735e1039f:

  btrfs: fix iteration bug in __qgroup_excl_accounting() (2025-08-07 17:07:16 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc2-tag

for you to fetch changes up to 74857fdc5dd2cdcdeb6e99bdf26976fd9299d2bb:

  btrfs: fix printing of mount info messages for NODATACOW/NODATASUM (2025-08-13 14:08:58 +0200)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: do not set mtime/ctime to current time when unlinking for log replay

Johannes Thumshirn (1):
      btrfs: zoned: skip ZONE FINISH of conventional zones

Kyoji Ogasawara (3):
      btrfs: fix incorrect log message for nobarrier mount option
      btrfs: restore mount option info messages during mount
      btrfs: fix printing of mount info messages for NODATACOW/NODATASUM

Naohiro Aota (5):
      btrfs: zoned: fix data relocation block group reservation
      btrfs: zoned: fix write time activation failure for metadata block group
      btrfs: zoned: limit active zones to max_open_zones
      btrfs: subpage: keep TOWRITE tag until folio is cleaned
      btrfs: fix buffer index in wait_eb_writebacks()

Qu Wenruo (3):
      btrfs: clear block dirty if submit_one_sector() failed
      btrfs: clear block dirty if btrfs_writepage_cow_fixup() failed
      btrfs: clear TAG_TOWRITE from buffer tree when submitting a tree block

 fs/btrfs/extent_io.c |  24 ++++++++--
 fs/btrfs/inode.c     |  29 +++++++----
 fs/btrfs/subpage.c   |  19 +++++++-
 fs/btrfs/super.c     |  13 +++--
 fs/btrfs/zoned.c     | 133 ++++++++++++++++++++++++++++++++++++++-------------
 5 files changed, 163 insertions(+), 55 deletions(-)

