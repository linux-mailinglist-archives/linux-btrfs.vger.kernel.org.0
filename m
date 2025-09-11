Return-Path: <linux-btrfs+bounces-16787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F17C1B5282C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Sep 2025 07:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A400B467F72
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Sep 2025 05:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4612472B0;
	Thu, 11 Sep 2025 05:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u0aBR+qo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RrdhvjXv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF7B238C04
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Sep 2025 05:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757569089; cv=none; b=ga9nhiilqCVINmsIfFqRU8NIFmO9Y9sqgNf78XDD7izbFzDYqyaS3Od8Z9sFJrTqhKOWDf+XfgImdP7Wk7LLd+cPS/qo3h3uaOvOA/CLiXmq/NNYjR/kVulx3g8D18c56LeY3yGzmDDgiA9FcYL1PqbAPz5OesuchKN9vBBlyN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757569089; c=relaxed/simple;
	bh=6EPgqrptUY7/bjRCLLyVLU30q+TjsMiYsBN8nnapNiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=htpNLKsQ9SVO1okyUDCrMFFcI9frorkIEwfZQFT6ymfCXFOXg5NTxPGg50eFo0MpTQiVIV5x53TR+EejikJGyqOAAAMWpFJtYbRZIPePYNhdXOXE5L8KXIlHdQjd/qjJOmlajDbxBAbw5F6T3Jag+87MrPRe2lV+yvRYIL+kl1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u0aBR+qo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RrdhvjXv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FE1538AB3;
	Thu, 11 Sep 2025 05:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757569084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8gMgISr+SkPeVPyaKXbnF0rlHGMHN1R4BL10DmtpUzI=;
	b=u0aBR+qoOecCH6XSY7aCEtXwbZrGvieBnppeH1jenL1q3uoUUBPvQeM/jgXACAFh/ZhivZ
	n5waudRZPKEVoMAxtfCWbq3n7w9FpYJ+79EOQKwjOs0l/kYuG/YCOHEDiLBMTK1sJAGMEO
	omMBP8sjnuJJK4XdUJVmamFyLaPX6MY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757569083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8gMgISr+SkPeVPyaKXbnF0rlHGMHN1R4BL10DmtpUzI=;
	b=RrdhvjXvdxqyy2iwPJ+QAuNQ6bu5cEu7vC1yu1NSx+oXppSdjceg++2YZZHTjwdrtHmih2
	NdymXN1lSTIhNtQoYL5zX8zxgifErxEY/s/BccEwi/pYFATqw72kuhYyCFyEZCw37mFmN0
	Of6iUkdO+PNc2zRy78HwNXj/V7GFuuw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4715F13301;
	Thu, 11 Sep 2025 05:38:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hTYUETtgwmicPAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 11 Sep 2025 05:38:03 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.17-rc6
Date: Thu, 11 Sep 2025 07:37:37 +0200
Message-ID: <cover.1757568026.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Hi,

please pull a few more fixes for btrfs. Thanks.

- fix delayed inode tracking in xarray, eviction can race with insertion
  and leave behind a disconnected inode

- on systems with large page (64K) and small block size (4K) fix
  compression read that can return partially filled folio

- slightly relax compression option format for backward compatibility,
  allow to specify level for LZO although there's only one

- fix simple quota accounting of compressed extents

- validate minimum device size in 'device add'

- update maintainers' entry

----------------------------------------------------------------
The following changes since commit 986bf6ed44dff7fbae7b43a0882757ee7f5ba21b:

  btrfs: avoid load/store tearing races when checking if an inode was logged (2025-08-22 00:58:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc5-tag

for you to fetch changes up to 3d1267475b94b3df7a61e4ea6788c7c5d9e473c4:

  btrfs: don't allow adding block device of less than 1 MB (2025-09-05 19:52:10 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: fix squota compressed stats leak

Calvin Owens (1):
      btrfs: accept and ignore compression level for lzo

Josef Bacik (1):
      MAINTAINERS: update btrfs entry

Mark Harmstone (1):
      btrfs: don't allow adding block device of less than 1 MB

Omar Sandoval (1):
      btrfs: fix subvolume deletion lockup caused by inodes xarray race

Qu Wenruo (1):
      btrfs: fix corruption reading compressed range when block size is smaller than page size

 MAINTAINERS          |  1 -
 fs/btrfs/extent_io.c | 40 ++++++++++++++++++++++++++++++----------
 fs/btrfs/inode.c     | 12 +++++++++++-
 fs/btrfs/qgroup.c    |  6 ++++--
 fs/btrfs/super.c     |  9 ++++++---
 fs/btrfs/volumes.c   |  5 +++++
 6 files changed, 56 insertions(+), 17 deletions(-)

