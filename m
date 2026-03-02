Return-Path: <linux-btrfs+bounces-22162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNucIXUZpmmeKQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22162-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 00:12:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F250B1E6660
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 00:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A49530584D0
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 23:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C8B31F9BA;
	Mon,  2 Mar 2026 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="lZQ6wxTf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BrObe3a3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3FE31F9A9
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 23:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772493095; cv=none; b=fOCO5aTaL/I1JFCtnHTvYvn56LXavkvomi/r6ftXEpCniJ/FrPeoz/jzgsW9TuHo3FVDRPL2LvOKXj9smPLxfgD/V7PcG0+7P+VLvhLB0jClchg4ffcBmcCHZcQLycAsD3IGhETdlkwP6XKP6AiV0zsOvT43xP3sNkdgA4gWfNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772493095; c=relaxed/simple;
	bh=cr5LIWKt47kjJvZ9yxt4F8UVkRIHj+Gaue1IwuOEyY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SD7uyGiVIjAyHZcoi50SCDgaLmhmQzOfqikyIk5KUgaSOpSpX9B29rqqwbuDkn96qmLAyffxfcg+uK3mjLGOAMPx0FMk+7/WJwWVvgfmCHeVh+2zB4SiiHu91+3K8SdeweAVAdLOi6tnq4DPp/I3i+Zk60Y1NkRQlTolMNBC0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=lZQ6wxTf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BrObe3a3; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 977C51D00225;
	Mon,  2 Mar 2026 18:11:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 02 Mar 2026 18:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772493092; x=1772579492; bh=+yVjZns21u
	C5mZ4ftsdby193M8ItaZ0LZRu7LwHEXpo=; b=lZQ6wxTfdXsHW8v7HShcdfBu3E
	BiqWcQz0XU336nU9HVjN5ei85oIchJGSMy+cejc+CQ7mFHXFQxvlnDCUgaeowCD2
	ix1N8p4lUn0bY+Jsi0t0CjhFyEMrmbMGScgXW3YvA7qpXurCLBr12wRtEEGiNSEd
	GY8hlNkSaw5/ZkV+fhZc5pSyn5Z9mCLRaWiVDLcEl4iMRvzKYmTSPFMjzAb4065K
	iM+dz4N2+39xNouVhYmdnVWBxDcJKcLQ8nF1aUOoX4V1WeF7OKcvoJtUzkOxphFS
	WAliPrxP11lvtEW7CtggR8aJ+bHbbgriIjLWNU3T5jIbDyEINJsSd0HG0dqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772493092; x=1772579492; bh=+yVjZns21uC5mZ4ftsdby193M8ItaZ0LZRu
	7LwHEXpo=; b=BrObe3a3+5t09ygveAsA2F1R+HaWM7EPipxJ9JWCii/lKzf/AbF
	ROk6O1WW7nJTJJgBO08Y/dcyzf2iwAg52gdpCuu74Kj8Fd1BDV/INp4kUGcBozez
	FHvGzzsi10FibBj9Y9FjsfMlIarNulFaap9JAdEWKkcPhbUkRlvyx1OENg2DQ3ul
	yItwtLYHg2FEt0yLd46eqmkUCVmcEn7iLYN7QPWhETvy+uHZaN2wUaYkVO79zp2g
	9Lic/IE/IeOQSrfHtQUVIbRPirGbgMkskAOfc7Hs84kqQV9ejpl3+sJyONYMBVE9
	/qRCT8z5rztfEparWhNVOawgahsDRco/u+w==
X-ME-Sender: <xms:JBmmaeoA5AZIkMouKFc5R3eZ_t5cwnHU0L73OYGcNY6QHU4RwUz21A>
    <xme:JBmmaUGXcD23-b4mrYI2VKfHDLpQxz_9CxQ7Zb2zHufN9F5ZRiHLTDZ4uHUzawpbM
    QTFvS22KsH0HyrS33bSrem3oREDKjz4DTSlc_qOxAfBQ7_Qn4Zo5Tg>
