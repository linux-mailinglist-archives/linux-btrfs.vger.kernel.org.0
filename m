Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D92B433F83
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 21:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhJST7y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 15:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbhJST7x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 15:59:53 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA71FC06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 12:57:40 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id i1so1059820qtr.6
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 12:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a0II1bUro4gNNa3YzgW8MeE6OhFEXtkRLZOV1dG8mrc=;
        b=uR4nHSshkFEHaXMuJqBUS3W+dbyXyxq5C+p4A1kNaSBwHsKhovZqCbWPg1D9ym7w8f
         MKBnidy4OYvNGJ+sUcrMbT+dh/gsPnItBJe8agvg4M8DGf7CRd/I8er29ddeGL2WrUYv
         iLZYNSzFmQ0+j+QKImy0c+/oxsFLlpoP8HJECopC1CK99pyxpAd6scJj1i311TPwDLv9
         kb2NyFA+Uvu8tYLoa8qFXNbCBrzntZWcvDziEB+dNIL5AhWQ8SjV8phfsZhk6SWEoHYN
         5c3J4eLW5jKaHYPWfQp516LjCvkFKN+bMfEf9MUBu78HoMBEKwxGjusuZtFscLjNt+0Z
         jigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a0II1bUro4gNNa3YzgW8MeE6OhFEXtkRLZOV1dG8mrc=;
        b=wtCMoJ2P96nZRXMIdIGFttwh2QBv29zNMoIy2U/uut/01TGA34RqqfcMfX1drN1FWb
         U4itapmvGEUWrP3pkDmt54SJSAvBNSYDRC2Ys7R0tBj8OiHYLyaJLAeDBk3hdIj1bQyP
         Y9hHR7/KDf5SZxexdyJg2AUNP524nks+5hcTcdqZ2neWFI5eImVDxOnRbtJRjQH74Bn4
         oEhZpSVWcnugCSSEEreDCeSu3TQNeDcEyUzYljkHax2kbpJiDI1pirr5yCyz0y7m17yY
         3poNL0o1cW7of91MSZe4j/Wtmp7CEYsIOF4if7E0JKyKIU3GfIleBy6abGrTcJ48x5fi
         CkNg==
X-Gm-Message-State: AOAM5338/dcNHs/ETu61xx5/XxN8k2iS91eO2EH52rXTy3lkLILXL8pL
        6l89RW4s7M7cIvKAs/iem1kydQ==
X-Google-Smtp-Source: ABdhPJy3ejdQih8I9GGZcre/Z/Jxuu2HVXcg3mSXjL8utoyKy1d8vEq2pbT3nhy3sG4bx+wJkOhWgg==
X-Received: by 2002:ac8:4117:: with SMTP id q23mr2222403qtl.390.1634673459808;
        Tue, 19 Oct 2021 12:57:39 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o14sm8241708qtv.91.2021.10.19.12.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 12:57:39 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:57:38 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add stub argument to transaction API
Message-ID: <YW8jMqfc6sZ7y7Bj@localhost.localdomain>
References: <20211018173803.18353-1-dsterba@suse.com>
 <YW3nBs4cr99TcyRL@localhost.localdomain>
 <20211019145412.GT30611@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019145412.GT30611@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 04:54:12PM +0200, David Sterba wrote:
> On Mon, Oct 18, 2021 at 05:28:38PM -0400, Josef Bacik wrote:
> > On Mon, Oct 18, 2021 at 07:38:03PM +0200, David Sterba wrote:
> > > Why the stub/context argument is needed: the NOFS protection is per call
> > > site, so it must be set and reset in the caller thread, so any
> > > allocations between btrfs_start_transaction and btrfs_end_transaction
> > > are safe. We can't store it in the transaction handle, because it's not
> > > passed everywhere, eg. to various helpers in btrfs and potentially in
> > > other subsystems.
> > 
> > So the plan is to instead pass the tctx around everywhere to carry the flags?  I
> > thought the whole point of memalloc_nofs_save() is that we don't have to pass
> > gfp_t's around everywhere, it just knows what we're supposed to be doing?
> 
> Nothing needs to be passed around, it will be hidden inside the
> transaction start/end, the only thing the caller needs to do is to
> define the variable and pass it to to transaction start call. The NOFS
> section will then apply to any calls until the transaction end call.
> 
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1232,6 +1232,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
>         struct btrfs_path *path;
>         struct btrfs_block_rsv *block_rsv;
>         int ret;
> +       DEFINE_TCTX(tctx);
>  
>         if (!delayed_node)
>                 return 0;
> @@ -1244,7 +1245,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
>         }
>         mutex_unlock(&delayed_node->mutex);
>  
> -       trans = btrfs_join_transaction(delayed_node->root, NULL);
> +       trans = btrfs_join_transaction(delayed_node->root, tctx);
>         if (IS_ERR(trans)) {
>                 ret = PTR_ERR(trans);
>                 goto out;
> @@ -1271,7 +1272,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
>         btrfs_free_path(path);
>         trans->block_rsv = block_rsv;
>  trans_out:
> -       btrfs_end_transaction(trans, NULL);
> +       btrfs_end_transaction(trans, tctx);
>         btrfs_btree_balance_dirty(fs_info);
>  out:
>         btrfs_release_delayed_node(delayed_node);
> ---
> 
> This is what needs to be done per caller.
> 

Ooooh so we don't want to enforce NOFS for ALL trans handles, just some of them?

If that's the case can't we just do

trans = btrfs_join_transaction_nofs()/btrfs_start_transaction_nofs()

and then handle it internally?

> 
> > So
> > the trans should be able to hold the flags since we only care about starting it
> > and restoring it, correct?  Or am I wrong and we do actually need to pass this
> > thing around?  In which case can't we still just save it in the trans handle,
> > and pass the u32 around where appropriate?  Thanks,
> 
> I had to dig in my memory why we can't store it in the transaction
> handle, because this is naturally less intrusive. But it does not work.
> 
> There are two things:
> 
> 1) In a function that starts/joins a transaction, the NOFS scope is from
>    that call until the transaction end. This is caller-specific.
>    Like in the example above, any allocation with GFP_KERNEL happening
>    will be safe and not recurse back to btrfs.
> 
> 2) Transaction handle is not caller-specific and is allocated when the
>    transaction starts (ie. a new kmem_cache_alloc call is done). Any
>    caller of transaction start will only increase the reference count.
> 

Right but we only really need to do the release when we free the trans handle,
so in fact we can just leave it for the end of btrfs_end_transaction() when we
free the trans handle and still be good.

Thanks,

Josef
