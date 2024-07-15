Return-Path: <linux-btrfs+bounces-6453-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5144930D86
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 07:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D1128146F
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 05:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5DC13AA39;
	Mon, 15 Jul 2024 05:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I8cl8a3Z";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I8cl8a3Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE3C28FA
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721020953; cv=none; b=I6GDpdMISr9gH6AXdNd6wKIGORCu3sVNnOumvbImqehbB6I3Go3fTi4jtR0HH/po333cxRxLSFn5lPOnaBoOgmRCpXoSHgedzF75/yRumpGsuf7iau2AXVUO3ftsJYzeMg8hs1Pr1tPdqUbv5TM+x1oer2ApWX4X7knZdGpSwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721020953; c=relaxed/simple;
	bh=OwU0iwJiEM3kggQ92LFsUmmQhs0VWA8yA5UZ9GvT9To=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BjUqQgI9vvEqE2XJIPwRZEPOOauDyYzeNDafjkGx88ENEDX8LnU+ryYRZoXd+r+pHqTMmSXidVq04OOKAF6k5QXzsqQutcLZLxFUG2/ECrquxPIYVfdYloMHnnqTytJls38s4WUL5dA4rE9E6LRiFn2NpRE+XaK1E2Wej2pmn/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I8cl8a3Z; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I8cl8a3Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C05B219E2
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721020949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7VHILr9Di021v3cPfnfb5ZzyzRV0S/TyFVPayj9fPPg=;
	b=I8cl8a3ZfVUYalDTs11do95Z+8pr7hHmm0MFSVxEKpkfrSWkOOmUuvGfCde/snJAi2hVkF
	KyQSFJq6hnbktP/+K/bbLDEmPs2Z4LfrJseqQzWKHLzkNegB75C5IYEv+2/NrRr2VeMRbZ
	a9xDB0/1FnB9f/BkjvojZZB5fN/Klio=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721020949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7VHILr9Di021v3cPfnfb5ZzyzRV0S/TyFVPayj9fPPg=;
	b=I8cl8a3ZfVUYalDTs11do95Z+8pr7hHmm0MFSVxEKpkfrSWkOOmUuvGfCde/snJAi2hVkF
	KyQSFJq6hnbktP/+K/bbLDEmPs2Z4LfrJseqQzWKHLzkNegB75C5IYEv+2/NrRr2VeMRbZ
	a9xDB0/1FnB9f/BkjvojZZB5fN/Klio=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B64CE134AB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1kruGxSylGZdRQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:22:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs-progs: small cleanups related to subvolume creation
Date: Mon, 15 Jul 2024 14:52:07 +0930
Message-ID: <cover.1721020730.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
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
X-Spam-Level: 

[CHANGELOG]
v2:
- A new patch to cleanup btrfs_mksubvol()
  We have a kernel function with the same name, but those two are doing
  completely different works.

  The progs version is more like linking a subvolume to a destination.

  The new patch removes btrfs_mksubvol(), and move the convert specific
  code to convert code basis.

Thanks to Mark's new effort to introduce subvolume creation ability, the
long existing duplicated subvolume creation problem is exposed again.

The first patch to do a small cleanup for btrfs_create_tree() so that
the parameter list matches the kernel one.

The second one is the main dish to fully merge the different functions
to create a subvolume.

We have btrfs_create_tree() to properly create an empty tree, and
btrfs_make_root_dir() to create the initial root dir.

So use them to create btrfs_make_subvolume():

- Calls btrfs_create_tree() to properly create an empty tree
  Unlike btrfs_copy_root() used in create_subvol(), which can be unsafe
  if the source subvolume is not empty.

- Calls btrfs_read_fs_root() to setup the cache and tracking
  Inside create_data_reloc_tree() we directly added the root to
  fs_root_tree, which is only safe for data reloc tree.

  As we didn't properly set the correct tracking flags.

- Calls btrfs_make_root_dir() to setup the root directory

And finally cleanup a confusing function, btrfs_mksubvol(), which is not
really creating a subvolume, but linking a subvolume to a parent inode.

Instead of the confusing name, create a new helper,
btrfs_link_subvolume() to do the linkage, and move the convert specific
retry behavior into convert code.

Qu Wenruo (3):
  btrfs-progs: remove fs_info parameter from btrfs_create_tree()
  btrfs-progs: introduce btrfs_make_subvolume()
  btrfs-progs: use btrfs_link_subvolume() to replace btrfs_mksubvol()

 Makefile                        |   1 +
 check/main.c                    |   9 +-
 common/root-tree-utils.c        | 215 ++++++++++++++++++++++++++++++++
 common/root-tree-utils.h        |  30 +++++
 convert/main.c                  | 107 +++++++++-------
 kernel-shared/ctree.h           |   8 +-
 kernel-shared/disk-io.c         |   4 +-
 kernel-shared/disk-io.h         |   1 -
 kernel-shared/free-space-tree.c |   2 +-
 kernel-shared/inode.c           | 140 +--------------------
 mkfs/common.c                   |  39 ------
 mkfs/common.h                   |   2 -
 mkfs/main.c                     |  78 +-----------
 13 files changed, 331 insertions(+), 305 deletions(-)
 create mode 100644 common/root-tree-utils.c
 create mode 100644 common/root-tree-utils.h

--
2.45.2


