Return-Path: <linux-btrfs+bounces-21951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMNiMDwZoGmzfgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21951-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 10:58:20 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC301A3DB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 10:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C114431257C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 09:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967AF316905;
	Thu, 26 Feb 2026 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP0WwWsK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9490A314B95
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099474; cv=none; b=AvoW9/eWu+0OhiLWx4colf79RAMfCQA7XeuxxOb5t8pX2HI1nLKtP9gSS8X10KCcafNFpS0IOunj2xD2wRnRQzysmGhF5jUu5SWwd1ge+4mzL1zoyaBlGRQVIowDZt9ZKFRsl1WPAOtMlfWJJK8XOYSmFW23GyZBgL39GztES+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099474; c=relaxed/simple;
	bh=GZMzaXXGl3aIHzl+/IHYTN9sR+Bn7Bvwx+7JH4hE9HE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HgsYD4drAn/zxEV49szaXqSnibijntm/CQVRLBmIYxNdk1K+JchE/NKNU+GMHvSgarxq0PZYrGPaWDcKFEE50l8Ezwi3eU7IhPwrtcNyErHM+6CFnV6O2BPNaHDas42ZieDftVRKqO7cd3WvfygrUlLJeCt8WKYcIjpbfpwkNcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UP0WwWsK; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-64ad46a44easo471947d50.0
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 01:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772099471; x=1772704271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLK+LUBhAEVVOwD2WVLNQV8CeAgXrRZ4EWRhDqTWZuA=;
        b=UP0WwWsKD3a1jqqF3rKZMy1EQdjnjBQdnkJdv5PcPvE9vx9THOWZ1yEOclQnmdeMzo
         xvjuojobt9iwefiSmEHjW1y/jsB+ZSo+ak0sxsL8m7t+/MvW9kKkEUOjce7Q8BYu9HFs
         mX5JWPGoJfv7OIpWSdCvbFGcZob4nQ615G2nL+ssDXVK8hC/lQuxkgRnOej7peC6yQ/d
         zFSm9x0N73HWP++prSpbg/0I5hU/cqIDeABv85h4uXg5RAPz/QhOX+IJEdOYIpTGFMHL
         122kUGPRkFmzSYWXSkXsN/AviX9fxBBu91zkTRtN1b+ERqNGACiOgovTgXEtunu8RqGE
         quQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772099471; x=1772704271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLK+LUBhAEVVOwD2WVLNQV8CeAgXrRZ4EWRhDqTWZuA=;
        b=m8Py4/pvpEJTDXMNwozqewr46lyHU0QU8KdUjHP2z2yPNi/hke/Nf+DD6CFRpn4Xuz
         bNnauaIfKhS3dj2YTvgvKq/KO4RS95Yh3u2cfDxRX4z+lA91/c1J9YkSOpZlFj5lFa98
         9Ziml2gcUw7Y3vwevpQB7PNg3gb4lWNmHtrwRO21rkDm2szxXu4loBXMNh6GXO0mThDK
         /zoZVJVPynTWv3hR8b429dLDDiE9qWSexBVBub/JYPthSLj5zh9paJ1ouzjwZ9kvuNX5
         OqZ3D3E+IRB74qlFbT+rdBZjL5okjxQuN+iHVL8GPeHfF1KhC67n0yVjroTmY9BE6JH4
         MoqQ==
X-Gm-Message-State: AOJu0YyOkGsHL0q7EyulkHwIdNzVBiSklsdarsIlQRSRWGabr+6kptuo
	8Ue8s0w5pAjFRGmBIRAa6ZhvGnchjCcrclivHhseoG5KAmCSH02nQco7rOdbfi/Y
X-Gm-Gg: ATEYQzwE541GgNkt9D/14W6Qx0UqLhUJ5IGsYsUBJmn2OoGoPcPm3ghRWqI8riDsAHv
	I0wssMq0kN+9FXri2y2R8SaRr2LLp4syuPiHeDS2UQhhgVb0EjkSSo9xPs06g9Uhg++0093HyK/
	KKctsYjgVwniQ3vpTZu+TOfTlSW9BbnagK4VpJHKI4wnwnh8KXvl+7AHOcxVot4mu+SkE5nVRf7
	qiY4URfRr3HcCI4vrvrkSldrT+7f3bxc4SMayLTJF09/6xFsyVIkk1zGtq2QHNfe3ixALu399UX
	2X6ZmBvqpsVQdp+zplxmFPK+8Hqcgo3ys1cKmmxO0k8asonNh76r/JfoFOLcUQ20OUIsMq3YACX
	6MMFflrQmQKQ9VpZNYMpHssk7dV8Y3kCg9VMpQaGpcpF/v8bk+PRQCxlh5T61QQLkOyvg7Wkvpn
	WAQX8zBdLRinTDPbteGA==
X-Received: by 2002:a53:d008:0:b0:649:429a:4577 with SMTP id 956f58d0204a3-64c790a6274mr14855140d50.86.1772099471236;
        Thu, 26 Feb 2026 01:51:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb7627181sm808281d50.14.2026.02.26.01.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:51:10 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 0/3] btrfs: fix COW amplification under memory pressure
Date: Thu, 26 Feb 2026 01:51:05 -0800
Message-ID: <cover.1772097864.git.loemra.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21951-lists,linux-btrfs=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FC301A3DB5
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
buffers mid-writeback are excluded. Beyond improving the amplification
bug, this is a general optimization for the entire transaction lifetime:
any time writeback runs during a transaction, revisiting the same path
no longer triggers unnecessary COW, reducing extent allocation overhead,
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

Changes since v3:

Patch 2:
 - Also inhibit writeback in should_cow_block() when COW is skipped,
   so that every transaction handle that reuses a COW'd buffer inhibits
   its writeback, not just the handle that originally COW'd it

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

 fs/btrfs/ctree.c             | 106 ++++++++++++++++++++++++++++-------
 fs/btrfs/disk-io.c           |   2 +-
 fs/btrfs/extent_io.c         |  67 ++++++++++++++++++++--
 fs/btrfs/extent_io.h         |   6 ++
 fs/btrfs/transaction.c       |  19 +++++++
 fs/btrfs/transaction.h       |   3 +
 include/trace/events/btrfs.h |  24 ++++++++
 7 files changed, 200 insertions(+), 27 deletions(-)

-- 
2.47.3


