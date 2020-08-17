Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3473246616
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 14:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgHQMMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 08:12:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:57120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbgHQMMn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 08:12:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 671E5AD60;
        Mon, 17 Aug 2020 12:13:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 38731DA6EF; Mon, 17 Aug 2020 14:11:38 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/5] btrfs: scrub: rename ratelimit state varaible to avoid shadowing
Date:   Mon, 17 Aug 2020 14:11:38 +0200
Message-Id: <6fb5314d1fab536c16d91755ff7f0ae7db808d02.1597666167.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1597666167.git.dsterba@suse.com>
References: <cover.1597666167.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's already defined _rs within ctree.h:btrfs_printk_ratelimited,
local variables should not use _ to avoid such name clashes with
macro-local variables.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 5a6cb9db512e..299a35bfe5c3 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -835,7 +835,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	int success;
 	bool full_stripe_locked;
 	unsigned int nofs_flag;
-	static DEFINE_RATELIMIT_STATE(_rs, DEFAULT_RATELIMIT_INTERVAL,
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
 	BUG_ON(sblock_to_check->page_count < 1);
@@ -969,14 +969,14 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.read_errors++;
 		spin_unlock(&sctx->stat_lock);
-		if (__ratelimit(&_rs))
+		if (__ratelimit(&rs))
 			scrub_print_warning("i/o error", sblock_to_check);
 		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERRS);
 	} else if (sblock_bad->checksum_error) {
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.csum_errors++;
 		spin_unlock(&sctx->stat_lock);
-		if (__ratelimit(&_rs))
+		if (__ratelimit(&rs))
 			scrub_print_warning("checksum error", sblock_to_check);
 		btrfs_dev_stat_inc_and_print(dev,
 					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
@@ -984,7 +984,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.verify_errors++;
 		spin_unlock(&sctx->stat_lock);
-		if (__ratelimit(&_rs))
+		if (__ratelimit(&rs))
 			scrub_print_warning("checksum/header error",
 					    sblock_to_check);
 		if (sblock_bad->generation_error)
-- 
2.25.0

