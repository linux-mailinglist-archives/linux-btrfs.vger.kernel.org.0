Return-Path: <linux-btrfs+bounces-7204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FDB95271B
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 02:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1C71F241A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 00:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3724A15;
	Thu, 15 Aug 2024 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hanE+fn0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hanE+fn0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76691186A;
	Thu, 15 Aug 2024 00:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723682292; cv=none; b=uEninI84I8aWUxljv+ysGD5T2NyLeqonDeycU521ctQBKtOml+aedNCFTm1P9BzMJ3pOXLXcjxhamkqhtn9RWPVT6wsfAmymRsOFSlbFjX2/Vr2EBvraRiw+mA60XJQLtvHIljJgcXeOgY4I/XYA8jlMQ9aW8QNTOSrqOSdSX6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723682292; c=relaxed/simple;
	bh=3DolbV72r+ZktqzDGiQbuyZ4jYwpkQfNN+pzs9OQ3vY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8QOArrFH95SxyBVOZJVelpoYl2NCSsWwGL+quBkxg3iVq5MIWq3N4TwhdsJnlZBGzfb8O+00rxTH48rBoaQ3AX/eMPqrAvv6/PP792Dg/0PQRhlEicNisvGZPjhGtin1hVGfT/KDh/UHLGxBJyNYOtIZ9vURynoFSEz9qdff/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hanE+fn0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hanE+fn0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6465F1FC04;
	Thu, 15 Aug 2024 00:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723682287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gygwxlJiBVf1p6hCClu6Ljyjykin3NQXB2ZaepiiHrU=;
	b=hanE+fn03kqV4sHxm8TGC77ONpxrdJl+vuFHUxucGm5d6M2PSJHRpZraU8cN+XbgTbdDke
	MpeU0qKvRUvIlZSL07wkLS4LIDyVILGq70pLvICuL4NQd57j0Xn0dvDPL7R/mvCkNG4fAN
	5VWHoN8AHvJA+hPdtsGyxUsS9LNJJhI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723682287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gygwxlJiBVf1p6hCClu6Ljyjykin3NQXB2ZaepiiHrU=;
	b=hanE+fn03kqV4sHxm8TGC77ONpxrdJl+vuFHUxucGm5d6M2PSJHRpZraU8cN+XbgTbdDke
	MpeU0qKvRUvIlZSL07wkLS4LIDyVILGq70pLvICuL4NQd57j0Xn0dvDPL7R/mvCkNG4fAN
	5VWHoN8AHvJA+hPdtsGyxUsS9LNJJhI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 587E513983;
	Thu, 15 Aug 2024 00:38:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wuNYFe9NvWaBBAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 15 Aug 2024 00:38:07 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.11-rc4
Date: Thu, 15 Aug 2024 02:38:02 +0200
Message-ID: <cover.1723673272.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

Hi,

please pull the following branch, with stable fixes and one regression
fix.  Thanks.

- extend tree-checker verification of directory item type

- fix regression in page/folio and extent state tracking in xarray, the
  dirty status can get out of sync and can cause problems e.g. a hang

- in send, detect last extent and allow to clone it instead of sending
  it as write, reduces amount of data transferred in the stream

- fix checking extent references when cleaning deleted subvolumes

- fix one more case in the extent map shrinker, let it run only in the
  kswapd context so it does not cause latency spikes during other
  operations

----------------------------------------------------------------
The following changes since commit 7c626ce4bae1ac14f60076d00eafe71af30450ba:

  Linux 6.11-rc3 (2024-08-11 14:27:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc3-tag

for you to fetch changes up to 6252690f7e1b173b86a4c27dfc046b351ab423e7:

  btrfs: fix invalid mapping of extent xarray state (2024-08-13 15:36:57 +0200)

----------------------------------------------------------------
Filipe Manana (2):
      btrfs: only run the extent map shrinker from kswapd tasks
      btrfs: send: allow cloning non-aligned extent if it ends at i_size

Josef Bacik (1):
      btrfs: check delayed refs when we're checking if a ref exists

Naohiro Aota (1):
      btrfs: fix invalid mapping of extent xarray state

Qu Wenruo (1):
      btrfs: tree-checker: reject BTRFS_FT_UNKNOWN dir type

 fs/btrfs/delayed-ref.c  | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/delayed-ref.h  |  2 ++
 fs/btrfs/extent-tree.c  | 51 ++++++++++++++++++++++++++++++++-----
 fs/btrfs/extent_io.c    | 14 +++++------
 fs/btrfs/extent_map.c   | 22 +++++-----------
 fs/btrfs/send.c         | 52 ++++++++++++++++++++++++++++----------
 fs/btrfs/super.c        | 10 ++++++++
 fs/btrfs/tree-checker.c |  5 ++--
 8 files changed, 179 insertions(+), 44 deletions(-)

