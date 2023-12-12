Return-Path: <linux-btrfs+bounces-831-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 621B080E1E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 03:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93737B216E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 02:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA16AD53;
	Tue, 12 Dec 2023 02:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L8xBiWbH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jlXVpez5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761C7109
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 18:28:59 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C80051FC83
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 02:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702348138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=B6WCJcyclvbMTNN7tMDH/BTzCLiUt6kbY4vOt/E/G/8=;
	b=L8xBiWbH9sg/4TpaYPdwt/AHUI8Ud2F2WBOb1NwnWE5qqAoNG7pgmWBwCagq09JwWE3e7t
	uCkPl4KL0xDwU1BZMcRmaPj/qjRSw1u5hrTao0A022Fb0rOJr2QxdvB6Q9hf7BNoJm/C4L
	62xTbSS7i/7zovd3mSWezoHQ3cP+q50=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702348137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=B6WCJcyclvbMTNN7tMDH/BTzCLiUt6kbY4vOt/E/G/8=;
	b=jlXVpez5pwKtepch2MP3KdbN3OAbnol96opvHLCCKcTwnT3uTWd5ZfsAlJDR1m/IpaZQ+9
	L3Lj4C3zvx6j1v0LgewA+KzHk4E2nixnGOjVc414xhDTZmj77NWR+HcWAa6ELEoKtReTST
	+kZ1V7+gWwsSobpPcqIN0tix3LrISw8=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BF5A713463
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 02:28:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id RxWVGmjFd2WtHQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 02:28:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: migrate IO path to folios
Date: Tue, 12 Dec 2023 12:58:35 +1030
Message-ID: <cover.1702347666.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 18.34
X-Spamd-Result: default: False [1.09 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 ARC_NA(0.00)[];
	 R_SPF_FAIL(0.00)[-all];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 WHITELIST_DMARC(-7.00)[suse.com:D:+];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spamd-Bar: +
X-Rspamd-Server: rspamd1
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C80051FC83
X-Spam-Score: 1.09
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=jlXVpez5;
	spf=fail (smtp-out2.suse.de: domain of wqu@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=wqu@suse.com;
	dmarc=pass (policy=quarantine) header.from=suse.com

[CHANGELOG]
v2:
- Fix a PAGE_SHIFT usage in the 3rd patch on the data read path
  I know this won't be touched any time soon, but considering it's
  really one patch away from enabling higher order folios for metadata,
  let's make the cleanup closer to perfection.


One critical problem I hit the most during my initial higher order
folios tests are, incorrect access to the pages which conflicts with the
page flag policy.

Since folio flags are only set to certain pages according to their
policies (PF_ANY, PF_HEAD, PF_ONLY_HEAD, PF_NO_TAIL, PF_NO_COMPOUND and
the most weird on PF_SECOND), setting page flags violating the policy
would immedate lead to VM_BUG_ON().

Thus no matter if we go compound page or folio, we can not go the
page-by-page iteration helpers that easily.
One of the hot spots which can lead to VM_BUG_ON()s are the endio
helpers.

So this patch would:

- Make metadata set/get helpers to utilize folio interfaces

- Make subpage code to accept folios directly
  This is to avoid btrfs_page_*() helpers to accept page pointers, which
  is another hot spot which uses page pointer a lot.

- Migrate btrfs bio endio functions to utilize bio_for_each_folio_all()
  This completely removes the ability to direct access page pointers.
  Although we still need some extra folio_page(folio, 0) calls to keep
  compatible with existing helpers.

  And since we're here, also fix the choas of btrfs endio functions'
  naming scheme, now it would always be:
    end_bbio_<target>_(read|write)
  The <target> can be:

  - data
    For non-compressed and non-encoeded operations

  - compressed
    For compressed IO and encoded IO.

  - meta

  And since compressed IO path is utilizing unmapped pages (pages
  without an address_space), thus they don't touch the page flags.
  This makes compressed IO path a very good test bed for the initial
  introduction of higher order folio.

Qu Wenruo (3):
  btrfs: migrate get_eb_page_index() and get_eb_offset_in_page() to
    folios
  btrfs: migrate subpage code to folio interfaces
  btrfs: migrate various btrfs end io functions to folios

 fs/btrfs/accessors.c        |  80 ++++----
 fs/btrfs/compression.c      |  15 +-
 fs/btrfs/ctree.c            |  13 +-
 fs/btrfs/defrag.c           |   3 +-
 fs/btrfs/disk-io.c          |   4 +-
 fs/btrfs/extent_io.c        | 363 +++++++++++++++++++-----------------
 fs/btrfs/extent_io.h        |  40 ++--
 fs/btrfs/file.c             |  13 +-
 fs/btrfs/free-space-cache.c |   4 +-
 fs/btrfs/inode.c            |  34 ++--
 fs/btrfs/ordered-data.c     |   5 +-
 fs/btrfs/reflink.c          |   6 +-
 fs/btrfs/relocation.c       |   5 +-
 fs/btrfs/subpage.c          | 304 ++++++++++++++----------------
 fs/btrfs/subpage.h          |  74 ++++----
 15 files changed, 500 insertions(+), 463 deletions(-)

-- 
2.43.0


