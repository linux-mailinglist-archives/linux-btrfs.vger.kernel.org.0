Return-Path: <linux-btrfs+bounces-14854-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166D2AE3D31
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 12:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A26B3A2F19
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 10:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D2C230BF8;
	Mon, 23 Jun 2025 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aWwkMFyq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sx843h5Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD33596F
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675621; cv=none; b=keAGGRtNF3d7rl01ihY7RQ8LCt5IRI6uc18cRQZ7yTiKzUagYe98lLhQWdvX/+PYoG9qj2xcF4ysK31Dn7xw+LvaxoXCO8IlmC6iSB8dS9BXeVJIqefqOBgsTLxev2FYo2PxC3FnLN8QCh1Kr5VspQYo0xb+1qTTBQOMeCQsaiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675621; c=relaxed/simple;
	bh=qocXKCuUv9/9GPPZvM/oC85Z2x2RsDxAAy58NCMJp5Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eNs4rYkWBO3uMLpFIsu63Btviod4bVyDisrQZIWLh8I1yX3yNSLrSOudEMytcx1h81xnDt5rprtelotS4C81w4JQPshU3JLAPtTRTphbxFuMK1XuvW0hkssL/VNBJAj5lWvIx/KPzfx2DxBTgPzw3OPQZxTFdRKle13VJldaufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aWwkMFyq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sx843h5Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74E432116C
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750675617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rgqdl+jtmBPLymbtKyqGV6m7sIVts3VnShy+4nj1zXg=;
	b=aWwkMFyqVh7mhHKfGW3v2MZa/+T6Ey5yIFUsaoAYb3BYDfHz6JEx0O4MwFJp9fJPc2pzj8
	FAn5pbEu4fPM8+OAzrJgQSaNBmPhQRvva33UnvDOq0Iq/Bb3IdRUiPE6kfHUPOoDIZJq/u
	YRuxVs5qKfM6VhNcSNuNIPwI7WJHv2s=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sx843h5Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750675616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rgqdl+jtmBPLymbtKyqGV6m7sIVts3VnShy+4nj1zXg=;
	b=sx843h5YNw/Q6XxsJA3jocxL4IQSPzul+6RSUvdcUwv772RMec+SEVxRs27YWzgwdP/kM3
	75dt5xwX8K07dCXk7bNQzZAJSu5J6xJhcx9Kp+gGT1Dr5OEUponSA+iURE/c+DSqTOfb9a
	Sb0deMVDFvU3gSjrdRVAwa1sHum43Fk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B15FC13485
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:46:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3VfCHJ8wWWgeJAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:46:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/8] btrfs: use fs_holder_ops for btrfs
Date: Mon, 23 Jun 2025 20:16:44 +0930
Message-ID: <cover.1750674924.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 74E432116C
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid]
X-Spam-Score: -3.01
X-Spam-Level: 

[CHANGELOG]
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


This is the refreshed series based on the one submitted by Johannes,
which is further based on the original series from Christoph.

This series is to make btrfs use fs_holder_ops, which provides a lot of
extra features like proper full fs freeze/thaw when freezing/thawing a
block device.
This may improve the hibernation/suspension for btrfs.

This is done by:

- Get rid of the re-entry of btrfs_get_tree()
  Just a simple cleanup.
  Now it's a simple call chain:

   btrfs_get_tree() -> btrfs_get_tree_subvol() -> btrfs_get_tree_super()

- Make it more clear on the sget_fc() behavior
  And what should be cleaned up.

- Call btrfs_close_devices() from kill_sb() callback

- Call bdev_fput() instead of deferred fput()
  This ensures we won't get some block devices with invalid holder,
  while the fs is already closed.

- Delay btrfs_open_devices() until super block is created
  This is done by introducing btrfs_fs_devices::holding.
  And the existing test case generic/604 is a pretty good one to expose
  various racing with that new holding behavior.

  Now the call chain looks like this for a new superblock:

  btrfs_get_tree_super()
  |- mutex_lock(uuid_mutex)
  |- btrfs_scan_one_device()
  |- btrfs_fs_devices_inc_holding()
  |  Now after uuid_mutex is unlocked, the fs_devices won't be freed
  |  until the holding number is decreased to 0.
  |- mutex_unlock(uuid_mutex)
  |
  |- sget_fc()
  |- mutex_lock(uuid_mutex)
  |- btrfs_fs_devices_dec_holding()
  |- btrfS_open_devices()

- Use super block as blk_holder

- Use fs_holder_ops for all btrfs opened block devices


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
 fs/btrfs/super.c       | 122 +++++++++++++++++++++--------------------
 fs/btrfs/volumes.c     |  33 +++++------
 fs/btrfs/volumes.h     |  27 ++++++++-
 7 files changed, 111 insertions(+), 85 deletions(-)

-- 
2.49.0


