Return-Path: <linux-btrfs+bounces-9100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEAB9ACFBC
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 18:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96DEAB236DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 16:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA1C1CB31C;
	Wed, 23 Oct 2024 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k1yUVUCV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k1yUVUCV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D741C8FD3;
	Wed, 23 Oct 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699678; cv=none; b=ipINZF7ZJ1s/XkYs+Dra3eAdjBmqZudugq/L9xCS3x2BFWxshZFrV7FNNBFZ6bV/YcOXgJi/poqDFS2vAk/8y5vQgEP+fKzA6czXKCboG6pIBw5j7TKCYkp8dwduy0Hxb9dJ/ksu3fMmyQR8UX1NVVqnnOxOrvWPRb8DfaqiapQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699678; c=relaxed/simple;
	bh=Wa+db8qXy2PwiOi+imW+9UjhrUt49h4FyD36IqGZJJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dc3si08PXw/ZeSZf5/ZeKViNzFcmxyiYmDufsigxcR47S7CTeLryvmoMBX6SLQhfXLijVV0dHZMe3NGhHZqafM9aDFsRdKSa2+TJMEjiLzKMmGHhxfVIbUYgtCI1BFZcgseDuWTTYp81blaQvXexSzhgsKo+bRn5iUvmrWoOjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k1yUVUCV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k1yUVUCV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AFD6B1FB5E;
	Wed, 23 Oct 2024 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729699674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UiuK+OCWN9YH4CFNOyu5h94c2DBzdUCQy5ofddMD7uk=;
	b=k1yUVUCV1hYhKj5BuIwG+iz84lxwNOeccxCj1OGQKJRXRbhidDU7cOgm8M76/aGyv0Aljy
	L+a1y3Ipeu9x4jV/ghk2kRioSYGdxxYXAt5Am4E2ZAP/P4/aaf3ci8acx2exV0zjtsIFRt
	nvi3Us8BjEdFYJ5FFuHSJN66qlMCTRU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=k1yUVUCV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729699674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UiuK+OCWN9YH4CFNOyu5h94c2DBzdUCQy5ofddMD7uk=;
	b=k1yUVUCV1hYhKj5BuIwG+iz84lxwNOeccxCj1OGQKJRXRbhidDU7cOgm8M76/aGyv0Aljy
	L+a1y3Ipeu9x4jV/ghk2kRioSYGdxxYXAt5Am4E2ZAP/P4/aaf3ci8acx2exV0zjtsIFRt
	nvi3Us8BjEdFYJ5FFuHSJN66qlMCTRU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8A3113AD3;
	Wed, 23 Oct 2024 16:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 44QmKVofGWelNQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Oct 2024 16:07:54 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.12-rc5
Date: Wed, 23 Oct 2024 18:07:39 +0200
Message-ID: <cover.1729698780.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AFD6B1FB5E
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

please pull the following fixes, all for stable trees. Thanks.

- mount option fixes:
  - fix handling of compression mount options on remount
  - reject rw remount in case there are options that don't work in
    read-write mode (like rescue options)

- fix zone accounting of unusable space

- fix in-memory corruption when merging extent maps

- fix delalloc range locking for sector < page

- use more convenient default value of drop subtree threshold, clean
  more subvolumes without the fallback to marking quotas inconsistent

- fix smatch warning about incorrect value passed to ERR_PTR

----------------------------------------------------------------
The following changes since commit 2ab5e243c2266c841e0f6904fad1514b18eaf510:

  btrfs: fix uninitialized pointer free on read_alloc_one_name() error (2024-10-11 19:55:04 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc4-tag

for you to fetch changes up to 75f49c3dc7b7423d3734f2e4dabe3dac8d064338:

  btrfs: fix passing 0 to ERR_PTR in btrfs_search_dir_index_item() (2024-10-22 16:10:55 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: fix read corruption due to race with extent map merging

Filipe Manana (1):
      btrfs: clear force-compress on remount when compress mount option is given

Naohiro Aota (1):
      btrfs: zoned: fix zone unusable accounting for freed reserved extent

Qu Wenruo (3):
      btrfs: qgroup: set a more sane default value for subtree drop threshold
      btrfs: fix the delalloc range locking if sector size < page size
      btrfs: reject ro->rw reconfiguration if there are hard ro requirements

Yue Haibing (1):
      btrfs: fix passing 0 to ERR_PTR in btrfs_search_dir_index_item()

 fs/btrfs/block-group.c |  2 ++
 fs/btrfs/dir-item.c    |  4 ++--
 fs/btrfs/disk-io.c     |  2 +-
 fs/btrfs/extent_io.c   | 17 +++++++++--------
 fs/btrfs/extent_map.c  | 31 ++++++++++++++++---------------
 fs/btrfs/inode.c       |  7 ++-----
 fs/btrfs/qgroup.c      |  2 +-
 fs/btrfs/qgroup.h      |  2 ++
 fs/btrfs/super.c       | 12 ++++++++++--
 9 files changed, 45 insertions(+), 34 deletions(-)

