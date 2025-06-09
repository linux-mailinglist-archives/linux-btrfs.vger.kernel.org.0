Return-Path: <linux-btrfs+bounces-14550-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCE1AD183E
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 07:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839D03A7E65
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 05:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5B6194C96;
	Mon,  9 Jun 2025 05:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Zj3ths8d";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Zj3ths8d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14BE2F4A
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 05:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749446413; cv=none; b=DaW/H9g4I1Jn3OLhvqxe4Y/2/CXWadhDUMGLe6VtT2fNlBtP8MPCMThTED7OItGk6EeT9+iweZL3BUf38VUDVRqIGiSz+/8QOredNl5MI8/Zbx0VSvKqcmIvUGnOHW7ULHFXqhiRgrviEFok4JQwe/5dckTdkKGJEXa+jhs+w2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749446413; c=relaxed/simple;
	bh=uuskJ05Q9mqEH6r+ksSOvdChC59qIc99ez2AHMgr76o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IW2yYwp3U3Np7DIICNxrrme6YjuiaQSvQEgEKG9+OILdIlDghEYMXDRRZyRr+68+dkaiYKwSEyzfdu+8CsXaBR2xpyZgqq+rVWYCMDmxBBKo6/H2FzmGrznGFxC9jYzpNdWxBoMOCiQD8zgU9SHLLF5d+kThZJFG3dyGdrteAYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Zj3ths8d; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Zj3ths8d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A426C1F395
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 05:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749446408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wNkE6ItF2CZYsoOJUUB88LfDw5HSnEg1lqjEFVaLIFU=;
	b=Zj3ths8dG3gkVUbe/fZdp6DXXUD8X9/SQBFCvbG5wkK42+Ijf9agLGC2FWWRAALyaCoOg9
	p8FQYUc44PX5pud9XkMJQzsD09RpLEwrHWs3AUA9shw2KIoBO5G6pii9qxunjBW9yijfe0
	xmXreF3Jlx3Xzv2Gl+L240zbnEzUGeI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Zj3ths8d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749446408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wNkE6ItF2CZYsoOJUUB88LfDw5HSnEg1lqjEFVaLIFU=;
	b=Zj3ths8dG3gkVUbe/fZdp6DXXUD8X9/SQBFCvbG5wkK42+Ijf9agLGC2FWWRAALyaCoOg9
	p8FQYUc44PX5pud9XkMJQzsD09RpLEwrHWs3AUA9shw2KIoBO5G6pii9qxunjBW9yijfe0
	xmXreF3Jlx3Xzv2Gl+L240zbnEzUGeI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3679137FE
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 05:20:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bAXqJAdvRmjqVQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 09 Jun 2025 05:20:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs: introduce btrfs specific bdev holder ops and implement mark_dead() call back
Date: Mon,  9 Jun 2025 14:49:46 +0930
Message-ID: <cover.1749446257.git.wqu@suse.com>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A426C1F395
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

[CHANGELOG]
v2:
- Extra patches to properly handle fs mounting/unmounting races

- Harden freeze/thaw races
  As they can be called on a per-fs and per-bdev basis, can cause extra
  races.

Btrfs doesn't implement any callbacks of blk_holder_ops, this means:

- No sync/freeze/thaw support for an opened btrfs device
  Not sure if this is the root cause of btrfs + hiberantion data loss,
  but it won't hurt if we have such support.

- No ability to detect dead device at runtime
  Meaning we can have "living" dead device in btrfs, the worst case is
  generic/730, that the single device of a btrfs is removed, and btrfs
  just abort transaction when it fails to write the transaction.

This series improve the situation by:

- Use a per-fs holder for block device
  This is a dependency to implement proper blk_holder_ops, as we need a
  way to grab the fs_info from a block device.

- Use bdev_fput() for btrfs devices
  This ensures the bdev holder reclaim will not be delayed, thus ensure
  the fs_info's lifespan is always covering any opened block devices.

  This is another dependency to implement blk_holder_ops, or we can grab
  an fs_info which is already released.

- Implement per-bdev sync/freeze/thaw callbacks
  This has a special requirement for freeze/thaw, as freeze/thaw can be
  triggered from two different paths, by ioctl (aka, per-fs) and by
  block device (aka, per-bdev).

  This means for the worst case, per-fs and per-dev freezing/thawing can
  race with each other, and this requires fs level serialization.

- Implement the mark_dead() call back
  This will automatically mark the dead devices as missing, and degrade
  the fs.

  Furthermore, if the remaining devices can no longer maintain RW
  operations, immediately mark the fs as error (thus also read-only) to
  prevent further data loss.


Qu Wenruo (4):
  btrfs: use fs_info as the block device holder
  btrfs: replace fput() with bdev_fput() for block devices
  btrfs: implement a basic per-block-device call backs
  btrfs: add a simple dead device detection mechanism

 fs/btrfs/dev-replace.c |   4 +-
 fs/btrfs/disk-io.c     |  11 +++
 fs/btrfs/fs.h          |  14 +++-
 fs/btrfs/ioctl.c       |   4 +-
 fs/btrfs/super.c       |  27 ++++++--
 fs/btrfs/super.h       |   2 +
 fs/btrfs/volumes.c     | 154 +++++++++++++++++++++++++++++++++++++----
 fs/btrfs/volumes.h     |   6 ++
 8 files changed, 197 insertions(+), 25 deletions(-)

-- 
2.49.0


