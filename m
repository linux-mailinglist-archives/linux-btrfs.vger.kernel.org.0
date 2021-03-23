Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE03346183
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 15:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhCWObp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Mar 2021 10:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231830AbhCWObd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Mar 2021 10:31:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19F7C619B1;
        Tue, 23 Mar 2021 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616509893;
        bh=yhZhazX2oACtfcU29Xevp6wA10wkcp2mGKfW9VxdBeM=;
        h=From:To:Cc:Subject:Date:From;
        b=eag8/TjooaMama1LhkL9+vLR4a0gGdT1zyhNJwRBRrNsvYpxcehxMwrITAD4WwPXV
         GgPiQHdtaLG63JToJAjT6iRVZdUGMnFaR/i4g3OtRVUEwJM7NPohScAjcA7wNaNoA0
         rZYT+eNMlHBOY2jNQAFMSo/OCQCSYg5i+qFhLmtAxx2lgmoLD6IJ4gSWmQO6A9KSO5
         78s4v1G83pE12LxKgHDM/Z9OvR2mbgOClazkH7l5VCzASVqDDEGT0zV0Ff6v6/9FqK
         7SgrqYMwzqPwl0zriTxXWk8KnrHkn/H7idqffQ9UXRzC7CizphkZKi+Qrjyc8/yvQK
         uI99OZxiIQ3QQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] btrfs: zoned: bail out in btrfs_alloc_chunk for bad input
Date:   Tue, 23 Mar 2021 15:31:19 +0100
Message-Id: <20210323143128.1476527-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc complains that the ctl->max_chunk_size member might be used
uninitialized when none of the three conditions for initializing it in
init_alloc_chunk_ctl_policy_zoned() are true:

In function ‘init_alloc_chunk_ctl_policy_zoned’,
    inlined from ‘init_alloc_chunk_ctl’ at fs/btrfs/volumes.c:5023:3,
    inlined from ‘btrfs_alloc_chunk’ at fs/btrfs/volumes.c:5340:2:
include/linux/compiler-gcc.h:48:45: error: ‘ctl.max_chunk_size’ may be used uninitialized [-Werror=maybe-uninitialized]
 4998 |         ctl->max_chunk_size = min(limit, ctl->max_chunk_size);
      |                               ^~~
fs/btrfs/volumes.c: In function ‘btrfs_alloc_chunk’:
fs/btrfs/volumes.c:5316:32: note: ‘ctl’ declared here
 5316 |         struct alloc_chunk_ctl ctl;
      |                                ^~~

If we ever get into this condition, something is seriously
wrong, so the same logic as in init_alloc_chunk_ctl_policy_regular()
and a few other places should be applied. This avoids both further
data corruption, and the compile-time warning.

Fixes: 1cd6121f2a38 ("btrfs: zoned: implement zoned chunk allocator")
Link: https://lore.kernel.org/lkml/20210323132343.GF7604@twin.jikos.cz/
Suggested-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Note that the -Wmaybe-unintialized warning is globally disabled
by default. For some reason I got this warning anyway when building
this specific file with gcc-11.
---
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bc3b33efddc5..d2994305ed77 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4989,6 +4989,8 @@ static void init_alloc_chunk_ctl_policy_zoned(
 		ctl->max_chunk_size = 2 * ctl->max_stripe_size;
 		ctl->devs_max = min_t(int, ctl->devs_max,
 				      BTRFS_MAX_DEVS_SYS_CHUNK);
+	} else {
+		BUG();
 	}
 
 	/* We don't want a chunk larger than 10% of writable space */
-- 
2.29.2

