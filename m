Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1168F2B19FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 12:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgKMLXs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 06:23:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgKMLXn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 06:23:43 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD43207DE
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 11:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605266613;
        bh=6Pd00lZix3E/B4VtYo7B3xs9jf5Ap7abDpKeLxLLF7A=;
        h=From:To:Subject:Date:From;
        b=TvAHwU0HTzmdVp9B/hPQ60fAOKxlLO4FKQGii6yP0V24wiDXrWmmM0d2wtcOVInoI
         f59O5pZnV4uGPLXCGG7XFigsZGDIBgbPK57vszlor0BhXo8YFReMzOAlCo6LZsdhwY
         4B+PcFJcg9gUunY1CfL+RTHHY05vL97qRQr3/BTg=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: stop incrementing log batch when joining log transaction
Date:   Fri, 13 Nov 2020 11:23:30 +0000
Message-Id: <5c0655d43b2809932ec8aa40d99b94295469e3f1.1605266377.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When joining a log transaction we acquire the root's log mutex, then
increment the root's log batch and log writers counters while holding
the mutex. However we don't need to increment the log batch there,
because we are holding the mutex and incremented the log writers counter
as well, so any other task trying to sync log will wait for the current
task to finish its logging and still achieve the desired log batching.

Since the log batch counter is an atomic counter and is incremented twice
at the very beginning of the fsync callback (btrfs_sync_file()), once
before flushing delalloc and once again after waiting for writeback to
complete, eliminating its increment when joining the log transaction
may provide some performance gains in case we have multiple concurrent
tasks doing fsyncs against different files in the same subvolume, as it
reduces contention on the atomic (locking the cacheline and bouncing it).

When testing fio with 32 jobs, on a 8 cores vm, doing fsyncs against
different files of the same subvolume, on top of a zram device, I could
consistently see gains (higher throughput) between 1% to 2%, which is a
very low value and possibly hard to be observed with a real device (I
couldn't observe consistent gains with my low/mid end NVMe device).
So this change is mostly motivated to just simplify the logic, as updating
the log batch counter is only relevant when an fsync starts and while not
holding the root's log mutex.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 17a08a7bf6cc..bc3396dfec10 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -172,7 +172,6 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 		root->log_start_pid = current->pid;
 	}
 
-	atomic_inc(&root->log_batch);
 	atomic_inc(&root->log_writers);
 	if (ctx && !ctx->logging_new_name) {
 		int index = root->log_transid % 2;
-- 
2.28.0

