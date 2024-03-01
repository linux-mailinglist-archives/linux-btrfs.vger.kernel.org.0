Return-Path: <linux-btrfs+bounces-2966-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BE786E26B
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 14:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81F1282CFE
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 13:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633196E604;
	Fri,  1 Mar 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZTyIUkrH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZTyIUkrH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D576E5E6;
	Fri,  1 Mar 2024 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300410; cv=none; b=qKM33Rr0CBwZ2W9bq8hRc23PdN5Oqnhac5ARpO4AHXPG0OKbwteHxZWJoeckBzEl8z1ftTIhZfzuoEdlg5PkcyTQAbmiqSH6AL/Lv1/yuozv9OSnQuf2uNnbQwp+yPWmwP5h1acJ90+HKC4RCLLveA9vvVJaDGWxgKHospOPP5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300410; c=relaxed/simple;
	bh=/Hcui98i45tL/akTfhBkadYuzPXQg8gyV3keWHPuFnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDRdxut3JVmm2hGGYcF2Tmu3Q7OKs1/U6RUWGF4N0tjAzszys9axurKx3cWUFZF05RE2/WSfpr1Szxs+5lMdGSAc0eF9JdY6xAkitpIaRUTxoSN6ftDvsOhmKkDl0jA0bTaTaODXVyabg78yYzEKwsiOfxK/y5SLm8JLf18V6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZTyIUkrH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZTyIUkrH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C4422204AB;
	Fri,  1 Mar 2024 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709300405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zj+zGP9Sa++I+q72KNtMQR36SXcnafQVnmCmlX6WdUc=;
	b=ZTyIUkrHyzhNBDGRRf/mubcHGpcRwB1hdaIVVWgjZN8oX9vv6tRz1+69zTtjh8ukOBvLbU
	lAazvUUQXHYbIatwCjPNDZu/0tri8o3toz3/Q71n6xncalfubGIntkVDr/9H2LWKGEGxMt
	F1WwusGOfJpNkZPh2UMj9AUHA0Sdkmo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709300405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zj+zGP9Sa++I+q72KNtMQR36SXcnafQVnmCmlX6WdUc=;
	b=ZTyIUkrHyzhNBDGRRf/mubcHGpcRwB1hdaIVVWgjZN8oX9vv6tRz1+69zTtjh8ukOBvLbU
	lAazvUUQXHYbIatwCjPNDZu/0tri8o3toz3/Q71n6xncalfubGIntkVDr/9H2LWKGEGxMt
	F1WwusGOfJpNkZPh2UMj9AUHA0Sdkmo=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BDC2C13A39;
	Fri,  1 Mar 2024 13:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id rz1OLrXa4WUXVwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Fri, 01 Mar 2024 13:40:05 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.8-rc7, part 2
Date: Fri,  1 Mar 2024 14:32:55 +0100
Message-ID: <cover.1709299316.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.71
X-Spamd-Result: default: False [3.71 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.19)[-0.961];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[40.44%]
X-Spam-Flag: NO

Hi,

a few more fixes. Please pull, thanks.

- fix freeing allocated id for anon dev when snapshot creation fails

- fiemap fixes
  - followup for a recent deadlock fix, ranges that fiemap can access
    can still race with ordered extent completion
  - make sure fiemap with SYNC flag does not race with writes

----------------------------------------------------------------
The following changes since commit c7bb26b847e5b97814f522686068c5628e2b3646:

  btrfs: fix data race at btrfs_use_block_rsv() when accessing block reserve (2024-02-22 12:15:12 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc6-tag

for you to fetch changes up to e2b54eaf28df0c978626c9736b94f003b523b451:

  btrfs: fix double free of anonymous device after snapshot creation failure (2024-02-29 22:34:11 +0100)

----------------------------------------------------------------
Filipe Manana (3):
      btrfs: fix race between ordered extent completion and fiemap
      btrfs: ensure fiemap doesn't race with writes when FIEMAP_FLAG_SYNC is given
      btrfs: fix double free of anonymous device after snapshot creation failure

 fs/btrfs/disk-io.c     |  22 ++++-----
 fs/btrfs/disk-io.h     |   2 +-
 fs/btrfs/extent_io.c   | 124 +++++++++++++++++++++++++++++++++++++++++--------
 fs/btrfs/inode.c       |  22 ++++++++-
 fs/btrfs/ioctl.c       |   2 +-
 fs/btrfs/transaction.c |   2 +-
 6 files changed, 139 insertions(+), 35 deletions(-)

