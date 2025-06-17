Return-Path: <linux-btrfs+bounces-14699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3FDADC17B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 07:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBBB175ED1
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 05:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06EE23B604;
	Tue, 17 Jun 2025 05:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y3vGCDm3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WxpGo01O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43CC2D1
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750137607; cv=none; b=d5PYPrxaU00+VW4rTmc4gXC///nXsbt5CmGOm9ud1dg9rO3bMwnZivRODI0f+uneATBIj2heGx/ajK4OWHEN9+EDaXa7bBDdjwiA+b0AtNi9EP8v3iTKGgBr7GGALpDXVeX4qAGeRhXzmRBmRoNeZEmg24IJNRatnoahSMKBX4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750137607; c=relaxed/simple;
	bh=ncTa06DrCkyF2G+ir87aBgoMJs6jTmC0JMpaMY3Pu6o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FfRC1el2sKcD88+U3IJSUDdaPTA2UXK8c3T3/xtMHOshD0LjMhtsj0KZ1NF8U9GBuC2YWw+/dx2/hbB/8xl5ZXlvJAdhzzg5xwycDY3IoE0MD1e2TJP9t6017NyFq9cb6r3GDNomkgq5UNjQo2/jc4rB/FXAos7QARKj9uHvLGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Y3vGCDm3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WxpGo01O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78E6B2115A
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750137603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oX5ZrmaD24eSFJdJrKHmOu49E+eXu9QGgscXsleBSwY=;
	b=Y3vGCDm3cXptbsfEWcCu5eUOsxtkEXK+/l2IeQM7VLlihTi0HYB0pOgL3mS3t6fe7d+I99
	BfI4YUj43WHYdu/g8bIgPzhAZ5vCHyeAHRtVANAOrZVpFMppSWEx8W0eks6fInqlHsoFCR
	xQ5v+WF0eBqlHaQN8vDag4KLh7ZrFQs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750137602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oX5ZrmaD24eSFJdJrKHmOu49E+eXu9QGgscXsleBSwY=;
	b=WxpGo01Om0A0c6P+7CdGAw0MqVSWTjUXH7GIZmeSPYtWVOGOtQYhMA9aBperN+m7AVwhP6
	YviLTyqxEWzoHB/TXiTZNz8MtOhl9d7uGYkl24jIiBWFZAtaWatdZT9epnVQf5BcY2q7hE
	Zvld2C9Fsapa/5+L4jrmlHamukDJSAE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4510139E2
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8eJ3HQH7UGgePwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/6] btrfs: use the super_block as bdev holder
Date: Tue, 17 Jun 2025 14:49:33 +0930
Message-ID: <cover.1750137547.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

[CHANGELOG]
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

This series is to make btrfs use its super block as blk_holder, this
allows future usage of fs_holder_ops to support block device operations.

This is done by:

- Get rid of the re-entry of btrfs_get_tree()
  Now it's a simple call chain:

   btrfs_get_tree() -> btrfs_get_tree_subvol() -> btrfs_get_tree_super()

- Make it more clear on the sget_fc() behavior
  And what should be cleaned up.

- Call btrfs_close_devices() from kill_sb() callback

- Call bdev_fput() instead of deferred fput()
  This ensures we won't get some block devices with invalid holder,
  while the fs is already closed.

- Delay btrfs_open_devices(0 until super block is created
  This is done in a simpler way, just expand the uuid_mutex critical
  section to cover sget_fc().

- Use super block as blk_holder


Christoph Hellwig (2):
  btrfs: call btrfs_close_devices from ->kill_sb
  btrfs: use the super_block as holder when mounting file systems

Qu Wenruo (4):
  btrfs: get rid of the re-entry of btrfs_get_tree()
  btrfs: add comments to make super block creation more clear
  btrfs: call bdev_fput() to reclaim the blk_holder immediately
  btrfs: delay btrfs_open_devices() until super block is created

 fs/btrfs/dev-replace.c |  4 +-
 fs/btrfs/disk-io.c     |  4 +-
 fs/btrfs/fs.h          |  2 -
 fs/btrfs/ioctl.c       |  4 +-
 fs/btrfs/super.c       | 96 ++++++++++++++++++------------------------
 fs/btrfs/volumes.c     | 22 +++++-----
 6 files changed, 59 insertions(+), 73 deletions(-)

-- 
2.49.0


