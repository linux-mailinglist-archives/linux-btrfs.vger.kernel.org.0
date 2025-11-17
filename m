Return-Path: <linux-btrfs+bounces-19050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF1AC62B96
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 08:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DCB03AC9CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 07:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE2731984C;
	Mon, 17 Nov 2025 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u1aBaMuR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u1aBaMuR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DEC318143
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364675; cv=none; b=tM2t4Q9IzOxg+jqHVlJ+H8V0GBWO/qKweVY5SyLuDH68dVDcnSzk8VkYLXsWpwaOANFyJ4kEktweX2ksXpNMXLxjMxfQt/8rZkiYEsDKTTF0jyNSnfj2CnXrYKkt3XQqQlIWwNQaaFUR3knaMrH8XNgzL6MTvuQg4HsAfv4+dkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364675; c=relaxed/simple;
	bh=Ut5V/ERoEbN+skKmbbRpQEBzujClEV1fFhiiKl4vP7Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=muKuSYPf+ejIHMK+4lVWXH7VyO+JkTqD9d5WM+9507jTa2rK78InH0x/R5AOBhMnZ22LkyQvbALiQr/0+echgHLXdmJLgtZAwVPXnZEHPsY5WCnAWGjgTB3P2wbEsINEYORoEOzuEihx+eCj3J5T8L+oYmvxf+SBQQvsq7pYLbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u1aBaMuR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u1aBaMuR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D8C5211FC
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Jz4/lOCVLtbLXMGSKhgaL4TavPow07VYKXMWOtmhnPg=;
	b=u1aBaMuRi4bBduJGMUU3WKfwgJgbqxe5qy7GP8vkHDbkN0tkaJ+9ndnRkFkqjIEq4gmmeS
	DIKwT/p6k1UQ1Q4KVSz1q9QIFVpA2fTdEaKqeod9YATh9ea/qOgq3Sa/8SKGCXglgjWMse
	mworyHEK30tWVbY+cngnsx5DBDDP5Vo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Jz4/lOCVLtbLXMGSKhgaL4TavPow07VYKXMWOtmhnPg=;
	b=u1aBaMuRi4bBduJGMUU3WKfwgJgbqxe5qy7GP8vkHDbkN0tkaJ+9ndnRkFkqjIEq4gmmeS
	DIKwT/p6k1UQ1Q4KVSz1q9QIFVpA2fTdEaKqeod9YATh9ea/qOgq3Sa/8SKGCXglgjWMse
	mworyHEK30tWVbY+cngnsx5DBDDP5Vo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3BBE3EA61
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xXZbID7PGmkLIgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/12] btrfs: add raid56 support for bs > ps cases
Date: Mon, 17 Nov 2025 18:00:40 +1030
Message-ID: <cover.1763361991.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

[OVERVIEW]
This series add the missing raid56 support for the experimental bs > ps
support.

The main challenge here is the conflicts between RAID56 RMW/recovery and
data checksum.

For RAID56 RMW/recovery, the vertical stripe can only be mapped one page
one time, as the upper layer can pass bios that are not backed by large
folios (direct IO, encoded read/write/send).

On the other hand, data checksum requires multiple pages at the same
time, e.g. btrfs_calculate_block_csum_pages().

To meet both requirements, introduce a new unit, step, which is
min(PAGE_SIZE, sectorsize), and make the paddrs[] arrays in RAID56 to be
in step sizes.

So for vertical stripe related works, reduce the map size from
one sector to one step. For data checksum verification grab the pointer
from involved paddrs[] array and pass the sub-array into
btrfs_calculate_block_csum_pages().

So before the patchset, the btrfs_raid_bio paddr pointers looks like
this:

  16K page size, 4K fs block size (aka, subpage case)

                       0                   16K  ...
  stripe_pages[]:      |                   |    ...
  stripe_paddrs[]:     0    1    2    3    4    ...
  fs blocks            |<-->|<-->|<-->|<-->|    ...

  There are at least one fs block (sector) inside a page, and each
  paddrs[] entry represents an fs block 1:1.

To the new structure for bs > ps support:

  4K page size, 8K fs block size

                       0    4k   8K   12K   16K  ...
  stripe_pages[]:      |    |    |    |    |     ...
  stripe_paddrs[]:     0    1    2    3    4     ...
  fs blocks            |<------->|<------->|     ...

  Now paddrs[] entry is no longer 1:1 mapped to an fs block, but
  multiple paddrs mapped to one fs block.

The glue unit between paddrs[] and fs blocks is a step.

One fs blocks can one or more steps, and one step maps to a paddr[]
entry 1:1.

For bs <= ps cases, one step is the same as an fs block.
For bs > ps case, one step is just a page.

For RAID56, now we need one extra step iteration loop when handling an
fs block.

[TESTING]
I have tested the following combinations:

- bs=4k ps=4k x86_64
- bs=4k ps=64k arm64
  The base line to ensure no regression caused by this patchset for bs
  == ps and bs < ps cases.

- bs=8k ps=4k x86_64
  The new run for this series.

  The only new failure is related to direct IO read verification, which
  is a known one caused by no direct IO support for bs > ps cases.

I'm afraid in the long run, the combination matrix will be larger than
larger, and I'm not sure if my environment can handle all the extra bs/ps
combinations.

The long term plan is to test bs=4k ps=4k, bs=4k ps=64k, bs=8k ps=4k
cases only.

[PATCHSET LAYOUT]
Patch 1 introduces an overview of how btrfs_raid_bio structure
works.
Patch 2~10 starts converting t he existing infrastructures to use the
new step based paddr pointers.
Patch 11 enables RAID56 for bs > ps cases, which is still an
experimental feature.
The last patch removes the "_step" infix which is used as a temporary
naming during the work.

[ROADMAP FOR BS > PS SUPPORT]
The remaining feature not yet implemented for bs > ps cases is direct
IO. The needed patch in iomap is submitted through VFS/iomap tree, and
the btrfs part is a very tiny patch, will be submitted during v6.19
cycle.


Qu Wenruo (12):
  btrfs: add an overview for the btrfs_raid_bio structure
  btrfs: introduce a new parameter to locate a sector
  btrfs: prepare generate_pq_vertical() for bs > ps cases
  btrfs: prepare recover_vertical() to support bs > ps cases
  btrfs: prepare verify_one_sector() to support bs > ps cases
  btrfs: prepare verify_bio_data_sectors() to support bs > ps cases
  btrfs: prepare set_bio_pages_uptodate() to support bs > ps cases
  btrfs: prepare steal_rbio() to support bs > ps cases
  btrfs: prepare rbio_bio_add_io_paddr() to support bs > ps cases
  btrfs: prepare finish_parity_scrub() to support bs > ps cases
  btrfs: enable bs > ps support for raid56
  btrfs: remove the "_step" infix

 fs/btrfs/disk-io.c |   6 -
 fs/btrfs/raid56.c  | 711 ++++++++++++++++++++++++++++-----------------
 fs/btrfs/raid56.h  |  87 ++++++
 3 files changed, 535 insertions(+), 269 deletions(-)

-- 
2.51.2


