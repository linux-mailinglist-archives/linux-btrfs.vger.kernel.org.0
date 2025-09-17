Return-Path: <linux-btrfs+bounces-16897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972F5B822E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 00:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FA217A31A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 22:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D633019C8;
	Wed, 17 Sep 2025 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="axnwzoa7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="axnwzoa7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461111A9FBE
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149200; cv=none; b=VfR5YtBqks552FHV8vyK5PPmItRunhWCNrIpiTHcXNzBJZ6ZYugctm46QO2plS5wl0VmsC9deco9h1LrIAHPeEou7Iug/VS7mWJOxJrXFzP1LXLjDffxxF7wuY8UYkKITtVq+CiloNk89Y6LziOG3MXycRqFrHo5nGpjIdNTups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149200; c=relaxed/simple;
	bh=nh5qDOUuOSl4hXlOfsxzPvafcBrVnNpKge0l5cIlMf4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=B6qX8lvMjThupNUUAOHpjwE+p+H7F5OtEMDEgHnSCXaFyrDS625/NYHBVLe+mQa4qU1RQp5eExHcyUHF7f5duH4OZRLD6JTa+DlVrpxKezLYAwDVPZ8IZuARWhANXOF2WlApx3EC95d04CpQ4+LxVPhIYEEFlHxEIRSsZveMuNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=axnwzoa7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=axnwzoa7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46E323403E
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 22:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758149196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i1R4ypiyDzqKHYlCgNTZl7j0qflZOSfcvG9soTis5kE=;
	b=axnwzoa7gZrjNnuDetCrV/3SvoV8GD+47N30rDYIYosAxtgsi/Grd7z5eCWycr8NH71D3V
	TfnS43Py/T8jWlHMQQ9u9dN+UJqWYiXvc9YfQxgy/sqvo6hpjBcYoLDp9HRLJywa/kCdqo
	tMtNPYKPH+luB800QMaL7co1K/YyA0Q=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758149196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i1R4ypiyDzqKHYlCgNTZl7j0qflZOSfcvG9soTis5kE=;
	b=axnwzoa7gZrjNnuDetCrV/3SvoV8GD+47N30rDYIYosAxtgsi/Grd7z5eCWycr8NH71D3V
	TfnS43Py/T8jWlHMQQ9u9dN+UJqWYiXvc9YfQxgy/sqvo6hpjBcYoLDp9HRLJywa/kCdqo
	tMtNPYKPH+luB800QMaL7co1K/YyA0Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89F9A1368D
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 22:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4XOTE0s6y2j/HQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 22:46:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/9] btrfs: initial bs > ps support
Date: Thu, 18 Sep 2025 08:16:05 +0930
Message-ID: <cover.1758147788.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

This series enables the initial bs > ps support, with several
limitations:

- No direct IO support
  All direct IOs fall back to buffered ones.

- No RAID56 support
  Any fs with RAID56 feature will be rejected at mount time.

- No encoded read/write/send
  Encoded send will fallback to the regular send (reading from page
  cache).
  Encoded read/write utilized by send/receive will fallback to regular
  ones.

Above limits are introduced by the fact that, we require large folios to
cover at least one fs block, so that no block can cross large folio
boundaries.

This simplifies our checksum and RAID56 handling.

The problem is, user space programs can only ensure their memory is
properly aligned in virtual addresses, but have no control on the
physical addresses. Thus they can got a contiguous memory but is backed
by incontiguous pages.

In that case, it will break the "no block can cross large folio
boundaries" assumption, and will need a very complex mechanism to handle
checksum, especially for RAID56.

The same applies to encoded send, which uses vmallocated memory.

In the long run, we will need to support all those complex mechanism
anyway.

- Still some instablity
  Sometimes I can hit the ASSERT()s inside submit_one_sector() where
  we should not get an hole em.

  Still debugging, so far it only occurs on multi-thread fsstress runs.
  Trying to get a smaller reproducer for this bug, but not an easy thing
  so far.

  Maybe memory pressure is involved in this case, as the same seed +
  parameters can not reliably reproduce the ASSERT() reliably.

Qu Wenruo (8):
  btrfs: prepare compression folio alloc/free for bs > ps cases
  btrfs: prepare zstd to support bs > ps cases
  btrfs: prepare lzo to support bs > ps cases
  btrfs: prepare zlib to support bs > ps cases
  btrfs: prepare scrub to support bs > ps cases
  btrfs: fix symbolic link reading when bs > ps
  btrfs: add extra ASSERT()s to catch unaligned bios
  btrfs: enable experimental bs > ps support

 fs/btrfs/bio.c         | 27 +++++++++++++++++++
 fs/btrfs/compression.c | 42 ++++++++++++++++++++---------
 fs/btrfs/compression.h |  2 +-
 fs/btrfs/direct-io.c   | 12 +++++++++
 fs/btrfs/disk-io.c     | 14 ++++++++--
 fs/btrfs/extent_io.c   |  7 +++--
 fs/btrfs/extent_io.h   |  3 ++-
 fs/btrfs/fs.c          | 20 ++++++++++++--
 fs/btrfs/fs.h          |  6 +++++
 fs/btrfs/inode.c       | 18 +++++++------
 fs/btrfs/ioctl.c       | 35 +++++++++++++++++-------
 fs/btrfs/lzo.c         | 59 ++++++++++++++++++++++-------------------
 fs/btrfs/raid56.c      | 43 +++++++++++++++++++++---------
 fs/btrfs/raid56.h      |  4 +--
 fs/btrfs/scrub.c       | 51 +++++++++++++++++++----------------
 fs/btrfs/send.c        |  9 ++++++-
 fs/btrfs/zlib.c        | 60 +++++++++++++++++++++++++++---------------
 fs/btrfs/zstd.c        | 44 +++++++++++++++++--------------
 18 files changed, 313 insertions(+), 143 deletions(-)

-- 
2.50.1


