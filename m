Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61895AD6FA
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 17:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiIEP4U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 11:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiIEP4T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 11:56:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673854BD13
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 08:56:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0823F33E98;
        Mon,  5 Sep 2022 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662393376;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Prc6tEQ5sHY5TfFQ04FBhrNU1Nr6qAI3oRawAeBwPlk=;
        b=C0t3k/UEq4q9t82poIzysZJPGz8B8CbeB0Zd7fXZYeZT1/FOrKBVsX0qZg4MHV85vpXONU
        lcli99pB0sD/7phjjJrc7oh2ACNQGSH9pgOwk/74FsMC7fQXcsdX6UI//hnga4GKKNp4kY
        n85XaegbHGOoHeQ24ozRt5vNlZhwidc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662393376;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Prc6tEQ5sHY5TfFQ04FBhrNU1Nr6qAI3oRawAeBwPlk=;
        b=USn3TlBuAMQLy1NPyuxGhzrLpdMZSYDAgScmVJZt92P+T/O2pvxIMj2vleTDrpLQnFSrTJ
        VgucbTHnJgj7hDBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D98C1139C7;
        Mon,  5 Sep 2022 15:56:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TdBMNB8cFmPZZgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 05 Sep 2022 15:56:15 +0000
Date:   Mon, 5 Sep 2022 17:50:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Filipe Manana <fdmanana@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: for-next: KCSAN failures on 6130a25681d4 (kdave/for-next) Merge
 branch 'for-next-next-v5.20-20220804' into for-next-20220804
Message-ID: <20220905155054.GK13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <YvHU/vsXd7uz5V6j@hungrycats.org>
 <CAL3q7H7XCZnsCfiz9yAgfSP8rekx7YntVKphdDu8LLSehJ1EAQ@mail.gmail.com>
 <20220905154203.GJ13489@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905154203.GJ13489@twin.jikos.cz>
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

On Mon, Sep 05, 2022 at 05:42:03PM +0200, David Sterba wrote:
> On Tue, Aug 09, 2022 at 08:35:42AM +0100, Filipe Manana wrote:
> > On Tue, Aug 9, 2022 at 4:33 AM Zygo Blaxell
> > <ce3g8jdj@umail.furryterror.org> wrote:
> > >
> > > Some KCSAN complaints I found while testing for other things...
> > >
> > > Here's one related to extent refs:
> > 
> > It's about the block reserves, nothing to do with extents refs.
> > 
> > These get reported every now and then like here:
> > 
> > https://lore.kernel.org/linux-btrfs/CAAwBoOJDjei5Hnem155N_cJwiEkVwJYvgN-tQrwWbZQGhFU=cA@mail.gmail.com/
> > 
> > It's actually harmless, but if we keep it like this, we'll keep
> > getting reports in the future.
> 
> Can we add some kind of annotation so KCSAN understands that? The ->full
> member would be accessed using a helper when outside of the lock so the
> annotation can be there.

Something like (only compile-tested):

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 6ce704d3bdd2..ec96285357e0 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -286,7 +286,7 @@ u64 btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
 	 */
 	if (block_rsv == delayed_rsv)
 		target = global_rsv;
-	else if (block_rsv != global_rsv && !delayed_rsv->full)
+	else if (block_rsv != global_rsv && !btrfs_block_rsv_full(delayed_rsv))
 		target = delayed_rsv;
 
 	if (target && block_rsv->space_info != target->space_info)
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 0c183709be00..a1f40b88fa82 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -91,5 +91,9 @@ static inline void btrfs_unuse_block_rsv(struct btrfs_fs_info *fs_info,
 	btrfs_block_rsv_add_bytes(block_rsv, blocksize, false);
 	btrfs_block_rsv_release(fs_info, block_rsv, 0, NULL);
 }
+static inline bool btrfs_block_rsv_full(const struct btrfs_block_rsv *rsv)
+{
+	return data_race(rsv->full);
+}
 
 #endif /* BTRFS_BLOCK_RSV_H */
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a0a2652962ec..eb0ae7e396ef 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2426,7 +2426,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	 * still can allocate chunks and thus are fine using the currently
 	 * calculated f_bavail.
 	 */
-	if (!mixed && btrfs_block_rsv_full(block_rsv->space_info) &&
+	if (!mixed && block_rsv->space_info->full &&
 	    total_free_meta - thresh < block_rsv->size)
 		buf->f_bavail = 0;
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index d9e608935e64..9d7563df81a0 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -594,7 +594,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		 */
 		num_bytes = btrfs_calc_insert_metadata_size(fs_info, num_items);
 		if (flush == BTRFS_RESERVE_FLUSH_ALL &&
-		    delayed_refs_rsv->full == 0) {
+		    btrfs_block_rsv_full(delayed_refs_rsv) == 0) {
 			delayed_refs_bytes = num_bytes;
 			num_bytes <<= 1;
 		}
@@ -619,7 +619,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		if (rsv->space_info->force_alloc)
 			do_chunk_alloc = true;
 	} else if (num_items == 0 && flush == BTRFS_RESERVE_FLUSH_ALL &&
-		   !delayed_refs_rsv->full) {
+		   !btrfs_block_rsv_full(delayed_refs_rsv)) {
 		/*
 		 * Some people call with btrfs_start_transaction(root, 0)
 		 * because they can be throttled, but have some other mechanism