X-ME-Received: <xmr:JBmmaQnVPlPqWZrrLYEH4CgYP8ILGdNEh9tWcxqVAbdTXJUZVRvzV2ijozaMQPq10pxSjHc_8cGOsRxCKugbezBwMnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlohgvmhhrrgdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:JBmmaXlOPQAkvOZwol39EEJq41nMhZfs2DsI5szBVbZF1phXytZWug>
    <xmx:JBmmaRubiN4a2SuxdWsytmZTeZJbHgO53DuVVXOwL1X9rvFmM7dAhA>
    <xmx:JBmmaanN-ew4bNYC5yrsFFpXV6wnQq3ZFcx5igMBqS3a0vtA6y_K2w>
    <xmx:JBmmactwwej5M2STRhlrfF5_Bmrqoea_wR4G-pPkPSlLCuV2laMSNg>
    <xmx:JBmmaamVeZSr4LZjiR4OeBMEozlV05oYZSCl0eIcv16H10EWYeoVAoBp>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 18:11:31 -0500 (EST)
Date: Mon, 2 Mar 2026 15:12:16 -0800
From: Boris Burkov <boris@bur.io>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 0/3] btrfs: fix COW amplification under memory pressure
Message-ID: <20260302231216.GA78195@zen.localdomain>
References: <cover.1772097864.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772097864.git.loemra.dev@gmail.com>
X-Rspamd-Queue-Id: F250B1E6660
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22162-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[bur.io];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zen.localdomain:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim,bur.io:dkim]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 01:51:05AM -0800, Leo Martins wrote:
> I've been investigating a pattern where COW amplification under memory
> pressure exhausts the transaction block reserve, leading to spurious
> ENOSPCs on filesystems with plenty of unallocated space.
> 
> The pattern is:
> 
>  1. btrfs_search_slot() begins tree traversal with cow=1
>  2. Node at level N needs COW (old generation or WRITTEN flag set)
>  3. btrfs_cow_block() allocates new block, copies data, updates
>     parent pointer
>  4. Traversal hits a condition requiring restart (node not cached,
>     lock contention, need higher write_lock_level)
>  5. btrfs_release_path() releases all locks and references
>  6. Memory pressure triggers writeback on the COW'd block
>  7. lock_extent_buffer_for_io() clears EXTENT_BUFFER_DIRTY and sets
>     BTRFS_HEADER_FLAG_WRITTEN
>  8. goto again - traversal restarts from root
>  9. Traversal reaches the same tree node
>  10. should_cow_block() sees WRITTEN flag, returns true
>  11. btrfs_cow_block() allocates yet another new block, copies data,
>      updates parent pointer again, consuming another reservation
>  12. Steps 4-11 repeat under sustained memory pressure
> 
> This series fixes the problem with two complementary approaches:
> 
> Patch 1 implements Filipe's suggestion of overwriting in place. When
> should_cow_block() encounters a WRITTEN buffer whose generation matches
> the current transaction, it re-dirties the buffer and returns false
> instead of requesting a COW. This is crash-safe because the committed
> superblock does not reference buffers allocated in the current
> transaction. Log trees, zoned devices, FORCE_COW, relocation, and
> buffers mid-writeback are excluded. Beyond improving the amplification
> bug, this is a general optimization for the entire transaction lifetime:
> any time writeback runs during a transaction, revisiting the same path
> no longer triggers unnecessary COW, reducing extent allocation overhead,
> memory copies, and space usage per transaction.
> 
> Patch 2 inhibits writeback on COW'd buffers for the lifetime of the
> transaction handle. This prevents WRITTEN from being set while a
> handle holds a reference to the buffer, avoiding unnecessary re-COW
> at its source. Only WB_SYNC_NONE (background/periodic flusher
> writeback) is inhibited. WB_SYNC_ALL (data-integrity writeback from
> btrfs_sync_log() and btrfs_write_and_wait_transaction()) always
> proceeds, which is required for correctness in the fsync path where
> log tree blocks must be written while the inhibiting handle is still
> active.
> 
> Both approaches are independently useful. The overwrite path is a
> general optimization that eliminates unnecessary COW across the entire
> transaction, not just within a single handle. Writeback inhibition
> prevents the problem from occurring in the first place and is the
> only fix for log trees and zoned devices where overwrite does not
> apply. Together they provide defense in depth against COW
> amplification.
> 
> Patch 3 adds a tracepoint for tracking search slot restarts.
> 
> Note: Boris's AS_KERNEL_FILE changes prevent cgroup-scoped reclaim
> from targeting extent buffer pages, making this harder to trigger via
> per-cgroup memory limits. I was able to reproduce the amplification
> using global memory pressure (drop_caches, root cgroup memory.reclaim,
> memory hog) with concurrent filesystem operations.
> 
> Benchmark: concurrent filesystem operations under aggressive global
> memory pressure. COW counts measured via bpftrace.
> 
>   Approach                   Max COW count   Num operations
>   -------                    -------------   --------------
>   Baseline                              35   -
>   Overwrite only                        19   ~same
>   Writeback inhibition only              5   ~2x
>   Combined (this series)                 4   ~2x

