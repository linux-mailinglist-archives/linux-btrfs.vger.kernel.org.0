Return-Path: <linux-btrfs+bounces-18277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEB7C05AA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 12:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B3019A86E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19259311952;
	Fri, 24 Oct 2025 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pjvP0lVF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qBElR3rx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729B30E0CD
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303010; cv=none; b=eVd2aom1p+9PGU0We+aPPJDlVmY+YInjRA7z/Lb3Hwh4XeYLVF3FJZuxkvWrhvJVcnXG09Tj7myd86fpP+wCkFP2MJgYTVFHJEHmWsEX4xp+v/H3IlMw9ZqturVctzLfY3fpC29hw/RKSRDK4F4L+mKSPZQXnBHuwBbfNDCx9Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303010; c=relaxed/simple;
	bh=9odnC4FOHeQCap8cZdgJBX+Rq46wJkc35+opunU23hs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=I5m4CaZACarSafOD5fb224HiWXoLWQpkE3ytY+/VEGPhTDv7fqyKXcY1pUOYuvV5K76oNOLoSFDw9jpTlYl6WRg9M+cPyTOGI3KJksuqSImFRKvulqUK+72XcyplcX3dx0HuoPpNi94B8Ahpiv0mBv/ekR0IG4s0qmKrolM9Dw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pjvP0lVF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qBElR3rx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 372B6211B1
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761303002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hp7HmrOdRBjZgzsZmxvhFor5byCD9Z+apo4xVE3hTN8=;
	b=pjvP0lVFkEo3gYyJ1XR3/Z2zYgHV81AEc14VkTyo5g35+1dgRc3KV0xg3mHD8h6bUylJpg
	8aN9yK3iaRTHWrR/bZAONk6ULntpR7Bfa399MfvKbYvSUWOClKGLqdNvYL/R6DXZwfQrei
	uBUz0PI2Vfk3a4XCft0qfS7Ma/RmGBc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761302998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hp7HmrOdRBjZgzsZmxvhFor5byCD9Z+apo4xVE3hTN8=;
	b=qBElR3rxrLFwfnj9CcCCfojZeA8pNweTc0vBgeRi/eA2WgC0PlfJPFbrpcgEW0CLlYx/Dm
	7R1hSbwaDFnW+6UBooqV5juYb18hQ6AMYHuZVQHkXGYO++Q3u8dADPvfsXexzYCcPHHCK/
	o24AZU86ia3FV+AJSDQKIq3TRUFN/hY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7155113693
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:49:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RVIJDdVZ+2iaZQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:49:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: introduce async_csum feature
Date: Fri, 24 Oct 2025 21:19:31 +1030
Message-ID: <cover.1761302592.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
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
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

The new async_csum feature will allow btrfs to calculate checksum for
data write bios and submit them in parallel.

This will reduce latency and improve write throughput when data checksum
is utilized.

This will slightly reclaim the performance drop after commit
968f19c5b1b7 ("btrfs: always fallback to buffered write if the inode
requires checksum").

The first patch makes sure btrfs_bio::end_io() is executed in task
context, as we will need to wait for csum calculation to finish before
end_io() function.

Then patch 2~3 are small cleanups related to the new task context of
end_io().

The last one enables async_csum for data writes with checksum, this will
slightly change the behavior of data checksum offload feature (offload
data checksum calculation to another thread, but still doing serial
calculation then submit behavior).

Since the new async_csum should be better than the csum offload anyway,
we may want to deprecate the csum offload feature completely in the
future.
Thankfully csum offload feature is still behind the experimental flag,
thus it should not affect end users.

Qu Wenruo (4):
  btrfs: make sure all btrfs_bio::end_io is called in task context
  btrfs: remove btrfs_fs_info::compressed_write_workers
  btrfs: relax btrfs_inode::ordered_tree_lock
  btrfs: introduce btrfs_bio::async_csum

 fs/btrfs/bio.c          | 79 +++++++++++++++++++++++++++++------------
 fs/btrfs/bio.h          |  5 +++
 fs/btrfs/compression.c  | 27 +++++---------
 fs/btrfs/compression.h  |  7 ++--
 fs/btrfs/disk-io.c      |  9 ++---
 fs/btrfs/extent_io.c    |  5 ++-
 fs/btrfs/file-item.c    | 61 +++++++++++++++++++++----------
 fs/btrfs/file-item.h    |  2 +-
 fs/btrfs/fs.h           |  1 -
 fs/btrfs/inode.c        |  4 +--
 fs/btrfs/ordered-data.c | 57 +++++++++++++----------------
 fs/btrfs/tree-log.c     |  4 +--
 12 files changed, 148 insertions(+), 113 deletions(-)

-- 
2.51.0


