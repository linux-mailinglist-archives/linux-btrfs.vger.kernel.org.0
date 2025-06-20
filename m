Return-Path: <linux-btrfs+bounces-14806-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6985AE134B
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 07:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C1D3BE7A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 05:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12E0219307;
	Fri, 20 Jun 2025 05:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Lo1omqDy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Lo1omqDy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C7E212B38
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398474; cv=none; b=PajF7ALvTAZyJGLFQ5oxwGakRvYMb05QgB0JdTN6wYNa7ud2uri+wTJEDJGghmqu5jKp10RnZDJrG1+LzKylUiQGpvawcBdOQlVVMtse2MH3s3yYncdj5qayrS9y02Mv2Pcy5ojTaK/WpkrK6wfTf9YSaE7zOJm9kEuJvJEzUFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398474; c=relaxed/simple;
	bh=X7sBtIcHduV3A1WS6U2UkltVtNkYCEEPh/+oucyILYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lE34EfuNu7hePYTm5IMvtIqFaVkp1n6IA5uhrESGnGdMKxhLxUlF8FRCl6bkUoDY0mqfN7bASvllW2/zCrVoq8JISD/hMFo0vm1U0aRDyvQvQ1wY41Q5SRhM+RcLuRcAIWArXEVEUiHM/Qko+uZL+BfdhP1UTJ8J3gJFGYPChqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Lo1omqDy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Lo1omqDy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1184321216;
	Fri, 20 Jun 2025 05:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750398469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vRiZsbpA0/iy6PITz0EHOCPAgrRmm9kFzaFTtXJGkMM=;
	b=Lo1omqDyQt0HUHFxFEzQCBNMaXiya4qo8IZvKOVLShs8SQPS42G4Zv+0Dj/DH6+1O/WsMG
	2zLkN5W/6vGjqwZI5ICLmXA2LQPP8audvmTO7Uswxfcz7SqMo44kMLWAjkCxqM4h5VEt2e
	Zj/eDGrdQj8gvxjK9NSVGwR40Wj1s44=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750398469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vRiZsbpA0/iy6PITz0EHOCPAgrRmm9kFzaFTtXJGkMM=;
	b=Lo1omqDyQt0HUHFxFEzQCBNMaXiya4qo8IZvKOVLShs8SQPS42G4Zv+0Dj/DH6+1O/WsMG
	2zLkN5W/6vGjqwZI5ICLmXA2LQPP8audvmTO7Uswxfcz7SqMo44kMLWAjkCxqM4h5VEt2e
	Zj/eDGrdQj8gvxjK9NSVGwR40Wj1s44=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DBCC13318;
	Fri, 20 Jun 2025 05:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xIT7AwP2VGi2NAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 20 Jun 2025 05:47:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH RFC 0/6] btrfs: go fs_holder_ops and add shutdown_bdev() callback
Date: Fri, 20 Jun 2025 15:17:23 +0930
Message-ID: <cover.1750397889.git.wqu@suse.com>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

This series is relying on another series here:
https://lore.kernel.org/linux-btrfs/cover.1750137547.git.wqu@suse.com/

That above series prepare btrfs to use fs_holder_ops, and the first
patch in this series is exactly making btrfs use that fs_holder_ops.

Then patch 2~4 implements the shutdown ioctl for btrfs.

For now the shutdown ioctl has no proper sync yet.

Patch 5 is the one affecting the generic fs_holder_ops and
super_operations, that we need a shutdown_bdev() variant, which passes
the bdev to the fs and let the fs to determine if they can continue
operation or needs to shutdown.

AKA, the shutdown_bdev() variant is for multi-devices filesystems like
btrfs and bcachefs.

And finally implement the shutdown_bdev() for btrfs, so that eventually
generic/730 can properly pass.

Reason for RFC:

There are still test failures for shutdown group, mostly due to the fact
that btrfs is not implementing the proper flags handling (e.g. currently
the shutdown never sync the fs no matter what).

But I want to get some feedback about the new
super_operations::shutdown_bdev() call back before committing too much.

Qu Wenruo (6):
  btrfs: introduce a new fs state, EMERGENCY_SHUTDOWN
  btrfs: reject file operations if in shutdown state
  btrfs: reject delalloc ranges if the fs is shutdown
  btrfs: implement shutdown ioctl
  fs: introduce a shutdown_bdev super block operation
  btrfs: implement shutdown_bdev super operation callback

 fs/btrfs/file.c            | 25 ++++++++++++++++++++++++-
 fs/btrfs/fs.h              | 18 ++++++++++++++++++
 fs/btrfs/inode.c           | 14 +++++++++++++-
 fs/btrfs/ioctl.c           | 21 +++++++++++++++++++++
 fs/btrfs/messages.c        |  1 +
 fs/btrfs/reflink.c         |  3 +++
 fs/btrfs/super.c           | 34 ++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c         |  2 ++
 fs/btrfs/volumes.h         |  5 +++++
 fs/super.c                 |  4 +++-
 include/linux/fs.h         | 10 ++++++++++
 include/uapi/linux/btrfs.h |  9 +++++++++
 12 files changed, 143 insertions(+), 3 deletions(-)

-- 
2.49.0


