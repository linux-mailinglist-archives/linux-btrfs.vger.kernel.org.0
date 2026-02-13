Return-Path: <linux-btrfs+bounces-21672-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPK8GKWLj2nURQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21672-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 21:37:57 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3171397A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 21:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8460630668A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 20:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A03F28134C;
	Fri, 13 Feb 2026 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GntejAnZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E9B250BEC
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771015025; cv=none; b=IijvbvMW4p8foXkyQqpSWLblmU7IGwG7fJSWHu42YxY70gOExu/6SMnly/5xUcG/pbJO69/NYo0w+zb9C8imYyuIvRpQ884TCglZD3TL13PD7iMiDJOSdSp/LH4kUq8LkcGuiUO2HErYKZ8pLrEe8DNG6hSb7LiMSiSTFT/9G9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771015025; c=relaxed/simple;
	bh=M7bkY1Kz0ddERHxsEtjKMdircBj8E/fNy7/+VYrgnCE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PGtSSCf0kbed2nDdU0vj4ow8E/t0WGf/ybnSt/IZ3Gq5nKJHBeDRgSYN9rXpmv+RbsdSTmk/wyHcBXzMK8kUCTf7I8l1GtWAF4aWNB3bPI/K1QLiigNauYIMl8TLRdLzfNWCYgFMvsKxlB5hYBLg1gfbFJoXWq1lhUPpwvgzBOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GntejAnZ; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-793fdbb8d3aso14259387b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 12:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771015023; x=1771619823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dpCMdVLj76oNDEYDVnRBdJT8qI6DJ+GbUgeGc/La0o=;
        b=GntejAnZaYz/yPIEWJK3Okq8ewjrf1IsG9so/vBeWHQY+RgbIQTCHkXckFwRABq4sx
         TM5HiB3SP7M4OuhNWh5RqUCP7KqsUyFDjVhiP+OvfYYuYmZQk/yOvkrtjhMJ7f8gkGrQ
         RDSw+gW/gKCc0Fxulx6aKOvtu99cmfe2cf1g+FG2rWlIlWZbrwC3P+Ns2guJOG6BfNxA
         O52Yds16hVyGSfvR1iRScWEQYDUt+US3RV85QlG/knoObGG3nV5j6CS9mkGSbBJyHIpX
         NIpor/w8yUeV5l3P2DnOd9LBuy8jCjLMuvPAWFCF4grncBRyn+4b5KWukAi0dyFWjwFs
         vCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771015023; x=1771619823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dpCMdVLj76oNDEYDVnRBdJT8qI6DJ+GbUgeGc/La0o=;
        b=X4rjjQBeCxCftEeQgS5IyiDSbxdZGfb8Tq+YaZ6LL9jPqDVvNJQxR2ev56BV7WBpW0
         4zEYQA5JsVV+fImfy+lgf0EzEM642vINCCHVb2vMOSDNLyu5li7jl+oxCDIf7K5JsJfT
         UttZue6JehPjFL1cqQCxYUO6vs9nS0mMooy6WQOOapp+Gv2B7lczgSkTLsyIzRHuUyYh
         kF9/lXrxYxNlF3g+9yMloiXU7Mst9Y6tcURFYiHB41CWk4nb5fyYRFeIS5jKHS9Dw06r
         FHz/4BAn+WdCu7hcQO9bZPZjdN5F0Y00NIozp9tGtLs2352awf4kSZ2zU6zFRf/VDauE
         JBoA==
X-Gm-Message-State: AOJu0Yxdv0//cUNL/0Xu+flQW7rz76Y0sJLO7ad6hkRdFyr0hRePRGE9
	rlnkFZoudnVdlNGGN26wg6sd6Am0RentW7HECjbjLOjPidk2148l/a4bcLy3uM0o
X-Gm-Gg: AZuq6aIsHovYFwx6FXlDJpX72Y+fjxhGB7WzmSz9cDN56XknPPDgGwJhOU0F7Ui6zs3
	7Xiox85FHZZmXz4+QGkwwJSm8yGbxlyYSSJ8GVGXsFEDe/va0smuQgbDT7ErYXLInEIleeXSjDD
	pMpTdqVK3iToZIjJ/9iYlpuiQps/fuG8n9rJK3OV44XgojNYfVTo2QCqpI4MOF1cDi0uzMnAj7K
	+eVpM74QFpZenTEBhivBjhmwiwO5OZBV8IEH2S5QmsO4cMKUExXFeIyXsRSp7dfQXC0khrK4jVu
	l5hjGXgTnS+1+rc8fr54KZW4F9nUhlv1uGxAhJglvrlCNs/A6GPptTSplbzBcIcD0NT5uW2XfwV
	HpYQvaKw5Ariy6XVvJrRlhou8e6oBRb0LS/AW4fSRarXj89/97FbFYiCrvzmCgySq2QGwegS5OG
	qc1pc/WQIXz7gBeA==
X-Received: by 2002:a05:690e:1515:b0:64a:d29c:e159 with SMTP id 956f58d0204a3-64c14dceacfmr2915610d50.82.1771015023259;
        Fri, 13 Feb 2026 12:37:03 -0800 (PST)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23f1bdsm76139627b3.28.2026.02.13.12.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 12:37:02 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 0/3] btrfs: fix COW amplification under memory pressure
Date: Fri, 13 Feb 2026 12:30:23 -0800
Message-ID: <cover.1771012202.git.loemra.dev@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21672-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF3171397A5
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
buffers mid-writeback are excluded. Beyond fixing the amplification bug,
this is a general optimization for the entire transaction lifetime: any
time writeback runs during a transaction, revisiting the same path no
longer triggers unnecessary COW, reducing extent allocation overhead,
memory copies,
and space usage per transaction. This is especially valuable now that
Qu's recent patch removed the btree_writepages 32M dirty threshold,
allowing external callers (mm, cgroup) to trigger metadata writeback
at any dirty level.

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

Patch 3 adds a tracepoint for tracking cow_count per search_slot
call.

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

Changes since v1:

The v1 patch used a per-btrfs_search_slot() xarray to track COW'd
buffers. Filipe pointed out this was too complex and too narrow in
scope, and suggested overwriting in place instead. Qu raised the
concern that other btrfs_cow_block() callers outside of search_slot
would not be covered. Boris suggested transaction-handle-level scope
as an alternative.

v2 implements both overwrite-in-place and writeback inhibition at
the transaction handle level. The per-search-slot xarray is replaced
by a per-transaction-handle xarray, which covers all
btrfs_force_cow_block() callers. Log trees are excluded from overwrite
because btrfs_sync_log() immediately commits a superblock referencing
them, and handled by writeback inhibition instead. The
EXTENT_BUFFER_WRITEBACK check addresses Sun YangKai's observation
about races with in-flight I/O.

Leo Martins (3):
  btrfs: skip COW for written extent buffers allocated in current
    transaction
  btrfs: inhibit extent buffer writeback to prevent COW amplification
  btrfs: add tracepoint for COW amplification tracking

 fs/btrfs/ctree.c             | 72 +++++++++++++++++++++++++++++++++---
 fs/btrfs/extent_io.c         | 62 ++++++++++++++++++++++++++++++-
 fs/btrfs/extent_io.h         |  5 +++
 fs/btrfs/transaction.c       | 19 ++++++++++
 fs/btrfs/transaction.h       |  2 +
 include/trace/events/btrfs.h | 26 +++++++++++++
 6 files changed, 180 insertions(+), 6 deletions(-)

-- 
2.47.3


