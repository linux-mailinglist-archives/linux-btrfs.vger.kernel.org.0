Return-Path: <linux-btrfs+bounces-21892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLHiLJn6nWmeSwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21892-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 20:23:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8317518BFE9
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 20:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D2F030493B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 19:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768FF3ACEF7;
	Tue, 24 Feb 2026 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebL5qerw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C3B3ACA7B
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960976; cv=none; b=XVW2xMfkoxvwXlH3k3WJTIZyB47vdlqaVKcoAVPSjDYe9u2Hm2wf0pUW2nKZFJtGoyrqmI2ogIUyy0rCHg0r0meUjX4Z8tugpGVZSSshYFdd5wQ76i+OgZSztDf86z2MlkcWA7ka4YcpHKA3jLm2otFFhKT43OUdd3JNiKwTNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960976; c=relaxed/simple;
	bh=DgpYht4fUNuDZAz5MFfPHu9mwJHcXotoLQpfQcChW7U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ccQ8OZP5q3ZsqyrFNBESrsVg9+zR0XTSaw7wplX3oVA4YfB4GQeRSIL/haymYXSk45e4hsxW7JdDoyOM0xLzooiDzHqtFTH6Xr2ujUSWY9DUA8JmuB8X3wz1uM+s2TFW+MH9+jNZX9CXT/0OQEUVjMOG6CZSJxaaonPt5PtxoVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebL5qerw; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-64aedd812baso5424653d50.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 11:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771960970; x=1772565770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VANXF4HiSIEvY4DxHkIXWSh8Y6I7Ix6T14TADgiqlJE=;
        b=ebL5qerwjg78pFZMXE/T5J+XC1SFScjTkZULJ5whsOL+YruCaN1DTDDIyEwZNCk6Y7
         OVOL/LwXnUbXQOPuOTTgNrDDTM54JGkBzQnTZHMSxEnJbBScVyDC4bqWbpShloxYwM6U
         HZRcb5miaMrmCqb4QvRY98WxJ3qM4yIHnPQtnL7KXcQYlDfQtnz5WGYLtsplZ9cl7AVN
         0GxE2PAslJp3rCQz9JxNkmsh8XK+9PLSOcFMzaGok3ZvZnFcVKneSG69m79v6zkaMPMR
         xpuH88DJivfSappL77MfNhJgsMTyyMTv0NpdKaTeiyyUu4zZPKA7q7DSZOZHiv68ujwr
         ptMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960970; x=1772565770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VANXF4HiSIEvY4DxHkIXWSh8Y6I7Ix6T14TADgiqlJE=;
        b=LMO48d3w1eWXueCQvQpXeO1ViHKC03l48p6DosqDZMPk6iOVVaPAB/k5xGGHW1/OXP
         vhe2GUU5c/GNcIvUACzV5qXp2ONwVpjQx5nFL5vs39568y4a8nYczFVuugxbK/6lOhk+
         qxdJjsfJk64t/E93Qs5NA4NEivSDKjnhZG6Ua23rPaUDCu52pHxkWoTqU/Q00qNeRN2R
         K3PtVr/I7xGRmdXo3xjiwR0hgYwfSK1NY0VptrhR+pKRQIH0c641DKRmm/2gTJL+9Tg0
         aw+6vJco5MULIryDd/MEFk2pUtIlHaUG/cqVKToG3zbPDYoQ5FXNDsS41YxPx7BvEPMz
         yJ5g==
X-Gm-Message-State: AOJu0YwcT01D3s5juqaeQg+j4OtyAdoeO9Xm9cBGar60j+hoMP1X8Mql
	WMOKe8hxh2FmVB4I7NSuLinpFil0H0mqB25+NMNqwagzG7tKTwPYYX/27nv14phvLKQ=
X-Gm-Gg: ATEYQzw5ZQwFgP/ndQWD/ixZ6xRTtgkrI7i0PSrOxJO9kNHG0pDAVGeWrW1eAsaMGMM
	ITcVKqs+Q5oXUCgXmPQ2asjusxR/Y/D3btO/dltM31Dm5BTj2VGKcwuy1cGj3UGy2MOZ55924nE
	2TG04EOE44jX3i2hAZZ9ll1hFe/DPgIYNmAGDq2317GlWSYSq73rRi11rj8RUai+FoCqL0I4ynx
	pGls0aT1YlSzNYxEqn4HHc0JOAwAPqM/azQYymJ5KUUWgz+E06dDncPuD1bwozFLytCcSPbWpch
	H366TPqfpJAkfd6WEFpwwRQ+pOrSjr0qnmVBTPQv4mU7vscyHa0RSN7wxU8Cmk6kSil0J/irGpe
	3u7z8f3vdaFpcNetHeDGz9QGeBDfkug/HIqaZ8I0e0s7xVP0cmy84bNfqq/bcu+oEIwRJEwLRV9
	v4/+8UCGpScNErAwP/5Q==
X-Received: by 2002:a05:690c:92:b0:798:25d:a4b2 with SMTP id 00721157ae682-79828f07424mr126145247b3.19.1771960970298;
        Tue, 24 Feb 2026 11:22:50 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dd81f97sm47052907b3.34.2026.02.24.11.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:22:49 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 0/3] btrfs: fix COW amplification under memory pressure
Date: Tue, 24 Feb 2026 11:22:31 -0800
Message-ID: <cover.1771884128.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21892-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8317518BFE9
X-Rspamd-Action: no action

