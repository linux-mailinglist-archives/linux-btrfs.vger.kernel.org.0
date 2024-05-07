Return-Path: <linux-btrfs+bounces-4791-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544D98BD9AF
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 05:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75212B239A8
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 03:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9E042AB4;
	Tue,  7 May 2024 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AgNt+QYn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ttf21Vmx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE82905
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 03:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715052200; cv=none; b=IUbP5dKGIJ8velzLyhqr1xllXTVz07MGEZEwjzsW7EJRkdqLy8xd9ICdN29Gb5jbsUbU9Ku39irRvPKML68tWhWyDu4geFvX9rhTE4lwsel2PLyd6oJYaoDTEKglIzJGEqf6e0DZU5OaFYRC6coE8WOQV97w7YMaKDKYYu6iXXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715052200; c=relaxed/simple;
	bh=/Ft+Qxbt5Cho/5tHZJeJ067exsjpbLpNqdU7BqmjRX8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tfxwINWougYa1ZW0n8E4LenD6v+cQEchJBYP7VY6+bn1TnzeplzeXwZLjoiizdxsCHoPQNNrxX9BCCCZdBYMuF0+cemKvwGJxyBBsyS8aBREV80KeLbWKbjzNIqQvF4+4cmhQe9ocpXKhHookaWq3goA8zs/TAwx8hxEyHQDJZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AgNt+QYn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ttf21Vmx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26E2F2029E
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 03:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715052196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pgpY7H2eS8Y2aaY+VNmkFPMJz7RHbA3/db1TPCn3bXI=;
	b=AgNt+QYnKCL+v3jcwQpBRHxndfYO6M4kop2sEfwR9aeB9J6IDmI797+KVMaPaB9DjOLT1k
	FwU1jvG7wAKqkWCCA6J3j7d8R3VUVgXZZbehd8aNWHiG71SoW5b1qvnWDhQdScq5f1GeKI
	ys8HJ9nRRM+MpqkvqkJ3au9rlVG5ELo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ttf21Vmx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715052195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pgpY7H2eS8Y2aaY+VNmkFPMJz7RHbA3/db1TPCn3bXI=;
	b=ttf21VmxAxNZ7Du7B970EXkWHVe3BNJrOS1V1hpw07nupR7ndX9EoxRcdf4wwQshViqqpN
	je05qEph+yxyiPi+ITpyOekx65Ae2U/raXmOwvbF9cS7zi5pmWQ4U/yz4Z+MGUnvwCjdTz
	HZ4qH/Rn7+4f8eN6Pc0dac5rRtT3rME=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 470F7139CB
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 03:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MP1vAKKeOWa9WgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 03:23:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: convert: proper ext4 unwritten extents handling
Date: Tue,  7 May 2024 12:52:52 +0930
Message-ID: <cover.1715051693.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 26E2F2029E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

[REPO]
https://github.com/adam900710/btrfs-progs/tree/unwritten_extent

There is a bug report that ext4 unwritten extents (extent with
EXT2_EXTENT_FLAGS_UNINIT, acts the same as BTRFS_FILE_EXTENT_PREALLOC)
would result a regular btrfs file extent.

Instead of filling the range with zero, converted btrfs would read
whatever from the disk, causing corruption.

Although there are some attempts trying to fix the problem, the resulted
patches are not meeting our standard, so I have to come up a fix by
myself.

The root cause is that, ext2fs_block_iterate2() won't report any extent
info, thus it's more or less only useful for ext2 filesystems.
For ext4 filesystems, inodes can have a feature called EXT4_EXTENTS_FL,
allowing a proper extent based iteratioin.

So this patch would keep the old ext2fs_block_iterate2() as fallback (as
for older ext2 fses, they do not support fallocate anyway), while for
newer ext4 fses, go with ect2fs_extent_*() APIs to iterate the file
extents.

The new APIs provides the extra extent.e_flags to indicate whether the
extent is unwritten or not.
For unwritten extents, we just puch it as a hole for now, since even if
we create a correct preallocated file extent, the space can not be
utlized as it's shared between the file extent and ext2 image.

So just punching a hole would be the simplest workaround for now.

Qu Wenruo (3):
  Revert "btrfs-progs: convert: add raid-stripe-tree to allowed
    features"
  btrfs-progs: convert: rework file extent iteration to handle unwritten
    extents
  btrfs-progs: tests/convert: add test case for ext4 unwritten extents

 common/fsfeatures.h                           |   3 +-
 convert/source-ext2.c                         | 116 ++++++++++++++++--
 tests/common.convert                          |  44 ++-----
 tests/convert-tests/001-ext2-basic/test.sh    |   2 +-
 tests/convert-tests/003-ext4-basic/test.sh    |   2 +-
 .../005-delete-all-rollback/test.sh           |   6 +-
 .../convert-tests/010-reiserfs-basic/test.sh  |   2 +-
 .../011-reiserfs-delete-all-rollback/test.sh  |   6 +-
 tests/convert-tests/024-ntfs-basic/test.sh    |   2 +-
 .../025-ext4-uninit-written/test.sh           |  53 ++++++++
 10 files changed, 177 insertions(+), 59 deletions(-)
 create mode 100755 tests/convert-tests/025-ext4-uninit-written/test.sh

--
2.45.0


