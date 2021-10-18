Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F5B43290C
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 23:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhJRVaz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 17:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbhJRVay (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 17:30:54 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C45C06161C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 14:28:42 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 77so16652348qkh.6
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 14:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TTtDOcJaKfUIqofFoq6XANCM2g0PNR6+VdvtFLGvszQ=;
        b=kcRdBWb2FtvvSMP4nk/yZ9WlP0IblKDLHHOIK6Pe2XX1zAQOM/AkHiBF6e0Q19UOXG
         nipWHdUd9YFdW5EntnFG8WAMHlNkkFMqIkI8lExTEIVsu05lX3/PRK8YA8OVYWR37K59
         1df+1JjsyZjo7UnK8qJKWpFTkXdyTXef+c5f3TX84lYAsrn4i7ICdFtYX7huGKVF1ZZK
         ewHD+3T7tSOQGWA7DXFwdNt4t01vfJffBN1Ipe+M+quNmat85Sw8F7qVIzQkloglaRC+
         dgKz9/s+MeOVBiUFUSh2WqptZ8XxyFyVCcM04QqgzeHxu5LeFrjA8ctMjZEovJJhG9n7
         LUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TTtDOcJaKfUIqofFoq6XANCM2g0PNR6+VdvtFLGvszQ=;
        b=7IbAH17uRwaJKSPZvz7y1nIb+caD28zhgcwin4qH69IA2AoRXk162l1gGCBSCqZSJW
         1Kma9Mt/QzV7PFuJQs9V/vrxAebqGk6MhxkSZzPPktDZG77nIETdBVvDv090HXGiaEM+
         zvmF/WMH5R4nDked3nbygdqNnqD2zbrNVSmRn5IaObPBlsCpscPup8+oYly9yL4b/POx
         n8saXzJ8/JPDta9unbCXRlbocH5VUJuNscLV+IZ3ZBNRrl+Si6oBWXxNwGWIAxs9lP0T
         cGkKx0vvk1BwCVRCXFP6h7uknT5bRDdrMKKJfI2vwueXcRflc3O/9v/LMpNuHhTknZu3
         /V2g==
X-Gm-Message-State: AOAM5321bKWzIwnVvZw9JOE1/lUj8Z3rLwHe9t4PyUPAgLiKu3ZBYpDT
        2ohcvKd4/qaRVv+GKKYtYHFAq5SuDSpslg==
X-Google-Smtp-Source: ABdhPJwjmOrLwb8B6CWDnuy0oFqPbxANnmyvF7x7ihN1NK3dy2v7qI+ySLNYV1maPuWpjLhw3NZFMQ==
X-Received: by 2002:a37:b5c4:: with SMTP id e187mr24331787qkf.27.1634592520588;
        Mon, 18 Oct 2021 14:28:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p22sm6684516qtl.83.2021.10.18.14.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 14:28:39 -0700 (PDT)
Date:   Mon, 18 Oct 2021 17:28:38 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add stub argument to transaction API
Message-ID: <YW3nBs4cr99TcyRL@localhost.localdomain>
References: <20211018173803.18353-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018173803.18353-1-dsterba@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 18, 2021 at 07:38:03PM +0200, David Sterba wrote:
> This is minimum preparatory patch (still big) for the scoped NOFS
> changes. I'd like to get it merged for 5.16 so I can start the
> conversion. To keep patch conflicts low I'm going to apply as one of the
> last patches before code freeze, as we're in rc6 time it's a good
> opportunity to still catch the next dev cycle.
> 
> ---
> 
> This is preparatory work for scope NOFS [1]. The section that must not
> recurse back to the filesystem would be enclosed in
> memalloc_nofs_save/memalloc_nofs_restore, wrapped by our transaction
> API. The new argument will store the context data for the NOFS status.
> 
> This patch doesn't change anything yet, only extends the functions to
> make it easier to integrate with new patches and develop the real scope
> NOFS changes in incrementally.
> 
> Until the rest of the changes lands, use NULL for the argument.
> 
> References:
> 
> * https://lwn.net/Articles/635354/ (2015)
> * https://lwn.net/Articles/723317/ (2017)
> * https://lwn.net/Articles/710545/ (2017)
> * every now and then somebody asks about GFP_NOFAIL and GFP_NOFS
> 
> Note: full conversion to scoped NOFS is a long term plan with following
> phases:
> 
> 1. switch GFP_NOFS to GFP_KERNEL where it's safe without any additional
>    changes (context is safe, eg. in tests)
> 2. switch GFP_NOFS to memalloc_nofs_* + GFP_KERNEL in cases where we
>    know it's unsafe to do plain GFP_KERNEL, eg. with an open transaction
> 3. introduce framework to do transaction start/end scope NOFS
>    protection, no actual changes
> 4. incrementally switch function by function to use the local
>    transaction context to track the NOFS context
> 5. once finished, remove the memalloc_nofs_* calls
> 
> 1 and 2 are basically done, 3 is this patch.
> 
> Why the stub/context argument is needed: the NOFS protection is per call
> site, so it must be set and reset in the caller thread, so any
> allocations between btrfs_start_transaction and btrfs_end_transaction
> are safe. We can't store it in the transaction handle, because it's not
> passed everywhere, eg. to various helpers in btrfs and potentially in
> other subsystems.
> 

So the plan is to instead pass the tctx around everywhere to carry the flags?  I
thought the whole point of memalloc_nofs_save() is that we don't have to pass
gfp_t's around everywhere, it just knows what we're supposed to be doing?  So
the trans should be able to hold the flags since we only care about starting it
and restoring it, correct?  Or am I wrong and we do actually need to pass this
thing around?  In which case can't we still just save it in the trans handle,
and pass the u32 around where appropriate?  Thanks,

Josef
