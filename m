Return-Path: <linux-btrfs+bounces-13727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB11AAC76F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 16:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACC24C5F84
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 14:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A521828137D;
	Tue,  6 May 2025 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YdUYhF60";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YdUYhF60"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D6127AC40
	for <linux-btrfs@vger.kernel.org>; Tue,  6 May 2025 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540384; cv=none; b=XCll0Btvr07e33RdU3kJSl35tqa1qzy2IWMmjxaz3/WSbNncFMiSx7CIcqBq8PDZuGcNGGlJe08iAlQIWWvXYObI2QDVeWa45YbRYkypuFFbeQVvGjAtrTWN6/OBaU+MaKGC7QDcb13ygC4Kjfs5zB/SvQd4x5p0JVWhvPJ5c1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540384; c=relaxed/simple;
	bh=3opEq2h5w0UOxmosWULNPMfe5jZlpZBAVrsnMKF+44k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JgMdj9NqQUhfz30HjjgF806QhYw58IvLNTF4G2a2lBw6vZ6NdsiGXeRPgrO4CRYzc3p/0yto3tVMMpF7sJZuRlGMoBge+nbhl/05dwFGxiyBCzuQbdTp4paYbiose8kJAPnAqVMHsH/1tvq82pyLCDCG9lumtXZSnzIhzAkcitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YdUYhF60; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YdUYhF60; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1074E1F443;
	Tue,  6 May 2025 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746540380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j6BNXNAYY3Jp10QsWYb3agAYiro+Uv/XF2h14CWtep4=;
	b=YdUYhF60cyT2tj29IA/BJ8V+ZsO3LVYSFawtU+7lZpo40SWbylv1Tq1WSFdIC5gWyrTMSL
	Vo88YND6YuVmONIFz0N9xVoXdQ1ia2K2Ve+w6EoliP5/27HHLEyGkT6H8UxqMinhHFYAJD
	4vPfpRo3Mw25iNNkuF4zgOCHmTl5o8I=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YdUYhF60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746540380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j6BNXNAYY3Jp10QsWYb3agAYiro+Uv/XF2h14CWtep4=;
	b=YdUYhF60cyT2tj29IA/BJ8V+ZsO3LVYSFawtU+7lZpo40SWbylv1Tq1WSFdIC5gWyrTMSL
	Vo88YND6YuVmONIFz0N9xVoXdQ1ia2K2Ve+w6EoliP5/27HHLEyGkT6H8UxqMinhHFYAJD
	4vPfpRo3Mw25iNNkuF4zgOCHmTl5o8I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09286137CF;
	Tue,  6 May 2025 14:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /iE1AlwXGmhjSgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 May 2025 14:06:20 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.15-rc6
Date: Tue,  6 May 2025 16:06:18 +0200
Message-ID: <cover.1746539430.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1074E1F443
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi,

a few more fixes, minor updates and one revert. Please pull, thanks.

- revert device path canonicalization, this does not work as intended
  with namespaces and is not reliable in all setups

- fix crash in scrub when checksum tree is not valid, e.g. when mounted
  with rescue=ignoredatacsums

- fix crash when tracepoint btrfs_prelim_ref_insert is enabled

- other minor fixups
  - open code folio_index(), meant to be used in MM code
  - use matching type for sizeof in compression allocation

----------------------------------------------------------------
The following changes since commit e08e49d986f82c30f42ad0ed43ebbede1e1e3739:

  btrfs: adjust subpage bit start based on sectorsize (2025-04-23 08:42:10 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-rc5-tag

for you to fetch changes up to 38e541051e1d19e8b1479a6af587a7884653e041:

  btrfs: open code folio_index() in btree_clear_folio_dirty_tag() (2025-05-02 13:20:56 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: handle empty eb->folios in num_extent_folios()

Goldwyn Rodrigues (1):
      btrfs: correct the order of prelim_ref arguments in btrfs__prelim_ref

Kairui Song (1):
      btrfs: open code folio_index() in btree_clear_folio_dirty_tag()

Kees Cook (1):
      btrfs: compression: adjust cb->compressed_folios allocation type

Qu Wenruo (2):
      btrfs: avoid NULL pointer dereference if no valid csum tree
      Revert "btrfs: canonicalize the device path before adding it"

 fs/btrfs/compression.c       |  2 +-
 fs/btrfs/extent_io.c         |  4 +-
 fs/btrfs/extent_io.h         |  2 +
 fs/btrfs/scrub.c             |  4 +-
 fs/btrfs/volumes.c           | 91 +-------------------------------------------
 include/trace/events/btrfs.h |  2 +-
 6 files changed, 9 insertions(+), 96 deletions(-)

