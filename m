Return-Path: <linux-btrfs+bounces-22280-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNUpAlAArmnF+gEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22280-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 00:03:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 985F523299F
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 00:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 175D7301B72F
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Mar 2026 23:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E187E3382C2;
	Sun,  8 Mar 2026 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k8em4XU8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k8em4XU8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73F351C25
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773011007; cv=none; b=tD1utY90q/+XjFxZKoy8bsoJdRY49cE/QWJxhX89Dd6BtKK6x0Oaqt+1I9y4ygLaJ/6yB8fF5pOChLW96BTqMcVxELCeAyQY7QBL9hD92xiuvwLeih+/KVHZuFNS4TIYhsaqGKmxctpMI375QsEGD1soub4TmwvwnRiH5KS0aAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773011007; c=relaxed/simple;
	bh=692exJvBxKcv6ZqYzTUiE5g6VdSC5kQqj0rp374wx5g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y6e6iY4xLhHFASFo3qAm7vMb43AtGxvMe3DsTp2J+q/J925qtnxs1jUR9Lm6yXELUIBhZCU9h93+jA+3tjaXWZu7k7CUizDx32fv59lzkMLAkXGl51WdFAvgTJf0uwABAXS/RfLwqb1RaDoCnDl/+VdLPRZmSvYwCCQK7vNNF5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k8em4XU8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k8em4XU8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E2CA5BDE3
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 23:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773010998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6Pw1YVnO5X51d32p10TF/MnZ4eag1gngmoCRo1LC29E=;
	b=k8em4XU8+se3TmPnhdQTrmOCpKRW4b1dSoBMKVLgLq3gnp0q+fTjuMkojCo8v+DE07Ina1
	o93Wu5K9fmKZi+rzyvFKzO47Pg+H/ci0E9oRwQN5AnvBwFlP0nikQfoIN4S/BC4RfX3qaM
	gh/BGn6KRsMkGHW5MLfmhqmFSFcJso4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=k8em4XU8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773010998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6Pw1YVnO5X51d32p10TF/MnZ4eag1gngmoCRo1LC29E=;
	b=k8em4XU8+se3TmPnhdQTrmOCpKRW4b1dSoBMKVLgLq3gnp0q+fTjuMkojCo8v+DE07Ina1
	o93Wu5K9fmKZi+rzyvFKzO47Pg+H/ci0E9oRwQN5AnvBwFlP0nikQfoIN4S/BC4RfX3qaM
	gh/BGn6KRsMkGHW5MLfmhqmFSFcJso4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B7DD3EBA8
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 23:03:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4DZuFzUArmkNbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 08 Mar 2026 23:03:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH PoC 0/6] btrfs: delay compression to bbio submission time
Date: Mon,  9 Mar 2026 09:32:49 +1030
Message-ID: <cover.1773009120.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 985F523299F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22280-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:mid]
X-Rspamd-Action: no action

[PROOF OF CONCEPT ONLY]
!!! There are a lot of known bugs !!!

It's only for dicussion of design choices!

[DESIGN CHOICES]
The following design choices need to be discussed:

- Is delayed ordered extent needed
  In theory we can skip the delayed ordered extent.

  But later I found it harder to handle cases like > i_size writes.
  As beyond i_size writes needs to grab the OE and manually mark them
  finished.

  Furthermore it will need extra handling for cow fixup.

  Although the current delayed OE (and its child OEs) implementation is
  complex, it requires the least amount of changes for existing code.

- Async thread vs regular workqueue
  The existing compression is done in async thread, which gives a
  special gift, the on-disk extent is mostly sequential.

  This is ensured by the ordered function of async thread, where the
  extent is allocated sequentially.

  The new PoC is using regular workqueue, can result out-of-order
  on-disk extents for compressed writes.

  The main quirk is from the fact that ordered functions require
  re-execution of the same workload with @do_free set to true.

  However in the current code we can not do the re-execution as the bbio
  can already be gone after the compressed bio is submitted.

[BACKGROUND]
Btrfs currently goes with async submission for compressed write, I'll go
the following example to explain the async submission:

The page and fs block sizes are all 4K, no large folio involved.
The dirty range is [0, 4K), [8K, 128K).

    0  4K  8K                                        128K
    |//|   |/////////////////////////////////////////|

