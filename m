Return-Path: <linux-btrfs+bounces-21931-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPn+KvEzn2lXZQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21931-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 18:40:01 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B4619BAA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 18:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7023E303CC2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2FE3D3CF8;
	Wed, 25 Feb 2026 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSih/S32"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9A22C17B3
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041171; cv=none; b=FQ0aCFFYNsT8bxojfubMblh6F8grEge95+Yno+RwbYbCGcuLrznCgm8piZuzqbH1fBYGh4fM6rXge3MAkxxjgyFxRqqV2oAfOzpKXDgAomaRmPTJYnSQz/CzPxgWTgF4Znoq1PF4xwopxtXXfEPP85v3DFmIrXG4g7PQ4K/ivC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041171; c=relaxed/simple;
	bh=swwpQKwnkQkPTQNBEKvWuoVM9KQC3eAiz7jBSp7zTE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5o5objXScKNd8ebWet7uG7DpabsGK8fDwsbArN9PyWLh40bEJhFfjwmSJADwl8TKUHBIGnUu1JXBH3h38MewQPdAPk3wVV9momUgfZdBtvTb5QUvOQWRe6GT5WgXWhjE5LA63E9viiGqbw3/PzBVuRW8FEubD5ODcYW2+dvJFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSih/S32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898F4C19421
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 17:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772041170;
	bh=swwpQKwnkQkPTQNBEKvWuoVM9KQC3eAiz7jBSp7zTE8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tSih/S32orSKV8D1HCphBnCUqKOA0GFwNa/QSV7VLuQ3JzY5+Qaqts+MjX3ReWXKd
	 OmtwjdOI8CIDjSF/WqlPKTacyXvu8sivDm0AaSmWvR/7jk5SRcM2BdSHia7Figxeo+
	 aVc8zwURCxm2IVTucS86d4wU+EOW9rDwBr7B4VgfHLWvmopnddcU7kBIp1tQXeWYUW
	 VakYcaDnXtwdiWSJmU2YOf06zA3ouQ+bmvjJnjfQqQf+clOuP3XC2JjOUa9MlTgGOn
	 y2APjEyu9MVZZ/QUR+CGKpBgY9I1mFvdapaBEtyq/3yq0pI9Kh+BypdUcMG6ao37aw
	 nciW3o/Oq3/+w==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8fb6ad3243so981122166b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 09:39:30 -0800 (PST)
X-Gm-Message-State: AOJu0YxjSXSnbTRJAhkY1mOqZwdoFMuJ1TP0k0GJ7zfB0rcs5sdlnTCq
	FAE+YYi5LHZjDfsmh03THqAX0a/NPjRm2/b/mVri9rL7NkGUlr/aHFlyIs0ayjvK7afA0/E7vxC
	M9FE3MalHZA6H0SL+OXAByq6F/JoIvM4=
X-Received: by 2002:a17:907:d0a:b0:b73:572d:3b07 with SMTP id
 a640c23a62f3a-b9081b3b176mr1236731066b.28.1772041169045; Wed, 25 Feb 2026
 09:39:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771884128.git.loemra.dev@gmail.com>
In-Reply-To: <cover.1771884128.git.loemra.dev@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 25 Feb 2026 17:38:52 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5RAa72uLEktuTiQ-gWHQuZ8_q_zY7cKT5xBjVkyruELA@mail.gmail.com>
X-Gm-Features: AaiRm51ba5nAKe3bldGDsQX3XiY1sTSNr5DsQrcrIMjsgr16LbVhWZF4b1uwiaI
Message-ID: <CAL3q7H5RAa72uLEktuTiQ-gWHQuZ8_q_zY7cKT5xBjVkyruELA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] btrfs: fix COW amplification under memory pressure
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-21931-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 15B4619BAA6
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 7:23=E2=80=AFPM Leo Martins <loemra.dev@gmail.com> =
wrote:
>
> I've been investigating a pattern where COW amplification under memory
> pressure exhausts the transaction block reserve, leading to spurious
> ENOSPCs on filesystems with plenty of unallocated space.
>
> The pattern is:
>
>  1. btrfs_search_slot() begins tree traversal with cow=3D1
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
> buffers mid-writeback are excluded. Beyond improving the amplification bu=
g,
> this is a general optimization for the entire transaction lifetime: any
> time writeback runs during a transaction, revisiting the same path no
> longer triggers unnecessary COW, reducing extent allocation overhead,
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
>
> Changes since v2:
>
> Patch 1:
>  - Add smp_mb__before_atomic() before FORCE_COW check (Filipe, Sun YangKa=
i)
>  - Hoist WRITEBACK, RELOC, FORCE_COW checks before WRITTEN block (Sun Yan=
gKai)
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

You can add to all the patches:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
>  fs/btrfs/ctree.c             | 70 +++++++++++++++++++++++++++++++-----
>  fs/btrfs/disk-io.c           |  2 +-
>  fs/btrfs/extent_io.c         | 67 +++++++++++++++++++++++++++++++---
>  fs/btrfs/extent_io.h         |  6 ++++
>  fs/btrfs/transaction.c       | 19 ++++++++++
>  fs/btrfs/transaction.h       |  3 ++
>  include/trace/events/btrfs.h | 24 +++++++++++++
>  7 files changed, 176 insertions(+), 15 deletions(-)
>
> --
> 2.47.3
>
>

