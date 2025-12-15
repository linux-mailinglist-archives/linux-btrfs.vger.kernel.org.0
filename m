Return-Path: <linux-btrfs+bounces-19760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 674DECBF999
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 20:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1405F3019BC8
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 19:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485B3341654;
	Mon, 15 Dec 2025 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y+Uje66a";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y+Uje66a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833F0326948
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765828218; cv=none; b=HXGMDynY3bHNBf6dXWeH2TjHmw7hhcF9ONaBVj9ayls0YYSaEhEtMyMjDd3Ke5bjaKi+oeFWkE76bZjClHUOPEJH5SMDgOy4ltXHDupGcP9ybGZ8vDWJCEX+rY+X3Q5UcvEde4g+JFpTWTr9R5TnxiF9j1tPfjqaWpw1nNSkzTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765828218; c=relaxed/simple;
	bh=2sQ9BlKvbFvjXc/W7mZXOOJO66vI/aVli1ip2xycNyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uvd3CHRKnFYql1z3fYCOkcnmWnFPoOOQeDsRhg6VrVBwiD7OEBVcL8CJCpDvoD5/iLTh2+Y4tCGZFeBffKvANV5B5PUX7nvCnCbJi5ErwODjq19twHrTzef0X/Ydxb9jYc8uekFcGb62E7Kfupj63sHnAZ+u0NxBRE95CdKviP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Y+Uje66a; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Y+Uje66a; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49AA75BCD8;
	Mon, 15 Dec 2025 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765828212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xcgNbX3BfJasmZckpC9TyM9kPMW9YZTUEZgiWaIKEU0=;
	b=Y+Uje66aIqKKxJeMR/mxDy/GrqZzI0D967YqFfPGTwR2rNbonmCLfRsAyPMnuJRigZBbUt
	JlffHuQnfH1ERnRhEQqbO0uIIw29gnP4RWY5kDbrLLIBmPy/ob4LxKC+siSjM4BMlRBos/
	aZsnuw6iTwgs9H68L4LI3mVBxX9PEYI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Y+Uje66a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765828212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xcgNbX3BfJasmZckpC9TyM9kPMW9YZTUEZgiWaIKEU0=;
	b=Y+Uje66aIqKKxJeMR/mxDy/GrqZzI0D967YqFfPGTwR2rNbonmCLfRsAyPMnuJRigZBbUt
	JlffHuQnfH1ERnRhEQqbO0uIIw29gnP4RWY5kDbrLLIBmPy/ob4LxKC+siSjM4BMlRBos/
	aZsnuw6iTwgs9H68L4LI3mVBxX9PEYI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E90C3EA63;
	Mon, 15 Dec 2025 19:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pBrqDnRmQGmnPwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 15 Dec 2025 19:50:12 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.19-rc2
Date: Mon, 15 Dec 2025 20:50:02 +0100
Message-ID: <cover.1765827039.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 49AA75BCD8
X-Spam-Flag: NO
X-Spam-Score: -3.01

Hi,

please pull the following fixes. Thanks.

- fix missing btrfs_path release after printing a relocation error
  message

- fix extent changeset leak on mmap write after failure to reserve
  metadata

- fix fs devices list structure freeing, it could be potentially leaked
  under some circumstances

- tree log fixes:

  - fix incremental directory logging where inodes for new dentries were
    incorrectly skipped

  - don't log conflicting inode if it's a directory moved in the current
    transaction

- regression fixes:

  - fix incorrect btrfs_path freeing when it's auto-cleaned

  - revert commit simplifying preallocation of temporary structures in
    qgroup functions, some cases were not handled properly

----------------------------------------------------------------
The following changes since commit 9e0e6577b3e5e5cf7c1acd178eb648e8f830ba17:

  btrfs: remove unnecessary inode key in btrfs_log_all_parents() (2025-11-25 01:53:33 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc1-tag

for you to fetch changes up to 37343524f000d2a64359867d7024a73233d3b438:

  btrfs: fix changeset leak on mmap write after failure to reserve metadata (2025-12-12 16:33:18 +0100)

----------------------------------------------------------------
Dan Carpenter (1):
      btrfs: tests: fix double btrfs_path free in remove_extent_ref()

Deepanshu Kartikey (1):
      btrfs: fix memory leak of fs_devices in degraded seed device path

Filipe Manana (3):
      btrfs: don't log conflicting inode if it's a dir moved in the current transaction
      btrfs: do not skip logging new dentries when logging a new name
      btrfs: fix changeset leak on mmap write after failure to reserve metadata

Qu Wenruo (2):
      Revert "btrfs: add ASSERTs on prealloc in qgroup functions"
      btrfs: fix a potential path leak in print_data_reloc_error()

 fs/btrfs/file.c               |  3 ++-
 fs/btrfs/inode.c              |  1 +
 fs/btrfs/qgroup.c             | 27 ++++---------------------
 fs/btrfs/tests/qgroup-tests.c |  1 -
 fs/btrfs/tree-log.c           | 46 +++++++++++++++++++++++++++++++++++--------
 fs/btrfs/volumes.c            |  1 +
 6 files changed, 46 insertions(+), 33 deletions(-)

