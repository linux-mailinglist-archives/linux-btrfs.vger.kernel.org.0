Return-Path: <linux-btrfs+bounces-17642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B101BD0DB0
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 01:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F9024E21D1
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Oct 2025 23:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BA1269D06;
	Sun, 12 Oct 2025 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r4RfZ7JP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r4RfZ7JP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B82322AE5D
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 23:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760313154; cv=none; b=I19y2JLp0/UFlePHda/mZmjvHD7P2riLSMXUr9jVZnE592m6OrYGtX2lq0RNTBp1iAu91x6WFmJNl2SadVRVLHIomrTb9jTNjwe+eyefzcA9QLrbYuGjB1Ll6pqz8eMXTgHBhZVaA4sM2P7qiptrRBNXg9r3nYfxQVIllgvTTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760313154; c=relaxed/simple;
	bh=o6ict1HgOhI/9JpabcXoxXw9lkOrAiC0tCfN+aALgho=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=twyhpuIK5zR+9k2EKxM5AXmj1wZIgkJkPkktLcLBtmEBu1w50PFQ6y27l3kH6XK+xdww/Wy3Oe+yxufYtL7JvjDxuuDd0OwHlxyvlkg7uhzHzlIP55BVoXApzaEd8vNRWqHX5+JCeynESWIV3kshjWJTR4sPQKG5JQRaHqmdXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r4RfZ7JP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r4RfZ7JP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 738C81F385
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 23:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760313144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oue6WSvPcHJfnzjiW3iDhBuqtDnYGfL3LtxcV6vs3vo=;
	b=r4RfZ7JPnH+GUPRd5uB5cDpLbE7YRyVRvQz2UMPj2ednchOgd25HSqWxYmshxDEw+AbjWW
	zOD+Nut+YbfAw6MblZckCy2l8UIyCNVxV4hIv+bKJMgR8Hpd1DNEL8t9yHDSJRuv5EZPst
	Nwt3dmlwTH0/vdOugUTrhlLYE353lWM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760313144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oue6WSvPcHJfnzjiW3iDhBuqtDnYGfL3LtxcV6vs3vo=;
	b=r4RfZ7JPnH+GUPRd5uB5cDpLbE7YRyVRvQz2UMPj2ednchOgd25HSqWxYmshxDEw+AbjWW
	zOD+Nut+YbfAw6MblZckCy2l8UIyCNVxV4hIv+bKJMgR8Hpd1DNEL8t9yHDSJRuv5EZPst
	Nwt3dmlwTH0/vdOugUTrhlLYE353lWM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0D6513782
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 23:52:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SGCuHDc/7Gj8SQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 23:52:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v7 0/3] btrfs: add shutdown() and remove_bdev() callback
Date: Mon, 13 Oct 2025 10:22:02 +1030
Message-ID: <cover.1760312845.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

[CHANGELOG]
v7:
- Change the message level of first time shutdown to critical
  Shutting down a fs has very huge impact, the old info level is
  definitely not good enough.

  And slightly update the commit message to mention that the delalloc
  error messages will definitely show up, and hopefully that critical
  message should help reduce the confusion.

- Fold the first 3 patches
  As each one is small, and all are just implementing the handling for
  shutdown states.
  
v6:
- Rebased to the latest for-next branch
  Only minor conflicts that can be solved by git.

  The VFS patch is already merged in v6.17, thus no more needed in the
  series.

v5:
- Split remove_bdev() from shutdown()
  Now remove_bdev() will have a return value to indicate if the fs can
  handle the removal of the device.
  And if not, a non-zero (normally minus) value is returned.

  In that case ->shutdown() will be called as usual.

  This allows us to avoid unnecessary operations that only make sense
  for shutdown case, like shrinking the cache.

  This also means no change to any of the existing filesystems.

- Implement ->shutdown() callback for btrfs
  Since ->shutdown() and ->remove_bdev() call backs are separate now,
  btrfs needs to implement both.

v4:
- Update the commit message of the first patch
  Remove the out-of-date comments about the old *_shutdown() names.

v3:
- Also rename the callback functions inside each fs to *_remove_bdev()
  To keep the consistency between the interface and implementation.

- Add extra handling if the to-be-removed device is already missing in
  btrfs
  I do not know if a device can be double-removed, but the handling
  inside btrfs is pretty simple, if the target device is already
  missing, nothing needs to be done and can exit immediately.

v2:
- Enhance and rename shutdown() callback
  Rename it to remove_bdev() and add a @bdev parameter.
  For the existing call backs in filesystems, keep their callback
  function names, now something like ".remove_bdev = ext4_shutdown,"
  will be a quick indicator of the behavior.

- Remove the @surprise parameter for the remove_bdev() parameter.
  The fs_bdev_mark_dead() is already trying to sync the fs if it's not
  a surprise removal.
  So there isn't much a filesystem can do with the @surprise parameter.

- Fix btrfs error handling when the devices are not opened
  There are several cases that the fs_devices is not opened, including:
  * sget_fc() failure
  * an existing super block is returned
  * a new super block is returned but btrfS_open_fs_devices() failed

  Handle the error properly so that fs_devices is not freed twice.

RFC->v1:
- Add a new remove_bdev() callback
  Thanks all the feedback from Christian, Christoph and Jan on this new
  name.

- Add a @surprise parameter to the remove_bdev() callback
  To keep it the same as the bdev_mark_dead().

- Hide the shutdown ioctl and remove_bdev callback behind experimental 
  With the shutdown ioctl, there are at least 2 test failures (g/388, g/508).

  G/388 is related to the error handling with COW fixup.
  G/508 looks like something related to log replay.

  And the remove_bdev() doesn't have any btrfs specific test case yet to
  check the auto-degraded behavior, nor the auto-degraded behavior is
  fully discussed.

  So hide both of them behind experimental features.

- Do not use btrfs_handle_fs_error() to avoid freeze/thaw behavior change
  btrfs_handle_fs_error() will flips the fs read-only, which will
  affect freeze/thaw behavior.
  And no other fs set the fs read-only when shutting down, so follow the
  other fs to have a more consistent behavior.


Qu Wenruo (3):
  btrfs: introduce a new shutdown state
  btrfs: implement shutdown ioctl
  btrfs: implement remove_bdev and shutdown super operation callbacks

 fs/btrfs/file.c            | 25 ++++++++++++++-
 fs/btrfs/fs.h              | 28 ++++++++++++++++
 fs/btrfs/inode.c           | 14 +++++++-
 fs/btrfs/ioctl.c           | 44 +++++++++++++++++++++++++
 fs/btrfs/messages.c        |  1 +
 fs/btrfs/reflink.c         |  3 ++
 fs/btrfs/super.c           | 66 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c         |  2 ++
 fs/btrfs/volumes.h         |  5 +++
 include/uapi/linux/btrfs.h |  9 ++++++
 10 files changed, 195 insertions(+), 2 deletions(-)

-- 
2.50.1


