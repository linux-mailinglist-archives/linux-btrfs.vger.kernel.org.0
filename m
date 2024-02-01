Return-Path: <linux-btrfs+bounces-2028-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58553845F4C
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 19:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7E51F23415
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 18:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D0E12FB1D;
	Thu,  1 Feb 2024 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rIiUaJOo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EcKZf518"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CAA74274
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810570; cv=none; b=hhfcIfPvPyF4sORb4XoxPJBkuwBpQuigOy6z5x8EgPinxfHUDqIdmOcq/eaaEIhU1MTmhRpdHdKKdmc7nKvF5+uqnUrVIX+hLTukPAoRdiuVSGol2f/dO4zcweOqaQvF3lP1fHvnTdmNjW7beo7J6YAVmzgGaESe7wYQGKjDMUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810570; c=relaxed/simple;
	bh=152Wb8ajyjfytKTCX4r71xCZht+jK+pF9LsE4BPu7kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAyPQ3Aevuzq53aC68z3p6nekqe8Jhx5gUPE2yiYnGyk2UpOOrikdWlvz3aNHEwZa3I3WL9w2iKnizet9BT9b5fnee/HEFBItGv/vNrGZEdSaHhwhumsPHmOzdxWUR4WMF90cuIrT/hfk53kTz5NyLiHuEwOHqFFtiipKf9OtWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rIiUaJOo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EcKZf518; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DBC151FC04;
	Thu,  1 Feb 2024 18:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706810567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LCrv2zPgEkHX0T/C29jIM1QVRpru506Qp2J3zL2hDcg=;
	b=rIiUaJOo1wbwDGETduqmFZ21vUPm/G1JR2fEeP2Fm9rPN4gUElthz8v3HvjxNS8OhDb0aY
	i3b/Rzi2XH32MI/TG8l/n/UuO143ayxYR3khvULKPJnsZ9VtkZy5sjqMKR+Ua4+XhEzvd1
	XAbr9hUAtKDRh4PPCsHBPkaxBrqm9so=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706810566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LCrv2zPgEkHX0T/C29jIM1QVRpru506Qp2J3zL2hDcg=;
	b=EcKZf5189Ii53A6mBoLmpRjy+9FKcfU98zFgNAR5CKhzwL7UzHViUJCYU1LjAetScSB+2H
	9RReiowt/oNvsR430YJCuv4D+w05qHpTAei1KPSWGKshaPo/I/cGURnldeY4iwULUy5FhD
	w/P+BV8kiPYvyWCFWtx255BCHTBn2s8=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D030913594;
	Thu,  1 Feb 2024 18:02:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id lZl/Msbcu2WaTwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Thu, 01 Feb 2024 18:02:46 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/5 v2] Struct to fs_info helpers
Date: Thu,  1 Feb 2024 19:02:20 +0100
Message-ID: <cover.1706810422.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=EcKZf518
X-Spamd-Result: default: False [1.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 URIBL_BLOCKED(0.00)[suse.com:dkim];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[20.13%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.19
X-Rspamd-Queue-Id: DBC151FC04
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

v2:

- move helper definitions to fs.h
- add _Generic to the macros for type checking
- reuse helpers to some code duplication

Add convenience helpers for getting a fs_info from page, bio, inode etc.
There's one prep patch where tests use a normal helper that expects
valid inode->root->fs_info.

David Sterba (5):
  btrfs: tests: allocate dummy fs_info and root in test_find_delalloc()
  btrfs: add helpers to get inode from page/folio pointers
  btrfs: add helpers to get fs_info from page/folio pointers
  btrfs: add helper to get fs_info from struct inode pointer
  btrfs: hoist fs_info out of loops in end_bbio_data_write and
    end_bbio_data_read

 fs/btrfs/compression.c           |  8 +++---
 fs/btrfs/defrag.c                |  4 +--
 fs/btrfs/disk-io.c               | 11 ++++----
 fs/btrfs/export.c                |  2 +-
 fs/btrfs/extent_io.c             | 45 ++++++++++++++++----------------
 fs/btrfs/file.c                  | 14 +++++-----
 fs/btrfs/free-space-cache.c      |  2 +-
 fs/btrfs/fs.h                    | 11 ++++++++
 fs/btrfs/inode.c                 | 42 ++++++++++++++---------------
 fs/btrfs/ioctl.c                 | 40 ++++++++++++++--------------
 fs/btrfs/lzo.c                   |  4 +--
 fs/btrfs/props.c                 |  2 +-
 fs/btrfs/reflink.c               |  6 ++---
 fs/btrfs/relocation.c            |  2 +-
 fs/btrfs/tests/extent-io-tests.c | 28 +++++++++++++++++---
 15 files changed, 126 insertions(+), 95 deletions(-)

-- 
2.42.1