I've been investigating a pattern where COW amplification under memory
pressure exhausts the transaction block reserve, leading to spurious
ENOSPCs on filesystems with plenty of unallocated space.

The pattern is:

 1. btrfs_search_slot() begins tree traversal with cow=1
 2. Node at level N needs COW (old generation or WRITTEN flag set)
 3. btrfs_cow_block() allocates new block, copies data, updates
    parent pointer
 4. Traversal hits a condition requiring restart (node not cached,
    lock contention, need higher write_lock_level)
 5. btrfs_release_path() releases all locks and references
 6. Memory pressure triggers writeback on the COW'd block
 7. lock_extent_buffer_for_io() clears EXTENT_BUFFER_DIRTY and sets
    BTRFS_HEADER_FLAG_WRITTEN
 8. goto again - traversal restarts from root
 9. Traversal reaches the same tree node
 10. should_cow_block() sees WRITTEN flag, returns true
 11. btrfs_cow_block() allocates yet another new block, copies data,
     updates parent pointer again, consuming another reservation
 12. Steps 4-11 repeat under sustained memory pressure

This series fixes the problem with two complementary approaches:

Patch 1 implements Filipe's suggestion of overwriting in place. When
should_cow_block() encounters a WRITTEN buffer whose generation matches
the current transaction, it re-dirties the buffer and returns false
instead of requesting a COW. This is crash-safe because the committed
superblock does not reference buffers allocated in the current
transaction. Log trees, zoned devices, FORCE_COW, relocation, and
buffers mid-writeback are excluded. Beyond improving the amplification bug,
this is a general optimization for the entire transaction lifetime: any
time writeback runs during a transaction, revisiting the same path no
longer triggers unnecessary COW, reducing extent allocation overhead,
memory copies, and space usage per transaction.

Patch 2 inhibits writeback on COW'd buffers for the lifetime of the
transaction handle. This prevents WRITTEN from being set while a
handle holds a reference to the buffer, avoiding unnecessary re-COW
at its source. Only WB_SYNC_NONE (background/periodic flusher
writeback) is inhibited. WB_SYNC_ALL (data-integrity writeback from
btrfs_sync_log() and btrfs_write_and_wait_transaction()) always
proceeds, which is required for correctness in the fsync path where
log tree blocks must be written while the inhibiting handle is still
active.

Both approaches are independently useful. The overwrite path is a
general optimization that eliminates unnecessary COW across the entire
transaction, not just within a single handle. Writeback inhibition
prevents the problem from occurring in the first place and is the
only fix for log trees and zoned devices where overwrite does not
apply. Together they provide defense in depth against COW
amplification.

Patch 3 adds a tracepoint for tracking search slot restarts.

Note: Boris's AS_KERNEL_FILE changes prevent cgroup-scoped reclaim
from targeting extent buffer pages, making this harder to trigger via
per-cgroup memory limits. I was able to reproduce the amplification
using global memory pressure (drop_caches, root cgroup memory.reclaim,
memory hog) with concurrent filesystem operations.

Benchmark: concurrent filesystem operations under aggressive global
memory pressure. COW counts measured via bpftrace.

  Approach                   Max COW count   Num operations
  -------                    -------------   --------------
  Baseline                              35   -
  Overwrite only                        19   ~same
  Writeback inhibition only              5   ~2x
  Combined (this series)                 4   ~2x

Changes since v2:

Patch 1:
 - Add smp_mb__before_atomic() before FORCE_COW check (Filipe, Sun YangKai)
 - Hoist WRITEBACK, RELOC, FORCE_COW checks before WRITTEN block (Sun YangKai)
 - Update dirty_pages comment for qgroup_account_snapshot() (Filipe)
 - Relax btrfs_mark_buffer_dirty() lockdep assertion to accept read locks
 - Use btrfs_mark_buffer_dirty() instead of set_extent_buffer_dirty()
 - Remove folio_test_dirty() debug assertion (concurrent reader race)

Patch 2:
 - Fix comment style (Filipe)

Patch 3:
 - Replace counters with per-restart-site tracepoint (Filipe)

Changes since v1:

The v1 patch used a per-btrfs_search_slot() xarray to track COW'd
buffers. Filipe pointed out this was too complex and too narrow in
scope, and suggested overwriting in place instead. Qu raised the
concern that other btrfs_cow_block() callers outside of search_slot
would not be covered. Boris suggested transaction-handle-level scope
as an alternative.

v2 implemented both overwrite-in-place and writeback inhibition at
the transaction handle level. The per-search-slot xarray was replaced
by a per-transaction-handle xarray, which covers all
btrfs_force_cow_block() callers.

Leo Martins (3):
  btrfs: skip COW for written extent buffers allocated in current
    transaction
  btrfs: inhibit extent buffer writeback to prevent COW amplification
  btrfs: add tracepoint for search slot restart tracking

 fs/btrfs/ctree.c             | 70 +++++++++++++++++++++++++++++++-----
 fs/btrfs/disk-io.c           |  2 +-
 fs/btrfs/extent_io.c         | 67 +++++++++++++++++++++++++++++++---
 fs/btrfs/extent_io.h         |  6 ++++
 fs/btrfs/transaction.c       | 19 ++++++++++
 fs/btrfs/transaction.h       |  3 ++
 include/trace/events/btrfs.h | 24 +++++++++++++
 7 files changed, 176 insertions(+), 15 deletions(-)

-- 
2.47.3


