Return-Path: <linux-btrfs+bounces-14318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D9EAC934A
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1883B0E3A
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22201A0BC5;
	Fri, 30 May 2025 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s6FK3Ta6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s6FK3Ta6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C9C2E401
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621828; cv=none; b=ge+v7v/tO580dnN9tnOvk7k2QoHEp9TPl6VJonKuSX1KbLzGFgdJ2FlcJEQhuUMcoKht3etQ5cF5iRKtCzCSKW8j+aflEm0L/XvnNZNcFfOt/iFIWm7VZTDHY5TRY+ECuhqQjgp0PN6i2a50uTAwG0rGALIr6kuAgnM6pzvLePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621828; c=relaxed/simple;
	bh=l+C046iYkrEC6JdgxRZpUavITEZFzeATi8BaXV3spEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VT+qcPvosWKQE3NMNd2S19q/1TkZL6BgSL2qJF0kds8mXBpRxAltzaz1V6Euyg7vEYNm4rB2usylIZGwPZ4rVPB/tXdRsVjxkAAVrsjj4SZ9XbFbLJNShxYDxJi/KWskcneu2VoXrodp0G5j9UlSPFw++jyU/Ae/CbLkLJBoSzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s6FK3Ta6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s6FK3Ta6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 62C6E1F7F2;
	Fri, 30 May 2025 16:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EapIfRKxwPO8xxrPjj3ef9pq+BXZgv4qtP0xsiAlob4=;
	b=s6FK3Ta6UgdconZFE5aQQOrBuKsYUtzggGVedZ1mm5qHt+vuLeHoCR2KWW69VbUCV6cZbK
	wdpJOErKsQfmZTcbqQt5GYMm4ZrqVebyZ6WaPdpPO0Q7b5k5xfBFHwHLWk7seQTWYlylOg
	5N+cTqrSjoB7Aw2H8MABGFA0tbJ+NL0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EapIfRKxwPO8xxrPjj3ef9pq+BXZgv4qtP0xsiAlob4=;
	b=s6FK3Ta6UgdconZFE5aQQOrBuKsYUtzggGVedZ1mm5qHt+vuLeHoCR2KWW69VbUCV6cZbK
	wdpJOErKsQfmZTcbqQt5GYMm4ZrqVebyZ6WaPdpPO0Q7b5k5xfBFHwHLWk7seQTWYlylOg
	5N+cTqrSjoB7Aw2H8MABGFA0tbJ+NL0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BB6B13889;
	Fri, 30 May 2025 16:17:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gZleFv/ZOWhbZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:17:03 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 00/22] Return variable name unifications
Date: Fri, 30 May 2025 18:16:54 +0200
Message-ID: <cover.1748621715.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

Simple conversions, 'ret' from 'err, or the secondary return value ret2.

David Sterba (22):
  btrfs: rename err to ret2 in resolve_indirect_refs()
  btrfs: rename err to ret2 in read_block_for_search()
  btrfs: rename err to ret2 in search_leaf()
  btrfs: rename err to ret2 in btrfs_search_slot()
  btrfs: rename err to ret2 in btrfs_search_old_slot()
  btrfs: rename err to ret2 in btrfs_setsize()
  btrfs: rename err to ret2 in btrfs_add_link()
  btrfs: rename err to ret2 in btrfs_truncate_inode_items()
  btrfs: rename err to ret in btrfs_try_lock_extent_bits()
  btrfs: rename err to ret in btrfs_lock_extent_bits()
  btrfs: rename err to ret in btrfs_alloc_from_bitmap()
  btrfs: rename err to ret in btrfs_init_inode_security()
  btrfs: rename err to ret in btrfs_setattr()
  btrfs: rename err to ret in btrfs_link()
  btrfs: rename err to ret in btrfs_symlink()
  btrfs: rename err to ret in calc_pct_ratio()
  btrfs: rename err to ret in btrfs_fill_super()
  btrfs: rename err to ret in quota_override_store()
  btrfs: rename err to ret in btrfs_wait_extents()
  btrfs: rename err to ret in btrfs_wait_tree_log_extents()
  btrfs: rename err to ret in btrfs_create_common()
  btrfs: rename err to ret in scrub_submit_extent_sector_read()

 fs/btrfs/backref.c          |  10 +--
 fs/btrfs/ctree.c            |  76 ++++++++++----------
 fs/btrfs/extent-io-tree.c   |  17 +++--
 fs/btrfs/free-space-cache.c |   6 +-
 fs/btrfs/inode-item.c       |  11 ++-
 fs/btrfs/inode.c            | 136 ++++++++++++++++++------------------
 fs/btrfs/scrub.c            |   8 +--
 fs/btrfs/space-info.c       |   6 +-
 fs/btrfs/super.c            |  24 +++----
 fs/btrfs/sysfs.c            |   8 +--
 fs/btrfs/transaction.c      |  20 +++---
 11 files changed, 158 insertions(+), 164 deletions(-)

-- 
2.47.1


