Return-Path: <linux-btrfs+bounces-17600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51B2BCBAEC
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 07:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBA63B1BFA
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 05:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2C26E17A;
	Fri, 10 Oct 2025 05:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gEKUooyz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gEKUooyz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F71846F
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 05:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760072418; cv=none; b=FhwcrKAxAdOq3agTFZTIKZiY45SdQpprxfsdyrjCpPpsDo7kKHuv2iIvy69inKW5cuNuE8fNgDTLA9uE44JiUoYlJygbMofYF0qscVQ/F9HgILQJDTzfGKJbqpKxjX1XSXb11OMlZQAHaZ3xOsSNn5REUAY22VYLUpXinYkO1e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760072418; c=relaxed/simple;
	bh=BF/Aow66bzMiCq57lsNvoev5hIvpldcYiMiADJt6jCI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QAMiIIsp0+BL+RUVkcMHolb1anUg2nyDVkNoTOWPpuu44uujpHw5u9xl72dwVThf9ZCoFmola4CmFjfP++F5J7x3SS29cIPclIv0rfGJFtMTb2jbykiLdDCVCLVFQwoup/Eeq7WJTyn33yiUpuPOf7uoZHgwMWXevu16svzcMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gEKUooyz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gEKUooyz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0892D1F385
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 05:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760072414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4TFLqxNVBmS8IE9CLSks+nVaq1MiB8CN1EKLfBoO5ug=;
	b=gEKUooyzLEv2c8utzIiKCCgdcudwMjG2tKrCAyzOXy0Ks37mXs0Nw1pKo/P9h9WD0H93pJ
	8izuwIoDOFg7+646E1+Uh53FwajD4o2mOqkP6Aj47A5x8fGT5Hyy+Rh4IEhCiFzWfbuWhy
	I3V/tb0H5xAeuaOOXxn8N1oA6lWlkbI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gEKUooyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760072414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4TFLqxNVBmS8IE9CLSks+nVaq1MiB8CN1EKLfBoO5ug=;
	b=gEKUooyzLEv2c8utzIiKCCgdcudwMjG2tKrCAyzOXy0Ks37mXs0Nw1pKo/P9h9WD0H93pJ
	8izuwIoDOFg7+646E1+Uh53FwajD4o2mOqkP6Aj47A5x8fGT5Hyy+Rh4IEhCiFzWfbuWhy
	I3V/tb0H5xAeuaOOXxn8N1oA6lWlkbI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4614F13A40
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 05:00:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id coetAt2S6GgCcQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 05:00:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v6 0/5] btrfs: add remove_bdev() callback
Date: Fri, 10 Oct 2025 15:29:42 +1030
Message-ID: <cover.1760069261.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0892D1F385
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

[CHANGELOG]
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


Qu Wenruo (5):
  btrfs: introduce a new fs state, EMERGENCY_SHUTDOWN
  btrfs: reject file operations if in shutdown state
  btrfs: reject delalloc ranges if in shutdown state
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


