Return-Path: <linux-btrfs+bounces-4028-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20A789CE71
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 00:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC4D1F234F4
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 22:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609941EEF7;
	Mon,  8 Apr 2024 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IAhIztC3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IAhIztC3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EF7383A5
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712615644; cv=none; b=hcyGV/QkIRW0sExfLv9C3V+ligikauOcWl1iFJ+oFzZgXZA58A1/SlcwGBmsURcJKoZoErj3zPNSmPsStRr/EVcAsbeTc+dCI/Iu7Ko1Z580B6I7a4dNIhagI+eNuET6OQiDZhjlPpaKgJaLQlPcHBkvEKPPPHCM5xyGNOiEd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712615644; c=relaxed/simple;
	bh=sEq1VwhhG52OxZMO7DIgCPZYqc2GPhfi5GJhiq9qCX0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GeeUsy/Qpwvk+bv8BiBGxc5aF2re+yZPrKx3VthuSTkyS3P5O/JdPTqV2vRnRKSBLn7BHPDrliBWxqZ0MWhbR48IbMfHQ0PlCYfbcsgdMgADu3s/LO+85NDZ8Ws/kJWsxiomuBEqYsV14iCphYZs4kBH2xO1RmCQmAeupb6iO/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IAhIztC3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IAhIztC3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4BD122DA8
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712615639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C4Uf/7s7vkK623wwRfK2BbFLcD/INd0Boq+RhRzoslo=;
	b=IAhIztC3aIGKChCB6XhJYQLPP+a7vJdn9Rc6Ghxa6REg2eBEKhlbAJbtOkgo7YOgBWhjcV
	XpnCwuVi7M65ZJB95Y6/zzlvL0663R+/drCjx5pPc9IXawlOTkoNB0WAYseKISSgd0VL0j
	62bbZcvQ+ycKFSMEDGSDqb3o+GchDaY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712615639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C4Uf/7s7vkK623wwRfK2BbFLcD/INd0Boq+RhRzoslo=;
	b=IAhIztC3aIGKChCB6XhJYQLPP+a7vJdn9Rc6Ghxa6REg2eBEKhlbAJbtOkgo7YOgBWhjcV
	XpnCwuVi7M65ZJB95Y6/zzlvL0663R+/drCjx5pPc9IXawlOTkoNB0WAYseKISSgd0VL0j
	62bbZcvQ+ycKFSMEDGSDqb3o+GchDaY=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C1F751332F
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:33:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id pZtMHdZwFGaSTQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Apr 2024 22:33:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: extent-map: use disk_bytenr/offset to replace block_start/block_len/orig_start
Date: Tue,  9 Apr 2024 08:03:39 +0930
Message-ID: <cover.1712614770.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

[REASON FOR RFC]
Not all sanity checks are implemented, there is a missing check for
ram_bytes on non-compressed extent.
Because even without this series, generic/311 can generate a file extent
with ram_bytes larger than disk_num_bytes.

This seems harmless, but I still want to fix it and implement a full
version of the em sanity check.

[REPO]
https://github.com/adam900710/linux/tree/em_cleanup

Which relies on previous changes on extent maps.

This series introduce two new members (disk_bytenr/offset) to
extent_map, and removes three old members
(block_start/block_len/offset), finally rename one member
(orig_block_len -> disk_num_bytes).

This should save us one u64 for extent_map.

But to make things safe to migrate, I introduce extra sanity checks for
extent_map, and do cross check for both old and new members.

The extra sanity checks already exposed one bug (thankfully harmless)
causing em::block_start to be incorrect.

There is another bug related to bad btrfs_file_extent_item::ram_bytes,
which can be larger than disk_num_bytes for non-compressed file extents.
(Generated by generic/311 test case, but it seems to be created on-disk
 first)

But so far, the patchset is fine for default fstests run.

The patchset would do two renames as preparation.
Then introduce the new member, the extra sanity checks.
Finally do the migration by remove the old member one-by-one, to make
sure everything is fine.

Qu Wenruo (8):
  btrfs: rename extent_map::orig_block_len to disk_num_bytes
  btrfs: rename members of can_nocow_file_extent_args
  btrfs: introduce new members for extent_map
  btrfs: introduce extra sanity checks for extent maps
  btrfs: remove extent_map::orig_start member
  btrfs: remove extent_map::block_len member
  btrfs: remove extent_map::block_start member
  btrfs: reorder disk_bytenr/disk_num_bytes/ram_bytes/offset parameters

 fs/btrfs/btrfs_inode.h            |   5 +-
 fs/btrfs/compression.c            |   7 +-
 fs/btrfs/defrag.c                 |  14 +-
 fs/btrfs/extent_io.c              |  10 +-
 fs/btrfs/extent_map.c             | 187 ++++++++++++++++--------
 fs/btrfs/extent_map.h             |  51 +++----
 fs/btrfs/file-item.c              |  23 +--
 fs/btrfs/file.c                   |  18 +--
 fs/btrfs/inode.c                  | 234 ++++++++++++++++--------------
 fs/btrfs/relocation.c             |   5 +-
 fs/btrfs/tests/extent-map-tests.c | 114 ++++++++-------
 fs/btrfs/tests/inode-tests.c      | 177 +++++++++++-----------
 fs/btrfs/tree-log.c               |  27 ++--
 fs/btrfs/zoned.c                  |   4 +-
 include/trace/events/btrfs.h      |  20 +--
 15 files changed, 487 insertions(+), 409 deletions(-)

-- 
2.44.0