I applied Filipe's suggestion of the lock assert and removing a comment
in patch 2 and pushed the series to for-next.

Thanks,
Boris

> 
> Changes since v3:
> 
> Patch 2:
>  - Also inhibit writeback in should_cow_block() when COW is skipped,
>    so that every transaction handle that reuses a COW'd buffer inhibits
>    its writeback, not just the handle that originally COW'd it
> 
> Changes since v2:
> 
> Patch 1:
>  - Add smp_mb__before_atomic() before FORCE_COW check (Filipe, Sun YangKai)
>  - Hoist WRITEBACK, RELOC, FORCE_COW checks before WRITTEN block (Sun YangKai)
>  - Update dirty_pages comment for qgroup_account_snapshot() (Filipe)
>  - Relax btrfs_mark_buffer_dirty() lockdep assertion to accept read locks
>  - Use btrfs_mark_buffer_dirty() instead of set_extent_buffer_dirty()
>  - Remove folio_test_dirty() debug assertion (concurrent reader race)
> 
> Patch 2:
>  - Fix comment style (Filipe)
> 
> Patch 3:
>  - Replace counters with per-restart-site tracepoint (Filipe)
> 
> Changes since v1:
> 
> The v1 patch used a per-btrfs_search_slot() xarray to track COW'd
> buffers. Filipe pointed out this was too complex and too narrow in
> scope, and suggested overwriting in place instead. Qu raised the
> concern that other btrfs_cow_block() callers outside of search_slot
> would not be covered. Boris suggested transaction-handle-level scope
> as an alternative.
> 
> v2 implemented both overwrite-in-place and writeback inhibition at
> the transaction handle level. The per-search-slot xarray was replaced
> by a per-transaction-handle xarray, which covers all
> btrfs_force_cow_block() callers.
> 
> Leo Martins (3):
>   btrfs: skip COW for written extent buffers allocated in current
>     transaction
>   btrfs: inhibit extent buffer writeback to prevent COW amplification
>   btrfs: add tracepoint for search slot restart tracking
> 
>  fs/btrfs/ctree.c             | 106 ++++++++++++++++++++++++++++-------
>  fs/btrfs/disk-io.c           |   2 +-
>  fs/btrfs/extent_io.c         |  67 ++++++++++++++++++++--
>  fs/btrfs/extent_io.h         |   6 ++
>  fs/btrfs/transaction.c       |  19 +++++++
>  fs/btrfs/transaction.h       |   3 +
>  include/trace/events/btrfs.h |  24 ++++++++
>  7 files changed, 200 insertions(+), 27 deletions(-)
> 
> -- 
> 2.47.3
> 

