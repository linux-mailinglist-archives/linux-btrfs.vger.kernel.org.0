Return-Path: <linux-btrfs+bounces-1428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F12982CA8D
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 09:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B612D1C21F9C
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 08:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C27E1110;
	Sat, 13 Jan 2024 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MPlHjG2f";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MPlHjG2f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E9236F
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A4CB81F789
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705135553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mY/jOssthkfafiXj+L31nFge28AuenjWHmayCGzxl9k=;
	b=MPlHjG2fYGOXuStlMpLgl2LH914pDtANV6Bw2l2ABQfri4wuvu0fOz1pzkkebukAQZ/t+m
	3o985uZdIgIYKm6iy41bZgri9Yl6chlYvWjsHCuW3N6ZFypZyW1gYBZv1wNDIq8wyhCcjt
	QK5sD3jdz6cCuGVv+UwvE0z4NaQAVbU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705135553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mY/jOssthkfafiXj+L31nFge28AuenjWHmayCGzxl9k=;
	b=MPlHjG2fYGOXuStlMpLgl2LH914pDtANV6Bw2l2ABQfri4wuvu0fOz1pzkkebukAQZ/t+m
	3o985uZdIgIYKm6iy41bZgri9Yl6chlYvWjsHCuW3N6ZFypZyW1gYBZv1wNDIq8wyhCcjt
	QK5sD3jdz6cCuGVv+UwvE0z4NaQAVbU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4BAC13676
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:45:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 62ykKcBNomVLeQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:45:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: allow tree-checker to be triggered more frequently for btrfs-convert
Date: Sat, 13 Jan 2024 19:15:28 +1030
Message-ID: <cover.1705135055.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MPlHjG2f
X-Spamd-Result: default: False [2.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[21.66%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.69
X-Rspamd-Queue-Id: A4CB81F789
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

We have issue #731, which is a large ext4 fs, and triggered tree-checker
very reliably.

The root cause is the bad write behavior of btrfs-convert, which always
insert inode refs/file extents/xattrs first, then the inode item.

Such bad behavior would normally trigger tree-checker, but for our
regular convert tests, it doesn't get trigger because:

- We have metadata cache
  The default size is system memory / 4, which can be very very large.
  And written tree blocks would still be cached thus no tree-checker
  triggered for those cached tree blocks.

- We won't commit transaction for every copied inodes
  This means for a lot of cases, we may just commit a large transaction
  for all inodes, further reduce the chance to trigger tree checker.

This patchset would introduce two debug environment variables:

- BTRFS_PROGS_DEBUG_METADATA_CACHE_SIZE
  Global metadata cache size, affecting all btrfs-progs tools that opens
  an unmounted btrfs.

- BTRFS_PROGS_DEBUG_BLOCKS_USED_THRESHOLD
  This only affects ext2 conversion, which determine how many bytes of
  dirty tree blocks we need before commit a transaction.

Those two variables would affect the speed of btrfs-convert greatly, and
we mostly use them for the selftests, thus they won't be documented
anyway but the source code.

With those new debug environment variables, we can reduce those values
to minimal, so that the existing convert tests are enough to trigger the
bug of issue #731.

Although the cost is, we make btrfs-convert test case 001 and 003 much
slower than usual (due to much frequent commit transaction commitment
and more IO to read tree blocks).

But I'd say, it's still worthy, as long as it can detect bad
btrfs-convert behaviors.

Qu Wenruo (3):
  btrfs-progs: convert/ext2: new debug environment variable to finetune
    transaction size
  btrfs-progs: new debug environment variable to finetune metadata cache
    size
  btrfs-progs: convert-tests: trigger tree-checker more frequently

 common/utils.c                             | 62 ++++++++++++++++++++++
 common/utils.h                             |  1 +
 convert/source-ext2.c                      |  9 +++-
 kernel-shared/extent_io.c                  |  5 +-
 tests/convert-tests/001-ext2-basic/test.sh |  7 +++
 tests/convert-tests/003-ext4-basic/test.sh |  7 +++
 6 files changed, 89 insertions(+), 2 deletions(-)

--
2.43.0


