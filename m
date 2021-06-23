Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4263B138B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 07:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhFWF57 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 01:57:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41976 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhFWF57 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 01:57:59 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 135E421941
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624427742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+kOAro5hOoyRfkB+lP6LLvxOKWH6ZvSbA1gVG3k3lU=;
        b=RVQsHVi6m+fmWANnAce6u1pM2p+/uEgmYvdEc5bV/diNYY2qeUjiilnli4IRHaIlPToBke
        hCcbkt3bo9jGPxpSWs9DAASu0kOFYSR5WlSGYPUlKIGY4YgPIl2CNHkt3S9797YKDGOmkM
        cPc6ISsIR3jdSVFXpAWHotAnexwQUOY=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id DED9EA3B8A
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 5/8] btrfs: use async_chunk::async_cow to replace the confusing pending pointer
Date:   Wed, 23 Jun 2021 13:55:26 +0800
Message-Id: <20210623055529.166678-6-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623055529.166678-1-wqu@suse.com>
References: <20210623055529.166678-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For structure async_chunk, we use a very strange member layout to grab
structure async_cow who owns this async_chunk.

At initialization, it goes like this:

		async_chunk[i].pending = &ctx->num_chunks;

Then at async_cow_free() we do a super weird freeing:

	/*
	 * Since the pointer to 'pending' is at the beginning of the array of
	 * async_chunk's, freeing it ensures the whole array has been freed.
	 */
	if (atomic_dec_and_test(async_chunk->pending))
		kvfree(async_chunk->pending);

This is absolutely an abuse of kvfree().

Replace async_chunk::pending with async_chunk::async_cow, so that we can
grab the async_cow structure directly, without this strange dancing.

And with this change, there is no requirement for any specific member
location.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 30cb8b1fc067..497c219758e0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -455,11 +455,10 @@ struct async_chunk {
 	struct list_head extents;
 	struct cgroup_subsys_state *blkcg_css;
 	struct btrfs_work work;
-	atomic_t *pending;
+	struct async_cow *async_cow;
 };
 
 struct async_cow {
-	/* Number of chunks in flight; must be first in the structure */
 	atomic_t num_chunks;
 	struct async_chunk chunks[];
 };
@@ -1322,18 +1321,17 @@ static noinline void async_cow_submit(struct btrfs_work *work)
 static noinline void async_cow_free(struct btrfs_work *work)
 {
 	struct async_chunk *async_chunk;
+	struct async_cow *async_cow;
 
 	async_chunk = container_of(work, struct async_chunk, work);
 	if (async_chunk->inode)
 		btrfs_add_delayed_iput(async_chunk->inode);
 	if (async_chunk->blkcg_css)
 		css_put(async_chunk->blkcg_css);
-	/*
-	 * Since the pointer to 'pending' is at the beginning of the array of
-	 * async_chunk's, freeing it ensures the whole array has been freed.
-	 */
-	if (atomic_dec_and_test(async_chunk->pending))
-		kvfree(async_chunk->pending);
+
+	async_cow = async_chunk->async_cow;
+	if (atomic_dec_and_test(&async_cow->num_chunks))
+		kvfree(async_cow);
 }
 
 static int cow_file_range_async(struct btrfs_inode *inode,
@@ -1394,7 +1392,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 		 * lightweight reference for the callback lifetime
 		 */
 		ihold(&inode->vfs_inode);
-		async_chunk[i].pending = &ctx->num_chunks;
+		async_chunk[i].async_cow = ctx;
 		async_chunk[i].inode = &inode->vfs_inode;
 		async_chunk[i].start = start;
 		async_chunk[i].end = cur_end;
-- 
2.32.0

