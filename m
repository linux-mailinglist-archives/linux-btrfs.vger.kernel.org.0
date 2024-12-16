Return-Path: <linux-btrfs+bounces-10392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CE49F2955
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 05:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3F3188620E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 04:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52501B87DE;
	Mon, 16 Dec 2024 04:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cj+mEVOk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cj+mEVOk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868191119A
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734324694; cv=none; b=cbUsIs9t9Bwmxfxw+OOgr8eXyCDpRFuHmTpX/j7j3SWxCs8dzN65T289XBXl4iXuF3osSS0SIdEZ80qbI2kYqyKqO7plSyVyEA4IoBOUl82vRgP5zL97YvGQBpXNZWQ+ZGXZ0WWvpnqd2IvKZ43aOOmeoUtxOGcDJFkAtCvHG+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734324694; c=relaxed/simple;
	bh=YrvoiYjrwp/trmqNOXxkJnfWi199ulwlFY6VfWXflcE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YDEAKVrr3sP1zoQBXAuoI7tkkstJZX1EBFZL8bnG38u+ToYQG+QSCHFi72eFyBJRWZjSryX9XqPYhjbWWJ1p8XOIaGqYYDJgJwRW86fk8WjnF6z0cs6TVvwDwev67UHyYH1LoUOi73ALaVuP4Oe4BEO7msFTj9jSbvtpzU2Fc3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cj+mEVOk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cj+mEVOk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8310B211E9
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734324690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yj1z9yTAkM+uLqkRsWg0JGzI0bdf+RPVzGz8KFAI/ms=;
	b=cj+mEVOkveqnCaqjN7WF83DWHNl2tPX/h5yBeuV9fV/1Jigr9HbpvQgIxjpy63HfNqkrvN
	sE8bIySFgtnZ24TcXaIsoAcEvDWtz86+JzDhlVuKOpBH1NltSS9g/judYHB/3k1XlgF2pR
	uwPMqrbB7id/3YFt2dH9OB/e7cETwmA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cj+mEVOk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734324690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yj1z9yTAkM+uLqkRsWg0JGzI0bdf+RPVzGz8KFAI/ms=;
	b=cj+mEVOkveqnCaqjN7WF83DWHNl2tPX/h5yBeuV9fV/1Jigr9HbpvQgIxjpy63HfNqkrvN
	sE8bIySFgtnZ24TcXaIsoAcEvDWtz86+JzDhlVuKOpBH1NltSS9g/judYHB/3k1XlgF2pR
	uwPMqrbB7id/3YFt2dH9OB/e7cETwmA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A82E137CF
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KtYUFNGxX2ciNwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs-progs: rename "sector size" to "block size"
Date: Mon, 16 Dec 2024 15:21:03 +1030
Message-ID: <cover.1734324435.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8310B211E9
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Since day 1 of btrfs, we use the name "sector size" to indicate the
minimum data unit size (from btrfs_super_block::sectorsize).

But all other file systems use "block size" to indicate the minimum data
unit size, and inside kernel, a sector is used to describe the minimal
IO block size for a block device.
Furthermore kernel sector size is fixed to 512, and different block
devices have different sector sizes, from the older 512 sector sized
HDDs, to modern day flash devices that are even pushing for 16K sector
size.

This has brought quite some confusiong when we need to co-operate with
other fs/mm people.

I believe it's time to do the migration for btrfs-progs first, then do
it inside the kernel, before we're pushing for iomap support.

Qu Wenruo (4):
  btrfs-progs: convert btrfs_fs_info::sectorsize to blocksize
  btrfs-progs: mkfs: add "--blocksize" option as an alias for
    "--sectorsize"
  btrfs-progs: docs: change the terminology from "sectorsize" to
    "blocksize"
  btrfs-progs: rename btrfs_super_block::sectorsize to blocksize

 Documentation/Status.rst             |  8 +--
 Documentation/Subpage.rst            | 11 ++--
 Documentation/btrfs-convert.rst      |  4 +-
 Documentation/btrfs-man5.rst         |  4 +-
 Documentation/ch-balance-filters.rst |  4 +-
 Documentation/ch-mount-options.rst   |  6 +-
 Documentation/ch-sysfs.rst           |  2 +-
 Documentation/mkfs.btrfs.rst         | 20 ++++--
 btrfs-corrupt-block.c                | 24 +++----
 check/main.c                         | 44 ++++++-------
 check/mode-common.c                  | 18 ++---
 check/mode-lowmem.c                  | 24 +++----
 check/repair.c                       |  4 +-
 cmds/inspect-dump-tree.c             |  8 +--
 cmds/rescue-chunk-recover.c          | 24 +++----
 cmds/restore.c                       |  6 +-
 common/clear-cache.c                 |  2 +-
 common/fsfeatures.c                  | 52 +++++++--------
 common/fsfeatures.h                  |  4 +-
 convert/common.c                     | 16 ++---
 convert/main.c                       | 24 +++----
 convert/source-ext2.c                | 18 ++---
 convert/source-fs.c                  | 16 ++---
 convert/source-reiserfs.c            | 12 ++--
 image/image-restore.c                |  8 +--
 kernel-shared/accessors.h            |  4 +-
 kernel-shared/ctree.h                |  5 +-
 kernel-shared/disk-io.c              | 28 ++++----
 kernel-shared/disk-io.h              |  2 +-
 kernel-shared/extent-tree.c          | 10 +--
 kernel-shared/file-item.c            | 18 ++---
 kernel-shared/file-item.h            |  4 +-
 kernel-shared/file.c                 | 18 ++---
 kernel-shared/free-space-cache.c     | 40 ++++++------
 kernel-shared/free-space-cache.h     |  4 +-
 kernel-shared/free-space-tree.c      | 28 ++++----
 kernel-shared/print-tree.c           | 12 ++--
 kernel-shared/tree-checker.c         | 98 ++++++++++++++--------------
 kernel-shared/uapi/btrfs_tree.h      |  4 +-
 kernel-shared/volumes.c              | 20 +++---
 mkfs/common.c                        | 22 +++----
 mkfs/common.h                        |  2 +-
 mkfs/main.c                          | 43 ++++++------
 mkfs/rootdir.c                       | 78 +++++++++++-----------
 tune/change-csum.c                   | 26 ++++----
 45 files changed, 419 insertions(+), 410 deletions(-)

--
2.47.1


