Return-Path: <linux-btrfs+bounces-10874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CD5A07DEA
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 17:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F7A3A7D0D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3277622333F;
	Thu,  9 Jan 2025 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BaGCTVzk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BaGCTVzk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481BB22258F;
	Thu,  9 Jan 2025 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440983; cv=none; b=MnxJ5Vl5XeTFlqy+F5QlpVeZzm+pw+X9NE3cfhjSUGo5Ycq4Fzd2Q0mkuy1RzxggOYqznbI8C9L8qxz3BC1ugAgpmPo1hcfqJmz3jibD/MBGKbih/uUbOPJ67RnxQ6PJcZj7OiJZo5eM6Heq0HtMALjbRmbpNep2tN2bsuPhAsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440983; c=relaxed/simple;
	bh=y8OfDy1HGsYxABTRa61veYXT4WHga35aiIFeqBdGwEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sGUSoWtb70EJcdqoPvK6kE8F668Hb+O7mDuCCuOan0QlZprWtQHKHCJ/38dx8RvOol7CWJYoy6StxACM8Ux0WIu73qosSMr3J63ViuTGZhs/iSqQ1KAvhRPWXqB01me7dZW73SKiV7HUxFn2aTwX4nFUC2tssmK+uEZNmNg6FwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BaGCTVzk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BaGCTVzk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96D3E1F7C2;
	Thu,  9 Jan 2025 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736440979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lxTux7STGb5X7UmQdV/HdSw2NN6JiQxwTlIjyTbWpYc=;
	b=BaGCTVzkqANUxQ2sqf8z4B6x91r+TcXeIVtcVLVbRz1nIHrzGD9xM7EN/iUo9D5cf4lbqR
	K5Y+KaDRujIynAHPOUC5ZeyG/ggucxct1kX8VZ59s24BArhqRyUExx5fRjFOkyu5qevdfU
	OzB/RiO7ss9eeSiMKN/kZqhHe2SOjpo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736440979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lxTux7STGb5X7UmQdV/HdSw2NN6JiQxwTlIjyTbWpYc=;
	b=BaGCTVzkqANUxQ2sqf8z4B6x91r+TcXeIVtcVLVbRz1nIHrzGD9xM7EN/iUo9D5cf4lbqR
	K5Y+KaDRujIynAHPOUC5ZeyG/ggucxct1kX8VZ59s24BArhqRyUExx5fRjFOkyu5qevdfU
	OzB/RiO7ss9eeSiMKN/kZqhHe2SOjpo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F3E0139AB;
	Thu,  9 Jan 2025 16:42:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aWzxIpP8f2ciDAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 16:42:59 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	axboe@kernel.dk
Subject: [GIT PULL] Btrfs fixes for 6.13-rc7
Date: Thu,  9 Jan 2025 17:42:55 +0100
Message-ID: <cover.1736439697.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

please pull a few more fixes. Besides the one-liners in Btrfs there's
fix to the io_uring and encoded read integration (added in this
development cycle). The update to io_uring provides more space for the
ongoing command that is then used in Btrfs to handle some cases.

Please pull, thanks.

- io_uring and encoded read
  - provide stable storage for io_uring command data
  - make a copy of encoded read ioctl call, reuse that in case the call
    would block and will be called again

- properly initialize zlib context for hardware compression on s390

- fix max extent size calculation on filesystems with non-zoned devices

- fix crash in scrub on crafted image due to invalid extent tree

----------------------------------------------------------------
The following changes since commit fca432e73db2bec0fdbfbf6d98d3ebcd5388a977:

  btrfs: sysfs: fix direct super block member reads (2024-12-23 22:06:44 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-rc6-tag

for you to fetch changes up to 0ee4736c003daded513de0ff112d4a1e9c85bbab:

  btrfs: zlib: fix avail_in bytes for s390 zlib HW compression path (2025-01-06 16:32:43 +0100)

----------------------------------------------------------------
Christoph Hellwig (1):
      btrfs: zoned: calculate max_extent_size properly on non-zoned setup

Jens Axboe (2):
      io_uring/cmd: rename struct uring_cache to io_uring_cmd_data
      io_uring/cmd: add per-op data to struct io_uring_cmd_data

Mark Harmstone (2):
      io_uring: add io_uring_cmd_get_async_data helper
      btrfs: don't read from userspace twice in btrfs_uring_encoded_read()

Mikhail Zaslonko (1):
      btrfs: zlib: fix avail_in bytes for s390 zlib HW compression path

Qu Wenruo (1):
      btrfs: avoid NULL pointer dereference if no valid extent tree

 fs/btrfs/ioctl.c             | 128 +++++++++++++++++++++++--------------------
 fs/btrfs/scrub.c             |   4 ++
 fs/btrfs/zlib.c              |   4 +-
 fs/btrfs/zoned.c             |   5 +-
 include/linux/io_uring/cmd.h |  10 ++++
 io_uring/io_uring.c          |   2 +-
 io_uring/opdef.c             |   3 +-
 io_uring/uring_cmd.c         |  23 +++++---
 io_uring/uring_cmd.h         |   4 --
 9 files changed, 106 insertions(+), 77 deletions(-)

