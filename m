Return-Path: <linux-btrfs+bounces-10816-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E7CA07308
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D691886E2A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8992165E4;
	Thu,  9 Jan 2025 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JaIVkGsx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JaIVkGsx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF12165E3
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418243; cv=none; b=mxh5BF4wDQQ/BKvBseA0pj5dVW2FoNSaV19RuuKHaL/u7oG7HU9KRkK/L+jNxSywVxvwB6Fhfk1pQ+39jPA1KLTI+xGMFZrU+LzBdvQeEkIwkmhA4L6uGtFwyeO/PzgXbiI/S1iW/ZuKpWWZ5JYIxIFoFsLdUX5GnNlvCxCqU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418243; c=relaxed/simple;
	bh=XcYZH6lEOzzY6Ao3V2yicF1DDhyFggo125E6ITL8iaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hd8D9K9f+R4fjyK2mP3lJEwFLqSu7fl5dmC8+NCpp/J4e+b7pYIMobJmhvjDqACUeJlcInb5W1gDw7+qXqErysQ+x2iAifW7Sq+8qZwyDiEM5c/mLsaouW0rldRTZcWosslYipTcJHvowGcnNpW29gwP48DanAT8AfoWLkzWnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JaIVkGsx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JaIVkGsx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 197B121101;
	Thu,  9 Jan 2025 10:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CoeidWyfk9KEwspssCwRrhI/k3uHRyLrUszumi9vpZQ=;
	b=JaIVkGsxz2CL8DqKS3lR3zFO7WP9iW1d/xOUCjgT5qyXKC5OfYoi41SAIlXFcuvcS/fnP+
	pnBgMslARooJj+5Ng1REhXllndXyZIirvzGWw4SgrqwdMRoNicFtrJLHEywVyZjOV0/+Sm
	Jatq1CF2rvDMHop+BxNSX70+SeafRLk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=JaIVkGsx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CoeidWyfk9KEwspssCwRrhI/k3uHRyLrUszumi9vpZQ=;
	b=JaIVkGsxz2CL8DqKS3lR3zFO7WP9iW1d/xOUCjgT5qyXKC5OfYoi41SAIlXFcuvcS/fnP+
	pnBgMslARooJj+5Ng1REhXllndXyZIirvzGWw4SgrqwdMRoNicFtrJLHEywVyZjOV0/+Sm
	Jatq1CF2rvDMHop+BxNSX70+SeafRLk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D41F139AB;
	Thu,  9 Jan 2025 10:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jq3tAr2jf2cKEQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:23:57 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 00/18] Random cleanups for 6.14
Date: Thu,  9 Jan 2025 11:23:54 +0100
Message-ID: <cover.1736418116.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 197B121101
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
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
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Unsorteed small cleanups and renames.

David Sterba (18):
  btrfs: drop unused parameter fs_info to btrfs_delete_delayed_insertion_item()
  btrfs: remove stray comment about SRCU
  btrfs: use SECTOR_SIZE defines in btrfs_issue_discard()
  btrfs: rename __unlock_for_delalloc() and drop underscores
  btrfs: open code set_page_extent_mapped()
  btrfs: rename __get_extent_map() and pass btrfs_inode
  btrfs: use btrfs_inode in extent_writepage()
  btrfs: make wait_on_extent_buffer_writeback() static inline
  btrfs: drop one time used local variable in end_bbio_meta_write()
  btrfs: open code __free_extent_buffer()
  btrfs: rename btrfs_release_extent_buffer_pages() to mention folios
  btrfs: switch grab_extent_buffer() to folios
  btrfs: change return type to bool type of check_eb_alignment()
  btrfs: unwrap folio locking helpers
  btrfs: remove unused define WAIT_PAGE_LOCK for extent io
  btrfs: split waiting from read_extent_buffer_pages(), drop parameter wait
  btrfs: remove redundant variables from __process_folios_contig() and lock_delalloc_folios()
  btrfs: async-thread: rename DFT_THRESHOLD to DEFAULT_THRESHOLD

 fs/btrfs/async-thread.c     |   6 +-
 fs/btrfs/delayed-inode.c    |   5 +-
 fs/btrfs/disk-io.c          |   2 +-
 fs/btrfs/disk-io.h          |   3 -
 fs/btrfs/extent-tree.c      |   4 +-
 fs/btrfs/extent_io.c        | 143 ++++++++++++++++--------------------
 fs/btrfs/extent_io.h        |  16 ++--
 fs/btrfs/free-space-cache.c |   2 +-
 fs/btrfs/relocation.c       |   2 +-
 9 files changed, 84 insertions(+), 99 deletions(-)

-- 
2.47.1