- Write back folio 0
  * Delalloc
    writepage_delalloc() will find the delalloc range [0, 4K), and since
    it can not be inlined and too small for compression, it will be go
    through COW path, thus a new data extent is allocated, with
    corresponding EM/OE created.

  * Submission
    That folio 0 will be added into a bbio, and since we reached the OE
    end, the bbio will be submitted.

- Write back folio 8K
  * Delalloc
    writepage_delalloc() find the delalloc range [8K, 128K) and go
    compression.
    Instead of allocating an extent immediately, it queues the work into
    delalloc_workers.

    Please note that the range [8K, 128K) is completely locked during
    compression.

  * Skip submission
    As the whole folio 8K went through async submission, we skip bbio
    submission.

- Write back folio 12K
  We wait for the folio to be unlocked (after compression is done and
  compressed bio is submitted).
  When the folio is unlocked, the folio will have writeback flag set and
  its dirty flag cleared. Thus we either wait for the writeback or skip
  the folio completely.

  This step repeats for the range [8K, 128K).

AFAIK the async submission is required as we can not submit two
different bbios for a single compressed range.
Which is different from the uncompressed write path, where we can have
several different bbios for a single ordered extent.

[PROBLEMS]
The async submission has the following problems:

- Non-sequential writeback
  Especially when large folios are involved, we can have some blocks
  submitted immediately (uncompressed), and some submitted later
  (compressed).

  That breaks the assumption of iomap and DONTCACHE writes.

- Not really async
  As the example given above, we keep the whole range locked during
  compression, making later read and even writeback itself to wait.

[DELAYED COMPRESSION]
The new idea is to delay the compression at bbio submission time.
Now the workflow will be:

- Write back folio 0
  The same, submitting it immediately

- Write back folio 8K
  * Delalloc
    writepage_delalloc() find the delalloc range [8K, 128K) and go
    compression, but this time we allocated delayed EM and OE for the
    range [8K, 128K).

  * Submission
    That folio 8K will be added into a bbio, with its dirty flag removed
    and writeback flag set.

- Writeback folio 12K ~ 124K
  * Delalloc
    No new delalloc range.
 
  * Submission
    Those folios will be added to the same bbio above.
    And after the last folio 124K is queued, we reached the OE end, and
    will submit the delayed bbio.

- Delayed bbio submission
  As the bbio has a special is_delayed flag set, it will not be
  submitted directly, but queued into a workqueue for compression.

  * Compression in the workqueue
  * Real delalloc
    Now an on-disk extent is reserved. The real EM will replace the
    delayed one.
    And the real OE will be added as a child of the original delayed
    one.
  * Compressed data submission
  * Delayed bbio finish
    When all child compressed/uncompressed writes finished, the delayed
    bbio will finish.

    The full delayed OE is also finished, which will insert all of its
    child OEs into the subvolume tree.

This solves both the problems mentioned above, but is definitely way
more complex than the current async submission:

- Layered OEs
  And we need to manage the child/parent OEs properly

- Possible extra split
  Since the delayed OE is allocated first, we can still submit two
  different delayed bbio for the same OE.

  This means we can have two smaller compressed extents compared to one,
  which may reduce the compression ratio.

- More complex error handling

- Unsolved bugs
  * Em leak
  * Bytes mayuse leak (METADATA)
  * Busy inode after umount
  * More hidden

Qu Wenruo (6):
  btrfs: add skeleton for delayed btrfs bio
  btrfs: add delayed ordered extent support
  btrfs: introduce the skeleton of delayed bbio endio function
  btrfs: introduce compression for delayed bbio
  btrfs: implement uncompressed fallback for delayed bbio
  btrfs: enable experimental delayed compression support

 fs/btrfs/bio.c          |   1 +
 fs/btrfs/bio.h          |   3 +
 fs/btrfs/btrfs_inode.h  |   3 +
 fs/btrfs/extent_io.c    |  29 ++-
 fs/btrfs/extent_map.h   |   9 +-
 fs/btrfs/inode.c        | 475 +++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/ordered-data.c |  73 +++++-
 fs/btrfs/ordered-data.h |  14 ++
 8 files changed, 595 insertions(+), 12 deletions(-)

-- 
2.53.0


