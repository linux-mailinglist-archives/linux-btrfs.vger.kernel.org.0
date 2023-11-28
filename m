Return-Path: <linux-btrfs+bounces-417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6567FC069
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 18:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9E52809A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 17:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A78539AD7;
	Tue, 28 Nov 2023 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b1Pp+ndv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10481D5B;
	Tue, 28 Nov 2023 09:40:14 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 92E06219A6;
	Tue, 28 Nov 2023 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701193212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vAnAMESl/RBl5agN44vVIGlcM5QSzJDmBjb6iA6A5vA=;
	b=b1Pp+ndv/UVUOUZq50Z7179KQ7WWCW7i1BKysBKsGD4JigbE46gU3Q/askHemVvPTC6vV2
	XKF7pFlTHR1R5sLxbPOaR9p2vAJw3eZ7VGtDQEscH3ZC8n/dkrAHWqOMQoPihCxs5F0cho
	YD9JocMe6yDGMyxq/BN613cgKzgv/Us=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 6211F2C152;
	Tue, 28 Nov 2023 17:40:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 78178DA86C; Tue, 28 Nov 2023 18:32:59 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.7-rc4
Date: Tue, 28 Nov 2023 18:32:56 +0100
Message-ID: <cover.1701191460.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++++++++
X-Spam-Score: 21.50
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	spf=pass (smtp-out1.suse.de: domain of dsterba@suse.cz designates 149.44.160.134 as permitted sender) smtp.mailfrom=dsterba@suse.cz;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: 92E06219A6
X-Spamd-Result: default: False [21.50 / 50.00];
	 RDNS_NONE(1.00)[];
	 SPAMHAUS_XBL(0.00)[149.44.160.134:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 R_SPF_ALLOW(-0.20)[+ip4:149.44.0.0/16];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
	 MX_GOOD(-0.01)[];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_NO_TLS_LAST(0.10)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
	 BAYES_HAM(-3.00)[100.00%];
	 RDNS_DNSFAIL(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_TWO(0.00)[2];
	 HFILTER_HOSTNAME_UNKNOWN(2.50)[]

Hi,

there are a few fixes and message updates. Please pull, thanks.

- fixes:

  - for simple quotas, handle the case when a snapshot is created and
    the target qgroup already exists

  - fix a warning when file descriptor given to send ioctl is not writable

  - fix off-by-one condition when checking chunk maps

  - free pages when page array allocation fails during compression read,
    other cases were handled

  - fix memory leak on error handling path in ref-verify debugging feature

  - copy missing struct member 'version' in 64/32bit compat send ioctl

- other updates

  - tree-checker verifies inline backref ordering

  - print messages to syslog on first mount and last unmount

  - update error messages when reading chunk maps

----------------------------------------------------------------
The following changes since commit d3933152442b7f94419e9ea71835d71b620baf0e:

  btrfs: make OWNER_REF_KEY type value smallest among inline refs (2023-11-09 14:02:12 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-rc3-tag

for you to fetch changes up to 0ac1d13a55eb37d398b63e6ff6db4a09a2c9128c:

  btrfs: send: ensure send_fd is writable (2023-11-24 18:50:53 +0100)

----------------------------------------------------------------
Bragatheswaran Manickavel (1):
      btrfs: ref-verify: fix memory leaks in btrfs_ref_tree_mod()

David Sterba (1):
      btrfs: fix 64bit compat send ioctl arguments not initializing version member

Filipe Manana (2):
      btrfs: fix off-by-one when checking chunk map includes logical address
      btrfs: make error messages more clear when getting a chunk map

Jann Horn (1):
      btrfs: send: ensure send_fd is writable

Qu Wenruo (4):
      btrfs: tree-checker: add type and sequence check for inline backrefs
      btrfs: do not abort transaction if there is already an existing qgroup
      btrfs: add dmesg output for first mount and last unmount of a filesystem
      btrfs: free the allocated memory if btrfs_alloc_page_array() fails

 fs/btrfs/disk-io.c      |  1 +
 fs/btrfs/extent_io.c    | 11 ++++++++---
 fs/btrfs/ioctl.c        |  1 +
 fs/btrfs/ref-verify.c   |  2 ++
 fs/btrfs/send.c         |  2 +-
 fs/btrfs/super.c        |  5 ++++-
 fs/btrfs/transaction.c  |  2 +-
 fs/btrfs/tree-checker.c | 39 +++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c      |  9 +++++----
 9 files changed, 62 insertions(+), 10 deletions(-)

