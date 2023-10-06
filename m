Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15BA7BBA25
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 16:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjJFOXe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 10:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJFOXc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 10:23:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9CEA6
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Oct 2023 07:23:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 89AD71F8A4;
        Fri,  6 Oct 2023 14:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696602209;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vsDrxpTh38nSWbfpW3Ao7OXRElih3fGtp33Ed0Hy4Rc=;
        b=U2ZCJsL0DNToOtWP5Jmh615GzS+cZ/7LiRfdzW9NBK6UYuo3ss90TwwgTNLNxTnrt8ZPEN
        SGWaC5hTiTuX23785+oUvw4VXkJ3UVr4DT01vepZORL6Bmqx8PFPDAWkzCuLxHZInzZvZd
        sQDg/OrSkJe7unthlXMHCQSDHynCZxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696602209;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vsDrxpTh38nSWbfpW3Ao7OXRElih3fGtp33Ed0Hy4Rc=;
        b=6ypnh5IuM4Knfd9X8d64hPzn+/uJgoyYrr0a+QWYrCMHqN3ID4xjliI3nV3lmyJxEFNLb5
        lU5WRa8/Bta6ppAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FE1813586;
        Fri,  6 Oct 2023 14:23:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F2SbFmEYIGXlWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 06 Oct 2023 14:23:29 +0000
Date:   Fri, 6 Oct 2023 16:16:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/6] btrfs: add and use helpers for reading and writing
 fs_info->generation
Message-ID: <20231006141645.GC28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1696415673.git.fdmanana@suse.com>
 <2d4e16f4c5ad1f0e6274b4f577b0944546b81517.1696415673.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d4e16f4c5ad1f0e6274b4f577b0944546b81517.1696415673.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 04, 2023 at 11:38:50AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently the generation field of struct btrfs_fs_info is always modified
