Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE1764BCB5
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 20:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiLMTFk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 14:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbiLMTFi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 14:05:38 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705ABE72
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:05:37 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3b48b139b46so205806537b3.12
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zbysh5AioqMuvc+FSMh4Yh5bPvB0wUFR+xoTiH1HThk=;
        b=gZ5tf3uYkvIB5OvbsutqNiuV6KliaPU8aRPEDzMISws+0ehEO+7Zsgny5/JrhhBLNr
         ZsE+1opcq/kdepVytJEcx8yNtCivTDS9nyOKm3af17G7EhfVeiF76EpnpDaG8C32K0PO
         kGFkwquvdDbwg3zVcTVD6xlsIMvdofJOHp1erBHZGw6ajm5W5VPdVcWF8bYtUcENFSGr
         +tEx17EuyNqOUflD0IsMKJaJEphI8EWUMGJ/aH3JMkLfaoH85nlRRQCIbPbp1A5/EbV6
         HpposimdBW73P46Af6ATT1mbzTGykRhdZ7hwTdd+ewJN7RfTMzAoD+cImW7HSB34vssf
         CRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbysh5AioqMuvc+FSMh4Yh5bPvB0wUFR+xoTiH1HThk=;
        b=g8fEFi6GrpD4TyWESGK6JAy8gZv4esVCeu4yNC4q5LMookuqBpZbuFgQyFaX4AarcE
         /IO4BIDb6yHI5CviM6PHWihKSZRMsYdXEoHYSFzBIvLZjHe8+bY3qetPlxFg/SfXRFKu
         R9B1wx9QvcdywsMRWWc3TycAI1Htz2iLwbDQtMdhueNIOAUdkvedDppT5UbUW49UrrGP
         k7L8+VhwsmX40hh8M+SNd1amTl3tuUA68i8YCrmhsFvB2lQYF6SfgHQf140CnwSBgot8
         EsJOifJN4SXDEkLtGWcjF2rxHWGAMbdiy/pFlWlrhu+OjSvX6S7iLuMBaPInOw3JaH0w
         EpVQ==
X-Gm-Message-State: ANoB5pkDLnAmSWZa6LZ7NVgMZtALslNUoG5wQZkPd/SEQJ3vkJCKUtMz
        ATr1aL+488kHvIKp5Ps2Uuf1bh/BE6j6MFq2XWQ=
X-Google-Smtp-Source: AA0mqf5g1xhBP8AQ05zhzI+mj+LUtwE221YeyT4HerqOl3MieiMOPasbwdIh6MlRs3wf+MZy25Bqcg==
X-Received: by 2002:a05:7500:1456:b0:ea:a406:1349 with SMTP id q22-20020a057500145600b000eaa4061349mr2416446gab.11.1670958336336;
        Tue, 13 Dec 2022 11:05:36 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id do39-20020a05620a2b2700b006fcc3858044sm8363919qkb.86.2022.12.13.11.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:05:35 -0800 (PST)
Date:   Tue, 13 Dec 2022 14:05:34 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 09/16] btrfs: lock/unlock extents while creation/end of
 async_chunk
