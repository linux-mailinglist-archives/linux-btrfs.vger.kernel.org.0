Return-Path: <linux-btrfs+bounces-15798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0259B18AF1
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 08:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A4A1AA3F8D
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 06:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE731DEFE6;
	Sat,  2 Aug 2025 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cGLa4nnt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f8iwugr8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87562E36E8
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754117776; cv=none; b=LkfBoufbi83UTYcBSs3AbrRs5z9uVOXt/awmB+VsdtX3EX3b21/RnXfVx915nBl3uD6FzVw8mG/5VQ99i6AXL8+Z+db/t9fy6lVQmrgu6bV/M5wqCqf+AnMXb2uMKzU4BhEdWzgcjKQWxBUpHssG77uA470WhfejPEngm+2qoqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754117776; c=relaxed/simple;
	bh=QbglDD9w6iXqkztqgKkkKO7yVGzSsS9IADl2/wmzhDQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=C72ED0CTDTfKH/y4wFX3tJqb1HDOfdDxwsxCwPfkyhZatHzzribSR/8gVwxBdHizTOzYhtDuWCmoMM2iMDXuRwxHVSW52KzD6vEvZipMIztQCZxVQc84Ukofed17Uio32TiPEDAz9hcGo7Rvs/vjx68yWmz7O0CVfSCpIZ8FxZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cGLa4nnt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f8iwugr8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7EF131F390
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754117771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/rL2VRKKeWRU4Vj+S/khPwfwQ0zFEGdHhMMz9ANObxI=;
	b=cGLa4nntnm46vq2fI8aka9lUjs3wfoB2jy4mBJ6ZLKMgDR0weS/I2baFQ9S9322s16568e
	ixjaKiDoeN3hmT4i56YZUHobTM0qCmZysAV6dN+dpwLog5yOi7ZCc7Xd4sN6YpVEUHU9V9
	yjDPzIHd6DYC1nWASTYYmwnUqe0q2zA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=f8iwugr8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754117770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/rL2VRKKeWRU4Vj+S/khPwfwQ0zFEGdHhMMz9ANObxI=;
	b=f8iwugr8t5QK8SzZAULPO3gsk0rgRLiScxYrEr5KRKsd6KriRQWdgnbxBpFtmp9ujvHeuM
	YXP2FvB3JQHI3MVNxF1wqEIlGyRzQm9kvXEHtbZWdTxLRwCD61FixKnldKEZ5EWh48ZNhI
	iXXhTDu3E3hyqLGFCO9AZs3g3+7XrXU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0B69133D1
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VThlG4m2jWhhHAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 02 Aug 2025 06:56:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs-progs: device_get_partition_size*() enhancement and cleanup
Date: Sat,  2 Aug 2025 16:25:46 +0930
Message-ID: <cover.1754116463.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7EF131F390
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid]
X-Spam-Score: -3.01

Inspired by recent fixes from Zotan to device_get_partition_size_sysfs(),
it turns out the idea of falling back to use sysfs is not sound in the first
place.

The original issue is unprivileged user can cause `btrfs device usage`
to output incorrect values:

  WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
  /dev/mapper/test-scratch1, ID: 1
     Device size:            20.00MiB <<
     Device slack:           16.00EiB <<
     Unallocated:                 N/A

It turns out that, the "unprivileged" part means, the user doesn't have
read access to the raw device.

It's common that a lot of distros have the following mode for raw block
devices:

  brw-rw---- 1 root disk 254, 32 Aug  2 13:35 /dev/vdc

So unprivileged users can not do read access to block devices thus
failed to grab the block device size, and this is normally considered as
a safety method.

But if the end user is inside disk group, everything works fine:

  WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
  /dev/mapper/test-scratch1, ID: 1
     Device size:            10.00GiB
     Device slack:              0.00B
     Unallocated:                 N/A

And the original bug is that the sysfs interface only gives the device
size in block unit, and block size can be hard to fetch (partition and
dm have different path to grab the block size).


This makes me wonder, why we need the sysfs interface in the first
place.
If the unprivileged user has no access to a block device, we should
not workaround it, but give a proper error/warning message.

So this series address the root problem, no proper error code for
device_get_partition_size*() helpers.
With proper error handling and messages, we shouldn't even need to use
sysfs to workaround the problem.

With the sysfs fallback removed, a completely unprivileged user will get
the following result:

  WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
  WARNING: failed to get device size for devid 1: Permission denied
  /dev/mapper/test-scratch1, ID: 1
     Device size:               0.00B
     Device slack:              0.00B
     Unallocated:                 N/A

Which should give enough for the end user without weird output at all.

Qu Wenruo (5):
  btrfs-progs: remove the unnecessary device_get_partition_size() call
  btrfs-progs: add error handling for device_get_partition_size()
  btrfs-progs: add error handling for
    device_get_partition_size_fd_stat()
  btrfs-progs: remove device_get_partition_size_fd()
  btrfs-progs: remove device_get_partition_size_sysfs()

 check/main.c            |  8 +++-
 check/mode-lowmem.c     |  8 +++-
 cmds/filesystem-usage.c | 11 ++++--
 cmds/replace.c          | 14 ++++++-
 common/device-utils.c   | 87 ++++++++++-------------------------------
 common/device-utils.h   |  5 +--
 image/common.c          |  7 +++-
 kernel-shared/volumes.c |  9 ++++-
 kernel-shared/zoned.c   | 18 ++++++---
 mkfs/common.c           | 16 ++++++--
 mkfs/main.c             | 12 ++++--
 11 files changed, 103 insertions(+), 92 deletions(-)

--
2.50.1


