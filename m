Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AC559EDFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 23:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiHWVIJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 17:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiHWVII (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 17:08:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582086334
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 14:08:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0CF1C336A3;
        Tue, 23 Aug 2022 21:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661288885;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xj7+qp9iwUmbDADyF0hONQr+CZ9dmHiA+yNfVCmHw8I=;
        b=VjNIiALj04XRax/gCQn9rv9KjjsyqszgZ7Kxamn4Bb2zJmUAQmm1xE6QD6qGsaDN88IlJm
        mMppsngxwYf27W5ih5uQrD+DwdB66ntGYqinl/qAI4OAd5hLTCO4UUwarLnppIS3WQ7o3i
        OHgTFMyN3F7Gwp3KvBn0ZZsUZaFtpns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661288885;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xj7+qp9iwUmbDADyF0hONQr+CZ9dmHiA+yNfVCmHw8I=;
        b=HolEjfT2Xpl8xtCQO71xmUP328t6mwsIPggbZXaXAINpblB6NRGhcUNMc9lAMfSePH+qu2
        s6W7wtiKkU552RDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBAC813AB7;
        Tue, 23 Aug 2022 21:08:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xR06MLRBBWNwEQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 Aug 2022 21:08:04 +0000
Date:   Tue, 23 Aug 2022 23:02:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 2/2] btrfs: Lockdep annotations for the extent bits
 wait event
Message-ID: <20220823210250.GV13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220812004241.1722846-1-iangelak@fb.com>
 <20220812004241.1722846-3-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812004241.1722846-3-iangelak@fb.com>
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

