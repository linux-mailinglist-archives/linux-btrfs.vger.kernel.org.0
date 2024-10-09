Return-Path: <linux-btrfs+bounces-8695-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9C9996DD0
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCCE1F215FB
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11410126C18;
	Wed,  9 Oct 2024 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AeGFMK7+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bfQpikqN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D6F1CD2C
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484255; cv=none; b=rnHgPkW+1I0WMl4LNRtd9d00q5m9g8Z+XTMRxEIy6CKeT14dzFFG88IrBr9F9i2Xgcb/bTb2OYD1cJa21epd/7nOU1WM6RVJQRVxnH9pb8SxPtehCkdM7AwwchCCUNt3Exsxz0cdq9P3R9QQlIA2pyAcTiySErQASpjDZrTMduo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484255; c=relaxed/simple;
	bh=0+tRKxo64aW7iAAiGKBwnfksqcivL9PS2SD8lN59r58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u4KPVwN3Ign7Hk6Ltm6lgZXZ5UPn5Wbzi8ZgzgSQYld/Spk5S4vpIguksIauputCUKgVvdsYBYAHVxnLSmUX75+7I48SMyPoE2nXcN9G8pJ8TWhE3qOxMDI0l+itvUKoCFFXbboWgrpTnV9hIADDsg6dw+18Gx7Oo2wWnhAXeEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AeGFMK7+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bfQpikqN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8032321EB2;
	Wed,  9 Oct 2024 14:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZrUsGRDHFIAt85bsFLGzcuXQOLDDtmpzATLR+dzvNQE=;
	b=AeGFMK7+VhYw38eIt5qi6Xpf4lB9Bw8NmtwEqXYM62KbRatHPKUZddRMYmYr7RKoFm2iMQ
	3ushE8kL5WAXRdja+E7MPyyuoG/noY/QVzNWar2aOnjKkm+CwqpvlMoJlr9WMvLJlnhU8q
	WoPZwPhf6fKpu2uIsjaU2qI2nij+sCo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZrUsGRDHFIAt85bsFLGzcuXQOLDDtmpzATLR+dzvNQE=;
	b=bfQpikqNUBWSd4RHjwIVP3BMbtnXIn7M00pKfcfBPFsFg1AVhSCNkmyiZNJ8r+19oyH85N
	6ICKjWGEUzRNbHvDrLPSxgtC/zDLCF5hYDnNsZvMsT7wb5inqngBLzhFxSTT7G1VHJbxxH
	WVH4c1gejjbXdInw7V1+d434/msrgag=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76E6E136BA;
	Wed,  9 Oct 2024 14:30:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1nX9HJiTBmfnRAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:30:48 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 00/25] Unused parameter cleanups
Date: Wed,  9 Oct 2024 16:30:40 +0200
Message-ID: <cover.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Level: 

Assorted unused parameter removal, I tried to go to history where it was
last used and seemed important. Most of them look like leftovers after
other changes.

David Sterba (25):
  btrfs: zstd: assert the timer pointer in callback
  btrfs: drop unused parameter path from btrfs_tree_mod_log_rewind()
  btrfs: drop unused parameter ctx from batch_delete_dir_index_items()
  btrfs: drop unused parameter fs_info from wait_reserve_ticket()
  btrfs: drop unused parameter fs_info from do_reclaim_sweep()
  btrfs: send: drop unused parameter num from iterate_inode_ref_t
    callbacks
  btrfs: send: drop unused parameter index from iterate_inode_ref_t
    callbacks
  btrfs: scrub: drop unused parameter sctx from
    scrub_submit_extent_sector_read()
  btrfs: drop unused parameter map from scrub_simple_mirror()
  btrfs: qgroup: drop unused parameter fs_info from __del_qgroup_rb()
  btrfs: drop unused transaction parameter from
    btrfs_qgroup_add_swapped_blocks()
  btrfs: lzo: drop unused paramter level from lzo_alloc_workspace()
  btrfs: drop unused parameter argp from btrfs_ioctl_quota_rescan_wait()
  btrfs: drop unused parameter inode from read_inline_extent()
  btrfs: drop unused parameter offset from __cow_file_range_inline()
  btrfs: drop unused parameter file_offset from
    btrfs_encoded_read_regular_fill_pages()
  btrfs: drop unused parameter iov_iter from btrfs_write_check()
  btrfs: drop unused parameter refs from visit_node_for_delete()
  btrfs: drop unused parameter mask from try_release_extent_state()
  btrfs: drop unused parameter fs_info from folio_range_has_eb()
  btrfs: drop unused parameter options from open_ctree()
  btrfs: drop unused parameter data from btrfs_fill_super()
  btrfs: drop unused parameter transaction from alloc_log_tree()
  btrfs: drop unused parameter fs_info from btrfs_match_dir_item_name()
  btrfs: drop unused parameter level from alloc_heuristic_ws()

 fs/btrfs/btrfs_inode.h  |  3 +--
 fs/btrfs/compression.c  |  6 +++---
 fs/btrfs/compression.h  |  2 +-
 fs/btrfs/ctree.c        |  2 +-
 fs/btrfs/dir-item.c     | 11 ++++-------
 fs/btrfs/dir-item.h     |  3 +--
 fs/btrfs/direct-io.c    |  2 +-
 fs/btrfs/disk-io.c      | 10 ++++------
 fs/btrfs/disk-io.h      |  3 +--
 fs/btrfs/extent-tree.c  |  7 +++----
 fs/btrfs/extent_io.c    |  8 ++++----
 fs/btrfs/file.c         |  6 +++---
 fs/btrfs/file.h         |  2 +-
 fs/btrfs/inode.c        | 17 ++++++++---------
 fs/btrfs/ioctl.c        |  5 ++---
 fs/btrfs/lzo.c          |  2 +-
 fs/btrfs/qgroup.c       | 10 ++++------
 fs/btrfs/qgroup.h       |  3 +--
 fs/btrfs/relocation.c   |  2 +-
 fs/btrfs/scrub.c        | 12 +++++-------
 fs/btrfs/send.c         | 25 +++++++------------------
 fs/btrfs/space-info.c   | 10 ++++------
 fs/btrfs/super.c        |  7 +++----
 fs/btrfs/tree-log.c     |  3 +--
 fs/btrfs/tree-mod-log.c |  1 -
 fs/btrfs/tree-mod-log.h |  1 -
 fs/btrfs/xattr.c        |  5 ++---
 fs/btrfs/zstd.c         |  2 ++
 28 files changed, 69 insertions(+), 101 deletions(-)

-- 
2.45.0


