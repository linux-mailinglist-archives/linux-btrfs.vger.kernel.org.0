Return-Path: <linux-btrfs+bounces-15074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D67AED3D0
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 07:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABAF61730C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 05:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA4C1C84C0;
	Mon, 30 Jun 2025 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lL6a+SJv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lL6a+SJv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3A01A23BD
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751261377; cv=none; b=d//wKScKuic2K7O9wiHTZv8+awR/siPZIUo4RCaz+cdp2ZetNqpN9OytdQoL4CoaVhJBzWeBrcHkqIOxXmGzWy69UhC/EISaOkXvh+EffA9cd9Xfi25xCt6xvKF99LTzekUl0ja2ed1zK+bdyh5sOZDz5YD+IIRMTPoUyF7so9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751261377; c=relaxed/simple;
	bh=tVMDwsZaJfHtuMDSbuMYv7Yc9Ougu/q1BgVyXYkRab0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ACkIsK1PvFgpwaYb/HFdb3tTWaBrZdxWopZAIfS68kQcUUnfKTAY/AeuLihLCVXpvDsXzxGuLWMcUbhlMlpn902hNQhWQ0TbboKUcL0DT4dNOnsQib3z6rHdE0audEV5IiaFS0IR64s7XMvyYVTkVyZKr8y9Ff49RN7enwwwaS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lL6a+SJv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lL6a+SJv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A0132115F
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751261372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j8pT5yhJW7gUh0hOh5V8CxGjNwVOFsKuK8r/jx9pHpU=;
	b=lL6a+SJvTqZGl3AP3BIqUh75vUHcc5pF1A4yl4zxmuXk6TCMETFgLA6E1KrAdePPi9CIab
	F2jnNMccGvqCbGAoJMbpT0pK2A6K5W6j+kC6eh/ME9ra7atxUPfZ9rjjGFpMTMJhGKu95J
	pZkGxxWjoSNJZ8PAXxovLCvoXPYYPsM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=lL6a+SJv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751261372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j8pT5yhJW7gUh0hOh5V8CxGjNwVOFsKuK8r/jx9pHpU=;
	b=lL6a+SJvTqZGl3AP3BIqUh75vUHcc5pF1A4yl4zxmuXk6TCMETFgLA6E1KrAdePPi9CIab
	F2jnNMccGvqCbGAoJMbpT0pK2A6K5W6j+kC6eh/ME9ra7atxUPfZ9rjjGFpMTMJhGKu95J
	pZkGxxWjoSNJZ8PAXxovLCvoXPYYPsM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81F87139D4
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6SGVELsgYmi4SAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v6 0/8] btrfs: use fs_holder_ops for btrfs
Date: Mon, 30 Jun 2025 14:59:04 +0930
Message-ID: <cover.1751261286.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4A0132115F
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01
X-Spam-Level: 

[CHANGELOG]
v6:
- Fix an error handling bug that can lead to use-after-free
  Reported by syzbot, that inside btrfs_get_tree_super() that if we
  didn't open the devices, there are corner cases that
  fs_info->fs_devices can be freed twice, causing use-after-free bug.

  This one fixed two error paths:
  * sget_fc() failure
    Which is not the one reported by syzbot, but still possible to hit.

  * btrfs_open_devices() failure
    Which I believe is the one reported by syzbot.

  There is a dedicated fix pushed into linux-next.

  This refreshed series is for the proper merge into our for-next
  branch.

v5:
- Fix a tailing whitespace
  This introduced by patch "btrfs: add comments to make super block
  creation more clear", and that patch is created during a small
  window where my commit checkpatch hook is broken.

  And unfortunately that comment is also later updated by several
  patches, causing several conflicts with that whitespace error fixed.

v4:
- Fix a lockdep error
  In the patch "btrfs: delay btrfs_open_devices() until super block is
  created", we call sget_fc() with uuid_mutex locked.
  But during fs closing, we also try to lock uuid_mutex with s_umount
  locked.

  This leads to a reserved lock sequence and resuled a lockdep warning.

  Fix it by introducing btrfs_fs_devices::holding (aka, the old solution
  introduced by Christoph), but this time with no extra bugs during
  fstests.

- Add the patch to use fs_holder_ops
  This patch is small and properly tested, it's more situable to include
  this one here, other than delaying it to the next devloss feature.

- Add the missing patch to always open device-readonly when scanning
  My bad, there are a little too many patches pending, and I forgot to
  include the first patch.

v3:
- Drop the btrfs_fs_devices::opened split
  It turns out to cause problems during tests.

- Extra cleanup related to the btrfs_get_tree_*()
  Now the re-entry through vfs_get_tree() is completely dropped.

- Extra comments explaining the sget_fc() behavior

- Call bdev_fput() instead of fput()
  This alignes us to all the other fses.

- Updated patch to delay btrfs_open_devices() until sget_fc()
  Instead of relying on the previous solution (split
  btrfs_open_devices::opened), just expand the uuid_mutex critical
  section.


Christoph Hellwig (3):
  btrfs: always open the device read-only in btrfs_scan_one_device
  btrfs: call btrfs_close_devices from ->kill_sb
  btrfs: use the super_block as holder when mounting file systems

Qu Wenruo (5):
  btrfs: get rid of the re-entry of btrfs_get_tree()
  btrfs: add comments to make super block creation more clear
  btrfs: call bdev_fput() to reclaim the blk_holder immediately
  btrfs: delay btrfs_open_devices() until super block is created
  btrfs: use fs_holder_ops for all opened devices

 fs/btrfs/dev-replace.c |   4 +-
 fs/btrfs/disk-io.c     |   4 +-
 fs/btrfs/fs.h          |   2 -
 fs/btrfs/ioctl.c       |   4 +-
 fs/btrfs/super.c       | 129 ++++++++++++++++++++++-------------------
 fs/btrfs/volumes.c     |  33 ++++++-----
 fs/btrfs/volumes.h     |  27 ++++++++-
 7 files changed, 119 insertions(+), 84 deletions(-)

-- 
2.50.0


