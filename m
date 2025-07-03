Return-Path: <linux-btrfs+bounces-15235-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A447AF8460
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jul 2025 01:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A68154412F
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 23:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BF42DCC01;
	Thu,  3 Jul 2025 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="haSb0ezo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="haSb0ezo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3FC2D94A4
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751586163; cv=none; b=uqQe6tueLLU9pqqEw/MdHOLYc6E+VdkZZXxToLXJBEkDK/bFGzC56XgsLSw6zAKU9SocUGwPRWXeU8HYFwjjW1sBr3XlsWwNA7VOwf4P9XcRJegUVfVf/8cXdcCZhIWK6NqdQxi74L/q6n5VrJchbEyovLDks0du4eHu392S19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751586163; c=relaxed/simple;
	bh=RFWM45xJVYd7rFegDhhTqYCu82bypijDNv1FO1mDDJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iy323r5byT5sGLritdCAF4l9MAhczUBUGeKgkFWlciPkBXx3IjC6Hb3M9qGQSVbZp8QKWtQiHT8YTuGB+rwX/x7yZ3NrEVyFD9ohROjTC0hOQ/FEG6kZoAtzwovIjS4zeSvGNzCvLuLdZySlo2h6MHtT6k54XY9qV6PgVYuQhyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=haSb0ezo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=haSb0ezo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D61221193;
	Thu,  3 Jul 2025 23:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751586159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lkrFmyjy0GdjNu/kpR0u1n5zBBN37FJ9C5+1L3g94UQ=;
	b=haSb0ezoP/Af+dUnX+1q1K0ySj8lRlXjDuizJjrviRMzYlb6SO7UuPgsuvJOvFJXBOrSws
	zy9APMW/zuBjK0zque8qbkBtfiGtdR3Og6VMblDsWJfPiw43607jc3zUIYaZloGOiPb5/y
	lEl0RDfOKglknMLxUL214aEGB1pZDck=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751586159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lkrFmyjy0GdjNu/kpR0u1n5zBBN37FJ9C5+1L3g94UQ=;
	b=haSb0ezoP/Af+dUnX+1q1K0ySj8lRlXjDuizJjrviRMzYlb6SO7UuPgsuvJOvFJXBOrSws
	zy9APMW/zuBjK0zque8qbkBtfiGtdR3Og6VMblDsWJfPiw43607jc3zUIYaZloGOiPb5/y
	lEl0RDfOKglknMLxUL214aEGB1pZDck=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B6E113721;
	Thu,  3 Jul 2025 23:42:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oC8kE20VZ2j7AQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 03 Jul 2025 23:42:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v3 0/6] btrfs: add remove_bdev() callback
Date: Fri,  4 Jul 2025 09:12:13 +0930
Message-ID: <cover.1751577459.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

[CHANGELOG]
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

Qu Wenruo (6):
  fs: enhance and rename shutdown() callback to remove_bdev()
  btrfs: introduce a new fs state, EMERGENCY_SHUTDOWN
  btrfs: reject file operations if in shutdown state
  btrfs: reject delalloc ranges if in shutdown state
  btrfs: implement shutdown ioctl
  btrfs: implement remove_bdev super operation callback

 fs/btrfs/file.c            | 25 ++++++++++++++++-
 fs/btrfs/fs.h              | 28 +++++++++++++++++++
 fs/btrfs/inode.c           | 14 +++++++++-
 fs/btrfs/ioctl.c           | 43 ++++++++++++++++++++++++++++
 fs/btrfs/messages.c        |  1 +
 fs/btrfs/reflink.c         |  3 ++
 fs/btrfs/super.c           | 57 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c         |  2 ++
 fs/btrfs/volumes.h         |  5 ++++
 fs/exfat/super.c           |  4 +--
 fs/ext4/super.c            |  4 +--
 fs/f2fs/super.c            |  4 +--
 fs/ntfs3/super.c           |  6 ++--
 fs/super.c                 |  4 +--
 fs/xfs/xfs_super.c         |  7 +++--
 include/linux/fs.h         |  7 ++++-
 include/uapi/linux/btrfs.h |  9 ++++++
 17 files changed, 206 insertions(+), 17 deletions(-)

-- 
2.50.0


