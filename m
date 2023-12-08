Return-Path: <linux-btrfs+bounces-758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9B580A008
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 10:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88771F216BF
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 09:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B8212B9F;
	Fri,  8 Dec 2023 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JLPG8uNS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JLPG8uNS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3B91727
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Dec 2023 01:54:45 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B3F8A1F38C
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Dec 2023 09:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702029283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AdDur/W0tRWLIQ4HH2cD32xk2gd00S8K6OtrKywzi4Q=;
	b=JLPG8uNSsXBbudcI3IKDTCB6BxT12d12059j5PntLYnZXXmyVlI/uRuWgxUy2K19wKaecI
	LXGB3m7dXC6xFBdyKCLyx4UMNcPUelm0OioVLtYMwhWSHkWKZKxapi9raGsyfIs3XP6AJF
	+ksjsjAjMUZVDOmwpQxJYBdn33ME1mo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702029283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AdDur/W0tRWLIQ4HH2cD32xk2gd00S8K6OtrKywzi4Q=;
	b=JLPG8uNSsXBbudcI3IKDTCB6BxT12d12059j5PntLYnZXXmyVlI/uRuWgxUy2K19wKaecI
	LXGB3m7dXC6xFBdyKCLyx4UMNcPUelm0OioVLtYMwhWSHkWKZKxapi9raGsyfIs3XP6AJF
	+ksjsjAjMUZVDOmwpQxJYBdn33ME1mo=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AA58013B42
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Dec 2023 09:54:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EKuNFeLncmUnRgAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 08 Dec 2023 09:54:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: migrate IO path to folios
Date: Fri,  8 Dec 2023 20:24:20 +1030
Message-ID: <cover.1702028578.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.71
X-Spam-Flag: NO
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 1.90

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

  - meta

  - compressed
    For compressed IO and encoded IO.

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
 fs/btrfs/extent_io.c        | 361 +++++++++++++++++++-----------------
 fs/btrfs/extent_io.h        |  40 ++--
 fs/btrfs/file.c             |  13 +-
 fs/btrfs/free-space-cache.c |   4 +-
 fs/btrfs/inode.c            |  34 ++--
 fs/btrfs/ordered-data.c     |   5 +-
 fs/btrfs/reflink.c          |   6 +-
 fs/btrfs/relocation.c       |   5 +-
 fs/btrfs/subpage.c          | 304 +++++++++++++++---------------
 fs/btrfs/subpage.h          |  74 ++++----
 15 files changed, 499 insertions(+), 462 deletions(-)

-- 
2.43.0


