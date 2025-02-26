Return-Path: <linux-btrfs+bounces-11841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16050A45A96
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916AA1895109
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E7223815F;
	Wed, 26 Feb 2025 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KVQ3Jf+q";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KVQ3Jf+q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE99224259
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563448; cv=none; b=MuTLyxSQVFmxrNmmKAKq+ZJmsjVlH1uGqncecSlHTruk8KRMUika3y6Nk1Fq06waoMNCywF3v7e4+ILklqU7tuJDu1CliA44qkxva0co37eW0yvqMSwhDpHolgBtvBeBhNheGB+G1DNDxnZXGyhog33RL+COxeNR4AxabWCBxiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563448; c=relaxed/simple;
	bh=dBtQyMACh84Iofas0Ss3LHY+xanLZNtDCzAFVJRzuZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rmw0DfUG5uVo4laZjXWGg3y9q86UkkuGPN3uBI95QJ72mcxgL9szXI64RTGv8oZNQEQIaAtRCHraNnwRwUfP+0VOXMAU8SDex1Pdaf3y6JmmPx38rokjHHlq2sdGg4TsxyZgWZmlxBH4xaIgnc1pviBz8wKVFRJ9n++rb1RMTyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KVQ3Jf+q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KVQ3Jf+q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 018DF21163;
	Wed, 26 Feb 2025 09:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=33nyEGEPP+sJarLB/USQDmq2bYRtIaN8efbz6I/lCoU=;
	b=KVQ3Jf+qiAMogPD8cLSzLXCK+MkY6T/ZQS4zcHValaDVG3vstsP7AioTQDPj/P6OgFSACe
	En+delFNJkDkvhCDoPR1PzTD6cqzr4ug0RXiIPBS5/w2PCm+4p//cPIW/+wK6LW//KzKqT
	1hLS9gb8GfHmTqBGkSx2i26eH4Hauyg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=KVQ3Jf+q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=33nyEGEPP+sJarLB/USQDmq2bYRtIaN8efbz6I/lCoU=;
	b=KVQ3Jf+qiAMogPD8cLSzLXCK+MkY6T/ZQS4zcHValaDVG3vstsP7AioTQDPj/P6OgFSACe
	En+delFNJkDkvhCDoPR1PzTD6cqzr4ug0RXiIPBS5/w2PCm+4p//cPIW/+wK6LW//KzKqT
	1hLS9gb8GfHmTqBGkSx2i26eH4Hauyg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE78713A53;
	Wed, 26 Feb 2025 09:50:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tgM0OvTjvmfyYQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:50:44 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 00/27] Struct btrfs_path auto cleaning conversions
Date: Wed, 26 Feb 2025 10:50:40 +0100
Message-ID: <cover.1740562070.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 018DF21163
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

We have the scoped freeing for struct btrfs_path but it's not used as
much as it could. This patchset converts the easy cases and it's also a
preview if we really want to do that. It makes understanding the exit
paths a bit less obvious, but so far I think it's manageable.

The path is used in many functions and following a few simple patterns,
with the macro BTRFS_PATH_AUTO_FREE quite visible among the
declarations, so it's nothing hard to be aware of that when reading the
code.

The conversion has been done on half of the files, so if somebody wants
to continue, feel free. I've skipped functions with more complicated
branching where the auto freeing would make it worse.

David Sterba (27):
  btrfs: use BTRFS_PATH_AUTO_FREE in sample_block_group_extent_item()
  btrfs: use BTRFS_PATH_AUTO_FREE in insert_dev_extent()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_setup_space_cache()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_start_dirty_block_groups()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_write_dirty_block_groups()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_insert_item()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_commit_inode_delayed_items()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_init_dev_replace()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_run_dev_replace()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_check_dir_item_collision()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_read_tree_root()
  btrfs: use BTRFS_PATH_AUTO_FREE in load_global_roots()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_init_root_free_objectid()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_get_name()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_lookup_data_extent()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_lookup_extent_info()
  btrfs: use BTRFS_PATH_AUTO_FREE in __btrfs_inc_extent_ref()
  btrfs: use BTRFS_PATH_AUTO_FREE in run_delayed_extent_op()
  btrfs: use BTRFS_PATH_AUTO_FREE in check_ref_exists()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_drop_subtree()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_insert_hole_extent()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_lookup_bio_sums()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_del_csums()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_remove_free_space_inode()
  btrfs: use BTRFS_PATH_AUTO_FREE in populate_free_space_tree()
  btrfs: use BTRFS_PATH_AUTO_FREE in clear_free_space_tree()
  btrfs: use BTRFS_PATH_AUTO_FREE in load_free_space_tree()

 fs/btrfs/block-group.c      | 20 ++++++----------
 fs/btrfs/ctree.c            |  3 +--
 fs/btrfs/delayed-inode.c    |  3 +--
 fs/btrfs/dev-replace.c      | 32 ++++++++++---------------
 fs/btrfs/dir-item.c         | 24 +++++++------------
 fs/btrfs/disk-io.c          | 29 ++++++++++-------------
 fs/btrfs/export.c           | 10 +++-----
 fs/btrfs/extent-tree.c      | 47 ++++++++++++++-----------------------
 fs/btrfs/file-item.c        | 17 +++++---------
 fs/btrfs/free-space-cache.c | 13 ++++------
 fs/btrfs/free-space-tree.c  | 45 ++++++++++++++---------------------
 11 files changed, 91 insertions(+), 152 deletions(-)

-- 
2.47.1


