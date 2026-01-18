Return-Path: <linux-btrfs+bounces-20656-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE85D39249
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 03:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B27F303802D
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 02:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D93202979;
	Sun, 18 Jan 2026 02:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mJWSfci4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kp5W5LDW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE1D189BB6
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768704564; cv=none; b=V5oUKOf0UoKW9x8WSTfxvDfZDr5LoMmSv87EcXpgkSEaazPVty2O9XcEU9cd2wLLdn4bCgl+1LX+0OBDPvbwmrPhtv7BGmAcBF14vKGRz5Vszh2PtXT1PqdRwp5IisMVFZeisL8DJ868hGE65K3LhBGXxbrTCldHSQna74CHDz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768704564; c=relaxed/simple;
	bh=HBUJXJ7FnfZVch7YgcuTtnoncIIy9J7LaP+rMaHSzsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kw/fFiNPUBZ19ObHWo2FQO1geHTagUpuFSQ0qUMan7F7xnJww77yIEXlIipXQvAR+WqcyAEkBCvI2UThGNCNUB5Io861WV++XxeHX+fdD3X6dnNShi/3wIc4IEwgse/m1AiTQiOfqE56Inktq0KzsYaSWaoqzIFg470OAieGpm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mJWSfci4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kp5W5LDW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0FAC33692;
	Sun, 18 Jan 2026 02:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768704556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2QP/eAeOWtBdCun+DeFFb02zVrvvztG24kz9DfBsze0=;
	b=mJWSfci48QoZZ+rcyrwTZZW/vCzlpOmoaKIOd2Zcf+46ge08iuRZC3ISWRX4334dwDDsr8
	eH6ZjI/qmSQbR0oP+wn1tvwLXrc0ljxPnOiAb3jdlJvUnuyxdLy1gKoW0o0eJsXr7eJb1I
	eLlMK1l+nZGiRxw+tdHN/VxQsJJoTWU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Kp5W5LDW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768704555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2QP/eAeOWtBdCun+DeFFb02zVrvvztG24kz9DfBsze0=;
	b=Kp5W5LDWXIDBKM3yvgeqooJZvHeoH+ZJAyR/ZxNwP338Y1Da67tk57rHazh2XoN8TEM6y8
	KsrZema2jHX8OdVIyuv5LfxiIq+tr9wi+JGZMBIswRrx0pi7bVce/4Hyn+jtFI055pfmxz
	czReF7cgrEkBImJYVGos8xZegkhOojw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C33CD3EA63;
	Sun, 18 Jan 2026 02:49:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BqFMLytKbGmGXgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Sun, 18 Jan 2026 02:49:15 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.19-rc6
Date: Sun, 18 Jan 2026 03:49:08 +0100
Message-ID: <cover.1768703360.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: D0FAC33692
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

Hi,

please pull the following fixes, thanks.

- with large folios in use, fix partial incorrect update of a reflinked
  range

- fix potential deadlock in iget when lookup fails and eviction is
  needed

- in send, validate inline extent type while detecting file holes

- fix memory leak after an error when creating a space info

- remove zone statistics from sysfs again, the output size limitations
  make it unusable, we'll do it in another way in another release

- test fixes:
  - return proper error codes from block remapping tests
  - fix tree root leaks in qgroup tests after errors

----------------------------------------------------------------
The following changes since commit 2bb83bc42be6280d9bc363b8fbcd6fdab690d16d:

  btrfs: show correct warning if can't read data reloc tree (2026-01-06 01:23:00 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc5-tag

for you to fetch changes up to 437cc6057e01d98ee124496f045ede36224af326:

  btrfs: remove zoned statistics from sysfs (2026-01-14 22:08:04 +0100)

----------------------------------------------------------------
Filipe Manana (2):
      btrfs: release path before iget_failed() in btrfs_read_locked_inode()
      btrfs: invalidate pages instead of truncate after reflinking

Jiasheng Jiang (1):
      btrfs: fix memory leaks in create_space_info() error paths

Johannes Thumshirn (1):
      btrfs: remove zoned statistics from sysfs

Naohiro Aota (1):
      btrfs: tests: fix return 0 on rmap test failure

Qu Wenruo (2):
      btrfs: send: check for inline extents in range_is_hole_in_parent()
      btrfs: update the Kconfig string for CONFIG_BTRFS_EXPERIMENTAL

Zilin Guan (1):
      btrfs: tests: fix root tree leak in btrfs_test_qgroups()

 fs/btrfs/Kconfig                  |  6 ++++-
 fs/btrfs/inode.c                  |  9 +++++++
 fs/btrfs/reflink.c                | 23 +++++++++--------
 fs/btrfs/send.c                   |  2 ++
 fs/btrfs/space-info.c             |  8 ++++--
 fs/btrfs/sysfs.c                  | 52 ---------------------------------------
 fs/btrfs/tests/extent-map-tests.c |  3 +++
 fs/btrfs/tests/qgroup-tests.c     |  6 ++---
 8 files changed, 41 insertions(+), 68 deletions(-)

