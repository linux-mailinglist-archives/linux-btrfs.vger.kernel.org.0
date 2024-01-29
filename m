Return-Path: <linux-btrfs+bounces-1914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AB5841208
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 19:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE8DDB21596
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 18:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D77824B57;
	Mon, 29 Jan 2024 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NeuxPDmu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NeuxPDmu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CAA125CC
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553218; cv=none; b=b17KytDnO4i6L5RVq+4uufKu/QH104odkfSK2kPrZpEnBybCn9cVJ1xAfv0Z1FzkdlmAsszUROp/ehNq348MDmSydiOHoug1RCaP/wTG6Bh5jtCfF6J7o/rhRUYMgmh1TfSZt+Lu1BMXSrdfIzDdH5B5Lydk+JpO/6BbDT7L83s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553218; c=relaxed/simple;
	bh=v9w4KO+emNFoNjZe1zMTvpnVoc3FSfDJIh677MLHWVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tKBocK/giIWZnTq7SEh6PjVrXrNbg7mlVF4aiC/7zgai4n+n3Li/02HlBPnuNwcPDVuV5VJa7/VyrEcwSRkPhNzUdkUgPhG1eN3pkmSDXHRdhkW9ZgflNQPszlHEyuooVzZLVscnBylcGQA4MgE8ZUd1JveeJtaaB4HrG+UYb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NeuxPDmu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NeuxPDmu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7725E1F7F9;
	Mon, 29 Jan 2024 18:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706553212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QrQs00vKYpEaAXApKnrT3f/nSEcR7Pu83tfkJrf/3oI=;
	b=NeuxPDmuB7Xs8ic8PG5+Kc1pIiX0b5LPhPm1v3WHunbzdWnbjmTgGD86MLWbaEu62M6/ek
	bTnAyPZyDjNP7Vfnbx4E1jO/B6EAleKYPCX3IJcH1IVqTx5ejVN3uOcp7iJp2FwGTy4C4S
	NJ8vs4q6ZqHkrL5dI1eJybMgxJLUcSg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706553212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QrQs00vKYpEaAXApKnrT3f/nSEcR7Pu83tfkJrf/3oI=;
	b=NeuxPDmuB7Xs8ic8PG5+Kc1pIiX0b5LPhPm1v3WHunbzdWnbjmTgGD86MLWbaEu62M6/ek
	bTnAyPZyDjNP7Vfnbx4E1jO/B6EAleKYPCX3IJcH1IVqTx5ejVN3uOcp7iJp2FwGTy4C4S
	NJ8vs4q6ZqHkrL5dI1eJybMgxJLUcSg=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FB16132FA;
	Mon, 29 Jan 2024 18:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id eVg8G3zvt2VjRAAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 29 Jan 2024 18:33:32 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/5] Struct to fs_info helpers
Date: Mon, 29 Jan 2024 19:33:07 +0100
Message-ID: <cover.1706553080.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

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
 fs/btrfs/inode.c                 | 42 ++++++++++++++---------------
 fs/btrfs/ioctl.c                 | 40 ++++++++++++++--------------
 fs/btrfs/lzo.c                   |  4 +--
 fs/btrfs/misc.h                  |  6 +++++
 fs/btrfs/props.c                 |  2 +-
 fs/btrfs/reflink.c               |  6 ++---
 fs/btrfs/relocation.c            |  2 +-
 fs/btrfs/tests/extent-io-tests.c | 28 +++++++++++++++++---
 15 files changed, 121 insertions(+), 95 deletions(-)

-- 
2.42.1


