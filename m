Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D023F544193
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 04:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiFICpO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 22:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiFICpN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 22:45:13 -0400
X-Greylist: delayed 328 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jun 2022 19:45:10 PDT
Received: from neville.hungrycats.org (unknown [207.192.69.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E4482A71C
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 19:45:09 -0700 (PDT)
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
Received: from waya.furryterror.org (waya.vpn7.hungrycats.org [10.132.226.63])
        by neville.hungrycats.org (Postfix) with ESMTP id D9F656018B;
        Wed,  8 Jun 2022 22:39:40 -0400 (EDT)
Received: from zblaxell by waya.furryterror.org with local (Exim 4.94.2)
        (envelope-from <zblaxell@waya.furryterror.org>)
        id 1nz85E-0006E9-DK; Wed, 08 Jun 2022 22:39:40 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: don't set lock_owner when locking tree pages for reading
Date:   Wed,  8 Jun 2022 22:39:36 -0400
Message-Id: <20220609023936.6112-1-ce3g8jdj@umail.furryterror.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In 196d59ab9ccc "btrfs: switch extent buffer tree lock to rw_semaphore"
the functions for tree read locking were rewritten, and in the process
the read lock functions started setting eb->lock_owner = current->pid.
Previously lock_owner was only set in tree write lock functions.

Read locks are shared, so they don't have exclusive ownership of the
underlying object, so setting lock_owner to any single value for a
read lock makes no sense.  It's mostly harmless because write locks
and read locks are mutually exclusive, and none of the existing code
in btrfs (btrfs_init_new_buffer and print_eb_refs_lock) cares what
nonsense is written in lock_owner when no writer is holding the lock.

KCSAN does care, and will complain about the data race incessantly.
Remove the assignments in the read lock functions because they're
useless noise.

Fixes: 196d59ab9ccc ("btrfs: switch extent buffer tree lock to rw_semaphore")
Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
---
 fs/btrfs/locking.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 313d9d685adb..33461b4f9c8b 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -45,7 +45,6 @@ void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting ne
 		start_ns = ktime_get_ns();
 
 	down_read_nested(&eb->lock, nest);
-	eb->lock_owner = current->pid;
 	trace_btrfs_tree_read_lock(eb, start_ns);
 }
 
@@ -62,7 +61,6 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
 int btrfs_try_tree_read_lock(struct extent_buffer *eb)
 {
 	if (down_read_trylock(&eb->lock)) {
-		eb->lock_owner = current->pid;
 		trace_btrfs_try_tree_read_lock(eb);
 		return 1;
 	}
@@ -90,7 +88,6 @@ int btrfs_try_tree_write_lock(struct extent_buffer *eb)
 void btrfs_tree_read_unlock(struct extent_buffer *eb)
 {
 	trace_btrfs_tree_read_unlock(eb);
-	eb->lock_owner = 0;
 	up_read(&eb->lock);
 }
 
-- 
2.30.2

