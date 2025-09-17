Return-Path: <linux-btrfs+bounces-16875-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF03B7DA3C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 14:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698951BC5D2D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 05:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B27D23B612;
	Wed, 17 Sep 2025 05:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U2gJL+zR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U2gJL+zR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4372614
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 05:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758086462; cv=none; b=L9EGx0Qwy596LZngH9VxoaKiXPN0Ohu9z6NK94rsfRUwUm/6g0rQ9IA3cRu3rufWCOjyJxlNRMpGAjReD8X4Sqnd11vCTGuzIU061X5DDnYefkNpLYQeA9PzZK0Ia1LxQXgLAwLWMov8nV9hcyP4rgX2QMvGyJJ5XmY9mCc21dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758086462; c=relaxed/simple;
	bh=ytaJL3Lu72Qq2J1zoez6EAL4k8dciMabCXni4D4fiaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSqIrjMsjydB1clJOg6CMtVhZG6X5mukFYTOZB2Nsz69fnZ1wBEorQVtfaOfXLEwvdOHo/3TjEeBztGEBI/6Y2f5drX9MD99OQmRs7FjIqkP43k1Los3PDjaTKOgpsMScNOvPjjqPhfSOPIdw4z2KYlCNQ+1BNWWSPtP0j848P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U2gJL+zR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U2gJL+zR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 319641F453;
	Wed, 17 Sep 2025 05:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758086451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SnNtfqMHOHGJ0sdD8D1IUBXDpO3hlgn7R3lJ/Py7U7w=;
	b=U2gJL+zRawlaP89+viz3u96mP6YGGd0IfS+LsnSs23wSZ8R8lzMwVW0ATxlsOuBhTwDKY/
	Nl3WogRi+C67WE3Y+ah5rDg7dSCwocOwIqZsw5Q1ZF2IBHTLjvIWvf4bGZMILnyVEI+i8r
	4zim4jABThcdscvHqYUoROVc1gKPRFQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758086451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SnNtfqMHOHGJ0sdD8D1IUBXDpO3hlgn7R3lJ/Py7U7w=;
	b=U2gJL+zRawlaP89+viz3u96mP6YGGd0IfS+LsnSs23wSZ8R8lzMwVW0ATxlsOuBhTwDKY/
	Nl3WogRi+C67WE3Y+ah5rDg7dSCwocOwIqZsw5Q1ZF2IBHTLjvIWvf4bGZMILnyVEI+i8r
	4zim4jABThcdscvHqYUoROVc1gKPRFQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2812F13A21;
	Wed, 17 Sep 2025 05:20:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lw17CTNFymgHSwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 17 Sep 2025 05:20:51 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes fur 6.17-rc7
Date: Wed, 17 Sep 2025 07:20:40 +0200
Message-ID: <cover.1758085289.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hi,

please pull a few more btrfs fixes. Thanks.

- in zoned mode, turn assertion to proper code when reserving space in
  relocation block group

- fix search key of extended ref (hardlink) when replaying log

- fix initialization of file extent tree on filesystems without no-holes
  feature

- add harmless data race annotation to block group comparator

----------------------------------------------------------------
The following changes since commit 3d1267475b94b3df7a61e4ea6788c7c5d9e473c4:

  btrfs: don't allow adding block device of less than 1 MB (2025-09-05 19:52:10 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc6-tag

for you to fetch changes up to 80eb65ccf6f72dc37b972583fe71cd8a50ff7e51:

  btrfs: annotate block group access with data_race() when sorting for reclaim (2025-09-15 05:25:43 +0200)

----------------------------------------------------------------
Filipe Manana (2):
      btrfs: fix invalid extref key setup when replaying dentry
      btrfs: annotate block group access with data_race() when sorting for reclaim

Johannes Thumshirn (1):
      btrfs: zoned: fix incorrect ASSERT in btrfs_zoned_reserve_data_reloc_bg()

austinchang (1):
      btrfs: initialize inode::file_extent_tree after i_mode has been set

 fs/btrfs/block-group.c   |  9 ++++++++-
 fs/btrfs/delayed-inode.c |  3 ---
 fs/btrfs/inode.c         | 11 +++++------
 fs/btrfs/tree-log.c      |  2 +-
 fs/btrfs/zoned.c         |  2 +-
 5 files changed, 15 insertions(+), 12 deletions(-)

