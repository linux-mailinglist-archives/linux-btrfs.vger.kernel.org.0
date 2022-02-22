Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046B64C0039
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 18:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiBVRgU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 12:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiBVRgT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 12:36:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2140416FDD2
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 09:35:53 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E39981F3A0;
        Tue, 22 Feb 2022 17:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645551350;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2h47yweATcOAA27gf9Xo6Tal8PNHpXJQOwBza/CPgXw=;
        b=v0My88vzl3r3swiLsU8c79dkMTUv4fVRHOA51QfBAvs4dqgeSNCeUBqu8oCZnmJdWZtWG7
        cmdHBvm+AIhL23ImMOoth+tCBwBdzLCQ64JY83d7pcCTLP7esAUZYbREKk4USckmzbY9TO
        +2/eRn4npAWsXK2941Qr7H9YY3WYW7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645551350;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2h47yweATcOAA27gf9Xo6Tal8PNHpXJQOwBza/CPgXw=;
        b=0Tp+BrdF9nXtsaWg+hSbpHZxf7LuxplV0Rc+U80dQV57ZnCknwlk2G46fPxNkFYc/ot4+E
        yi9wi2oGifdf0zCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DD4F2A3B81;
        Tue, 22 Feb 2022 17:35:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0891CDA823; Tue, 22 Feb 2022 18:32:02 +0100 (CET)
Date:   Tue, 22 Feb 2022 18:32:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs: autodefrag: only scan one inode once
Message-ID: <20220222173202.GL12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1644737297.git.wqu@suse.com>
 <7e33c57855a9d323be8f70123d365429a8463d7b.1644737297.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e33c57855a9d323be8f70123d365429a8463d7b.1644737297.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 13, 2022 at 03:42:32PM +0800, Qu Wenruo wrote:
> Although we have btrfs_requeue_inode_defrag(), for autodefrag we are
> still just exhausting all inode_defrag items in the tree.
> 
> This means, it doesn't make much difference to requeue an inode_defrag,
> other than scan the inode from the beginning till its end.
> 
> This patch will change the beahvior by always scan from offset 0 of an
> inode, and till the end of the inode.
> 
> By this we get the following benefit:
> 
> - Straight-forward code
> 
> - No more re-queue related check
> 
> - Less members in inode_defrag
> 
> We still keep the same btrfs_get_fs_root() and btrfs_iget() check for
> each loop, and added extra should_auto_defrag() check per-loop.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Below is a version of the patch without the control structure and with a
manual while (true) loop so there's not that much code moved and it's
clear what's being added. I haven't tested it yet, but this is what I'd
like to get merged and then forwarded to stable so we can finally get
over this.

 fs/btrfs/file.c | 84 +++++++++++++------------------------------------
 1 file changed, 22 insertions(+), 62 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 62c4edd5e2f9..1efc378e4bbe 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -49,12 +49,6 @@ struct inode_defrag {
 
 	/* root objectid */
 	u64 root;
-
-	/* last offset we were able to defrag */
-	u64 last_offset;
-
-	/* if we've wrapped around back to zero once already */
-	int cycled;
 };
 
 static int __compare_inode_defrag(struct inode_defrag *defrag1,
@@ -107,8 +101,6 @@ static int __btrfs_add_inode_defrag(struct btrfs_inode *inode,
 			 */
 			if (defrag->transid < entry->transid)
 				entry->transid = defrag->transid;
-			if (defrag->last_offset > entry->last_offset)
-				entry->last_offset = defrag->last_offset;
 			return -EEXIST;
 		}
 	}
@@ -178,34 +170,6 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-/*
- * Requeue the defrag object. If there is a defrag object that points to
- * the same inode in the tree, we will merge them together (by
- * __btrfs_add_inode_defrag()) and free the one that we want to requeue.
- */
-static void btrfs_requeue_inode_defrag(struct btrfs_inode *inode,
-				       struct inode_defrag *defrag)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	int ret;
-
-	if (!__need_auto_defrag(fs_info))
-		goto out;
-
-	/*
-	 * Here we don't check the IN_DEFRAG flag, because we need merge
-	 * them together.
-	 */
-	spin_lock(&fs_info->defrag_inodes_lock);
-	ret = __btrfs_add_inode_defrag(inode, defrag);
-	spin_unlock(&fs_info->defrag_inodes_lock);
-	if (ret)
-		goto out;
-	return;
-out:
-	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
-}
-
 /*
  * pick the defragable inode that we want, if it doesn't exist, we will get
  * the next one.
@@ -278,8 +242,14 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 	struct btrfs_root *inode_root;
 	struct inode *inode;
 	struct btrfs_ioctl_defrag_range_args range;
-	int num_defrag;
-	int ret;
+	int ret = 0;
+	u64 cur = 0;
+
+again:
+	if (test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state))
+		goto cleanup;
+	if (!__need_auto_defrag(fs_info))
+		goto cleanup;
 
 	/* get the inode */
 	inode_root = btrfs_get_fs_root(fs_info, defrag->root, true);
@@ -295,39 +265,29 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 		goto cleanup;
 	}
 
+	if (cur >= i_size_read(inode)) {
+		iput(inode);
+		break;
+	}
+
 	/* do a chunk of defrag */
 	clear_bit(BTRFS_INODE_IN_DEFRAG, &BTRFS_I(inode)->runtime_flags);
 	memset(&range, 0, sizeof(range));
 	range.len = (u64)-1;
-	range.start = defrag->last_offset;
+	range.start = cur;
 
 	sb_start_write(fs_info->sb);
-	num_defrag = btrfs_defrag_file(inode, NULL, &range, defrag->transid,
+	ret = btrfs_defrag_file(inode, NULL, &range, defrag->transid,
 				       BTRFS_DEFRAG_BATCH);
 	sb_end_write(fs_info->sb);
-	/*
-	 * if we filled the whole defrag batch, there
-	 * must be more work to do.  Queue this defrag
-	 * again
-	 */
-	if (num_defrag == BTRFS_DEFRAG_BATCH) {
-		defrag->last_offset = range.start;
-		btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
-	} else if (defrag->last_offset && !defrag->cycled) {
-		/*
-		 * we didn't fill our defrag batch, but
-		 * we didn't start at zero.  Make sure we loop
-		 * around to the start of the file.
-		 */
-		defrag->last_offset = 0;
-		defrag->cycled = 1;
-		btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
-	} else {
-		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
-	}
-
 	iput(inode);
-	return 0;
+
+	if (ret < 0)
+		goto cleanup;
+
+	cur = max(cur + fs_info->sectorsize, range.start);
+	goto again;
+
 cleanup:
 	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
 	return ret;
-- 
2.34.1

