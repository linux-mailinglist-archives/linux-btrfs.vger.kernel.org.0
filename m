Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E059665A64
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 12:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjAKLjl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 06:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjAKLjK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 06:39:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A428FD8
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 03:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E080AB81BB6
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD07C433D2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673436999;
        bh=1fX028zxFCx5/VXZF94TGwUkwBcK5Mkvrq51Ihk4WeM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=W+IiJMDpustMHilj/1L4E+GOLTYJPEr0t7ZCMgtpU0cOKCqrEhvYoUGQHTlktDI/U
         25rlzAgiU9/0euCdxv5nsTGhFPPIrTZkKWE5hXkJ7b2mkfhpNx2o0+oQ5VCMgBnkni
         tDa5Hr2Toa1R13mW/6ibSIg/aWF8nLOHGPDTtk8VCKLc3+2C6mRUiti5tFPgtrXvZy
         hxg7Tr/pVgwrpWnVMSdG11gVdHXwaAsDZo/iYUdXhgH8i/BBw0Gx8ChqJbnAIvJ6fy
         h+ur0R/Fmhy1t2bRa+Sq5IpEuaacrP/YT9nWRLC7OqVUdFLJXgDy7IETjbsSYx5Mnw
         SQpEJt/IhG8xQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 18/19] btrfs: send: update size of roots array for backref cache entries
Date:   Wed, 11 Jan 2023 11:36:19 +0000
Message-Id: <cdb915da279873161aecf299b9a1ecd102a5d246.1673436276.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673436276.git.fdmanana@suse.com>
References: <cover.1673436276.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently we limit the size of the roots array, for backref cache entries,
to 12 elements. This is because that number is enough for most cases and
to make the backref cache entry size to be exactly 128 bytes, so that
memory is allocated from the kmalloc-128 slab and no space is wasted.

However recent changes in the series refactored the backref cache to be
more generic and allow it to be reused for other purposes, which resulted
in increasing the size of the embedded structure btrfs_lru_cache_entry in
order to allow for supporting inode numbers as keys on 32 bits system and
allow multiple generations per key. This resulted in increasing the size
of struct backref_cache_entry from 128 bytes to 152 bytes. Since the cache
entries are allocated with kmalloc(), it means we end up using the slab
kmalloc-192, so we end up wasting 40 bytes of memory. So bump the size of
the roots array from 12 elements to 17 elements, so we end up using 192
bytes for each backref cache entry.

This patch is part of a larger patchset and the changelog of the last
patch in the series contains a sample performance test and results.
The patches that comprise the patchset are the following:

  btrfs: send: directly return from did_overwrite_ref() and simplify it
  btrfs: send: avoid unnecessary generation search at did_overwrite_ref()
  btrfs: send: directly return from will_overwrite_ref() and simplify it
  btrfs: send: avoid extra b+tree searches when checking reference overrides
  btrfs: send: remove send_progress argument from can_rmdir()
  btrfs: send: avoid duplicated orphan dir allocation and initialization
  btrfs: send: avoid unnecessary orphan dir rbtree search at can_rmdir()
  btrfs: send: reduce searches on parent root when checking if dir can be removed
  btrfs: send: iterate waiting dir move rbtree only once when processing refs
  btrfs: send: use MT_FLAGS_LOCK_EXTERN for the backref cache maple tree
  btrfs: send: initialize all the red black trees earlier
  btrfs: send: genericize the backref cache to allow it to be reused
  btrfs: adapt lru cache to allow for 64 bits keys on 32 bits systems
  btrfs: send: cache information about created directories
  btrfs: allow a generation number to be associated with lru cache entries
  btrfs: add an api to delete a specific entry from the lru cache
  btrfs: send: use the lru cache to implement the name cache
  btrfs: send: update size of roots array for backref cache entries
  btrfs: send: cache utimes operations for directories if possible

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7d327d977fa0..ae2d462f647e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -84,19 +84,20 @@ struct clone_root {
 #define SEND_MAX_NAME_CACHE_SIZE 256
 
 /*
- * Limit the root_ids array of struct backref_cache_entry to 12 elements.
- * This makes the size of a cache entry to be exactly 128 bytes on x86_64.
+ * Limit the root_ids array of struct backref_cache_entry to 17 elements.
+ * This makes the size of a cache entry to be exactly 192 bytes on x86_64, which
+ * can be satisfied from the kmalloc-192 slab, without wasting any space.
  * The most common case is to have a single root for cloning, which corresponds
- * to the send root. Having the user specify more than 11 clone roots is not
+ * to the send root. Having the user specify more than 16 clone roots is not
  * common, and in such rare cases we simply don't use caching if the number of
- * cloning roots that lead down to a leaf is more than 12.
+ * cloning roots that lead down to a leaf is more than 17.
  */
-#define SEND_MAX_BACKREF_CACHE_ROOTS 12
+#define SEND_MAX_BACKREF_CACHE_ROOTS 17
 
 /*
  * Max number of entries in the cache.
- * With SEND_MAX_BACKREF_CACHE_ROOTS as 12, the size in bytes, excluding
- * maple tree's internal nodes, is 16K.
+ * With SEND_MAX_BACKREF_CACHE_ROOTS as 17, the size in bytes, excluding
+ * maple tree's internal nodes, is 24K.
  */
 #define SEND_MAX_BACKREF_CACHE_SIZE 128
 
-- 
2.35.1