> while holding fs_info->trans_lock locked. Most readers will access this
> field without taking that lock but while holding a transaction handle,
> which is safe to do due to the transaction life cycle.
> 
> However there are other readers that are neither holding the lock nor
> holding a transaction handle open:
> 
> 1) When reading an inode from disk, at btrfs_read_locked_inode();
> 
> 2) When reading the generation to expose it to sysfs, at
>    btrfs_generation_show();
> 
> 3) Early in the fsync path, at skip_inode_logging();
> 
> 4) When creating a hole at btrfs_cont_expand(), during write paths,
>    truncate and reflinking;
> 
> 5) In the fs_info ioctl (btrfs_ioctl_fs_info());
> 
> 6) While mounting the filesystem, in the open_ctree() path. In these
>    cases it's safe to directly read fs_info->generation as no one
>    can concurrently start a transaction and update fs_info->generation.
> 
> In case of the fsync path, races here should be harmless, and in the worst
> case they may cause a fsync to log an inode when it's not really needed,
> so nothing bad from a functional perspective. In the other cases it's not
> so clear if functional problems may arise, though in case 1 rare things
> like a load/store tearing [1] may cause the BTRFS_INODE_NEEDS_FULL_SYNC
> flag not being set on an inode and therefore result in incorrect logging
> later on in case a fsync call is made.
> 
> To avoid data race warnings from tools like KCSAN and other issues such
> as load and store tearing (amongst others, see [1]), create helpers to
> access the generation field of struct btrfs_fs_info using READ_ONCE() and
> WRITE_ONCE(), and use these helpers where needed.
> 
> [1] https://lwn.net/Articles/793253/
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/file.c        |  2 +-
>  fs/btrfs/fs.h          | 16 ++++++++++++++++
>  fs/btrfs/inode.c       |  4 ++--
>  fs/btrfs/ioctl.c       |  2 +-
>  fs/btrfs/sysfs.c       |  2 +-
>  fs/btrfs/transaction.c |  2 +-
>  6 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 004c53482f05..723f0c70452e 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1749,7 +1749,7 @@ static inline bool skip_inode_logging(const struct btrfs_log_ctx *ctx)
>  	struct btrfs_inode *inode = BTRFS_I(ctx->inode);
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  
> -	if (btrfs_inode_in_log(inode, fs_info->generation) &&
> +	if (btrfs_inode_in_log(inode, btrfs_get_fs_generation(fs_info)) &&
>  	    list_empty(&ctx->ordered_extents))
>  		return true;
>  
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 2bd9bedc7095..d04b729cbdf3 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -416,6 +416,12 @@ struct btrfs_fs_info {
>  
>  	struct btrfs_block_rsv empty_block_rsv;
>  
> +	/*
> +	 * Updated while holding the lock 'trans_lock'. Due to the life cycle of
> +	 * a transaction, it can be directly read while holding a transaction
> +	 * handle, everywhere else must be read with btrfs_get_fs_generation().
> +	 * Should always be updated using btrfs_set_fs_generation().
> +	 */
>  	u64 generation;
>  	u64 last_trans_committed;
>  	/*
> @@ -817,6 +823,16 @@ struct btrfs_fs_info {
>  #endif
>  };
>  
> +static inline u64 btrfs_get_fs_generation(const struct btrfs_fs_info *fs_info)
> +{
> +	return READ_ONCE(fs_info->generation);
> +}
> +
> +static inline void btrfs_set_fs_generation(struct btrfs_fs_info *fs_info, u64 gen)
> +{
> +	WRITE_ONCE(fs_info->generation, gen);
> +}
> +
>  static inline void btrfs_set_last_root_drop_gen(struct btrfs_fs_info *fs_info,
>  						u64 gen)
>  {
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3b3aec302c33..c9317c047587 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3800,7 +3800,7 @@ static int btrfs_read_locked_inode(struct inode *inode,
>  	 * This is required for both inode re-read from disk and delayed inode
>  	 * in delayed_nodes_tree.
>  	 */
> -	if (BTRFS_I(inode)->last_trans == fs_info->generation)
> +	if (BTRFS_I(inode)->last_trans == btrfs_get_fs_generation(fs_info))
>  		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
>  			&BTRFS_I(inode)->runtime_flags);
>  
> @@ -4923,7 +4923,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
>  			hole_em->orig_block_len = 0;
>  			hole_em->ram_bytes = hole_size;
>  			hole_em->compress_type = BTRFS_COMPRESS_NONE;
> -			hole_em->generation = fs_info->generation;
> +			hole_em->generation = btrfs_get_fs_generation(fs_info);
>  
>  			err = btrfs_replace_extent_map_range(inode, hole_em, true);
>  			free_extent_map(hole_em);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 848b7e6f6421..7ab21283fae8 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2822,7 +2822,7 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
>  	}
>  
>  	if (flags_in & BTRFS_FS_INFO_FLAG_GENERATION) {
> -		fi_args->generation = fs_info->generation;
> +		fi_args->generation = btrfs_get_fs_generation(fs_info);
>  		fi_args->flags |= BTRFS_FS_INFO_FLAG_GENERATION;
>  	}
>  
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index e07be193323a..21ab8b9b62ce 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1201,7 +1201,7 @@ static ssize_t btrfs_generation_show(struct kobject *kobj,
>  {
>  	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
>  
> -	return sysfs_emit(buf, "%llu\n", fs_info->generation);
> +	return sysfs_emit(buf, "%llu\n", btrfs_get_fs_generation(fs_info));
>  }
>  BTRFS_ATTR(, generation, btrfs_generation_show);
>  
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 3aa59cfa4ab0..f5db3a483f40 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -386,7 +386,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
>  			IO_TREE_TRANS_DIRTY_PAGES);
>  	extent_io_tree_init(fs_info, &cur_trans->pinned_extents,
>  			IO_TREE_FS_PINNED_EXTENTS);
> -	fs_info->generation++;
> +	btrfs_set_fs_generation(fs_info, fs_info->generation + 1);

Should this also use the helper for the part where it reads the value?

	btrfs_set_fs_generation(fs_info, btrfs_get_fs_generation(fs_info) + 1);

It's a matter of annotation not a functional fix, I don't know if KCSAN
would warn here. I'd expect that the unprotected access uses the helpers
consistently, ie. both or none.
