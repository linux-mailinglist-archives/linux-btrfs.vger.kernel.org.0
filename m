Return-Path: <linux-btrfs+bounces-6902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D39F6942471
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 04:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884FC285AA4
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 02:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A1B10A0C;
	Wed, 31 Jul 2024 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fGKY+EtZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fGKY+EtZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B468101C4;
	Wed, 31 Jul 2024 02:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722392059; cv=none; b=ERuflZn49X8by9uL8DU01vO6QrIAlljWt7Y2NmrA1SQxK4yS29ZdV+QEvoipbMBWgfSqkQpoo85scZqdzNTPz3QN6PZ5bpFTjY4qCSO5zYKClNrkvaemjn4UgwmT2d56znifpIdN6PA+qF6v8SjiA2KrKbJTijSCKkUSNJZBTPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722392059; c=relaxed/simple;
	bh=Zf9AA9aIXHwTBBiD9oLmRaGfwDCmv/LevEcuNtay4sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUy2CnfJ4NtSsJ2jPSFigHg0mgkmls4wOZVbb41ISo7SSdnJ0mRRdFuqIg9Vw+VyegF8In5zJKytQ6tO0FlKWbNeIauHtEsIMfV8YCox64LRH5CNS0KZ2XtnDKGDknSbIj7P+LK7Ey8Nl+miKoYjOj1R2KFCJ9zngclkgwByakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fGKY+EtZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fGKY+EtZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 86C9421EF6;
	Wed, 31 Jul 2024 02:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722392054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EcWBOKPbUOQ/gLATLyls+MqjOHRtPx91BjGH09NjhMs=;
	b=fGKY+EtZAXpz7BkI6BsIPkRuE7p/QUh1H+S4AgKVnoSH5CwShfO3fZLONS8W3naRbAE7hC
	QHE7twnRWEhb6/+Nqe/2ob/b3MWZIeljY/5PahyaSoobDXXzgRwj3hHDyzPEQFrYZ+AuIp
	dP/lPAfJZgeQ8MCWKtWRyw+Jyk0OLdQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fGKY+EtZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722392054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EcWBOKPbUOQ/gLATLyls+MqjOHRtPx91BjGH09NjhMs=;
	b=fGKY+EtZAXpz7BkI6BsIPkRuE7p/QUh1H+S4AgKVnoSH5CwShfO3fZLONS8W3naRbAE7hC
	QHE7twnRWEhb6/+Nqe/2ob/b3MWZIeljY/5PahyaSoobDXXzgRwj3hHDyzPEQFrYZ+AuIp
	dP/lPAfJZgeQ8MCWKtWRyw+Jyk0OLdQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8025C13297;
	Wed, 31 Jul 2024 02:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RfNEH/adqWbmJAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 31 Jul 2024 02:14:14 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.11-rc2
Date: Wed, 31 Jul 2024 04:14:09 +0200
Message-ID: <cover.1722390813.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.81 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.81
X-Rspamd-Queue-Id: 86C9421EF6

Hi,

please pull the following fixes, thanks.

- fix regression in extent map rework when handling insertion of
  overlapping compressed extent

- fix unexpected file length when appending to a file using direct io
  and buffer not faulted in

- in zoned mode, fix accounting of unusable space when flipping
  read-only block group back to read-write

- fix page locking when COWing an inline range, assertion failure found
  by syzbot

- fix calculation of space info in debugging print

- tree-checker, add validation of data reference item

- fix a few -Wmaybe-uninitialized build warnings

----------------------------------------------------------------
The following changes since commit c3ece6b7ffb4a7c00e8d53cbf4026a32b6127914:

  btrfs: change BTRFS_MOUNT_* flags to 64bit type (2024-07-19 17:20:23 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc1-tag

for you to fetch changes up to b8e947e9f64cac9df85a07672b658df5b2bcff07:

  btrfs: initialize location to fix -Wmaybe-uninitialized in btrfs_lookup_dentry() (2024-07-30 15:33:06 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: make cow_file_range_inline() honor locked_page on error

David Sterba (1):
      btrfs: initialize location to fix -Wmaybe-uninitialized in btrfs_lookup_dentry()

Filipe Manana (2):
      btrfs: fix corrupt read due to bad offset of a compressed extent map
      btrfs: fix corruption after buffer fault in during direct IO append write

Naohiro Aota (2):
      btrfs: do not subtract delalloc from avail bytes
      btrfs: zoned: fix zone_unusable accounting on making block group read-write again

Qu Wenruo (1):
      btrfs: tree-checker: validate dref root and objectid

 fs/btrfs/block-group.c            | 13 +++--
 fs/btrfs/ctree.h                  |  1 +
 fs/btrfs/direct-io.c              | 38 +++++++++++----
 fs/btrfs/extent-tree.c            |  3 +-
 fs/btrfs/extent_map.c             |  2 +-
 fs/btrfs/file.c                   | 17 +++++--
 fs/btrfs/free-space-cache.c       |  4 +-
 fs/btrfs/inode.c                  | 18 ++++---
 fs/btrfs/space-info.c             |  5 +-
 fs/btrfs/space-info.h             |  1 +
 fs/btrfs/tests/extent-map-tests.c | 99 +++++++++++++++++++++++++++++++++++++++
 fs/btrfs/tree-checker.c           | 47 +++++++++++++++++++
 include/trace/events/btrfs.h      |  8 ++++
 13 files changed, 225 insertions(+), 31 deletions(-)

