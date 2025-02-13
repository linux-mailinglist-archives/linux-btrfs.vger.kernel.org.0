Return-Path: <linux-btrfs+bounces-11453-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AEBA34EEF
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 21:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F54216D373
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 20:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DA524BBEC;
	Thu, 13 Feb 2025 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dvPaCot+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qaDHjsEv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10C28A2CB;
	Thu, 13 Feb 2025 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476968; cv=none; b=Sr9OKO/PdCzTfpk1CnLLoRHL4ipjmQNWgcyxWCRgfjQQfmTJMd0qrWIbKDAiAkNnQ2PfPlvQBQAlCs/HYnnjU6OANaPI7XgBuNZPSiTyHRBdd7un9XtS1rxd7uiwqQ0mVGQDBXjYn/nsrDgvDIllI/QAVeq94bkcAEMzwQfofl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476968; c=relaxed/simple;
	bh=vKI+/VyZyuyXDySF2CgE26qyrB7GCzu7H7S9aWPJHOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XImTnuctdfw+U54oo3j17TH5biRYEtYfkcev8voot/hv9kq2Lj/1twUyQirUso+uGoGIk7B5qFYR3zrxY6H6ecPZS61TvBGuM3PMrGsR1YCb+p/hT1i38z42y9fKgpRdx+Dw+OlLtdtB8ZIQ0p0kJciWZ9QVgqX6fkHZpueEuQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dvPaCot+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qaDHjsEv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E68A3220CF;
	Thu, 13 Feb 2025 20:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739476964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JE7zJK9MWCb/ubVE/xyIp52g1kxFJ07FN8eQVA5JPwc=;
	b=dvPaCot+txYXRlgyLUM4Qt/vemdrBj6V9sk1Dw15Xb9iTHBv//KwWPYRKSVqcnS/zEKRvU
	K4ji6JMpoMVQyFIQ1Y8QRqHKkFK57AlcbLaITdMV3KG6VKAmUZW9pbn4aTIlxs3ErIu95C
	CCCmpu/yr1wTuize0kugQkb0kluZcyw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=qaDHjsEv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739476963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JE7zJK9MWCb/ubVE/xyIp52g1kxFJ07FN8eQVA5JPwc=;
	b=qaDHjsEv0wtyvXBezbzbAfvO1iXrq8ifCev/EqATNDoT2jjY1RixkX10YopZYRLOKDUfx9
	SmZID2jTtuSIOnRg54H9fXw1Dx25AUmG4PVSaKCaE0sBcJMf0Cv0gy7PZsYHLFad3ceDcf
	LaYa2hj3MJ9BPXpO0o3Ta+M471sU/T0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF70313874;
	Thu, 13 Feb 2025 20:02:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lh6JNuNPrmepWAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 13 Feb 2025 20:02:43 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.14-rc3
Date: Thu, 13 Feb 2025 21:02:41 +0100
Message-ID: <cover.1739475780.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E68A3220CF
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi,

please pull, a few more btrfs fixes. Thanks.

- fix stale page cache after race between readahead and direct IO write

- fix hole expansion when writing at an offset beyond EOF, the range
  will not be zeroed

- use proper way to calculate offsets in folio ranges

----------------------------------------------------------------
The following changes since commit fdef89ce6fada462aef9cb90a140c93c8c209f0f:

  btrfs: avoid starting new transaction when cleaning qgroup during subvolume drop (2025-01-23 22:34:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.14-rc2-tag

for you to fetch changes up to da2dccd7451de62b175fb8f0808d644959e964c7:

  btrfs: fix hole expansion when writing at an offset beyond EOF (2025-02-11 23:09:03 +0100)

----------------------------------------------------------------
Filipe Manana (2):
      btrfs: fix stale page cache after race between readahead and direct IO write
      btrfs: fix hole expansion when writing at an offset beyond EOF

Matthew Wilcox (Oracle) (1):
      btrfs: fix two misuses of folio_shift()

 fs/btrfs/extent_io.c | 29 ++++++++++++++++++++---------
 fs/btrfs/file.c      |  4 +---
 2 files changed, 21 insertions(+), 12 deletions(-)

