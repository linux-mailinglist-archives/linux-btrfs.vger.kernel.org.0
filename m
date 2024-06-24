Return-Path: <linux-btrfs+bounces-5925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7A4915387
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 18:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B769D1F2459A
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 16:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE9119E7DA;
	Mon, 24 Jun 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="menKVwRu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="menKVwRu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0A519DF77
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246186; cv=none; b=QGe4hY/HKWU6CNVi4ArKA41CJ/kZV7Ug6tRpOlCVSpv/XuRVUQk/uNobNAwMsX2rqOabZieA1PVcvQdym/GqhAkxhTffIX9RVhcOwIeirGlN76lRD/MvxZCTh6zW5039QWukOq03RgEPgFvG+OWFnmjwpDMenOE/nYh/Rx02BN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246186; c=relaxed/simple;
	bh=BSp1e8iJ6EWUkEaD50iMYUElNpMVcLTQ+1SCoQXQWDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/uxOaeB+T3bhHNwVEmRbALQ5jfSLnLKkzjEblD3XGMxfmuQo4XLbDpXO8dVWwfYP1c+ie2rrgf/gQRFnrs6sUe2oqW1VlbvTzILX+pVjyvr7YT/xjyUvJzCYTkhw9+LUpQ5U3kHp/zTOQxexi2Tpq7csjkBVvXoVpoEgiJw6+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=menKVwRu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=menKVwRu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3FC601F7A4;
	Mon, 24 Jun 2024 16:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719246181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fdL4GGctj9udq8zuLytP5X29NSt5FkSmvYmMWJj64uM=;
	b=menKVwRudelHSJ7+RYPHGMyWSyWK5e5iT3KPUS7qJf6O/Lm+QNRDFkQyMFPyHdysXSikRY
	f/uPUQ4p+LJVwmLf+bXFWb5f25sbaAJMp+YBjuw83C4jQ86darnH1N0kJJ45NFr/kznhvA
	ygdm45cur0WQwbIjsW6Er1eY14wVq2c=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719246181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fdL4GGctj9udq8zuLytP5X29NSt5FkSmvYmMWJj64uM=;
	b=menKVwRudelHSJ7+RYPHGMyWSyWK5e5iT3KPUS7qJf6O/Lm+QNRDFkQyMFPyHdysXSikRY
	f/uPUQ4p+LJVwmLf+bXFWb5f25sbaAJMp+YBjuw83C4jQ86darnH1N0kJJ45NFr/kznhvA
	ygdm45cur0WQwbIjsW6Er1eY14wVq2c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 348561384C;
	Mon, 24 Jun 2024 16:23:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VWCMDGWdeWbMLQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 24 Jun 2024 16:23:01 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 00/11] Inode type conversion
Date: Mon, 24 Jun 2024 18:22:56 +0200
Message-ID: <cover.1719246104.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

A small batch converting inode to btrfs_inode for internal functions and
data structures.

David Sterba (11):
  btrfs: pass a btrfs_inode to btrfs_readdir_put_delayed_items()
  btrfs: pass a btrfs_inode to btrfs_readdir_get_delayed_items()
  btrfs: pass a btrfs_inode to is_data_inode()
  btrfs: switch btrfs_block_group::inode to struct btrfs_inode
  btrfs: pass a btrfs_inode to btrfs_ioctl_send()
  btrfs: switch btrfs_pending_snapshot::dir to btrfs_inode
  btrfs: switch btrfs_ordered_extent::inode to struct btrfs_inode
  btrfs: pass a btrfs_inode to btrfs_compress_heuristic()
  btrfs: pass a btrfs_inode to btrfs_set_prop()
  btrfs: pass a btrfs_inode to btrfs_load_inode_props()
  btrfs: pass a btrfs_inode to btrfs_inode_inherit_props()

 fs/btrfs/bio.c              |  2 +-
 fs/btrfs/block-group.c      |  4 ++--
 fs/btrfs/block-group.h      |  2 +-
 fs/btrfs/btrfs_inode.h      |  4 ++--
 fs/btrfs/compression.c      |  6 +++---
 fs/btrfs/compression.h      |  2 +-
 fs/btrfs/delayed-inode.c    | 12 +++++------
 fs/btrfs/delayed-inode.h    |  4 ++--
 fs/btrfs/extent_io.c        |  2 +-
 fs/btrfs/free-space-cache.c |  4 ++--
 fs/btrfs/inode.c            | 18 ++++++++--------
 fs/btrfs/ioctl.c            | 16 +++++++-------
 fs/btrfs/ordered-data.c     | 22 +++++++++----------
 fs/btrfs/ordered-data.h     |  2 +-
 fs/btrfs/props.c            | 43 ++++++++++++++++++-------------------
 fs/btrfs/props.h            |  8 +++----
 fs/btrfs/relocation.c       |  2 +-
 fs/btrfs/send.c             |  4 ++--
 fs/btrfs/send.h             |  4 ++--
 fs/btrfs/subpage.c          |  4 ++--
 fs/btrfs/transaction.c      |  2 +-
 fs/btrfs/transaction.h      |  2 +-
 fs/btrfs/xattr.c            |  2 +-
 fs/btrfs/zoned.c            |  8 +++----
 24 files changed, 89 insertions(+), 90 deletions(-)

-- 
2.45.0