Message-ID: <Y5jM/m185dsjsO4t@localhost.localdomain>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <bb12e8c269c6dd67496aa868cef2a7c4bc75d292.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb12e8c269c6dd67496aa868cef2a7c4bc75d292.1668530684.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 12:00:27PM -0600, Goldwyn Rodrigues wrote:
> writepages() writebacks the unwritten pages the synchronously. So we
> know that once writepages returns, the pages are "done" and can be
> safely unlocked. However, with async writes, this is done over a thread.
> So, for async writeback, perform this within the async thread.
> 
> Locking is performed at origin of async_chunk and unlocked when
> async_chunk completes.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/inode.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 92726831dd5d..aa393219019b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -528,6 +528,7 @@ struct async_chunk {
>  	struct list_head extents;
>  	struct cgroup_subsys_state *blkcg_css;
>  	struct btrfs_work work;
> +	struct extent_state *cached_state;

I'd rather this be separated into it's own patch, I definitely got confused for
a second.

>  	struct async_cow *async_cow;
>  };
>  
> @@ -1491,6 +1492,9 @@ static noinline void async_cow_start(struct btrfs_work *work)
>  
>  	compressed_extents = compress_file_range(async_chunk);
>  	if (compressed_extents == 0) {
> +		unlock_extent(&async_chunk->inode->io_tree,
> +				async_chunk->start, async_chunk->end,
> +				&async_chunk->cached_state);
>  		btrfs_add_delayed_iput(async_chunk->inode);
>  		async_chunk->inode = NULL;
>  	}
> @@ -1530,11 +1534,16 @@ static noinline void async_cow_free(struct btrfs_work *work)
>  	struct async_cow *async_cow;
>  
>  	async_chunk = container_of(work, struct async_chunk, work);
> -	if (async_chunk->inode)
> +	if (async_chunk->inode) {
> +		unlock_extent(&async_chunk->inode->io_tree,
> +				async_chunk->start, async_chunk->end,
> +				&async_chunk->cached_state);
>  		btrfs_add_delayed_iput(async_chunk->inode);
> +	}
>  	if (async_chunk->blkcg_css)
>  		css_put(async_chunk->blkcg_css);
>  
> +

Extra whitespace.

>  	async_cow = async_chunk->async_cow;
>  	if (atomic_dec_and_test(&async_cow->num_chunks))
>  		kvfree(async_cow);
> @@ -1558,7 +1567,6 @@ static int cow_file_range_async(struct btrfs_inode *inode,
>  	unsigned nofs_flag;
>  	const blk_opf_t write_flags = wbc_to_write_flags(wbc);
>  
> -	unlock_extent(&inode->io_tree, start, end, NULL);
>  
>  	if (inode->flags & BTRFS_INODE_NOCOMPRESS &&
>  	    !btrfs_test_opt(fs_info, FORCE_COMPRESS)) {
> @@ -1600,6 +1608,9 @@ static int cow_file_range_async(struct btrfs_inode *inode,
>  		ihold(&inode->vfs_inode);
>  		async_chunk[i].async_cow = ctx;
>  		async_chunk[i].inode = inode;
> +		async_chunk[i].cached_state = NULL;
> +		btrfs_lock_and_flush_ordered_range(inode, start, cur_end,
> +				&async_chunk[i].cached_state);
>  		async_chunk[i].start = start;
>  		async_chunk[i].end = cur_end;
>  		async_chunk[i].write_flags = write_flags;
> @@ -8222,10 +8233,11 @@ static int btrfs_writepages(struct address_space *mapping,
>  			    struct writeback_control *wbc)
>  {
>  	u64 start, end;
> -	struct inode *inode = mapping->host;
> +	struct btrfs_inode *inode = BTRFS_I(mapping->host);
>  	struct extent_state *cached = NULL;
> +	bool async_wb;
>  	int ret;
> -	u64 isize = round_up(i_size_read(inode), PAGE_SIZE) - 1;
> +	u64 isize = round_up(i_size_read(&inode->vfs_inode), PAGE_SIZE) - 1;
>  
>  	if (wbc->range_cyclic) {
>  		start = mapping->writeback_index << PAGE_SHIFT;
> @@ -8239,9 +8251,18 @@ static int btrfs_writepages(struct address_space *mapping,
>  	if (start >= end)
>  		return 0;
>  
> -	lock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached);
> +	/*
> +	 * For async I/O, locking and unlocking is performed with the
> +	 * allocation and completion of async_chunk.
> +	 */
> +	async_wb = btrfs_inode_can_compress(inode) &&
> +		   inode_need_compress(inode, start, end);

These can change their answer arbitrarily and randomly, which means we could end
up doing an async extent when we didn't think we would, and then unpleasantness
happens.  Thanks,

Josef