On Thu, Aug 11, 2022 at 05:42:44PM -0700, Ioannis Angelakopoulos wrote:
> Add lockdep annotations in five places that lock extent bits:
>   1) find_lock_delalloc_range() in fs/btrfs/extent_io.c and its callers
>   2) btrfs_lock_and_flush_ordered_range() in fs/btrfs/ordered-data.c and
>   its callers
>   3) extent_fiemap() in fs/btrfs/extent_io.c
>   4) btrfs_fallocate() in fs/btrfs/file.c
>   5) btrfs_finish_ordered_io() in fs/btrfs/inode.c
> 
> To annotate the extent bits wait event we make use of a two level lockdep
> map (making use of the multilevel wait event lockdep annotation macros).
> The first level is used for high level functions such as btrfs_fallocate()
> and the second level is used for low level functions, such as
> find_lock_delalloc_range().
> 
> If we used only one level then lockdep would complain because there are
> execution contexts where the extent bits annotation is acquired before the
> delalloc_mutex (i.e., in btrfs_fallocate()) and later delalloc_mutex is
> acquired before the extent bits annotation (i.e.,
> find_lock_delalloc_range()). Normally, if the range of bits locked were the
> same for both btrfs_fallocate() and find_lock_delalloc_range() we would
> have a deadlock(). However, a call to btrfs_wait_ordered_range() from
> btrfs_fallocate() guarantees that the range of extent bits is unlocked
> before locking, thus the deadlock is averted.
> 
> By using a two level lockdep map we "break" the dependency between the high
> and low levels, thus lockdep does not complain.
> 
> Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
> ---
>  fs/btrfs/ctree.h        |   1 +
>  fs/btrfs/disk-io.c      |   1 +
>  fs/btrfs/extent_io.c    | 114 +++++++++++++++++++++++++++++++++++++---
>  fs/btrfs/file.c         |  10 ++--
>  fs/btrfs/inode.c        |  22 ++++++--
>  fs/btrfs/ordered-data.c |   4 +-
>  6 files changed, 133 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 44837545eef8..85f947ce6e6b 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1104,6 +1104,7 @@ struct btrfs_fs_info {
>  	struct lockdep_map btrfs_state_change_map[4];
>  	struct lockdep_map btrfs_trans_pending_ordered_map;
>  	struct lockdep_map btrfs_ordered_extent_map;
> +	struct lockdep_map btrfs_inode_extent_lock_map;
>  
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	spinlock_t ref_verify_lock;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 6268dafeeb2d..afd971c31168 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2996,6 +2996,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  	btrfs_lockdep_init_map(fs_info, btrfs_trans_num_extwriters);
>  	btrfs_lockdep_init_map(fs_info, btrfs_trans_pending_ordered);
>  	btrfs_lockdep_init_map(fs_info, btrfs_ordered_extent);
> +	btrfs_lockdep_init_map(fs_info, btrfs_inode_extent_lock);
>  	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_commit_start,
>  				     BTRFS_LOCKDEP_TRANS_COMMIT_START);
>  	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_unblocked,
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6e8e936a8a1e..3d2ef3d78e7f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -891,6 +891,24 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
>  
>  }
>  
> +int __clear_extent_bit_lockdep(struct extent_io_tree *tree, u64 start, u64 end,
> +			       u32 bits, int wake, int delete,
> +			       struct extent_state **cached_state,
> +			       gfp_t mask, struct extent_changeset *changeset)
> +{
> +	int ret;
> +
> +	ret = __clear_extent_bit(tree, start, end, bits, wake, delete, cached_state,
> +				 mask, changeset);
> +
> +	if ((tree->owner != IO_TREE_FREE_SPACE_INODE_IO) &&
> +	    (tree->owner == IO_TREE_INODE_IO))
> +		btrfs_lockdep_release(tree->fs_info, btrfs_inode_extent_lock);
> +
> +	return ret;
> +}
> +
> +
>  static void wait_on_state(struct extent_io_tree *tree,
>  			  struct extent_state *state)
>  		__releases(tree->lock)
> @@ -1470,6 +1488,14 @@ int clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
>  				  cached, GFP_NOFS, NULL);
>  }
>  
> +int clear_extent_bit_lockdep(struct extent_io_tree *tree, u64 start, u64 end,
> +			     u32 bits, int wake, int delete,
> +			     struct extent_state **cached)
> +{
> +	return __clear_extent_bit_lockdep(tree, start, end, bits, wake, delete,
> +					  cached, GFP_NOFS, NULL);
> +}
> +
>  int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
>  		u32 bits, struct extent_changeset *changeset)
>  {
> @@ -1504,6 +1530,43 @@ int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
>  			break;
>  		WARN_ON(start > end);
>  	}
> +
> +	return err;
> +}
> +
> +int lock_extent_bits_lockdep(struct extent_io_tree *tree, u64 start, u64 end,
> +			     struct extent_state **cached_state, bool nested)
> +{
> +	int err;
> +#ifdef CONFIG_LOCKDEP
> +	int subclass = 1;
> +#endif

Does this compile with lockdep disabled?

> +
> +	/* The wait event occurs within lock_extent_bits() */
> +	if ((tree->owner != IO_TREE_FREE_SPACE_INODE_IO) &&
> +	    (tree->owner == IO_TREE_INODE_IO)) {
> +		if (nested)
> +			btrfs_might_wait_for_event_nested(tree->fs_info,
> +							  btrfs_inode_extent_lock,
> +							  subclass);

it's used here

> +		else
> +			btrfs_might_wait_for_event(tree->fs_info,
> +						   btrfs_inode_extent_lock);
> +	}
> +
> +	err = lock_extent_bits(tree, start, end, cached_state);
> +
> +	if ((tree->owner != IO_TREE_FREE_SPACE_INODE_IO) &&
> +	    (tree->owner == IO_TREE_INODE_IO)) {
> +		if (nested)
> +			btrfs_lockdep_acquire_nested(tree->fs_info,
> +						     btrfs_inode_extent_lock,
> +						     subclass);

and here

> +		else
> +			btrfs_lockdep_acquire(tree->fs_info,
> +					      btrfs_inode_extent_lock);
> +	}
> +
>  	return err;
>  }
