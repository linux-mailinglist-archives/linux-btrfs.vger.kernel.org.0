Return-Path: <linux-btrfs+bounces-7022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEE394A8C1
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961221C22DF2
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 13:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AD8200100;
	Wed,  7 Aug 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="unH2wi2m";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="unH2wi2m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8FA1EA0AE;
	Wed,  7 Aug 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038030; cv=none; b=K/FJO8XTq2yvKouWkTArf6Aboeud4koetRkyKKF0PkgkcpAa/yiCV663W9wXj4uZ9Fyh6Fb0uouWqeGAo5Q9TJ9A5kMe/DSF+lkkH3cdquHnbWAPXvpteQDpXxtlX8lDtaw2/9mcK3s1PKGuHVlGOTyrhHQHpQfFEeTQ+eX07KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038030; c=relaxed/simple;
	bh=xlq8QXlO+yghFU1rwjZ8V/mZoIA8/cUHHtJYoAlRuzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u8VhGCVkKwW3E5EgUFiwP1K4XqoDpYkAMEOl6C0Nrf7dKIqQeN2LDTKtCXLP+1VIJsgNZ4G+/TS+rmavGz82E7BBuB0fuqTuhUmgKHjRUviUni9dGNXw0YsqsZ7g6m0exl/363hJMuiu0UvrGNk6nmzotPCTh92BzZr2R0RC84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=unH2wi2m; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=unH2wi2m; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A41D81FB92;
	Wed,  7 Aug 2024 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723038026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D/hzxygWO4Mvx0mpri2Uoaj7ElaMLljcwjYxSPP3ZuA=;
	b=unH2wi2myC/Vhq4DcMt2t0hB/NIyk1jZWxYSocR2hiOTVPjB6GWGLYL4L+5RMTlK64IUH0
	9y4ptKM9BxdXiTh/fHdf8WI8xqCTUtkDjspcgV6mCW1NKTaUe8GcX0ydy7CJzoTy+0uXu+
	vQX5Hb9qBMpZrZjAvP/5+MoORncBL/I=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723038026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D/hzxygWO4Mvx0mpri2Uoaj7ElaMLljcwjYxSPP3ZuA=;
	b=unH2wi2myC/Vhq4DcMt2t0hB/NIyk1jZWxYSocR2hiOTVPjB6GWGLYL4L+5RMTlK64IUH0
	9y4ptKM9BxdXiTh/fHdf8WI8xqCTUtkDjspcgV6mCW1NKTaUe8GcX0ydy7CJzoTy+0uXu+
	vQX5Hb9qBMpZrZjAvP/5+MoORncBL/I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DB9613A7D;
	Wed,  7 Aug 2024 13:40:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IOB8Jkp5s2ZWWAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 07 Aug 2024 13:40:26 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.11-rc3
Date: Wed,  7 Aug 2024 15:40:22 +0200
Message-ID: <cover.1723037280.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30

Hi,

a few regular fixes. Please pull, thanks.

- fix double inode unlock for direct IO sync writes (reported by syzbot)

- fix root tree id/name map definitions, don't use fixed size buffers
  for name (reported by -Werror=unterminated-string-initialization)

- fix qgroup reserve leaks in bufferd write path

- update scrub status structure more often so it can be reported in user
  space more accurately and let 'resume' not repeat work

- in preparation to remove space chache v1 in the future print a warning
  if it's detected

----------------------------------------------------------------
The following changes since commit b8e947e9f64cac9df85a07672b658df5b2bcff07:

  btrfs: initialize location to fix -Wmaybe-uninitialized in btrfs_lookup_dentry() (2024-07-30 15:33:06 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc2-tag

for you to fetch changes up to 12653ec36112ab55fa06c01db7c4432653d30a8d:

  btrfs: avoid using fixed char array size for tree names (2024-08-02 22:44:27 +0200)

----------------------------------------------------------------
Boris Burkov (2):
      btrfs: implement launder_folio for clearing dirty page reserve
      btrfs: fix qgroup reserve leaks in cow_file_range

Filipe Manana (1):
      btrfs: fix double inode unlock for direct IO sync writes

Josef Bacik (1):
      btrfs: emit a warning about space cache v1 being deprecated

Qu Wenruo (3):
      btrfs: factor out stripe length calculation into a helper
      btrfs: scrub: update last_physical after scrubbing one stripe
      btrfs: avoid using fixed char array size for tree names

 fs/btrfs/file.c       |  5 ++++-
 fs/btrfs/inode.c      | 10 ++++++++++
 fs/btrfs/print-tree.c |  2 +-
 fs/btrfs/scrub.c      | 25 +++++++++++++++++++------
 fs/btrfs/super.c      |  5 ++++-
 5 files changed, 38 insertions(+), 9 deletions(-)

